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
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fsize=20;

FLstepsize=20;
FLengthHistEdge=0:FLstepsize:300;

FLengthDis=[];
for expiter=1:4
    FLengthDis=[FLengthDis Exp(expiter).FLength];
end

FLengthHistCount=histcounts(FLengthDis,FLengthHistEdge);
FLengthHistCount=FLengthHistCount./sum(FLengthHistCount);


FLengthDisX=FLengthHistEdge(1:end-1)+FLstepsize./2;
figure
plot(FLengthDisX,FLengthHistCount,'LineWidth',1.5);
xlabel('Run time (s)');
ylabel('Percentage');
title('Forward Time Distribution');
legend(Exp(expiter).name);
set(gca,'box','off','TickDir','out','FontSize',18)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AGstepsize=15;
AngleHistEdge=-180:AGstepsize:180;

for expiter=1:4
    Exp(expiter).Angle=rad2deg(Exp(expiter).Angle);
    Exp(expiter).AngleHistCount=histcounts(Exp(expiter).Angle,AngleHistEdge);
    Exp(expiter).AngleHistCount=Exp(expiter).AngleHistCount./sum(Exp(expiter).AngleHistCount);
end
AngleDis=Exp(2).AngleHistCount;

PolarX=deg2rad([-180+(AGstepsize/2):AGstepsize:180-(AGstepsize/2) 180+AGstepsize/2]);
PolarRef=(1/(360/AGstepsize))*ones(size(PolarX));

p1 =   1.015e-14;
p2 =  -1.752e-11;
p3 =  -1.988e-09;
p4 =   9.397e-07;
p5 =   5.144e-05;
p6 =     0.03515;
f1=@(x) p1.*x.^5 + p2.*x.^4 + p3.*x.^3 + p4.*x.^2 + p5.*x + p6;

AngleFit=f1(rad2deg(PolarX(1:end-1)));
figure
polarplot(PolarX,[AngleDis AngleDis(1)],'LineWidth',1.5);
hold on
polarplot(PolarX,PolarRef,'LineWidth',0.5,'Color','black');
hold on
polarplot(PolarX,[AngleFit AngleFit(1)],'LineWidth',1.5);
title('Reorientation Angle Distribution','FontSize',16);
legend('50-100','reference','Fit');


% figure
% plot(rad2deg(PolarX),[AngleDis AngleDis(1)],'LineWidth',1.5);
% hold on
% plot(rad2deg(PolarX),PolarRef,'LineWidth',0.5,'Color','black');
% title('Reorientation Angle Distribution','FontSize',16);
% legend('50-100');
% set(gca,'box','off','TickDir','out','FontSize',18)

% Xfit=rad2deg(PolarX);
% Yfit=[AngleDis AngleDis(1)];