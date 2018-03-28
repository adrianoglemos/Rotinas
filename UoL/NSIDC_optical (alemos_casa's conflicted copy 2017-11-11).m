pathsate_opt=['/nfs/a59/eeagdl/DATABASE/GREENLAND/Optical_velocity/JAK/'];
d_opt=dir(pathsate_opt);
j=1;
for i=48:length(d_opt);
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name


j=1;
for i=[1:length(list_opt)];
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    
    date=list_opt{i,1};
    
cd(path1);

eval(['[velx,Ropt_' date(13:16) '_' date(18:19) ']=geotiffread(''OPT_W69.10N_' date(13:end) '.vx.tif'');']);
eval(['vely=imread(''OPT_W69.10N_' date(13:end) '.vy.tif'');']);

eval(['Vel_opt_' date(13:16) '_' date(18:19) '=sqrt((velx.^2)+(vely.^2));']);

eval(['[row,col] = map2pix(Ropt_' date(13:16) '_' date(18:19) ',X_p_curve_JAK,Y_p_curve_JAK);']);
eval(['vel=Vel_opt_' date(13:16) '_' date(18:19) ';']);

vel(vel>=1.4140e+05)=nan;
eval(['prof_opt(:,' num2str(j) ')=improfile(vel,col(~isnan(col)),row(~isnan(row)));']);
subplot(3,3,i);
h=imagesc(vel);
tt=double(~isnan(vel)); set(h,'AlphaData', tt);
axis off;
caxis([0 8000])

j=j+1;
clear velx vely date vel row col

end

c=colorbar('location','south','Position',...
    [0.60150709219858 0.0485159817351597 0.299645390070922 0.045662100456621]);
annotation(gcf,'textbox',...
    [0.726190476190475 0.048382717100611 0.0992063466439803 0.0529100518588245],...
    'String',{'m.yr^{-1}'},...
    'LineStyle','none',...
    'FitBoxToText','off');

%%% Dist relative to the prof_curve_JAK

%dist=0:((0.048957*999)/(length(prof_curve_JAK)-1)):(0.048957*999);

load('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/IM_paper.mat','dist')

figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
for i=1:8
   
    plot(dist(1,:),prof_opt(:,i)/1000,'.'); hold on
          
end

%  B_=nan(2,3);
%  B_(:,1)=[-2000;20000];
%  B_(:,2)=889*0.047949;
 ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
 xlabel('distance [km]','fontsize',12,'fontweight','b')
 hold on;
%  plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
 xlim([0 (0.048957*999)+1]);
 ylim(gca,[0 16]);
 set(gca,'XTick',[0:5:45])
 set(gca,'YTick',[0:2:16])
 grid on;
 legend('10/2014','02/2015','03/2015','04/2015','05/2015','06/2015','07/2015','08/2015','location','northeast');

 
 
 figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
for i=1:19
   
    plot(dist(1,:),prof_curve_JAK(:,i),'.'); hold on
       
end
%  B_=nan(2,3);
%  B_(:,1)=[-2000;20000];
%  B_(:,2)=889*0.047949;
 ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
 xlabel('distance [km]','fontsize',12,'fontweight','b')
 hold on;
%  plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
 xlim([0 (0.048957*999)+1]);
 ylim(gca,[0 16]);
 set(gca,'XTick',[0:5:45])
 set(gca,'YTick',[0:2:16])
 grid on;

 
 
 
 
 
 scale=1.1;
 scale_grid=0.9;
 Z = resizem(Vel_opt_2014_10,scale);
RR=Ropt_2014_10; %Backup
 RR.CellExtentInWorldX=Ropt_2014_10.CellExtentInWorldX*scale_grid;
 RR.CellExtentInWorldY=Ropt_2014_10.CellExtentInWorldY*scale_grid;
 RR.RasterSize=size(Z);
 
 load('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/Velocities_JAK.mat', 'Vel_map_1','Rs1_1')
 [X,Y] = meshgrid([1:965],[1:823]);
 [x,y] = pix2map(RR,X(:),Y(:));
 [lin,col]=map2pix(Rs1_1,x,y);
 [cx,cy,zz]=improfile(Vel_map_1,col, lin);
 
 sub=griddata(cy,cx,zz,cy,cx);
 mat=nan(2616,3110);
 for i=1:length(cx)
 mat(fix(cy(i)),fix(cx(i)))=zz(i);
 end
 
 ind=~isnan(dif(:));
 dif_col=dif(:);
 rms_dif=rms(dif_col(ind));
 
 imagesc(mat)
caxis([0 8])


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% feb: 4:5
% mar: 6:8
% ap: 8:10
% may: 10:12
% jun: 12
% jul: 13
% aug: 13:16
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


prof_curve_JAK_fev=mean(prof_curve_JAK(:,4:5),2);
prof_curve_JAK_mar=mean(prof_curve_JAK(:,6:8),2);
prof_curve_JAK_apr=mean(prof_curve_JAK(:,8:10),2);
prof_curve_JAK_may=mean(prof_curve_JAK(:,10:12),2);
prof_curve_JAK_jun=mean(prof_curve_JAK(:,12),2);
prof_curve_JAK_jul=mean(prof_curve_JAK(:,13),2);
prof_curve_JAK_aug=mean(prof_curve_JAK(:,13:16),2);

mdl_fev = fitlm(prof_curve_JAK_fev,prof_opt(:,2)/1000);
mdl_mar = fitlm(prof_curve_JAK_mar,prof_opt(:,3)/1000);
mdl_apr = fitlm(prof_curve_JAK_apr,prof_opt(:,4)/1000);
mdl_may = fitlm(prof_curve_JAK_may,prof_opt(:,5)/1000);
mdl_jun = fitlm(prof_curve_JAK_jun,prof_opt(:,6)/1000);
mdl_jul = fitlm(prof_curve_JAK_jul,prof_opt(:,7)/1000);
mdl_aug = fitlm(prof_curve_JAK_aug,prof_opt(:,8)/1000);


% Plotting the comparison between the mean profile extracted and the profile from NSIDC:

mdl_JAK = fitlm(nanmean(prof_curve_JAK(:,4:16),2),nanmean(prof_opt(:,2)/1000,2));

figure;
plot(nanmean(prof_curve_JAK(:,4:16),2),nanmean(prof_opt(:,2)/1000,2),'.');hold on
plot(nanmean(prof_curve_JAK(:,4:16),2),mdl_JAK.Fitted,'k');
xlim([0 15]);
ylim([0 15]);
xlabel('Sentinel-1 velocity [m/yr]','fontsize',12,'fontweight','b');
ylabel('NSIDC optical velocity [m/yr]','fontsize',12,'fontweight','b');
title('Jakobshavn Isbræ','fontsize',12,'fontweight','b');


% Plotting the comparison between the profile extracted and the profile from NSIDC:

figure;
subplot(3,3,1);
plot(prof_curve_JAK_fev,prof_opt(:,2)/1000,'.'); hold on;
plot(prof_curve_JAK_fev,mdl_fev.Fitted,'k');
xlim([0 12]);
ylim([0 12]);
%grid on;
%plot([0 12000],[0 12000],'k');
% xlabel('S1a velocity [m/yr]');
% ylabel('NSIDC optical velocity [m/yr]');
title('February 2015');

subplot(3,3,2);
plot(prof_curve_JAK_mar,prof_opt(:,3)/1000,'.'); hold on;
plot(prof_curve_JAK_mar,mdl_mar.Fitted,'k');
xlim([0 12]);
ylim([0 12]);
% grid on;
% plot([0 12000],[0 12000],'k');
% xlabel('S1a velocity [m/yr]');
% ylabel('NSIDC optical velocity [m/yr]');
title('March 2015');


subplot(3,3,3);
plot(prof_curve_JAK_apr,prof_opt(:,4)/1000,'.'); hold on;
plot(prof_curve_JAK_apr,mdl_apr.Fitted,'k');
xlim([0 12]);
ylim([0 12]);
% grid on;
% plot([0 12000],[0 12000],'k');
% xlabel('S1a velocity [m/yr]');
% ylabel('NSIDC optical velocity [m/yr]');
title('April 2015');

subplot(3,3,4);
plot(prof_curve_JAK_may,prof_opt(:,5)/1000,'.'); hold on;
plot(prof_curve_JAK_may,mdl_may.Fitted,'k');
xlim([0 12]);
ylim([0 12]);
% grid on;
% plot([0 12000],[0 12000],'k');
% xlabel('S1a velocity [m/yr]');
% ylabel('NSIDC optical velocity [m/yr]');
title('May 2015');

subplot(3,3,5);
plot(prof_curve_JAK_jun,prof_opt(:,6)/1000,'.'); hold on;
plot(prof_curve_JAK_jun,mdl_jun.Fitted,'k');
xlim([0 12]);
ylim([0 12]);
% grid on;
% plot([0 12000],[0 12000],'k');
% xlabel('S1a velocity [m/yr]');
% ylabel('NSIDC optical velocity [m/yr]');
title('June 2015');

subplot(3,3,6);
plot(prof_curve_JAK_jul,prof_opt(:,7)/1000,'.'); hold on;
plot(prof_curve_JAK_jul,mdl_jul.Fitted,'k');
xlim([0 12]);
ylim([0 12]);
% grid on;
% plot([0 12000],[0 12000],'k');
% xlabel('S1a velocity [m/yr]');
% ylabel('NSIDC optical velocity [m/yr]');
title('July 2015');

subplot(3,3,8);
plot(prof_curve_JAK_aug,prof_opt(:,8)/1000,'.'); hold on;
plot(prof_curve_JAK_aug,mdl_aug.Fitted,'k');
xlim([0 12]);
ylim([0 12]);
% grid on;
% plot([0 12000],[0 12000],'k');
xlabel('S1a velocity [m/yr]','fontsize',24);
ylabel('NSIDC optical velocity [m/yr]','fontsize',24);
title('August 2015');

print -dpng -r300 /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/Profiles/JAK/S1_X_NSIDC_Monthly_filtered2

% Plot velocities same graph

figure;
subplot(3,3,1);
plot(dist(1,:),prof_opt(:,2),'.'); hold on;
plot(dist(1,:),prof_curve_JAK_fev*1000,'.');
grid on;
legend('NSIDC optical','S1a','location','northwest')
xlim([0 50]);
ylim([0 14000]);
% xlabel('distance [km]');
% ylabel('Velocity magnitude [m/yr]');
title('February 2015');

subplot(3,3,2);
plot(dist(1,:),prof_opt(:,3),'.'); hold on;
plot(dist(1,:),prof_curve_JAK_mar*1000,'.');
grid on;
xlim([0 50]);
ylim([0 14000]);
%legend('NSIDC optical','S1a','location','northwest')
% xlabel('distance [km]');
% ylabel('Velocity magnitude [m/yr]');
title('March 2015');


subplot(3,3,3);
plot(dist(1,:),prof_opt(:,4),'.'); hold on;
plot(dist(1,:),prof_curve_JAK_apr*1000,'.');
grid on;
xlim([0 50]);
ylim([0 14000]);
%legend('NSIDC optical','S1a','location','northwest')
% xlabel('distance [km]');
% ylabel('Velocity magnitude [m/yr]');
title('April 2015');

subplot(3,3,4);
plot(dist(1,:),prof_opt(:,5),'.'); hold on;
plot(dist(1,:),prof_curve_JAK_may*1000,'.');
grid on;
xlim([0 50]);
ylim([0 14000]);
%legend('NSIDC optical','S1a','location','northwest')
% xlabel('distance [km]');
% ylabel('Velocity magnitude [m/yr]');
title('May 2015');

subplot(3,3,5);
plot(dist(1,:),prof_opt(:,6),'.'); hold on;
plot(dist(1,:),prof_curve_JAK_jun*1000,'.');
grid on;
xlim([0 50]);
ylim([0 14000]);
%legend('NSIDC optical','S1a','location','northwest')
% xlabel('distance [km]');
% ylabel('Velocity magnitude [m/yr]');
title('June 2015');

subplot(3,3,6);
plot(dist(1,:),prof_opt(:,7),'.'); hold on;
plot(dist(1,:),prof_curve_JAK_jul*1000,'.');
grid on;
%legend('NSIDC optical','S1a','location','northwest')
xlim([0 50]);
ylim([0 14000]);
% xlabel('distance [km]');
% ylabel('Velocity magnitude [m/yr]');
title('July 2015');

subplot(3,3,8);
plot(dist(1,:),prof_opt(:,8),'.'); hold on;
plot(dist(1,:),prof_curve_JAK_aug*1000,'.');
grid on;
%legend('NSIDC optical','S1a','location','northwest')
xlim([0 50]);
ylim([0 14000]);
xlabel('distance [km]','fontsize',24);
ylabel('Velocity magnitude [m/yr]','fontsize',24);
title('August 2015');

print -dpng -r300 /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/Profiles/JAK/S1_X_NSIDC_Monthly_Velocities_filtered


%% Joughin Velocity

cd /nfs/a59/eeagdl/DATABASE/GREENLAND/Joughin_Data_GRIS/GRIS_mosaic
!cp /nfs/a59/eeagdl/Dropbox/Rotinas/UoL/profile_ext.m ./

[Vel_Joughin_2015,R_Joughin_2015]=geotiffread('greenland_vel_mosaic250_v1.tif');

prof_Joughin_2015_JAK=profile_ext(X_p_curve_JAK,Y_p_curve_JAK,Vel_Joughin_2015,R_Joughin_2015);

mdl_JAK_Joughin_2015 = fitlm(nanmean(prof_curve_JAK,2),prof_Joughin_2015_JAK/1000);

figure;
plot(nanmean(prof_curve_JAK,2),nanmean(prof_Joughin_2015_JAK/1000,2),'.');hold on
plot(nanmean(prof_curve_JAK,2),mdl_JAK_Joughin_2015.Fitted,'k');
xlim([0 15]);
ylim([0 15]);
xlabel('Sentinel-1 velocity [km/yr]','fontsize',12,'fontweight','b');
ylabel('InSAR velocity NSIDC [km/yr]','fontsize',12,'fontweight','b');
title('Jakobshavn Isbræ','fontsize',12,'fontweight','b');

% Histogram: S1-InSAR
S1_minus_Joughin_JAK=nanmean(prof_curve_JAK,2)-nanmean(prof_Joughin_2015_JAK/1000,2);
figure,hist(S1_minus_Joughin_JAK,[-2:0.2:2])
xlim([-2 2])
title('Jakobshavn Isbræ','fontsize',12,'fontweight','b');
% Fig: /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Hist_S1_minus_Joughin_JAK.png

% PG

prof_Joughin_2015_PG=profile_ext(X_p_curve_PG,Y_p_curve_PG,Vel_Joughin_2015,R_Joughin_2015);
dist_PG2=0:((0.1916*999)/(length(prof_Joughin_2015_PG)-1)):(0.1916*999);

prof_curve_PG_interp = interp1(dist_PG,nanmean(prof_curve_PG,2),dist_PG2);
mdl_PG_Joughin_2015 = fitlm(prof_curve_PG_interp/1000,prof_Joughin_2015_PG/1000);

figure;
plot(prof_curve_PG_interp/1000,prof_Joughin_2015_PG/1000,'.');hold on
plot(prof_curve_PG_interp/1000,mdl_PG_Joughin_2015.Fitted,'k');
xlim([0 1.4]);
ylim([0 1.4]);
xlabel('Sentinel-1 velocity [km/yr]','fontsize',12,'fontweight','b');
ylabel('InSAR velocity NSIDC [km/yr]','fontsize',12,'fontweight','b');
title('Petermann Glacier','fontsize',12,'fontweight','b');

% Histogram: S1-InSAR
S1_minus_Joughin_PG=(prof_curve_PG_interp'/1000)-(prof_Joughin_2015_PG/1000);
figure,hist(S1_minus_Joughin_PG,[-0.1:0.01:0.1]) 
title('Petermann Glacier','fontsize',12,'fontweight','b');
xlim([-0.1 0.1])
% Fig: /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Hist_S1_minus_Joughin_PG.png

% PG removing the first 250 points

prof_curve_PG_interp = interp1(dist_PG,nanmean(prof_curve_PG,2),dist_PG2);
mdl_PG_Joughin_2015_250 = fitlm(prof_curve_PG_interp(250:end)/1000,prof_Joughin_2015_PG(250:end)/1000);

figure;
plot(prof_curve_PG_interp(250:end)/1000,prof_Joughin_2015_PG(250:end)/1000,'.');hold on
plot(prof_curve_PG_interp(250:end)/1000,mdl_PG_Joughin_2015_250.Fitted,'k');
xlim([0 1.4]);
ylim([0 1.4]);
xlabel('Sentinel-1 velocity [km/yr]','fontsize',12,'fontweight','b');
ylabel('InSAR velocity NSIDC [km/yr]','fontsize',12,'fontweight','b');
title('Petermann Glacier','fontsize',12,'fontweight','b');

% Histogram: S1-InSAR
S1_minus_Joughin_PG_250=(prof_curve_PG_interp(250:end)'/1000)-(prof_Joughin_2015_PG(250:end)/1000);
figure,hist(S1_minus_Joughin_PG_250,[-0.1:0.01:0.1]) 
title('Petermann Glacier','fontsize',12,'fontweight','b');
xlim([-0.1 0.1])

% Fig: /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Hist_S1_minus_Joughin_PG250.png

% FJ

prof_Joughin_2015_FJ=profile_ext(X_p_curve_FJ,Y_p_curve_FJ,Vel_Joughin_2015,R_Joughin_2015);
dist_FJ2=0:((0.1916*999)/(length(prof_Joughin_2015_FJ)-1)):(0.1916*999);

prof_curve_FJ_interp = interp1(dist_FJ,nanmean(prof_curve_FJ,2),dist_FJ2);
mdl_FJ_Joughin_2015 = fitlm(prof_curve_FJ_interp/1000,prof_Joughin_2015_FJ/1000);

figure;
plot(prof_curve_FJ_interp/1000,prof_Joughin_2015_FJ/1000,'.');hold on
plot(prof_curve_FJ_interp/1000,mdl_FJ_Joughin_2015.Fitted,'k');
xlim([0 1.6]);
ylim([0 1.6]);
xlabel('Sentinel-1 velocity [km/yr]','fontsize',12,'fontweight','b');
ylabel('InSAR velocity NSIDC [km/yr]','fontsize',12,'fontweight','b');
title('79-Fjord','fontsize',12,'fontweight','b');

% Histogram: S1-InSAR
S1_minus_Joughin_FJ=prof_curve_FJ_interp'/1000-prof_Joughin_2015_FJ/1000;
figure,hist(S1_minus_Joughin_FJ,[-0.1:0.01:0.1]) 
title('79-Fjord','fontsize',12,'fontweight','b');
xlim([-0.1 0.1])

% Fig: /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Hist_S1_minus_Joughin_FJ.png









