load('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/IM_Paper_updated3.mat','date_pt_S1_Joughin_JAK','pt_S1_Joughin_JAK_Npts','date_pt_S1_Joughin_JAK','pt_S1_Joughin_JAK_Npts', 'date_pt_S1_Joughin_JAK','pt_S1_Joughin_JAK_Npts', 'n_sorted_update','n_sorted_2015_', 'mean_velocity_stack_JAK', 'mean_velocity_stack_PG')
load /nfs/a59/eeagdl/s1.mat
load('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/IM_Paper_updated3.mat','position_Ice_Front_S1_JAK_joughinReference','Joughin_2014_IceFront','pt_TSX_Joughin_JAK_Npts_updated','date_Ice_Front_S1_JAK_num');
%%  TSX


ind2= [];ind3= [];ind4=[];

for i=1:size(Joughin_2014_IceFront(:,1),1)

  ind1=find(Joughin_2014_IceFront(i,1)<=n_sorted_update+2 & Joughin_2014_IceFront(i,1)>=n_sorted_update-2);
  
  if (isempty(ind1));
      
  else
  ind3=[ind3;repelem(i,size(ind1,1))'];
  ind4=[ind4;size(ind1,1)];
  ind2=[ind2;ind1];
  end
  
end

ii=find(~isnan(Joughin_2014_IceFront(:,2)));
%plot(pt_TSX_Joughin_JAK_Npts_updated(ind2,11),Joughin_2014_IceFront(ind3,2),'.')

tempJif=pt_TSX_Joughin_JAK_Npts_updated(ind2,28);
tempJ1=pt_TSX_Joughin_JAK_Npts_updated(ind2,11);
tempJ2=pt_TSX_Joughin_JAK_Npts_updated(ind2,17);
temp_Joughin_IF=Joughin_2014_IceFront(ind3,2);
temp_Joughin_date=Joughin_2014_IceFront(ind3,1);


%% Jif

ii=~isnan(pt_S1_Joughin_JAK_Npts(:,28));
nao_nan_date_pt_S1_Joughin_JAK=date_pt_S1_Joughin_JAK(ii);
nao_nan_pt_S1_Joughin_JAK_Npts=pt_S1_Joughin_JAK_Npts(ii,28);

ind=[];ind2=[];
for i=1:size(nao_nan_date_pt_S1_Joughin_JAK,1)
ind1=find(nao_nan_date_pt_S1_Joughin_JAK(i)==date_Ice_Front_S1_JAK_num);
ind2=[ind2; ind1];
if isempty(ind1)
ind=[ind; nan];
else
ind=[ind; ind1];
end
end

ii=find(~isnan(ind));

%plot(nao_nan_pt_S1_Joughin_JAK_Npts(ii),position_Ice_Front_S1_JAK_joughinReference(ind2)/1000,'.')


cloud_Jif=[nao_nan_pt_S1_Joughin_JAK_Npts(ii) ; tempJif];
cloud_Jif_IF=[position_Ice_Front_S1_JAK_joughinReference(ind2)/1000;temp_Joughin_IF];
cloud_Jif_date=[nao_nan_date_pt_S1_Joughin_JAK(ii);temp_Joughin_date];

mean_cloud_Jif=nanmean(cloud_Jif(:));
mean_cloud_Jif_IF=nanmean(cloud_Jif_IF(:));

figure(1)

a = 25;
scatter(cloud_Jif-mean_cloud_Jif,cloud_Jif_IF-mean_cloud_Jif_IF,a,cloud_Jif_date,'filled'); hold on;
cbar=colorbar;
cbdate('yyyy')
xlabel('Velocity anomaly [m/yr]','fontsize',14,'fontweight','b')
ylabel('Calving front anomaly [km]','fontsize',14,'fontweight','b')

xlim([-7000 7000])
ylim([-5 5])

title('Jif','fontsize',14,'fontweight','b')

mdl_cloud_Jif = fitlm(cloud_Jif-mean_cloud_Jif,cloud_Jif_IF-mean_cloud_Jif_IF)

text(-6000,4,['R^2=' num2str(mdl_cloud_Jif.Rsquared.Ordinary)])
%text(-6000,3.5,['RMS=' num2str(mdl_cloud_Jif.RMSE)])

print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/IF_vs_Velo_Jif


%%%% plot 2

figure(2)

a = 25;
scatter(cloud_Jif([1:16 99:184])-mean_cloud_Jif,cloud_Jif_IF([1:16 99:184])-mean_cloud_Jif_IF,a,cloud_Jif_date([1:16 99:184]),'filled'); hold on;
scatter(cloud_Jif([17:98])-mean_cloud_Jif,cloud_Jif_IF([17:98])-mean_cloud_Jif_IF,a,cloud_Jif_date([17:98]),'filled'); 
cbar=colorbar;
cbdate('yyyy')
xlabel('Velocity anomaly [m/yr]','fontsize',14,'fontweight','b')
ylabel('Calving front anomaly [m]','fontsize',14,'fontweight','b')

xlim([-7000 7000])
ylim([-5 5])

title('Jif','fontsize',14,'fontweight','b')

mdl_cloud_Jif_2012_2017 = fitlm(cloud_Jif([1:16 99:184])-mean_cloud_Jif,(cloud_Jif_IF([1:16 99:184])-mean_cloud_Jif_IF)*1000)
mdl_cloud_Jif_2009_2011 = fitlm(cloud_Jif([17:98])-mean_cloud_Jif,(cloud_Jif_IF([17:98])-mean_cloud_Jif_IF)*1000)

text(-6000,4,['R^2=' num2str(round(mdl_cloud_Jif_2009_2011.Rsquared.Ordinary,2)) ' (2009-2011)'],'color','r')
text(-6000,3.3,['R^2=' num2str(round(mdl_cloud_Jif_2012_2017.Rsquared.Ordinary,2)) ' (2012-2017)'])

plot(cloud_Jif([1:16 99:184])-mean_cloud_Jif,mdl_cloud_Jif_2012_2017.Fitted/1000,'-k','linewidth',2)

plot(cloud_Jif([17:98])-mean_cloud_Jif,mdl_cloud_Jif_2009_2011.Fitted/1000,'-r','linewidth',2)
%text(-6000,3.5,['RMS=' num2str(mdl_cloud_Jif.RMSE)])


print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/IF_vs_Velo_Jif_fitted













%% J1


ii=~isnan(pt_S1_Joughin_JAK_Npts(:,11));
nao_nan_date_pt_S1_Joughin_JAK=date_pt_S1_Joughin_JAK(ii);
nao_nan_pt_S1_Joughin_JAK_Npts=pt_S1_Joughin_JAK_Npts(ii,11);

ind=[];ind2=[];
for i=1:size(nao_nan_date_pt_S1_Joughin_JAK,1)
ind1=find(nao_nan_date_pt_S1_Joughin_JAK(i)==date_Ice_Front_S1_JAK_num);
ind2=[ind2; ind1];
if isempty(ind1)
ind=[ind; nan];
else
ind=[ind; ind1];
end
end

ii=find(~isnan(ind));

cloud_J1=[nao_nan_pt_S1_Joughin_JAK_Npts(ii) ; tempJ1];
cloud_J1_IF=[position_Ice_Front_S1_JAK_joughinReference(ind2)/1000;temp_Joughin_IF];
cloud_J1_date=[nao_nan_date_pt_S1_Joughin_JAK(ii);temp_Joughin_date];

mean_cloud_J1=nanmean(cloud_J1(:));
mean_cloud_J1_IF=nanmean(cloud_J1_IF(:));

figure(2)
a = 25;

scatter(cloud_J1-mean_cloud_J1,cloud_J1_IF-mean_cloud_J1_IF,a,cloud_J1_date,'filled'); hold on;
cbar=colorbar;
cbdate('yyyy')
xlabel('Velocity anomaly [m/yr]','fontsize',14,'fontweight','b')
ylabel('Calving front anomaly [km]','fontsize',14,'fontweight','b')

xlim([-1500 1500])
ylim([-5 5])

title('J1','fontsize',14,'fontweight','b')
mdl_cloud_J1 = fitlm(cloud_J1-mean_cloud_J1,cloud_J1_IF-mean_cloud_J1_IF)

text(-1250,4,['R^2=' num2str(mdl_cloud_J1.Rsquared.Ordinary)])



% ylim([4 12])
print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/IF_vs_Velo_J1


%%  J2

ii=~isnan(pt_S1_Joughin_JAK_Npts(:,17));
nao_nan_date_pt_S1_Joughin_JAK=date_pt_S1_Joughin_JAK(ii);
nao_nan_pt_S1_Joughin_JAK_Npts=pt_S1_Joughin_JAK_Npts(ii,17);

ind=[];ind2=[];
for i=1:size(nao_nan_date_pt_S1_Joughin_JAK,1)
ind1=find(nao_nan_date_pt_S1_Joughin_JAK(i)==date_Ice_Front_S1_JAK_num);
ind2=[ind2; ind1];
if isempty(ind1)
ind=[ind; nan];
else
ind=[ind; ind1];
end
end

ii=find(~isnan(ind));

cloud_J2=[nao_nan_pt_S1_Joughin_JAK_Npts(ii) ; tempJ2];
cloud_J2_IF=[position_Ice_Front_S1_JAK_joughinReference(ind2)/1000;temp_Joughin_IF];
cloud_J2_date=[nao_nan_date_pt_S1_Joughin_JAK(ii);temp_Joughin_date];

mean_cloud_J2=nanmean(cloud_J2(:));
mean_cloud_J2_IF=nanmean(cloud_J2_IF(:));

%plot(nao_nan_pt_S1_Joughin_JAK_Npts(ii),position_Ice_Front_S1_JAK_joughinReference(ind2)/1000,'.')
figure(3)

a = 25;
scatter(cloud_J2-mean_cloud_J2,cloud_J2_IF-mean_cloud_J2_IF,a,cloud_J2_date,'filled'); hold on;
cbar=colorbar;
cbdate('yyyy')
xlabel('Velocity anomaly [m/yr]','fontsize',14,'fontweight','b')
ylabel('Calving front anomaly [km]','fontsize',14,'fontweight','b')

xlim([-1000 1000])
ylim([-5 5])

title('J2','fontsize',14,'fontweight','b')
mdl_cloud_J2 = fitlm(cloud_J2-mean_cloud_J2,cloud_J2_IF-mean_cloud_J2_IF)

text(-750,4,['R^2=' num2str(mdl_cloud_J2.Rsquared.Ordinary)])


print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/IF_vs_Velo_J2

%%

figure(1)
a = 25;
c = temp_Joughin_date;
scatter(tempJif-mean_cloud_Jif,temp_Joughin_IF,a,c,'filled');hold on;
cbar=colorbar;
cbdate('yyyy')
xlabel('Velocity [m/yr]','fontsize',14,'fontweight','b')
ylabel('Ice Front Position [km]','fontsize',14,'fontweight','b')

print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/IF_vs_Velo_Jif

figure(2)
scatter(tempJ1-mean_cloud_J1,temp_Joughin_IF,a,c,'filled');hold on;
cbar=colorbar;
cbdate('yyyy')
xlabel('Velocity [m/yr]','fontsize',14,'fontweight','b')
ylabel('Ice Front Position [km]','fontsize',14,'fontweight','b')

print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/IF_vs_Velo_J1

figure(3)
scatter(tempJ2-mean_cloud_J2,temp_Joughin_IF,a,c,'filled');hold on;
cbar=colorbar;
cbdate('yyyy')
xlabel('Velocity [m/yr]','fontsize',14,'fontweight','b')
ylabel('Ice Front Position [km]','fontsize',14,'fontweight','b')

print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/IF_vs_Velo_J2



