[date_pt_S1_Joughin_JAK_sorted,II]=sort(date_pt_S1_Joughin_JAK(1,:));
S1_JAK_sorted(:,1)=pt_S1_Joughin_JAK_Npts(II,11);
S1_JAK_sorted(:,2)=pt_S1_Joughin_JAK_Npts(II,17);


figure(1)
plot(n_sorted(:,1),ones(size(pt_TSX_Joughin_JAK_Npts,1)),'Marker','none','LineStyle','none'); hold on;
hold on
plot(date_pt_S1_Joughin_JAK,ones(size(date_pt_S1_Joughin_JAK,2)),'Marker','none','LineStyle','none'); hold on;
xlim([datenum('122008','mmyyyy')  datenum('042017','mmyyyy')])
ylim([1500 7000])
datetick('x','yyyy','keeplimits');
ylabel('velocity [m/yr]','fontsize',12,'fontweight','b')
set(gca,'XGrid','on','YAxisLocation','left')

j=1;
for i=1:size(pt_TSX_Joughin_JAK_Npts,1)
  plot(n_sorted(i,1),pt_TSX_Joughin_JAK_Npts(i,11),'MarkerFaceColor','r','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');hold on;%pad15
  plot(n_sorted(i,1),pt_TSX_Joughin_JAK_Npts(i,17),'MarkerFaceColor','k','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');hold on;%pad15
  %eval(['print -dpng -r300 /nfs/a59/eeagdl/JAK_montagem/Pts_JAK_Js_' num2str(j)]);
  frames(j)=getframe;
j=j+1;
  
end
    
for i=1:size(date_pt_S1_Joughin_JAK_sorted,2)
   plot(date_pt_S1_Joughin_JAK_sorted(1,i),S1_JAK_sorted(i,1),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','r','Marker','^','MarkerEdgeColor','k');hold on; %N6
   plot(date_pt_S1_Joughin_JAK_sorted(1,i),S1_JAK_sorted(i,2),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','k','Marker','^','MarkerEdgeColor','k');hold on; %N6
  %eval(['print -dpng -r300 /nfs/a59/eeagdl/JAK_montagem/Pts_JAK_Js_' num2str(j)]);
   frames(j)=getframe;
   j=j+1;
end


