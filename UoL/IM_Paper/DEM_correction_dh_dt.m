%%
load('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/dhdt_correction.mat');
%%
cd /nfs/a59/eeagdl/DATABASE/GREENLAND/GIMP_DEM
[gimp,Rgimp]=geotiffread('gimpdem_90m.tif');

xgimp=[-639955:90:855845-90];
ygimp=[-3355595:90:-655595-90];

[Xgimp,Ygimp] = meshgrid(xgimp,ygimp);

[noel2,Rnoel2]=geotiffread('/nfs/a59/eeagdl/DATABASE/GREENLAND/dh_dt_Swath_Noel_JAK/rate_T734356_T736204_500m__500m_any.tif');
xvel=[Rnoel.XWorldLimits(1):500:Rnoel.XWorldLimits(2)-500];
yvel=[Rnoel.YWorldLimits(1):500:Rnoel.YWorldLimits(2)-500];
[Xvel,Yvel] = meshgrid(xvel,yvel);

ii=~isnan(noel);

dh_noel_cubic=griddata(Xvel(ii),Yvel(ii),double(noel(ii)),Xgimp,Ygimp,'cubic');

h=imagesc(xgimp,ygimp, gimp); tt=double(~isnan(gimp)); set(h,'AlphaData', tt);
h=imagesc(xgimp,ygimp, dh_flip); tt=double(~isnan(dh_flip)); set(h,'AlphaData', tt);

h=imagesc(xgimp,ygimp, flip(dh_noel_cubic)); tt=double(~isnan(flip(dh_noel_cubic))); set(h,'AlphaData', tt);
h=imagesc(xgimp,ygimp, dh_noel_cubic); tt=double(~isnan(dh_noel_cubic)); set(h,'AlphaData', tt);

xvel=[-355495:100:-73795];
yvel=[-2462565:100:-2247965];
[Xvel,Yvel] = meshgrid(xvel,yvel);

dh = interp2(gridx,gridy,gis_dzdt,Xgimp,Ygimp);

dh_flip=flip(dh);

dem_temp(:,:,1)=gimp;
dem_temp(:,:,2)=(18.*dh_flip);

gimp_corrected=nansum(dem_temp,3);


% Create a DEM in GAMMA format
gimp_corrected_int16=int16(gimp_corrected);
Y = swapbytes(gimp_corrected_int16);

