group1='50_100';
group2='cold';
group3='cold_50_100';

rate=[];

cd(group1)
load('tra_rate_dis')
rate=[rate, median_tra_rate];
cd ..

cd(group2)
load('tra_rate_dis')
rate=[rate, median_tra_rate];
cd ..

cd(group3)
load('tra_rate_dis')
rate=[rate, median_tra_rate];
cd ..


angseg=6;
angedge=deg2rad(linspace(0,360,angseg+1));
angcen=angedge(1:end-1)+((angedge(2)-angedge(1))/2);

lw=1.5;
figure(1)
polarplot([angcen angcen(1)]+(pi/2),[rate(:,1)' rate(1,1)],'LineWidth',lw)
hold on
polarplot([angcen angcen(1)],[rate(:,2)' rate(1,2)],'LineWidth',lw)
hold on
polarplot([angcen angcen(1)],[rate(:,3)' rate(1,3)],'LineWidth',lw)
% hold on
% polarplot([angcen angcen(1)],[rate(:,1)'+rate(:,2)' rate(1,1)+rate(1,2)],'LineWidth',lw)
hold off
title('Transition rate distribution')
legend('50-100','cold','cold & 50-100','rate1 + rate2')