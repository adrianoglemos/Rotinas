load('/nfs/a59/eeagdl/Petterman_S1/SNRs.mat')
load('/nfs/a59/eeagdl/Petterman_S1/mov_median_S1_ERS.mat')

prof_shp = shaperead('/nfs/a59/eeagdl/Petterman_S1/S1_arcgis/Profile2_projLine.shp');
X_p=extractfield(prof_shp,'X');
Y_p=extractfield(prof_shp,'Y');

X_p=X_p(~isnan(X_p));
Y_p=Y_p(~isnan(Y_p));

%Importing the NSIDC Greenland velocity map and extracting the data along the profile:

[NSIDC_map,Rnsidc]=geotiffread('/nfs/a59/eeagdl/Data/Velocity_NSIDC/greenland_vel_mosaic500_2008_2009_sp.tif');

[row_NSIDC,col_NSIDC]=map2pix(Rnsidc,X_p,Y_p);
prof_NSIDC=improfile(NSIDC_map,col_NSIDC(~isnan(col_NSIDC)),row_NSIDC(~isnan(row_NSIDC)));

%plot(X_p,Y_p);

[row_S1,col_S1] = map2pix(Rs1,X_p,Y_p);

prof_S1_snr5_1km=improfile(mov_med_S1_snr5_1km,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));
prof_S1_snr7_1km=improfile(mov_med_S1_snr7_1km,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));
prof_S1_snr10_1km=improfile(mov_med_S1_snr10_1km,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));

prof_S1_snr5_5km=improfile(mov_med_S1_snr5_5km,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));
prof_S1_snr7_5km=improfile(mov_med_S1_snr7_5km,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));
prof_S1_snr10_5km=improfile(mov_med_S1_snr10_5km,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));


[row_ERS,col_ERS] = map2pix(Rers,X_p,Y_p);

prof_ERS_snr5_1km=improfile(mov_med_ERS_snr5_1km,col_ERS(~isnan(col_ERS)),row_ERS(~isnan(row_ERS)));
prof_ERS_snr7_1km=improfile(mov_med_ERS_snr7_1km,col_ERS(~isnan(col_ERS)),row_ERS(~isnan(row_ERS)));
prof_ERS_snr10_1km=improfile(mov_med_ERS_snr10_1km,col_ERS(~isnan(col_ERS)),row_ERS(~isnan(row_ERS)));

prof_ERS_snr5_5km=improfile(mov_med_ERS_snr5_5km,col_ERS(~isnan(col_ERS)),row_ERS(~isnan(row_ERS)));
prof_ERS_snr7_5km=improfile(mov_med_ERS_snr7_5km,col_ERS(~isnan(col_ERS)),row_ERS(~isnan(row_ERS)));
prof_ERS_snr10_5km=improfile(mov_med_ERS_snr10_5km,col_ERS(~isnan(col_ERS)),row_ERS(~isnan(row_ERS)));



dist=0:(160.75/(length(prof_ERS_snr10_1km)-1)):160.75;
dist_nsidc=0:(160.75/(length(prof_NSIDC)-1)):160.75;

B_=nan(6,3);
B_(:,1)=[-2:3];
B_(:,2)=138*0.98; % Ice front line position
B_(:,3)=90*0.98; % Grounding line position

% Plots Profiles

%%% mov median 1km

figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
plot(dist,prof_ERS_snr5_1km); hold on; 
plot(dist,prof_S1_snr5_1km,'r')
title('SNR >= 5', 'fontsize',12,'fontweight','b')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
xlabel('km','fontsize',12,'fontweight','b')

hold on;
plot(B_(:,2),B_(:,1),'color','g', 'Linestyle', '--','LineWidth',2);
plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 165]);
ylim([0 2]);
set(gca,'XTick',[0:10:165])
grid on;
legend('ERS','Sentinel 1');

print -dpng -r300 /nfs/a59/eeagdl/Petterman_S1/profile_snr5_1km
%print -dpng -r300 /DADOS/Uni_Leeds/PG/profile_snr5_1km

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
plot(dist,prof_ERS_snr7_1km); hold on; 
plot(dist,prof_S1_snr7_1km,'r');
plot(dist_nsidc,prof_NSIDC/1000,'k');

%title('SNR >= 7', 'fontsize',12,'fontweight','b')
ylabel('Velocity (km/yr)','fontsize',14,'fontweight','b')
xlabel('Distance (km)','fontsize',14,'fontweight','b')