fileID = fopen('/nfs/a59/eeagdl/DATABASE/GREENLAND/GIMP_DEM/DEM_dh_dt_16_times/gimp_dh_dt_corrected_18.dem','w');
fwrite(fileID,Y','integer*2');
fclose(fileID);


% Plot the three maps DEM, dh/dt DEM_corrected
figure
subplot(1,3,1)
imagesc(xgimp,ygimp,gimp)
title('GIMP DEM','fontsize',12,'fontweight','b');
caxis([0 3500]);
axis off
cc=colorbar;
ylabel(cc,'[m]','fontsize',12,'fontweight','b');

subplot(1,3,2)
imagesc(xgimp,ygimp,6.*dh_flip)
caxis([-30 5])
axis off
cc=colorbar;
ylabel(cc,'[m/yr]','fontsize',12,'fontweight','b');
%colormap redbluecmap
title('dh/dt','fontsize',12,'fontweight','b');

subplot(1,3,3)
imagesc(xgimp,ygimp,gimp_corrected_int16)
title('DEM corrected','fontsize',12,'fontweight','b');
caxis([0 3500]);
axis off
cc=colorbar;
ylabel(cc,'[m]','fontsize',12,'fontweight','b');



h=imagesc(diff_im_corr_2); tt=double(~isnan(diff_im_corr_2)); set(h,'AlphaData', tt);

diff_mov_mean=movmean(diff_im_corr,[10 10]);

diff_im_corr_2=diff_im_corr;

diff_im_corr_2=diff_mov_mean;


diff_im_corr_2(diff_im_corr_2<=2 | diff_im_corr_2>=700)=nan;
h=imagesc(diff_im_corr_2); tt=double(~isnan(diff_im_corr_2)); set(h,'AlphaData', tt);

nanmean(diff_im_corr_2(:))


diff_mov_mean(diff_mov_mean<=10)=nan;

nanmedian(diff_mov_mean(:))




figure
subplot(121);h=imagesc(diff_im_corr3); tt=double(~isnan(diff_im_corr3)); set(h,'AlphaData', tt);
caxis([-10 10])
subplot(122);h=imagesc(diff_im_corr); tt=double(~isnan(diff_im_corr)); set(h,'AlphaData', tt);
caxis([-10 10])


%%  Thinning from Ice Bridge

load('/nfs/a59/eeagdl/DATABASE/GREENLAND/IceBridge/IB_dh_dt/GIS_ib_forAdriano_12oct17.mat')

% which includes a structure where the forth entry contains the data. This is just how my code is set up to handle multiple time periods. You can plot using:

figure('Position',[1 1 600 800]),
ha=imagesc(gridx(1,:),gridy(:,1),ib_ra_diff_str.mission(4).ib_dzdt_grid_mean);
set(ha,'alphadata',~isnan(ib_ra_diff_str.mission(4).ib_dzdt_grid_mean))
set(gca,'yDir','Normal')
axis([min(gridx(:)) max(gridx(:)) min(gridy(:)) max(gridy(:))])
caxis([-2 2])
title(['icebridge elevation trend (m/yr) ' ib_ra_diff_str.mission(4).mission_id ' period'],'fontsize',12)
colorbar
colormap jet


IB_grid=griddata(gridx,gridy,ib_ra_diff_str.mission(4).ib_dzdt_grid_mean,Xgimp,Ygimp,'v4');
tt=ib_ra_diff_str.mission(4).ib_dzdt_grid_mean;


dh_IB = interp2(gridx,gridy,ib_ra_diff_str.mission(4).ib_dzdt_grid_mean,Xgimp,Ygimp);

figure('Position',[1 1 600 800]),
ha=imagesc(Xgimp(1,:),Ygimp(:,1),dh_IB);
set(ha,'alphadata',~isnan(dh_IB))
set(gca,'yDir','Normal')


%##### IB Raw data

load('/nfs/a59/eeagdl/DATABASE/GREENLAND/IceBridge/IB_dh_dt/GIS_ibraw_forAdriano_12oct17.mat')

X_p_curve_JAK=extractfield(prof_curve_read_JAK,'X');

x_IB=ib_dzdt_str.mission(4).x;
y_IB=ib_dzdt_str.mission(4).y;
dhdt_IB=ib_dzdt_str.mission(4).dzdt;


doc griddata


xgridIBraw=min(x_IB)-2500:2500:max(x_IB)+2500;

ygridIBraw=min(y_IB)-2500:2500:max(y_IB)+2500;

[XgridIBraw,YgridIBraw]=meshgrid(xgridIBraw,ygridIBraw);
 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% vec_X, vec_Y, vec_data -- icebridge x, y, dzdt vectors
% map_XX, map_YY  --  2.5 km grids created using meshgrid

[zgrid_med, zgrid_N, zgrid_mad, zgrid_mean, zgrid_sd, xbin_ind, ybin_ind] = bin_median_vector_data_new2(x_IB,y_IB,dhdt_IB,XgridIBraw,YgridIBraw);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ii=~isnan(zgrid_mean);
ii=~isnan(zgrid_med_excludedvalues);

zgrid_mean_cubic=griddata(XgridIBraw(ii),YgridIBraw(ii),zgrid_mean(ii),Xgimp,Ygimp,'cubic');
zgrid_median_cubic=griddata(XgridIBraw(ii),YgridIBraw(ii),zgrid_med(ii),Xgimp,Ygimp,'cubic');

zgrid_median_cubic_excludedvalues2=griddata(XgridIBraw(ii),YgridIBraw(ii),zgrid_med_excludedvalues(ii),Xgimp,Ygimp,'cubic');

dhdt_from_vel=double((flip(im_vel).*-1)./1000);
ii=~isnan(dhdt_from_vel);
dtdt_from_vel_gimp_interp=griddata(Xvel(ii),Yvel(ii),dhdt_from_vel(ii),Xgimp,Ygimp,'cubic');

%cd /nfs/a59/eeagdl/DATABASE/GREENLAND/IceBridge/IB_dh_dt/

world_shp = shaperead('/nfs/a59/eeagdl/DATABASE/GREENLAND/Coastline/Greenland_Cosatline.shp');
X_w=extractfield(world_shp,'X');
Y_w=extractfield(world_shp,'Y');

IF=shaperead('/nfs/a59/eeagdl/DATABASE/GREENLAND/CCI_products/greenland_calving_front_locations/cfl_JAK_20150819_PS.shp');
X_if=extractfield(IF,'X');
Y_if=extractfield(IF,'Y');

figure
hold on
plot(X_w,Y_w,'k');
ha=imagesc(XgridIBraw(1,:),YgridIBraw(:,1),zgrid_mean);
set(ha,'alphadata',~isnan(zgrid_mean))
set(gca,'yDir','Normal')
caxis([-10 0])
oldcmap = colormap;
colormap( flipud(oldcmap) );
colorbar
title('Mean dh/dt IB 2500m grid','fontsize',12,'fontweight','b');
xlim([-220000 -110000]);
ylim([-2300000 -2245000]);

figure
hold on
plot(X_w,Y_w,'k');
ha=imagesc(XgridIBraw(1,:),YgridIBraw(:,1),zgrid_med_excludedvalues);
set(ha,'alphadata',~isnan(zgrid_med_excludedvalues))
set(gca,'yDir','Normal')
caxis([-10 0])
oldcmap = colormap;
colormap( flipud(oldcmap) );
colorbar
title('Mean dh/dt IB 2500m grid','fontsize',12,'fontweight','b');
xlim([-220000 -110000]);
ylim([-2300000 -2245000]);
zgrid_med_excludedvalues(413,437:438)=nan;


figure
hold on
ha=imagesc(Xgimp(1,:),Ygimp(:,1),zgrid_median_cubic);
set(ha,'alphadata',~isnan(zgrid_median_cubic))
set(gca,'yDir','Normal')
caxis([-10 0])
colormap jet
oldcmap = colormap;
colormap( flipud(oldcmap) );
colorbar
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k');
title('Median dh/dt IB 2500m grid','fontsize',12,'fontweight','b');
xlim([-220000 -110000]);
ylim([-2300000 -2245000]);

ha=imagesc(Xgimp(1,:),Ygimp(:,1),zgrid_mean_cubic);
caxis([-5 5])
set(ha,'alphadata',~isnan(zgrid_mean_cubic))
set(gca,'yDir','Normal')
caxis([-10 5])
xlim([-220000 -110000]);
ylim([-2300000 -2245000]);

figure
hold on
ha=imagesc(Xgimp(1,:),Ygimp(:,1),zgrid_median_cubic_excludedvalues);
set(ha,'alphadata',~isnan(zgrid_median_cubic_excludedvalues))
set(gca,'yDir','Normal')
caxis([-15 0])
colormap redbluecmap
oldcmap = colormap;
colormap( flipud(oldcmap) );
colorbar
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k');
title('Median dh/dt IB 2500m grid','fontsize',12,'fontweight','b');
xlim([-220000 -110000]);
ylim([-2300000 -2245000])

figure
hold on
plot(X_w,Y_w,'k');
ha=imagesc(Xvel(1,:),Yvel(:,1),dhdt_from_vel);
set(ha,'alphadata',~isnan(dhdt_from_vel))
set(gca,'yDir','Normal')
caxis([-15 0])
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k');
colormap redbluecmap
oldcmap = colormap;
colormap( flipud(oldcmap) );
colorbar
title('dh/dt simulated from Velocity','fontsize',12,'fontweight','b');

xlim([-220000 -110000]);
ylim([-2300000 -2245000]);

figure
hold on
plot(X_w,Y_w,'k');
ha=imagesc(Xgimp(1,:),Ygimp(:,1),dtdt_from_vel_gimp_interp);
set(ha,'alphadata',~isnan(dtdt_from_vel_gimp_interp))
set(gca,'yDir','Normal')
caxis([-15 0])
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k');
colormap redbluecmap
oldcmap = colormap;
colormap( flipud(oldcmap) );
colorbar
title('dh/dt simulated from Velocity','fontsize',12,'fontweight','b');

xlim([-220000 -110000]);
ylim([-2300000 -2245000]);


%dhdt_2500m_IB=griddata(x_IB,y_IB,dhdt_IB,XgridIBraw,YgridIBraw,'natural');

%####### Plot the 2500 m grid

ha=imagesc(xgridIBraw,ygridIBraw,dhdt_2500m_IB)
set(ha,'alphadata',~isnan(dhdt_2500m_IB))
set(gca,'yDir','Normal')
caxis([-10 5])
colormap jet

% ####################

% Interpolating the IB to GIMP resolution and transform to GAMMA format

dh_IB_interpolate_to_GIMP = griddata(XgridIBraw,YgridIBraw,zgrid_mean,Xgimp,Ygimp,'cubic');
dh_IB_interpolate_to_GIMP_linear = griddata(XgridIBraw,YgridIBraw,zgrid_mean,Xgimp,Ygimp);

figure
ha=imagesc(Xgimp(1,:),Ygimp(:,1),dh_IB_interpolate_to_GIMP)
set(ha,'alphadata',~isnan(dh_IB_interpolate_to_GIMP))
set(gca,'yDir','Normal')
caxis([-5 5])
colormap jet


dh__IB_interpolate_to_GIMP_flip=flip(dh_IB_interpolate_to_GIMP);

dem_temp_IB(:,:,1)=gimp;
dem_temp_IB(:,:,2)=(18.*dh__IB_interpolate_to_GIMP_flip);

gimp_corrected_IB=nansum(dem_temp_IB,3);
gimp_corrected_IB=dem_temp_IB(:,:,1)+dem_temp_IB(:,:,2);

figure
ha=imagesc(Xgimp(1,:),Ygimp(:,1),gimp_corrected_IB)
set(ha,'alphadata',~isnan(gimp_corrected_IB))
set(gca,'yDir','Normal')
caxis([0 1000])
colormap jet

% Create a DEM in GAMMA format
gimp_corrected_int16=int16(gimp_corrected);
Y = swapbytes(gimp_corrected_int16);

fileID = fopen('/nfs/a59/eeagdl/DATABASE/GREENLAND/GIMP_DEM/DEM_dh_dt_16_times/gimp_dh_dt_corrected_18.dem','w');
fwrite(fileID,Y','integer*2');
fclose(fileID);


% Create a DEM in GAMMA format from the SIMULATED dhdt (got from velocity)

dhdt_vel_6times=int16(dtdt_from_vel_gimp_interp.*6);
gimp_corrected_vel=gimp+flip(dhdt_vel_6times);
Y = swapbytes(gimp_corrected_vel);

fileID = fopen('/nfs/a59/eeagdl/DATABASE/GREENLAND/GIMP_DEM/DEM_dh_dt_16_times/gimp_dh_dt_corrected_velocity_data.dem','w');
fwrite(fileID,Y','integer*2');
fclose(fileID);


dhdt_IB_2500m_interp_6times=int16(zgrid_median_cubic_excludedvalues.*6);
gimp_corrected_IB_2500m=gimp+flip(dhdt_IB_2500m_interp_6times);
Y = swapbytes(gimp_corrected_IB_2500m);

fileID = fopen('/nfs/a59/eeagdl/DATABASE/GREENLAND/GIMP_DEM/DEM_dh_dt_16_times/gimp_corrected_IB_2500m.dem','w');
fwrite(fileID,Y','integer*2');
fclose(fileID);




figure;
subplot(121)
ha=imagesc(Xgimp(1,:),Ygimp(:,1),gimp_corrected_vel);
set(ha,'alphadata',~isnan(gimp_corrected_vel));
set(gca,'yDir','Reverse')
caxis([0 1000])
xlim([-220000 -110000]);
ylim([-1800000 -1645000]);
colormap jet

subplot(122)
ha=imagesc(Xgimp(1,:),Ygimp(:,1),gimp);
set(ha,'alphadata',~isnan(gimp))
set(gca,'yDir','Reverse')
caxis([0 1000])
xlim([-220000 -110000]);
ylim([-1800000 -1645000]);
colormap jet


%%
%#######
figure;
a1=subplot(321);
hold on
ha=imagesc(Xgimp(1,:),Ygimp(:,1),dtdt_from_vel_gimp_interp);
set(ha,'alphadata',~isnan(dtdt_from_vel_gimp_interp))
set(gca,'yDir','Normal')
caxis([-15 0])
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k');
c1=colormap(a1,'redbluecmap');
colormap(a1,flipud(c1) );
colorbar
title('dh/dt simulated from Velocity','fontsize',12,'fontweight','b');
xlim([-220000 -110000]);
ylim([-2300000 -2245000]);


a2=subplot(322);
hold on
ha=imagesc(Xgimp(1,:),Ygimp(:,1),zgrid_median_cubic_excludedvalues);
set(ha,'alphadata',~isnan(zgrid_median_cubic_excludedvalues))
set(gca,'yDir','Normal')
caxis([-15 0])
c2=colormap(a2,'redbluecmap');
colormap(a2, flipud(c2) );
colorbar
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k');
title('Median dh/dt IB 2500m grid','fontsize',12,'fontweight','b');
xlim([-220000 -110000]);
ylim([-2300000 -2245000])

a3=subplot(323);
hold on
ha=imagesc(Xvel(1,:),Yvel(:,1),flip(im_vel_161024_161030_dhdtVEL_correc));
set(ha,'alphadata',~isnan(flip(im_vel_161024_161030_dhdtVEL_correc)))
set(gca,'yDir','Normal')
caxis([0 10000])
c3=colormap(a3,'jet');
%colormap(a3, flipud(c3) );
%colorbar
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k');
ylabel('Velocity','fontsize',12,'fontweight','b');
xlim([-220000 -110000]);
ylim([-2300000 -2245000])

a4=subplot(324);
hold on
ha=imagesc(Xvel(1,:),Yvel(:,1),flip(im_vel_161024_161030_IB2500m_correc));
set(ha,'alphadata',~isnan(flip(im_vel_161024_161030_IB2500m_correc)))
set(gca,'yDir','Normal')
caxis([0 10000])
c4=colormap(a4,'jet');
%colormap(a3, flipud(c3) );
%colorbar
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k');
xlim([-220000 -110000]);
ylim([-2300000 -2245000])


a5=subplot(325);
hold on
ha=imagesc(Xvel(1,:),Yvel(:,1),flip(diff_161024_161030_dhdtVEL_correc));
set(ha,'alphadata',~isnan(flip(diff_161024_161030_dhdtVEL_correc)))
set(gca,'yDir','Normal')
caxis([-5 5])
c5=colormap(a5,'redbluecmap');
colormap(a5, flipud(c5) );
%colorbar
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k');
ylabel('Velocity Difference','fontsize',12,'fontweight','b');
xlim([-220000 -110000]);
ylim([-2300000 -2245000])

a6=subplot(326);
hold on
ha=imagesc(Xvel(1,:),Yvel(:,1),flip(diff_161024_161030_IB2500m_correc));
set(ha,'alphadata',~isnan(flip(diff_161024_161030_IB2500m_correc)))
set(gca,'yDir','Normal')
caxis([-5 5])
c6=colormap(a6,'redbluecmap');
colormap(a6, flipud(c6) );
%colorbar
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k');
xlim([-220000 -110000]);
ylim([-2300000 -2245000])

print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/dhdt_from_Velocity_AND_IB_2500mGRID


figure;
subplot(121)
hist(diff_161024_161030_dhdtVEL_correc(:),[-400:2:400])
xlim([-410 410])
ylim([0 10000])

subplot(122)
hist(diff_161024_161030_IB2500m_correc(:),[-400:2:400])
xlim([-410 410])
ylim([0 10000])


%%
%#######
window=[5 5];
diff_161024_161030_dhdtVEL_correc=im_vel_161024_161030_dhdtVEL_correc-im_vel;
diff_161024_161030_dhdtVEL_correc=movmean(im_vel_161024_161030_dhdtVEL_correc,window,'omitnan')-movmean(im_vel,window,'omitnan');
% diff_161024_161030_dhdtVEL_correc=medfilt2(diff_161024_161030_dhdtVEL_correc,window);
%diff_161024_161030_dhdtVEL_correc=movmedian(diff_161024_161030_dhdtVEL_correc,window,'omitnan');

diff_161024_161030_corrected=im_vel_161024_161030_correc-im_vel;
diff_161024_161030_corrected=movmean(im_vel_161024_161030_correc,window,'omitnan')-movmean(im_vel,window,'omitnan');
% diff_161024_161030_corrected=medfilt2(diff_161024_161030_corrected,window);
%diff_161024_161030_corrected=movmedian(diff_161024_161030_corrected,window,'omitnan');

diff_161024_161030_IB2500m_correc_excluded=im_vel_161024_161030_IB2500m_correc_excluded-im_vel;
diff_161024_161030_IB2500m_correc_excluded=movmean(im_vel_161024_161030_IB2500m_correc_excluded,window,'omitnan')-movmean(im_vel,window,'omitnan');
% diff_161024_161030_IB2500m_correc_excluded=medfilt2(diff_161024_161030_IB2500m_correc_excluded,window);
%diff_161024_161030_IB2500m_correc_excluded=movmedian(diff_161024_161030_IB2500m_correc_excluded,window,'omitnan');

figure('Position',[1 1 2200 1000]),

%%%% Cryosat

a9=subplot(541);
hold on
ha=imagesc(Xgimp(1,:),Ygimp(:,1),flip((dh_flip)));
set(ha,'alphadata',~isnan(flip(dh_flip)))
set(gca,'yDir','Normal')
caxis([-15 0])
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k','markersize',1);
c9=colormap(a9,'redbluecmap');
colormap(a9,flipud(c9) );
%colorbar
ylabel('dh/dt Cryosat','fontsize',12,'fontweight','b');
xlim([-220000 -110000]);
ylim([-2300000 -2245000]);
plot(X_if,Y_if,'k','markersize',2);
cc=colorbar(a9,'location','north','Position',[0.144 0.96 0.14 0.013]);
title('[m/yr]','fontsize',12,'fontweight','b');


a10=subplot(5,4,2);
hold on
ha=imagesc(Xvel(1,:),Yvel(:,1),flip(im_vel_161024_161030_correc));
set(ha,'alphadata',~isnan(flip(im_vel_161024_161030_correc)))
set(gca,'yDir','Normal')
caxis([0 10000])
c10=colormap(a10,'jet');
%colormap(a3, flipud(c3) );
%colorbar
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k','markersize',1);
xlim([-220000 -110000]);
ylim([-2300000 -2245000])
plot(X_if,Y_if,'k','markersize',2);
title('Velocity [m/yr]','fontsize',12,'fontweight','b');

a11=subplot(5,4,3);
hold on
ha=imagesc(Xvel(1,:),Yvel(:,1),flip(diff_161024_161030_corrected));
set(ha,'alphadata',~isnan(flip(diff_161024_161030_corrected)))
set(gca,'yDir','Normal')
caxis([-150 150])
c11=colormap(a11,'redbluecmap');
colormap(a11, flipud(c11) );
%colorbar
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k','markersize',1);
xlim([-220000 -110000]);
ylim([-2300000 -2245000])
plot(X_if,Y_if,'k','markersize',2);
title('Velocity Difference [m/yr]','fontsize',12,'fontweight','b');

subplot(5,4,4)
hist(diff_161024_161030_corrected(:),[-200:2:200])
xlim([-210 210])
ylim([0 10000])
nanstd(diff_161024_161030_corrected(:))
nanmean(diff_161024_161030_corrected(:))
nanmedian(diff_161024_161030_corrected(:))
text(-205,9000,['mean:' num2str(round(nanmean(diff_161024_161030_corrected(:)),2))])
text(-205,8000,['median:' num2str(round(nanmedian(diff_161024_161030_corrected(:)),2))])
text(-205,7000,['sd:' num2str(round(nanstd(diff_161024_161030_corrected(:)),2))])


%%% IB

a2=subplot(545);
hold on
ha=imagesc(Xgimp(1,:),Ygimp(:,1),zgrid_median_cubic_excludedvalues2);
set(ha,'alphadata',~isnan(zgrid_median_cubic_excludedvalues2))
set(gca,'yDir','Normal')
caxis([-15 0])
c2=colormap(a2,'redbluecmap');
colormap(a2, flipud(c2) );
%colorbar
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k','markersize',1);
ylabel('Med dh/dt IB 2.5km grid','fontsize',12,'fontweight','b');
xlim([-220000 -110000]);
ylim([-2300000 -2245000])
plot(X_if,Y_if,'k','markersize',2);


a4=subplot(546);
hold on
ha=imagesc(Xvel(1,:),Yvel(:,1),flip(im_vel_161024_161030_IB2500m_correc));
set(ha,'alphadata',~isnan(flip(im_vel_161024_161030_IB2500m_correc)))
set(gca,'yDir','Normal')
caxis([0 10000])
c4=colormap(a4,'jet');
%colormap(a3, flipud(c3) );
%colorbar
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k','markersize',1);
xlim([-220000 -110000]);
ylim([-2300000 -2245000])
plot(X_if,Y_if,'k','markersize',2);


a6=subplot(547);
%a6=subplot(1,1,1);
hold on
ha=imagesc(Xvel(1,:),Yvel(:,1),flip(diff_161024_161030_IB2500m_correc_excluded));
set(ha,'alphadata',~isnan(flip(diff_161024_161030_IB2500m_correc_excluded)))
set(gca,'yDir','Normal')
caxis([-150 150])
c6=colormap(a6,'redbluecmap');
colormap(a6, flipud(c6) );
%colorbar
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k','markersize',1);
xlim([-220000 -110000]);
ylim([-2300000 -2245000])
plot(X_if,Y_if,'k','markersize',2);


subplot(548)
hist(diff_161024_161030_IB2500m_correc_excluded(:),[-200:2:200])
xlim([-210 210])
ylim([0 10000])
nanstd(diff_161024_161030_IB2500m_correc_excluded(:))
nanmean(diff_161024_161030_IB2500m_correc_excluded(:))
nanmedian(diff_161024_161030_IB2500m_correc_excluded(:))
text(-205,9000,['mean:' num2str(round(nanmean(diff_161024_161030_IB2500m_correc_excluded(:)),2))])
text(-205,8000,['median:' num2str(round(nanmedian(diff_161024_161030_IB2500m_correc_excluded(:)),2))])
text(-205,7000,['sd:' num2str(round(nanstd(diff_161024_161030_IB2500m_correc_excluded(:)),2))])

%%%% Simulated Velocity

a1=subplot(5,4,9);
hold on
ha=imagesc(Xgimp(1,:),Ygimp(:,1),dtdt_from_vel_gimp_interp);
set(ha,'alphadata',~isnan(dtdt_from_vel_gimp_interp))
set(gca,'yDir','Normal')
caxis([-15 0])
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k','markersize',1);
c1=colormap(a1,'redbluecmap');
colormap(a1,flipud(c1) );
%colorbar
ylabel('dh/dt simulated from Vel','fontsize',12,'fontweight','b');
xlim([-220000 -110000]);
ylim([-2300000 -2245000]);
plot(X_if,Y_if,'k','markersize',2);


a3=subplot(5,4,10);
hold on
ha=imagesc(Xvel(1,:),Yvel(:,1),flip(im_vel_161024_161030_dhdtVEL_correc));
set(ha,'alphadata',~isnan(flip(im_vel_161024_161030_dhdtVEL_correc)))
set(gca,'yDir','Normal')
caxis([0 10000])
c3=colormap(a3,'jet');
%colormap(a3, flipud(c3) );
%colorbar
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k','markersize',1);
xlim([-220000 -110000]);
ylim([-2300000 -2245000])
plot(X_if,Y_if,'k','markersize',2);
cc=colorbar(a3,'location','north','Position',[0.344 0.96 0.14 0.013]);

a5=subplot(5,4,11);
hold on
ha=imagesc(Xvel(1,:),Yvel(:,1),flip(diff_161024_161030_dhdtVEL_correc));
set(ha,'alphadata',~isnan(flip(diff_161024_161030_dhdtVEL_correc)))
set(gca,'yDir','Normal')
caxis([-150 150])
c5=colormap(a5,'redbluecmap');
colormap(a5, flipud(c5) );
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k','markersize',1);
xlim([-220000 -110000]);
ylim([-2300000 -2245000])
plot(X_if,Y_if,'k','markersize',2);
colorbar(a5,'location','north','Position',[0.544 0.96 0.14 0.013]);

subplot(5,4,12)
hist(diff_161024_161030_dhdtVEL_correc(:),[-200:2:200])
xlim([-210 210])
ylim([0 10000])
nanstd(diff_161024_161030_dhdtVEL_correc(:))
nanmean(diff_161024_161030_dhdtVEL_correc(:))
nanmedian(diff_161024_161030_dhdtVEL_correc(:))
text(-205,9000,['mean:' num2str(round(nanmean(diff_161024_161030_dhdtVEL_correc(:)),2))])
text(-205,8000,['median:' num2str(round(nanmedian(diff_161024_161030_dhdtVEL_correc(:)),2))])
text(-205,7000,['sd:' num2str(round(nanstd(diff_161024_161030_dhdtVEL_correc(:)),2))])



%%%% Simulated Velocity 10x

a17=subplot(5,4,13);
hold on
ha=imagesc(Xgimp(1,:),Ygimp(:,1),dtdt_from_vel_gimp_interp.*10);
set(ha,'alphadata',~isnan(dtdt_from_vel_gimp_interp))
set(gca,'yDir','Normal')
caxis([-150 0])
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k','markersize',1);
c17=colormap(a17,'redbluecmap');
colormap(a17,flipud(c17) );
%colorbar
ylabel('dh/dt simulated from Vel 10x','fontsize',12,'fontweight','b');
xlim([-220000 -110000]);
ylim([-2300000 -2245000]);
plot(X_if,Y_if,'k','markersize',2);
%cc=colorbar
%title('[m/yr]','fontsize',12,'fontweight','b');

a18=subplot(5,4,14);
hold on
ha=imagesc(Xvel(1,:),Yvel(:,1),flip(im_vel_161024_161030_dhdtVEL_correc_60x));
set(ha,'alphadata',~isnan(flip(im_vel_161024_161030_dhdtVEL_correc_60x)))
set(gca,'yDir','Normal')
caxis([0 10000])
c18=colormap(a18,'jet');
%colormap(a3, flipud(c3) );
%colorbar
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k','markersize',1);
%title('Velocity [m/yr]','fontsize',12,'fontweight','b');
xlim([-220000 -110000]);
ylim([-2300000 -2245000])
plot(X_if,Y_if,'k','markersize',2);
%cc=colorbar


diff_161024_161030_dhdtVEL_correc_60x=movmean(im_vel_161024_161030_dhdtVEL_correc_60x,[5 5],'omitnan')-movmean(im_vel,[5 5],'omitnan');
a19=subplot(5,4,15);
hold on
ha=imagesc(Xvel(1,:),Yvel(:,1),flip(diff_161024_161030_dhdtVEL_correc_60x));
set(ha,'alphadata',~isnan(flip(diff_161024_161030_dhdtVEL_correc_60x)))
set(gca,'yDir','Normal')
caxis([-1000 1000])
c19=colormap(a19,'redbluecmap');
colormap(a19, flipud(c19) );
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k','markersize',1);
%title('Velocity Difference [m/yr]','fontsize',12,'fontweight','b');
xlim([-220000 -110000]);
ylim([-2300000 -2245000])
plot(X_if,Y_if,'k','markersize',2);
%colorbar

a20=subplot(5,4,16)
hist(diff_161024_161030_dhdtVEL_correc_60x(:),[-2500:5:2500])
xlim([-2600 2600])
ylim([0 10000])
nanstd(diff_161024_161030_dhdtVEL_correc_60x(:))
nanmean(diff_161024_161030_dhdtVEL_correc_60x(:))
nanmedian(diff_161024_161030_dhdtVEL_correc_60x(:))
text(-2400,9000,['mean:' num2str(round(nanmean(diff_161024_161030_dhdtVEL_correc_60x(:)),2))])
text(-2400,8000,['median:' num2str(round(nanmedian(diff_161024_161030_dhdtVEL_correc_60x(:)),2))])
text(-2400,7000,['sd:' num2str(round(nanstd(diff_161024_161030_dhdtVEL_correc_60x(:)),2))])

%%%% FLAT

a9=subplot(5,4,17);
hold on
% ha=imagesc(Xgimp(1,:),Ygimp(:,1),flip((dh_flip)));
% set(ha,'alphadata',~isnan(flip(dh_flip)))
set(gca,'yDir','Normal')
caxis([-15 0])
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k','markersize',1);
% c9=colormap(a9,'redbluecmap');
% colormap(a9,flipud(c9) );
%colorbar
ylabel('Flat DEM','fontsize',12,'fontweight','b');
xlim([-220000 -110000]);
ylim([-2300000 -2245000]);
plot(X_if,Y_if,'k','markersize',2);

a14=subplot(5,4,18);
hold on
ha=imagesc(Xvel(1,:),Yvel(:,1),flip(im_vel_ONES));
set(ha,'alphadata',~isnan(flip(im_vel_ONES)))
set(gca,'yDir','Normal')
caxis([0 10000])
c14=colormap(a14,'jet');
%colormap(a3, flipud(c3) );
%colorbar
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k','markersize',1);
xlim([-220000 -110000]);
ylim([-2300000 -2245000])
plot(X_if,Y_if,'k','markersize',2);

a15=subplot(5,4,19);
% a15=subplot(1,1,1);
hold on
ha=imagesc(Xvel(1,:),Yvel(:,1),flip(diff_FLAT));
set(ha,'alphadata',~isnan(flip(diff_FLAT)))
set(gca,'yDir','Normal')
caxis([-1000 1000])
c15=colormap(a15,'redbluecmap');
colormap(a15, flipud(c15) );
%colorbar
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k','markersize',1);
plot(X_if,Y_if,'.k','markersize',1);
plot(X_if,Y_if,'k','markersize',2);
xlim([-220000 -110000]);
ylim([-2300000 -2245000])
cc=colorbar(a15,'location','north','Position',[0.575 0.24 0.10 0.013]);

subplot(5,4,20)
hist(diff_FLAT(:),[-500:2:500])
xlim([-1010 1010])
ylim([0 50000])
nanstd(diff_FLAT(:))
nanmean(diff_FLAT(:))
nanmedian(diff_FLAT(:))
text(-950,40000,['mean:' num2str(round(nanmean(diff_FLAT(:)),2))])
text(-950,30000,['median:' num2str(round(nanmedian(diff_FLAT(:)),2))])
text(-950,35000,['sd:' num2str(round(nanstd(diff_FLAT(:)),2))])


print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/dhdt_from_Velocity_AND_IB_2500mGRID

print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/dhdt_from_Velocity_AND_IB_2500mGRID_Cryosat_v2_med_filter5x5

print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/dhdt_from_Velocity_AND_IB_2500mGRID_Cryosat_FLAT_Movmedian_filter3x3
print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/dhdt_from_Velocity_AND_IB_2500mGRID_Cryosat_FLAT_Movmedian_filter5x5

print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/dhdt_from_Velocity_AND_IB_2500mGRID_Cryosat_FLAT_NoFilter

print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/dhdt_from_Velocity_AND_IB_2500mGRID_Cryosat_FLAT_movMean_5x5_Velocities



%% Plot dh/dt vel simulated 10x

figure
a1=subplot(221);
hold on
ha=imagesc(Xgimp(1,:),Ygimp(:,1),dtdt_from_vel_gimp_interp.*10);
set(ha,'alphadata',~isnan(dtdt_from_vel_gimp_interp))
set(gca,'yDir','Normal')
caxis([-150 0])
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k','markersize',1);
c1=colormap(a1,'redbluecmap');
colormap(a1,flipud(c1) );
%colorbar
ylabel('dh/dt simulated from Vel 10x','fontsize',12,'fontweight','b');
xlim([-220000 -110000]);
ylim([-2300000 -2245000]);
plot(X_if,Y_if,'k','markersize',2);
cc=colorbar
title('[m/yr]','fontsize',12,'fontweight','b');

a3=subplot(222);
hold on
ha=imagesc(Xvel(1,:),Yvel(:,1),flip(im_vel_161024_161030_dhdtVEL_correc_60x));
set(ha,'alphadata',~isnan(flip(im_vel_161024_161030_dhdtVEL_correc_60x)))
set(gca,'yDir','Normal')
caxis([0 10000])
c3=colormap(a3,'jet');
%colormap(a3, flipud(c3) );
%colorbar
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k','markersize',1);
title('Velocity [m/yr]','fontsize',12,'fontweight','b');
xlim([-220000 -110000]);
ylim([-2300000 -2245000])
plot(X_if,Y_if,'k','markersize',2);
cc=colorbar



diff_161024_161030_dhdtVEL_correc_60x=movmean(im_vel_161024_161030_dhdtVEL_correc_60x,[5 5],'omitnan')-movmean(im_vel,[5 5],'omitnan');
a5=subplot(223);
hold on
ha=imagesc(Xvel(1,:),Yvel(:,1),flip(diff_161024_161030_dhdtVEL_correc_60x));
set(ha,'alphadata',~isnan(flip(diff_161024_161030_dhdtVEL_correc_60x)))
set(gca,'yDir','Normal')
caxis([-1500 1500])
c5=colormap(a5,'redbluecmap');
colormap(a5, flipud(c5) );
plot(X_w,Y_w,'k');
plot(X_p_curve_JAK,Y_p_curve_JAK,'.k','markersize',1);
title('Velocity Difference [m/yr]','fontsize',12,'fontweight','b');
xlim([-220000 -110000]);
ylim([-2300000 -2245000])
plot(X_if,Y_if,'k','markersize',2);
colorbar


subplot(224)
hist(diff_161024_161030_dhdtVEL_correc_60x(:),[-2500:5:2500])
xlim([-2600 2600])
ylim([0 10000])
nanstd(diff_161024_161030_dhdtVEL_correc_60x(:))
nanmean(diff_161024_161030_dhdtVEL_correc_60x(:))
nanmedian(diff_161024_161030_dhdtVEL_correc_60x(:))
text(-2400,9000,['mean:' num2str(round(nanmean(diff_161024_161030_dhdtVEL_correc_60x(:)),2))])
text(-2400,8000,['median:' num2str(round(nanmedian(diff_161024_161030_dhdtVEL_correc_60x(:)),2))])
text(-2400,7000,['sd:' num2str(round(nanstd(diff_161024_161030_dhdtVEL_correc_60x(:)),2))])

print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/dhdt_from_Velocity_10x

%% vel profiles

prof_im_vel=profile_ext_mean(X_p_curve_JAK,Y_p_curve_JAK,im_vel,R_vel,5);
prof_im_vel_correc=profile_ext_mean(X_p_curve_JAK,Y_p_curve_JAK,im_vel_161024_161030_correc,R_vel,5);
prof_im_vel_dhdtVEL_correc=profile_ext_mean(X_p_curve_JAK,Y_p_curve_JAK,im_vel_161024_161030_dhdtVEL_correc,R_vel,5);
prof_im_vel_dhdtVEL_correc_60x=profile_ext_mean(X_p_curve_JAK,Y_p_curve_JAK,im_vel_161024_161030_dhdtVEL_correc_60x,R_vel,5);
prof_im_vel_dhdtVEL_IB2500m_correc_excluded=profile_ext_mean(X_p_curve_JAK,Y_p_curve_JAK,im_vel_161024_161030_IB2500m_correc_excluded,R_vel,5);
prof_im_vel_Flat=profile_ext_mean(X_p_curve_JAK,Y_p_curve_JAK,im_vel_ONES,R_vel,5);


figure
plot(dist_if_JAK,prof_im_vel,'.');
hold on
plot(dist_if_JAK,prof_im_vel_correc,'.');
plot(dist_if_JAK,prof_im_vel_dhdtVEL_IB2500m_correc_excluded,'.');
plot(dist_if_JAK,prof_im_vel_dhdtVEL_correc,'.');
plot(dist_if_JAK,prof_im_vel_dhdtVEL_correc_60x,'.');
plot(dist_if_JAK,prof_im_vel_Flat,'.');

plot([0 0],[0 18000],'--k');
ylim([0 14000])
xlabel('distance from the grounding line [km]','fontsize',12,'fontweight','b')
ylabel('Velocity [m/yr]','fontsize',12,'fontweight','b');
grid on

legend('No correction','Cryosat','IB 2.5km grid','simulated dh/dt from Vel','simulated dh/dt from Vel 10x','Flat');

print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Velocity_Profiles_dhdt_correction



% Velocity Comparison


% 
% figure
% subplot(511)
% plot(dist_if_JAK,movmedian(prof_im_vel_correc-prof_im_vel,25),'r.');hold on
% 
% subplot(512)
% plot(dist_if_JAK,movmedian(prof_im_vel_dhdtVEL_IB2500m_correc_excluded-prof_im_vel,25),'r.');hold on
% 
% subplot(513)
% plot(dist_if_JAK,movmedian(prof_im_vel_dhdtVEL_correc-prof_im_vel,25),'r.');hold on
% 
% subplot(514)
% plot(dist_if_JAK,movmedian(prof_im_vel_dhdtVEL_correc_60x-prof_im_vel,25),'r.');hold on
% 
% subplot(515)
% plot(dist_if_JAK,movmedian(prof_im_vel_Flat-prof_im_vel,25),'r.');hold on
% 
% subplot(511)
% plot(dist_if_JAK,prof_im_vel_correc-prof_im_vel,'.');hold on
% ylim([-250 250])
% grid on
% plot([0 0],[-2000 2000],'--k');
% title('Cryosat - NoCorrection','fontsize',12,'fontweight','b');
% 
% 
% subplot(512)
% plot(dist_if_JAK,prof_im_vel_dhdtVEL_IB2500m_correc_excluded-prof_im_vel,'.');hold on
% ylim([-250 250])
% grid on
% plot([0 0],[-2000 2000],'--k');
% title('IB - NoCorrection','fontsize',12,'fontweight','b');
% ylabel('Difference [m/yr]','fontsize',14,'fontweight','b');
% 
% 
% subplot(513)
% plot(dist_if_JAK,prof_im_vel_dhdtVEL_correc-prof_im_vel,'.');hold on
% ylim([-250 250])
% grid on
% plot([0 0],[-2000 2000],'--k');
% title('Simulated From Vel - NoCorrection','fontsize',12,'fontweight','b');
% 
% subplot(514)
% plot(dist_if_JAK,prof_im_vel_dhdtVEL_correc_60x-prof_im_vel,'.');hold on
% ylim([-2000 2000])
% grid on
% plot([0 0],[-2000 2000],'--k');
% title('Simulated From Vel 10x - NoCorrection','fontsize',12,'fontweight','b');
% 
% subplot(515)
% plot(dist_if_JAK,prof_im_vel_Flat-prof_im_vel,'.');hold on
% ylim([-2000 2000])
% grid on
% plot([0 0],[-2000 2000],'--k');
% title('Flat DEM - NoCorrection','fontsize',12,'fontweight','b');
% xlabel('distance from the grounding line [km]','fontsize',14,'fontweight','b')
% 
% 
% print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Velocity_Profiles_dhdt_correction_Difference_movMedianDestaque_Window5


% Creating a table each 5 km along the prifile (Vide Slope_Correction_dhdt.xls)

diff_prof_im_vel_correc=prof_im_vel_correc-prof_im_vel;
diff_prof_im_vel_dhdtVEL_IB2500m_correc_excluded=prof_im_vel_dhdtVEL_IB2500m_correc_excluded-prof_im_vel;
diff_prof_im_vel_dhdtVEL_correc=prof_im_vel_dhdtVEL_correc-prof_im_vel;
diff_prof_im_vel_dhdtVEL_correc_60x=prof_im_vel_dhdtVEL_correc_60x-prof_im_vel;
diff_prof_im_vel_Flat=prof_im_vel_Flat-prof_im_vel;

j=1;
for i=138:102:953
  mean_diff_slope_correction(1,j)=nanmean(diff_prof_im_vel_correc(i:i+101));
  mean_diff_slope_correction(2,j)=nanmean(diff_prof_im_vel_dhdtVEL_IB2500m_correc_excluded(i:i+101));
  mean_diff_slope_correction(3,j)=nanmean(diff_prof_im_vel_dhdtVEL_correc(i:i+101));
  mean_diff_slope_correction(4,j)=nanmean(diff_prof_im_vel_dhdtVEL_correc_60x(i:i+101));
  mean_diff_slope_correction(5,j)=nanmean(diff_prof_im_vel_Flat(i:i+101));
  j=j+1
end
j=9;
mean_diff_slope_correction(1,j)=nanmean(diff_prof_im_vel_correc(954:999));
  mean_diff_slope_correction(2,j)=nanmean(diff_prof_im_vel_dhdtVEL_IB2500m_correc_excluded(954:999));
  mean_diff_slope_correction(3,j)=nanmean(diff_prof_im_vel_dhdtVEL_correc(954:999));
  mean_diff_slope_correction(4,j)=nanmean(diff_prof_im_vel_dhdtVEL_correc_60x(954:999));
  mean_diff_slope_correction(5,j)=nanmean(diff_prof_im_vel_Flat(954:999));

  
  thres=40;thres2=100;
  for i=546:749
      
  if  (diff_prof_im_vel_correc(i)>=thres | diff_prof_im_vel_correc(i)<=-thres)
      diff_prof_im_vel_correc(i)=nan;
  else
      diff_prof_im_vel_correc(i)=diff_prof_im_vel_correc(i);
  end
  
  if  (diff_prof_im_vel_dhdtVEL_IB2500m_correc_excluded(i)>=thres | diff_prof_im_vel_dhdtVEL_IB2500m_correc_excluded(i)<=-thres)
      diff_prof_im_vel_dhdtVEL_IB2500m_correc_excluded(i)=nan;
  else
      diff_prof_im_vel_dhdtVEL_IB2500m_correc_excluded(i)=diff_prof_im_vel_dhdtVEL_IB2500m_correc_excluded(i);
  end
  
  if  (diff_prof_im_vel_dhdtVEL_correc(i)>=thres | diff_prof_im_vel_dhdtVEL_correc(i)<=-thres)
      diff_prof_im_vel_dhdtVEL_correc(i)=nan;
  else
      diff_prof_im_vel_dhdtVEL_correc(i)=diff_prof_im_vel_dhdtVEL_correc(i);
  end
  
  if  (diff_prof_im_vel_dhdtVEL_correc_60x(i)>=thres2 | diff_prof_im_vel_dhdtVEL_correc_60x(i)<=-thres2)
      diff_prof_im_vel_dhdtVEL_correc_60x(i)=nan;
  else
      diff_prof_im_vel_dhdtVEL_correc_60x(i)=diff_prof_im_vel_dhdtVEL_correc_60x(i);
  end
  
  if  (diff_prof_im_vel_Flat(i)>=thres2 | diff_prof_im_vel_Flat(i)<=-thres2)
      diff_prof_im_vel_Flat(i)=nan;
  else
     diff_prof_im_vel_Flat(i)=diff_prof_im_vel_Flat(i);
  end
 
  
  end
  
  
  j=5;
mean_diff_slope_correction(1,j)=nanmean(diff_prof_im_vel_correc(546:647));
  mean_diff_slope_correction(2,j)=nanmean(diff_prof_im_vel_dhdtVEL_IB2500m_correc_excluded(546:647));
  mean_diff_slope_correction(3,j)=nanmean(diff_prof_im_vel_dhdtVEL_correc(546:647));
  mean_diff_slope_correction(4,j)=nanmean(diff_prof_im_vel_dhdtVEL_correc_60x(546:647));
  mean_diff_slope_correction(5,j)=nanmean(diff_prof_im_vel_Flat(546:647));
  
  j=6;
mean_diff_slope_correction(1,j)=nanmean(diff_prof_im_vel_correc(648:749));
  mean_diff_slope_correction(2,j)=nanmean(diff_prof_im_vel_dhdtVEL_IB2500m_correc_excluded(648:749));
  mean_diff_slope_correction(3,j)=nanmean(diff_prof_im_vel_dhdtVEL_correc(648:749));
  mean_diff_slope_correction(4,j)=nanmean(diff_prof_im_vel_dhdtVEL_correc_60x(648:749));
  mean_diff_slope_correction(5,j)=nanmean(diff_prof_im_vel_Flat(648:749));

%%% max e min


j=1;
for i=138:102:953
  max_diff_slope_correction(1,j)=max(diff_prof_im_vel_correc(i:i+101));
  max_diff_slope_correction(2,j)=max(diff_prof_im_vel_dhdtVEL_IB2500m_correc_excluded(i:i+101));
  max_diff_slope_correction(3,j)=max(diff_prof_im_vel_dhdtVEL_correc(i:i+101));
  max_diff_slope_correction(4,j)=max(diff_prof_im_vel_dhdtVEL_correc_60x(i:i+101));
  max_diff_slope_correction(5,j)=max(diff_prof_im_vel_Flat(i:i+101));
  j=j+1
end
j=9;
max_diff_slope_correction(1,j)=max(diff_prof_im_vel_correc(954:999));
  max_diff_slope_correction(2,j)=max(diff_prof_im_vel_dhdtVEL_IB2500m_correc_excluded(954:999));
  max_diff_slope_correction(3,j)=max(diff_prof_im_vel_dhdtVEL_correc(954:999));
  max_diff_slope_correction(4,j)=max(diff_prof_im_vel_dhdtVEL_correc_60x(954:999));
  max_diff_slope_correction(5,j)=max(diff_prof_im_vel_Flat(954:999));
  
  j=1;
for i=138:102:953
  min_diff_slope_correction(1,j)=min(diff_prof_im_vel_correc(i:i+101));
  min_diff_slope_correction(2,j)=min(diff_prof_im_vel_dhdtVEL_IB2500m_correc_excluded(i:i+101));
  min_diff_slope_correction(3,j)=min(diff_prof_im_vel_dhdtVEL_correc(i:i+101));
  min_diff_slope_correction(4,j)=min(diff_prof_im_vel_dhdtVEL_correc_60x(i:i+101));
  min_diff_slope_correction(5,j)=min(diff_prof_im_vel_Flat(i:i+101));
  j=j+1
end
j=9;
min_diff_slope_correction(1,j)=min(diff_prof_im_vel_correc(954:999));
  min_diff_slope_correction(2,j)=min(diff_prof_im_vel_dhdtVEL_IB2500m_correc_excluded(954:999));
  min_diff_slope_correction(3,j)=min(diff_prof_im_vel_dhdtVEL_correc(954:999));
  min_diff_slope_correction(4,j)=min(diff_prof_im_vel_dhdtVEL_correc_60x(954:999));
  min_diff_slope_correction(5,j)=min(diff_prof_im_vel_Flat(954:999));

  
  
figure
subplot(511)
plot(dist_if_JAK,diff_prof_im_vel_correc,'.');hold on
ylim([-250 250])
grid on
plot([0 0],[-2000 2000],'--k');
title('Cryosat - NoCorrection','fontsize',12,'fontweight','b');


subplot(512)
plot(dist_if_JAK,diff_prof_im_vel_dhdtVEL_IB2500m_correc_excluded,'.');hold on
ylim([-250 250])
grid on
plot([0 0],[-2000 2000],'--k');
title('IB - NoCorrection','fontsize',12,'fontweight','b');


subplot(513)
plot(dist_if_JAK,diff_prof_im_vel_dhdtVEL_correc,'.');hold on
ylim([-250 250])
grid on
plot([0 0],[-2000 2000],'--k');
title('Simulated From Vel - NoCorrection','fontsize',12,'fontweight','b');
ylabel('Difference [m/yr]','fontsize',14,'fontweight','b');

subplot(514)
plot(dist_if_JAK,diff_prof_im_vel_dhdtVEL_correc_60x,'.');hold on
ylim([-2000 2000])
grid on
plot([0 0],[-2000 2000],'--k');
title('Simulated From Vel 10x - NoCorrection','fontsize',12,'fontweight','b');

subplot(515)
plot(dist_if_JAK,diff_prof_im_vel_Flat,'.');hold on
ylim([-2000 2000])
grid on
plot([0 0],[-2000 2000],'--k');
title('Flat DEM - NoCorrection','fontsize',12,'fontweight','b');
xlabel('distance from the grounding line [km]','fontsize',14,'fontweight','b')


print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Velocity_Profiles_dhdt_correction_Difference


