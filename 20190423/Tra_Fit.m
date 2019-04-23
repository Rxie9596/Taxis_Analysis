load('displacement_cold_50_100.mat')
load('reori_cold_50_100.mat')

displa = displacement;
reori = reori_cold_50_100;

lw=1.5;
ps=20;
fit_datapt_num = 20;
mean_datapt_num = 20;
bound = 10;

Inspect_Flag = false;

trace_length = [];
trace_theta = [];
for traiter = 1:size(displa,1)/2

    idx = reori(2*traiter-1,:);
    idx = idx(~isnan(idx));

    if Inspect_Flag
        plot(displa(2*traiter-1,:),displa(2*traiter,:),'LineWidth',lw)
        hold on
        scatter(displa(2*traiter-1,idx),displa(2*traiter,idx),ps,'*','r')
        hold on
        pause
    end

    for reoiter = 1:length(idx)
        try 
            x_pre_turn_idx = idx(reoiter):-1:idx(reoiter)-fit_datapt_num+1;
            y_pre_turn_idx = idx(reoiter):-1:idx(reoiter)-fit_datapt_num+1;
            x_pre_turn = displa(2*traiter-1,x_pre_turn_idx);
            y_pre_turn = displa(2*traiter,y_pre_turn_idx);
            p = polyfit(x_pre_turn,y_pre_turn,1);
            x_0 = displa(2*traiter-1,x_pre_turn_idx(1));
            x_pre_turn_m = mean(x_pre_turn);
            theta_sign = sign(x_0-x_pre_turn_m);

            theta_t = atan(p(1));
            if theta_sign > 0 
                if theta_t > 0
                    theta = theta_t;
                else
                    theta = theta_t + 2*pi;
                end
            else
                theta = theta_t + pi;
            end

        catch ME
            if (strcmp(ME.identifier,'MATLAB:badsubscript'))
                disp(ME.message);
                continue
            else
                rethrow(ME)
            end
        end

        if Inspect_Flag
            x_offset = -10*bound*cos(theta);
            y_offset = bound/cos(theta);

            x_line = [x_0, x_0 + x_offset];
            y_line = polyval(p,x_line);
            y_up_bound = y_line + y_offset;
            y_low_bound = y_line - y_offset;

            plot(x_line,y_line,'Color','r')
            hold on
            plot(x_line,y_up_bound,':','Color','m')
            hold on
            plot(x_line,y_low_bound,':','Color','m')
            hold on

        end
        
        tl = (mean_datapt_num+1)/2;
        for traceiter = 1:idx(reoiter)-mean_datapt_num+1
            x_win_idx = idx(reoiter):-1:idx(reoiter)-mean_datapt_num+1;
            y_win_idx = idx(reoiter):-1:idx(reoiter)-mean_datapt_num+1;
            x_win_idx = x_win_idx - traceiter +1;
            y_win_idx = y_win_idx - traceiter +1;
            x_win_m = mean(displa(2*traiter-1,x_win_idx));
            y_win_m = mean(displa(2*traiter,y_win_idx));

            if point_to_line([x_win_m,y_win_m], p)>bound

                if Inspect_Flag
                    scatter(x_win_m,y_win_m,ps,'o','r')
                    hold on
                    pause
                end
                
                break
            end

            if Inspect_Flag
                scatter(x_win_m,y_win_m,ps,'o','b')
                hold on
                pause
            end

            tl = tl+1;
        end

        trace_length = [trace_length tl];
        trace_theta = [trace_theta theta];
    end
end

save('trace_info.mat','trace_length','trace_theta')
clear

function d = point_to_line(pt, p)
    % return the distance between a potint and a line in 2D
    % pt, potint coordinate
    % p, polynomial coefficients of the line
    
    x = [-1, 1];
    y = polyval(p,x);
    v1 = [x(1) , y(1) , 0];
    v2 = [x(2) , y(2) , 0];
    pt = [pt , 0];

    a = v1 - v2;
    b = pt - v2;
    d = norm(cross(a,b)) / norm(a);
end