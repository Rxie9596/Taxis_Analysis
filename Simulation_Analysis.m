load('simulation_data');
TraNum=10000;
TraLength=30;
Angle_Sample=reshape(Angle_Sample,[TraNum,TraLength]);
FTime_Sample=reshape(FTime_Sample,[TraNum,TraLength]);
v=1;

Xpos=zeros(TraNum,TraLength+1);
Ypos=zeros(TraNum,TraLength+1);

for traiter=1:TraNum
    for pointiter=1:TraLength
        Xpos(traiter,pointiter+1)=Xpos(traiter,pointiter)+FTime_Sample(traiter,pointiter).*v.*cos(Angle_Sample(traiter,pointiter));
        Ypos(traiter,pointiter+1)=Ypos(traiter,pointiter)+FTime_Sample(traiter,pointiter).*v.*sin(Angle_Sample(traiter,pointiter));
    end
end

% scatter(0,0,200,'filled','d','MarkerFaceColor','r','MarkerEdgeColor','r')
% grid on
% hold on

% for plotiter=1:5
%     plot(Xpos(plotiter,:),Ypos(plotiter,:),'LineWidth',1.5)
%     hold on 
% end
% title('5 simulation trajectory')
% set(gca,'box','off','TickDir','out','FontSize',18)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Heatmap
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xpos_vec=[];
Ypos_vec=[];
for traiter=1:TraNum
    Xpos_vec=[Xpos_vec Xpos(traiter,5:end)];
    Ypos_vec=[Ypos_vec Ypos(traiter,5:end)];
end

hist3([Xpos_vec',Ypos_vec'],'CDataMode','auto','FaceColor','interp','Nbins',[100 100])
xlabel('X axis')
ylabel('Y axis')
title('Trajectory Density Distribution (Starting from 5th step)')