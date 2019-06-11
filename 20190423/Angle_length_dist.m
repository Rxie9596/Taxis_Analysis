load('trace_info.mat')

angseg=6;
angedge=deg2rad(linspace(0,360,angseg+1));
angcen=angedge(1:end-1)+((angedge(2)-angedge(1))/2);

theta_dist = zeros(1,angseg);
avg_length = zeros(1,angseg); 
for angiter=1:angseg
    len = trace_length(trace_theta>angedge(angiter) & trace_theta<angedge(angiter+1));
    theta_dist(angiter) = size(len,2);
    avg_length(angiter) = mean(len);
end


lw=1.5;
% theta distribution
figure(1)
polarplot([angcen angcen(1)],[theta_dist theta_dist(1)],'LineWidth',lw)
title('Reorientation theta distribution')


% lengh distribution
figure(2)
polarplot([angcen angcen(1)],[avg_length avg_length(1)],'LineWidth',lw)
title('Length distribution')