hold on;
plot(B_(:,2),B_(:,1),'color','g', 'Linestyle', '--','LineWidth',2);
plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 165]);
ylim([0 2]);
set(gca,'XTick',[0:10:165],'fontsize',15)
set(gca,'YTick',[0:0.2:2],'fontsize',15)

grid on;
legend('ERS','Sentinel-1a','NSIDC vel.');

print -dpng -r300 /nfs/a59/eeagdl/Petterman_S1/profile_snr7_1km_V3
%print -dpng -r300 /DADOS/Uni_Leeds/PG/profile_snr7_1km

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
plot(dist,prof_ERS_snr10_1km); hold on; 
plot(dist,prof_S1_snr10_1km,'r')
title('SNR >= 10', 'fontsize',12,'fontweight','b')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
xlabel('km','fontsize',12,'fontweight','b')

hold on;
plot(B_(:,2),B_(:,1),'color','g', 'Linestyle', '--','LineWidth',2);
plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 165]);
ylim([0 2]);
set(gca,'XTick',[0:10:165])
grid on;
legend('ERS','Sentinel 1');

print -dpng -r300 /nfs/a59/eeagdl/Petterman_S1/profile_snr10_1km
%print -dpng -r300 /DADOS/Uni_Leeds/PG/profile_snr10_1km

%%% Mov median 5km

figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
plot(dist,prof_ERS_snr5_5km); hold on; 
plot(dist,prof_S1_snr5_5km,'r')
title('SNR >= 5', 'fontsize',12,'fontweight','b')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
xlabel('km','fontsize',12,'fontweight','b')

hold on;
plot(B_(:,2),B_(:,1),'color','g', 'Linestyle', '--','LineWidth',2);
plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 165]);
ylim([0 2]);
set(gca,'XTick',[0:10:165])
grid on;
legend('ERS','Sentinel 1');

print -dpng -r300 /nfs/a59/eeagdl/Petterman_S1/profile_snr5_5km
%print -dpng -r300 /DADOS/Uni_Leeds/PG/profile_snr5_5km

figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
plot(dist,prof_ERS_snr7_5km); hold on; 
plot(dist,prof_S1_snr7_5km,'r')
title('SNR >= 7', 'fontsize',12,'fontweight','b')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
xlabel('km','fontsize',12,'fontweight','b')

hold on;
plot(B_(:,2),B_(:,1),'color','g', 'Linestyle', '--','LineWidth',2);
plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 165]);
ylim([0 2]);
set(gca,'XTick',[0:10:165])
grid on;
legend('ERS','Sentinel 1');

print -dpng -r300 /nfs/a59/eeagdl/Petterman_S1/profile_snr7_5km
%print -dpng -r300 /DADOS/Uni_Leeds/PG/profile_snr7_5km


figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
plot(dist,prof_ERS_snr10_5km); hold on; 
plot(dist,prof_S1_snr10_5km,'r')
title('SNR >= 10', 'fontsize',12,'fontweight','b')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
xlabel('km','fontsize',12,'fontweight','b')

hold on;
plot(B_(:,2),B_(:,1),'color','g', 'Linestyle', '--','LineWidth',2);
plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 165]);
ylim([0 2]);
set(gca,'XTick',[0:10:165])
grid on;
legend('ERS','Sentinel 1');

print -dpng -r300 /nfs/a59/eeagdl/Petterman_S1/profile_snr10_5km
%print -dpng -r300 /DADOS/Uni_Leeds/PG/profile_snr10_5km


%% Subtracting ERS-S1:
% 1km radius


for i=1:length(prof_ERS_snr5_1km)
    if prof_ERS_snr5_1km(i)>0 && prof_S1_snr5_1km(i)>0
    minus_snr5_1km(i)=prof_ERS_snr5_1km(i)-prof_S1_snr5_1km(i);
    else
        minus_snr5_1km(i)=nan;
    end
end

