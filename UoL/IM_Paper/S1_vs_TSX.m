% 
% % mdl_pt_JAK3_5window_mean = fitlm(data_str_JAK_num,pt_JAK3_5window_mean/1000);
% [n_sorted_update_unique, index] = unique(n_sorted_update); 
% 
% fit_Jif=pchip(n_sorted_update_unique,pt_TSX_Joughin_JAK_Npts_updated(index,28),[735905:736706]');
% 
% ind2= [];ind3= [];ind4=[];
% 
% for i=1:size(date_pt_S1_Joughin_JAK,1)
% 
%   ind1=find(date_pt_S1_Joughin_JAK(i)==n_sorted_update_unique);
%   
%   if (isempty(ind1));
%       
%   else
%   ind3=[ind3;repelem(i,size(ind1,1))'];
%   ind4=[ind4;size(ind1,1)];
%   ind2=[ind2;ind1];
%   end
%   
% end
% 
% pt_TSX_Joughin_JAK_Npts_updated_unique=fit_Jif;
% 
% diff1=pt_S1_Joughin_JAK_Npts(ind3,11)-pt_TSX_Joughin_JAK_Npts_updated_unique(ind2,11);
% diff1_ind=~isnan(diff1);
% rms_diff1=rms(diff1(diff1_ind))
% 
% diff2=pt_S1_Joughin_JAK_Npts(ind3,17)-pt_TSX_Joughin_JAK_Npts_updated_unique(ind2,17);
% diff2_ind=~isnan(diff2);
% rms_diff2=rms(diff2(diff2_ind))
% 
% diff3=pt_S1_Joughin_JAK_Npts(ind3,28)-fit_Jif(ind2);
% diff3_ind=~isnan(diff3);
% rms_diff3=rms(diff3(diff3_ind))
% 
load('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/IM_Paper_updated3.mat', 'dist_if_JAK', 'dist_JAK_fill', 'n_sorted_update', 'n_sorted_2015_', 'n_sorted_2015', 'date_pt_S1_Joughin_JAK','pt_S1_Joughin_JAK_Npts','pt_TSX_Joughin_JAK_Npts_updated','pt_Error_TSX_Joughin_JAK_Npts_updated')

load /nfs/a59/eeagdl/s1.mat


ind2= [];ind3= [];ind4=[];

for i=1:size(date_pt_S1_Joughin_JAK,1)

  ind1=find(date_pt_S1_Joughin_JAK(i)<=n_sorted_update+2 & date_pt_S1_Joughin_JAK(i)>=n_sorted_update-2);
  
  if (isempty(ind1));
      
  else
  ind3=[ind3;repelem(i,size(ind1,1))'];
  ind4=[ind4;size(ind1,1)];
  ind2=[ind2;ind1];
  end
  
end

% temporario=pt_S1_noise;
% pt_S1_noise=[pt_S1_noise(1:67,:);nan nan nan nan;pt_S1_noise(68:end,:)];
% 
% %plot(date_pt_S1_Joughin_JAK(ind3),n_sorted_update(ind2),'.')
% plot(date_pt_S1_Joughin_JAK(ind3),n_sorted_update(ind2),'.')
% plot(pt_S1_Joughin_JAK_Npts(ind3,28),pt_TSX_Joughin_JAK_Npts_updated(ind2,28),'.'); hold on;
% 
% plot(date_pt_S1_Joughin_JAK(ind3),pt_S1_Joughin_JAK_Npts(ind3,28),'.')
% hold on
% plot(n_sorted_update(ind2),pt_TSX_Joughin_JAK_Npts_updated(ind2,28),'.')
% 
%figure('PaperOrientation','landscape','position',[1 1 820 625])
subplot(1,3,1)
%errorbarxy(pt_S1_Joughin_JAK_Npts(ind3,28),pt_TSX_Joughin_JAK_Npts_updated(ind2,28),pt_S1_noise(ind3,3),pt_Error_TSX_Joughin_JAK_Npts_updated(ind2,28),{'w.', 'k', 'k'});hold on;
plot(pt_S1_Joughin_JAK_Npts(ind3,28),pt_TSX_Joughin_JAK_Npts_updated(ind2,28),'k.'); hold on;
%xlabel('Sentinel 1-a/b [m/yr]','fontsize',12,'fontweight','b');
ylabel('TSX [m/yr]','fontsize',16,'fontweight','b');
xlim([7000 11200]); ylim([7000 11200]);
plot([7000 11200],[7000 11200],':k');
title('Jif','fontsize',12,'fontweight','b');
annotation(gcf,'textbox',[0.13 0.80 0.125 0.08],'String',{'rms: 465 m.yr^{-1}'},...
    'LineStyle','none','FitBoxToText','off');

set(gca,'YTick',[6000:1000:11200],'fontsize',10)
set(gca,'XTick',[6000:1000:13000],'fontsize',10)
annotation(gcf,'textbox',[0.13 0.76 0.125 0.08],'String',{'error:'},...
    'LineStyle','none','FitBoxToText','off');
plot([7100 7100+nanmean(pt_S1_noise(ind3,3))],[10400 10400],'k');
plot([7100 7100],[10400 10400+nanmean(pt_Error_TSX_Joughin_JAK_Npts_updated(ind2,28))],'k');


subplot(1,3,2)
%errorbarxy(pt_TSX_Joughin_JAK_Npts_updated(ind2,11),pt_S1_Joughin_JAK_Npts(ind3,11),pt_Error_TSX_Joughin_JAK_Npts_updated(ind2,11),pt_S1_noise(ind3,1),{'w.', 'k', 'k'});hold on;
plot(pt_S1_Joughin_JAK_Npts(ind3,11),pt_TSX_Joughin_JAK_Npts_updated(ind2,11),'k.'); hold on;
xlabel('Sentinel 1-a/b [m/yr]','fontsize',16,'fontweight','b');
%ylabel('TSX [m/yr]','fontsize',12,'fontweight','b');
xlim([4500 5700]); ylim([4500 5700]);
plot([4500 5700],[4500 5700],':k');
title('J1','fontsize',12,'fontweight','b');
annotation(gcf,'textbox',[0.41 0.80 0.125 0.08],'String',{'rms: 97 m.y^{-1}'},...
    'LineStyle','none','FitBoxToText','off');
%set(gca,'YTickLabel',[8000:2000:16000],'fontsize',10)
set(gca,'YTick',[4500:500:5500],'fontsize',10)
set(gca,'XTick',[4500:500:5500],'fontsize',10)

annotation(gcf,'textbox',[0.41 0.76 0.125 0.08],'String',{'error:'},...
    'LineStyle','none','FitBoxToText','off');
plot([4525 4525+nanmean(pt_S1_noise(ind3,1))],[5450 5450],'k');
plot([4525 4525],[5450 5450+nanmean(pt_Error_TSX_Joughin_JAK_Npts_updated(ind2,11))],'k');




subplot(1,3,3)
%errorbarxy(pt_S1_Joughin_JAK_Npts(ind3,17),pt_TSX_Joughin_JAK_Npts_updated(ind2,17),pt_S1_noise(ind3,2),pt_Error_TSX_Joughin_JAK_Npts_updated(ind2,17),{'w.', 'k', 'k'});hold on;
plot(pt_S1_Joughin_JAK_Npts(ind3,17),pt_TSX_Joughin_JAK_Npts_updated(ind2,17),'k.'); hold on;
xlabel('Sentinel 1-a/b [m/yr]','fontsize',12,'fontweight','b');
ylabel('TSX [m/yr]','fontsize',12,'fontweight','b');
xlim([3300 4100]); ylim([3300 4100]);
plot([3300 4100],[3300 4100],'k');
title('J2','fontsize',12,'fontweight','b');
annotation(gcf,'textbox',[0.69 0.80 0.125 0.08],'String',{'rms: 111m/yr'},...
    'LineStyle','none','FitBoxToText','off');
set(gca,'YTick',[3400:200:4000],'fontsize',10)
set(gca,'XTick',[3400:200:4000],'fontsize',10)

annotation(gcf,'textbox',[0.69 0.76 0.125 0.08],'String',{'error:'},...
    'LineStyle','none','FitBoxToText','off');
plot([3325 3325+nanmean(pt_S1_noise(ind3,2))],[3940 3940],'k');
plot([3325 3325],[3940 3940+nanmean(pt_Error_TSX_Joughin_JAK_Npts_updated(ind2,17))],'k');


print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/S1_vs_TSX

% diff1=J1 ; diff2=J2 ; diff3=Jif;

diff1=pt_S1_Joughin_JAK_Npts(ind3,11)-pt_TSX_Joughin_JAK_Npts_updated(ind2,11);
diff1_ind=~isnan(diff1);
rms_diff1=rms(diff1(diff1_ind))
mean_diff1=nanmean(diff1(:))

diff2=pt_S1_Joughin_JAK_Npts(ind3,17)-pt_TSX_Joughin_JAK_Npts_updated(ind2,17);
diff2_ind=~isnan(diff2);
rms_diff2=rms(diff2(diff2_ind))
mean_diff1=nanmean(diff2(:))

diff3=pt_S1_Joughin_JAK_Npts(ind3,28)-pt_TSX_Joughin_JAK_Npts_updated(ind2,28);
diff3_ind=~isnan(diff3);
rms_diff3=rms(diff3(diff3_ind))
mean_diff1=nanmean(diff3(:))

figure

plot(pt_S1_Joughin_JAK_Npts(ind3,28),pt_TSX_Joughin_JAK_Npts_updated(ind2,28),'b.'); hold on;
plot(pt_S1_Joughin_JAK_Npts(ind3,11),pt_TSX_Joughin_JAK_Npts_updated(ind2,11),'k.'); 
plot(pt_S1_Joughin_JAK_Npts(ind3,17),pt_TSX_Joughin_JAK_Npts_updated(ind2,17),'r.');
% errorbarxy(pt_S1_Joughin_JAK_Npts(ind3,17),pt_TSX_Joughin_JAK_Npts_updated(ind2,17),pt_S1_noise(ind3,2),pt_Error_TSX_Joughin_JAK_Npts_updated(ind2,17),{'w.', 'r', 'r'});hold on;
% errorbarxy(pt_S1_Joughin_JAK_Npts(ind3,11),pt_TSX_Joughin_JAK_Npts_updated(ind2,11),pt_S1_noise(ind3,1),pt_Error_TSX_Joughin_JAK_Npts_updated(ind2,11),{'w.', 'k', 'k'});hold on;
% errorbarxy(pt_S1_Joughin_JAK_Npts(ind3,28),pt_TSX_Joughin_JAK_Npts_updated(ind2,28),pt_S1_noise(ind3,3),pt_Error_TSX_Joughin_JAK_Npts_updated(ind2,28),{'w.', 'b', 'b'});hold on;

xlabel('Sentinel 1-a/b [m/yr]','fontsize',14,'fontweight','b');
ylabel('TSX [m/yr]','fontsize',14,'fontweight','b');
legend('Jif: rms=465 m/yr', 'J1: rms=97 m/yr', 'J2: rms=111 m/yr','location','northwest');

xlim([3300 11500]); ylim([3300 11500]);
plot([3300 11500],[3300 11500],':k');

annotation(gcf,'textbox',[0.16 0.73 0.125 0.08],'String',{'error:'},...
    'LineStyle','none','FitBoxToText','off');

plot([3800 3800+nanmean(pt_S1_noise(ind3,2))],[9800 9800],'r');
plot([3800 3800],[9800 9800+nanmean(pt_Error_TSX_Joughin_JAK_Npts_updated(ind2,17))],'r');

plot([3800 3800+nanmean(pt_S1_noise(ind3,1))],[9700 9700],'k');
plot([3800 3800],[9700 9700+nanmean(pt_Error_TSX_Joughin_JAK_Npts_updated(ind2,11))],'k');

plot([3800 3800+nanmean(pt_S1_noise(ind3,3))],[9600 9600],'b');
plot([3800 3800],[9600 9600+nanmean(pt_Error_TSX_Joughin_JAK_Npts_updated(ind2,28))],'b');


print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/S1_vs_TSX_plot2


title('J1','fontsize',12,'fontweight','b');

subplot(1,3,3)
 hold on;
% xlabel('Sentinel 1-a/b [m/yr]','fontsize',12,'fontweight','b');
% ylabel('TSX [m/yr]','fontsize',12,'fontweight','b');
xlim([ 4100]); ylim([3300 4100]);
plot([3300 4100],[3300 4100],'k');
title('J2','fontsize',12,'fontweight','b');

subplot(1,3,1)
%xlabel('Sentinel 1-a/b [m/yr]','fontsize',12,'fontweight','b');
ylabel('TSX [m/yr]','fontsize',16,'fontweight','b');
xlim([7000 11500]); ylim([7000 11500]);
plot([7000 11500],[7000 11500],'k');
title('Jif','fontsize',12,'fontweight','b');





