groupname='50_100';

load(['displacement_' groupname '.mat'])
load(['reori_' groupname '.mat'])

displa = displacement;
reori = eval(['reori_' groupname]);
reori(reori==0)=NaN;

lw=1.5;
ps=20;

for iter=1:size(displa,1)/2
    plot(displa(2*iter-1,:),displa(2*iter,:),'LineWidth',lw)
    hold on
    idx=reori(2*iter-1,:);
    idx=idx(~isnan(idx));
    scatter(displa(2*iter-1,idx),displa(2*iter,idx),ps,'*','r')
    hold on
    pause
end