for i=1:length(prof_ERS_snr7_1km)
    if prof_ERS_snr7_1km(i)>0 && prof_S1_snr7_1km(i)>0 && prof_NSIDC(i)>0
    minus_snr7_1km(i)=prof_ERS_snr7_1km(i)-prof_S1_snr7_1km(i);
   else
        minus_snr7_1km(i)=nan;
       
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%interpolating the NSIDC data to fit in length with the ERS and the S1 data
nsidc_fit = (interp1(dist_nsidc,prof_NSIDC,dist,'spline'))/1000;
    for i=1:length(prof_ERS_snr7_1km)
        if prof_ERS_snr7_1km(i)>0
         NSIDC_minus_ERS(i)=nsidc_fit(i)-prof_ERS_snr7_1km(i);
        else
        NSIDC_minus_ERS(i)=nan;
       
        end
    end

    for i=1:length(prof_ERS_snr7_1km)
        if prof_S1_snr7_1km(i)>0
         NSIDC_minus_S1(i)=nsidc_fit(i)-prof_S1_snr7_1km(i);
        else
         NSIDC_minus_S1(i)=nan;
       
        end
    end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for i=1:length(prof_ERS_snr10_1km)
    if prof_ERS_snr10_1km(i)>0 && prof_S1_snr10_1km(i)>0
    minus_snr10_1km(i)=prof_ERS_snr10_1km(i)-prof_S1_snr10_1km(i);
    else
        minus_snr10_1km(i)=nan;
    end
end


% 5km radius

for i=1:length(prof_ERS_snr5_5km)
    if prof_ERS_snr5_5km(i)>0 && prof_S1_snr5_5km(i)>0
    minus_snr5_5km(i)=prof_ERS_snr5_5km(i)-prof_S1_snr5_5km(i);
    else
        minus_snr5_5km(i)=nan;
    end
end

for i=1:length(prof_ERS_snr7_5km)
    if prof_ERS_snr7_5km(i)>0 && prof_S1_snr7_5km(i)>0
    minus_snr7_5km(i)=prof_ERS_snr7_5km(i)-prof_S1_snr7_5km(i);
    else
        minus_snr7_5km(i)=nan;
    end
end

for i=1:length(prof_ERS_snr10_5km)
    if prof_ERS_snr10_5km(i)>0 && prof_S1_snr10_5km(i)>0
    minus_snr10_5km(i)=prof_ERS_snr10_5km(i)-prof_S1_snr10_5km(i);
    else
        minus_snr10_5km(i)=nan;
    end
end

%% Plotting ERS-S1:

% Plots Profiles
%%% mov median 1km

figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
subplot(2,2,1);
plot(dist,minus_snr5_1km,'.'); hold on; 
title('SNR >= 5', 'fontsize',12,'fontweight','b')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
xlabel('km','fontsize',12,'fontweight','b')

hold on;
plot(B_(:,2),B_(:,1),'color','g', 'Linestyle', '--','LineWidth',2);
plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 165]);
ylim([-0.8 0.8]);
set(gca,'XTick',[0:25:165])
set(gca,'YTick',[-0.8:0.2:0.8])

grid on;
hold off


subplot(2,2,2);
plot(dist,minus_snr7_1km,'.'); hold on;
plot(dist,NSIDC_minus_ERS,'.','color','r');
plot(dist,NSIDC_minus_S1,'.','color','k');
%title('SNR >= 7', 'fontsize',12,'fontweight','b')
ylabel('km/yr','fontsize',14,'fontweight','b')
xlabel('Distance (km)','fontsize',14,'fontweight','b')

hold on;
plot(B_(:,2),B_(:,1),'color','g', 'Linestyle', '--','LineWidth',2);
plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 165]);
ylim([-0.4 0.4]);
set(gca,'XTick',[0:10:165],'fontsize',15)
set(gca,'YTick',[-0.4:0.1:0.4],'fontsize',15)
grid on;
legend('ERS-S1a','NSIDC-ERS','NSIDC-S1a','Location','NorthWest');
hold off;


subplot(2,2,3.5);
plot(dist,minus_snr10_1km,'.'); hold on; 
title('SNR >= 10', 'fontsize',12,'fontweight','b')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
xlabel('km','fontsize',12,'fontweight','b')

hold on;
plot(B_(:,2),B_(:,1),'color','g', 'Linestyle', '--','LineWidth',2);
plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 165]);
ylim([-0.8 0.8]);
set(gca,'XTick',[0:25:165])
set(gca,'YTick',[-0.8:0.2:0.8])
grid on;
%legend('ERS','Sentinel 1');
hold off

print -dpng -r300 /nfs/a59/eeagdl/Petterman_S1/ERS-S1_1km
%print -dpng -r300 /DADOS/Uni_Leeds/PG/profile_snr10_1km

