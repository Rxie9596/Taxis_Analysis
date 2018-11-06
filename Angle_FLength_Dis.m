load('0-50_reori_thetaout.mat');
load('0-50_runLength.mat');
Exp(1).Angle_raw=reori_thetaout;
Exp(1).FLength_raw=runLength;
Exp(1).name='0-50 Chemotaxis';

load('50-100_reori_thetaout.mat');
load('50-100_runLength.mat');
Exp(2).Angle_raw=reori_thetaout;
Exp(2).FLength_raw=runLength;
Exp(2).name='50-100 Chemotaxis';

load('cold_reori_thetaout.mat');
load('cold_runLength.mat');
Exp(3).Angle_raw=reori_thetaout;
Exp(3).FLength_raw=runLength;
Exp(3).name='Cold Thermotaxis';

load('hot(th)_reori_thetaout.mat');
load('hot(th)_runLength.mat');
Exp(4).Angle_raw=reori_thetaout;
Exp(4).FLength_raw=runLength;
Exp(4).name='Hot Thermotaxis';

% Angle_raw=Angle_raw(:,2:end)-Angle_raw(:,1:end-1);

for expiter=1:4
Exp(expiter).Angle=[];
Exp(expiter).FLength=[];

    for rowiter=1:size(Exp(expiter).Angle_raw,1)
        for coliter=1:size(Exp(expiter).Angle_raw,2)
            if Exp(expiter).Angle_raw(rowiter,coliter) ~= NaN 
                Exp(expiter).Angle=[Exp(expiter).Angle Exp(expiter).Angle_raw(rowiter,coliter)];
            end

        end
    end

    for rowiter=1:size(Exp(expiter).FLength_raw,1)
        for coliter=1:size(Exp(expiter).FLength_raw,2)
            if Exp(expiter).FLength_raw(rowiter,coliter) ~= NaN 
                Exp(expiter).FLength=[Exp(expiter).FLength Exp(expiter).FLength_raw(rowiter,coliter)];
            end
        end
    end
end


fsize=20;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Polar Plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AGstepsize=20;
AngleHistEdge=-180:AGstepsize:180;

for expiter=1:4
    Exp(expiter).Angle=rad2deg(Exp(expiter).Angle);
    Exp(expiter).AngleHistCount=histcounts(Exp(expiter).Angle,AngleHistEdge);
    Exp(expiter).AngleHistCount=Exp(expiter).AngleHistCount./sum(Exp(expiter).AngleHistCount);
end

PolarX=deg2rad([-180+(AGstepsize/2):AGstepsize:180-(AGstepsize/2) 180+AGstepsize/2]);
PolarRef=(1/(360/AGstepsize))*ones(size(PolarX));

for expiter=1:4
    figure
    polarplot(PolarX,[Exp(expiter).AngleHistCount Exp(expiter).AngleHistCount(1)],'LineWidth',1.5);
    hold on
    polarplot(PolarX,PolarRef,'LineWidth',0.5,'Color','black');
    title('Reorientation Angle Distribution','FontSize',16);
    legend({Exp(expiter).name,'Reference'},'FontSize',16);
end

figure
for expiter=1:4
    polarplot(PolarX,[Exp(expiter).AngleHistCount Exp(expiter).AngleHistCount(1)],'LineWidth',1.5);
    hold on
end
polarplot(PolarX,PolarRef,'LineWidth',0.5,'Color','black');
title('Reorientation Angle Distribution','FontSize',16);
legend('0-50','50-100','Cold','Hot');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Forward Time Distribution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FLstepsize=20;
FLengthHistEdge=0:FLstepsize:300;

for expiter=1:4
    Exp(expiter).FLengthHistCount=histcounts(Exp(expiter).FLength,FLengthHistEdge);
    Exp(expiter).FLengthHistCount=Exp(expiter).FLengthHistCount./sum(Exp(expiter).FLengthHistCount);
end

FLengthDisX=FLengthHistEdge(1:end-1)+FLstepsize./2;

for expiter=1:4
    figure
    plot(FLengthDisX,Exp(expiter).FLengthHistCount,'LineWidth',1.5);
    xlabel('Run time (s)');
    ylabel('Percentage');
    title('Forward Time Distribution','FontSize',fsize);
    legend(Exp(expiter).name);
    set(gca,'box','off','TickDir','out','FontSize',18)
end

figure
for expiter=1:4
    plot(FLengthDisX,Exp(expiter).FLengthHistCount,'LineWidth',1.5);
    hold on
end
xlabel('Run time (s)');
ylabel('Percentage');
title('Forward Time Distribution');
legend('0-50','50-100','Cold','Hot');
set(gca,'box','off','TickDir','out','FontSize',18)