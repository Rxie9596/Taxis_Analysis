load('trace_info.mat')

angseg=6;
angedge=deg2rad(linspace(0,360,angseg+1));
angcen=angedge(1:end-1)+((angedge(2)-angedge(1))/2);

lenseg=20;
plotspace=[0 200];
lenedge=linspace(plotspace(1),plotspace(2),lenseg+1);
lenedge_tol=linspace(plotspace(1),plotspace(2),lenseg*angseg+1);
lencen=lenedge(1:end-1)+((lenedge(2)-lenedge(1))/2);
lencen_tol=lenedge_tol(1:end-1)+((lenedge_tol(2)-lenedge_tol(1))/2);
%----------------------------------------------------
len_tol=trace_length;
lencount_tol=histcounts(len_tol,lenedge_tol);
lenperc_tol=100*lencount_tol/sum(lencount_tol);
tra_rate_tol=transition_rate(lencount_tol);
median_tra_rate_tol=median(tra_rate_tol(~isnan(tra_rate_tol)));

figure(1)
subplot(2,1,1)
bar(lencen_tol,lenperc_tol)
xlim(plotspace)
xlabel('Trace Length distribution')
ylabel('Percentage')
set(gca,'box','off','TickDir','out','FontSize',18)

subplot(2,1,2)
scatter(lencen_tol,tra_rate_tol)
xlim(plotspace)
title('whole distribution')
xlabel('Trace Length distribution')
ylabel('Percentage')
set(gca,'box','off','TickDir','out','FontSize',18)

%----------------------------------------------------
lencount=zeros(angseg,lenseg);
lenperc=zeros(angseg,lenseg);
tra_rate=zeros(angseg,lenseg);
median_tra_rate=zeros(angseg,1);
for angiter=1:angseg
    len = trace_length(trace_theta>angedge(angiter) & trace_theta<angedge(angiter+1));
    lencount(angiter,:)=histcounts(len,lenedge);
    lenperc(angiter,:)=100*lencount(angiter,:)/sum(lencount(angiter,:));
    tra_rate(angiter,:)=transition_rate(lencount(angiter,:));
    tra_rate_real=tra_rate(angiter,:);
    tra_rate_real=tra_rate_real(~isnan(tra_rate_real));
    median_tra_rate(angiter)=median(tra_rate_real);
end

figure(2)
for plotiter=1:angseg
    subplot(angseg,2,2*plotiter-1)
    bar(lencen,lenperc(plotiter,:))
    xlim(plotspace)
    xlabel('Trace Length distribution')
    ylabel('Percentage')
    % set(gca,'box','off','TickDir','out','FontSize',10)

    subplot(angseg,2,2*plotiter)
    scatter(lencen,tra_rate(plotiter,:))
    xlim(plotspace)
    title([num2str(rad2deg(angedge(plotiter))) '-' num2str(rad2deg(angedge(plotiter+1))) ' distribution'])
    xlabel('Trace Length distribution')
    ylabel('rate')
    % set(gca,'box','off','TickDir','out','FontSize',10)
end

figure(3)
polarplot([angcen angcen(1)],[median_tra_rate' median_tra_rate(1)])
title('Transition rate distribution')

save('tra_rate_dis.mat','median_tra_rate')

function rate=transition_rate(count)
    rate=zeros(1,length(count));
    for iter=1:length(count)
        rate(iter)=count(iter)./sum(count(iter:end));
    end
end