%%% Mov median 5km

figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
subplot(2,2,1);
plot(dist,minus_snr5_5km,'.'); hold on; 
title('SNR >= 5', 'fontsize',12,'fontweight','b')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
xlabel('km','fontsize',12,'fontweight','b')

hold on;
plot(B_(:,2),B_(:,1),'color','g', 'Linestyle', '--','LineWidth',2);
plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 165]);
ylim([-0.8 0.8]);
set(gca,'XTick',[0:25:165])
set(gca,'YTick',[-0.8:0.2:0.8])
grid on;
hold off
%legend('ERS','Sentinel 1');

%print -dpng -r300 /nfs/a59/eeagdl/Petterman_S1/ERS-S1_snr5_5km
%print -dpng -r300 /DADOS/Uni_Leeds/PG/profile_snr5_5km

%figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
subplot(2,2,2);
plot(dist,minus_snr7_5km,'.'); hold on; 
title('SNR >= 7', 'fontsize',12,'fontweight','b')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
xlabel('km','fontsize',12,'fontweight','b')

hold on;
plot(B_(:,2),B_(:,1),'color','g', 'Linestyle', '--','LineWidth',2);
plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 165]);
ylim([-0.8 0.8]);
set(gca,'XTick',[0:25:165])
set(gca,'YTick',[-0.8:0.2:0.8])
grid on;
% legend('ERS','Sentinel 1');
hold off
%print -dpng -r300 /nfs/a59/eeagdl/Petterman_S1/ERS-S1_snr7_5km
%print -dpng -r300 /DADOS/Uni_Leeds/PG/profile_snr7_5km


%figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
subplot(2,2,3.5);
plot(dist,minus_snr10_5km,'.'); hold on; 
title('SNR >= 10', 'fontsize',12,'fontweight','b')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
xlabel('km','fontsize',12,'fontweight','b')

hold on;
plot(B_(:,2),B_(:,1),'color','g', 'Linestyle', '--','LineWidth',2);
plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 165]);
ylim([-0.8 0.8]);
set(gca,'XTick',[0:25:165])
set(gca,'YTick',[-0.8:0.2:0.8])
grid on;
hold off

print -dpng -r300 /nfs/a59/eeagdl/Petterman_S1/ERS-S1_5km
%print -dpng -r300 /DADOS/Uni_Leeds/PG/profile_snr10_5km

%%


% 
% [row2,col2] = map2pix(Rs1,X_p,Y_p);
% row2=round(row2);
% col2=round(col2);
% 
% row2_i=uint32(row2(~isnan(row2)));
% col2_i=uint32(col2(~isnan(col2)));
% 
% 
% for i=1:length(row2_i)
%    if row2_i(i)>0 && col2_i(i)>0
%     ve(i)=Vel_S1(row2_i(i),col2_i(i));
%    end
%     
% end
% 
% for i=1:length(row2_i)
%    if row2_i(i)>0 && col2_i(i)>0
%     ve2(i)=mov_med_S1_snr7_1km(row2_i(i),col2_i(i));
%    else
%        ve2(i)=nan;
%    end
%     
% end
% 
% for i=1:length(row2_i)
%    if row2_i(i)>0 && col2_i(i)>0
%     ve3(i)=mov_med_S1_snr7_5km(row2_i(i),col2_i(i));
%    else
%        ve3(i)=nan;
%    end
%     
% end
% 
% 
% 
% 
% for i=1:length(sss_NN)
%    if sss_NN(i,1)>0 && sss_NN(i,2)>0
%     ve(i)=Vel_ERS(uint32(sss_NN(i,1)),uint32(sss_NN(i,2)));
%    end
%     
% end
% 
% 
% 
% for i=1:length(sss_NN)
%    if sss_NN(i,1)>0 && sss_NN(i,2)>0
%     ve2(i)=mov_med_ERS_snr10_1km(uint32(sss_NN(i,1)),uint32(sss_NN(i,2)));
%    end
%     
% end
% 
% for i=1:length(sss_NN)
%    if sss_NN(i,1)>=0 && sss_NN(i,2)>=0
%     ve3(i)=mov_med_ERS_snr10_5km(uint32(sss_NN(i,1)),uint32(sss_NN(i,2)));
%    end
%     
% end

ruler(2:17,:)=num2str([10:10:160]');
imagesc(mov_med_ERS_snr10_1km);caxis([0 2]);hold on
plot(col_ERS,row_ERS,'k');
plot(flipud(col_ERS(1:length(col_ERS)/17:end)),row_ERS(1:length(col_ERS)/17:end),'LineStyle','.','color','k');
text(col_ERS(1:length(col_ERS)/17:end),row_ERS(1:length(col_ERS)/17:end),ruler(:,:))


h3=imagesc(mov_med_S1_snr10_5km); t3=double(~isnan(mov_med_S1_snr10_5km));
caxis([0 2]);
set(h3,'AlphaData', t3);
title('SNR >= 10', 'fontsize',12,'fontweight','b')
hold on
plot(col_S1,row_S1,'k');
plot(y_cf_s1,x_cf_s1,'r');
plot(y_gl_s1,x_gl_s1,'k');
plot(col_S1(1:length(col_S1)/17:end),row_S1(1:length(col_S1)/17:end),'LineStyle','.','color','k');
text(col_S1(1:length(col_S1)/17:end),row_S1(1:length(col_S1)/17:end),ruler(:,:))

%calving front
cf_shp = shaperead('/nfs/a59/eeagdl/Petterman_S1/S1_arcgis/Calving_Front.shp');
X_cf=extractfield(cf_shp,'X');
Y_cf=extractfield(cf_shp,'Y');
[x_cf_s1,y_cf_s1]=map2pix(Rs1,X_cf,Y_cf);
[x_cf_ers,y_cf_ers]=map2pix(Rers,X_cf,Y_cf);

%grounding line
gl_shp = shaperead('/nfs/a59/eeagdl/Petterman_S1/S1_arcgis/PG_GL.shp');
X_gl=extractfield(gl_shp,'X');
Y_gl=extractfield(gl_shp,'Y');
[x_gl_s1,y_gl_s1]=map2pix(Rs1,X_gl,Y_gl);
[x_gl_ers,y_gl_ers]=map2pix(Rers,X_gl,Y_gl);

%% Subtracting ERS-S1 spatially 

%%% Creating a mask in the main flow (ERS):
mapshow(mov_med_ERS_snr5_1km,R_snr_ers, 'DisplayType','mesh'); caxis([0 2]);
pol=impoly();
map = getPosition(pol);
pos_ERS=map2pix(Rers,map(:,1),map(:,2));
pos_S1=map2pix(Rs1,map(:,1),map(:,2));
mask_S1=poly2mask(pos_S1(:,2),pos_S1(:,1),1960,1168);
mask_ERS=poly2mask(pos_ERS(:,2),pos_ERS(:,1),1514,1366);

save mask_main_flow.mat map pos* mask*

%%% Masking the data:

load('/nfs/a59/eeagdl/Petterman_S1/mask_main_flow.mat');

mask_mov_med_ERS_snr5_1km=mov_med_ERS_snr5_1km;
mask_mov_med_ERS_snr5_1km(mask_ERS==0)=nan;

mask_mov_med_ERS_snr7_1km=mov_med_ERS_snr7_1km;
mask_mov_med_ERS_snr7_1km(mask_ERS==0)=nan;

mask_mov_med_ERS_snr10_1km=mov_med_ERS_snr10_1km;
mask_mov_med_ERS_snr10_1km(mask_ERS==0)=nan;


mask_mov_med_ERS_snr5_5km=mov_med_ERS_snr5_5km;
mask_mov_med_ERS_snr5_5km(mask_ERS==0)=nan;

mask_mov_med_ERS_snr7_5km=mov_med_ERS_snr7_5km;
mask_mov_med_ERS_snr7_5km(mask_ERS==0)=nan;

mask_mov_med_ERS_snr10_5km=mov_med_ERS_snr10_5km;
mask_mov_med_ERS_snr10_5km(mask_ERS==0)=nan;


TESTE=mov_med_ERS_snr10_5km(mask_ERS==0)-mov_med_s1_snr10_5km(mask_s1==0);

TRE=map2pix(Rs1,Xi_ers(:),Yi_ers(:));
cd=mov_med_S1_snr10_1km;
TRE(:,1)=uint64(round(TRE(:,1)));
TRE(:,2)=uint64(round(TRE(:,2)));

sx=cd(TRE(:,2),TRE(:,1));

sx=nan(1960,1168);

for i=1:length(TRE)
    
    sx(TRE(i,2),TRE(i,1))=cd(TRE(i,2),TRE(i,1));
    
end




