IB_2010_p1 = shaperead('/nfs/a59/eeagdl/DATABASE/GREENLAND/IceBridge/Elevation/2010/IB_2010_p1_reproj.shp');
lon_IB2010_JAK_p1=extractfield(IB_2010_p1,'X');
lat_IB2010_JAK_p1=extractfield(IB_2010_p1,'Y');
elev_IB2010_JAK_p1=extractfield(IB_2010_p1,'WGS84_Elli');

IB_2010_p2 = shaperead('/nfs/a59/eeagdl/DATABASE/GREENLAND/IceBridge/Elevation/2010/IB_2010_p2_reproj.shp');
lon_IB2010_JAK_p2=extractfield(IB_2010_p2,'X');
lat_IB2010_JAK_p2=extractfield(IB_2010_p2,'Y');
elev_IB2010_JAK_p2=extractfield(IB_2010_p2,'WGS84_Elli');

IB_2010_p3 = shaperead('/nfs/a59/eeagdl/DATABASE/GREENLAND/IceBridge/Elevation/2010/IB_2010_p3_reproj.shp');
lon_IB2010_JAK_p3=extractfield(IB_2010_p3,'X');
lat_IB2010_JAK_p3=extractfield(IB_2010_p3,'Y');
elev_IB2010_JAK_p3=extractfield(IB_2010_p3,'WGS84_Elli');


elev_IB2010_JAK=[elev_IB2010_JAK_p3 elev_IB2010_JAK_p2 elev_IB2010_JAK_p1];
lon_IB2010_JAK=[lon_IB2010_JAK_p3 lon_IB2010_JAK_p2 lon_IB2010_JAK_p1];
lat_IB2010_JAK=[lat_IB2010_JAK_p3 lat_IB2010_JAK_p2 lat_IB2010_JAK_p1];

distIB_2010=-14.7:(77/(length(elev_IB2010_JAK)-1)):62.3;


prof_DEM_JAK_2010=profile_ext(lon_IB2010_JAK,lat_IB2010_JAK,GIMP_DEM,R_gimp);
distIB_2010_DEM=-14.7:(77/(length(prof_DEM_JAK_2010)-1)):62.3;
prof_DEM_JAK_2010_interp=interp1(distIB_2010_DEM,prof_DEM_JAK_2010,distIB_2010,'cubic');


prof_DEM_JAK_2010_2km=profile_ext_mean(lon_IB2010_JAK,lat_IB2010_JAK,GIMP_DEM,R_gimp,22);
prof_DEM_JAK_2010_5km=profile_ext_mean(lon_IB2010_JAK,lat_IB2010_JAK,GIMP_DEM,R_gimp,55);
%prof_DEM_JAK_2010_10km=profile_ext_mean(lon_IB2010_JAK,lat_IB2010_JAK,GIMP_DEM,R_gimp,111);

prof_DEM_JAK_2010_interp_2km=interp1(distIB_2010_DEM,prof_DEM_JAK_2010_2km,distIB_2010,'cubic');
prof_DEM_JAK_2010_interp_5km=interp1(distIB_2010_DEM,prof_DEM_JAK_2010_5km,distIB_2010,'cubic');
%prof_DEM_JAK_2010_interp_10km=interp1(distIB_2010_DEM,prof_DEM_JAK_2010_10km,distIB_2010,'cubic');


%%%  2016

ice_Bridge_2016 = shaperead('/nfs/a59/eeagdl/DATABASE/GREENLAND/IceBridge/Elevation/2016/IB_2016_pts_reproj.shp');
lon_IB2016_JAK=extractfield(ice_Bridge_2016,'xx');
lat_IB2016_JAK=extractfield(ice_Bridge_2016,'yy');
elev_IB2016_JAK=extractfield(ice_Bridge_2016,'WGS84_Elli');

distIB_2016=-7.7:(54/(length(elev_IB2016_JAK)-1)):46.3;


prof_DEM_JAK_2016=profile_ext(lon_IB2016_JAK,lat_IB2016_JAK,GIMP_DEM,R_gimp);
distIB_2016_DEM=-7.7:(54/(length(prof_DEM_JAK_2016)-1)):46.3;

prof_DEM_JAK_2016_interp=interp1(distIB_2016_DEM,prof_DEM_JAK_2016,distIB_2016,'cubic');

prof_DEM_JAK_2016_2km=profile_ext_mean(lon_IB2016_JAK,lat_IB2016_JAK,GIMP_DEM,R_gimp,22);
prof_DEM_JAK_2016_5km=profile_ext_mean(lon_IB2016_JAK,lat_IB2016_JAK,GIMP_DEM,R_gimp,55);
%prof_DEM_JAK_2016_10km=profile_ext_mean(lon_IB2016_JAK,lat_IB2016_JAK,GIMP_DEM,R_gimp,111);

prof_DEM_JAK_2016_interp_2km=interp1(distIB_2016_DEM,prof_DEM_JAK_2016_2km,distIB_2016,'cubic');
prof_DEM_JAK_2016_interp_5km=interp1(distIB_2016_DEM,prof_DEM_JAK_2016_5km,distIB_2016,'cubic');
%prof_DEM_JAK_2016_interp_10km=interp1(distIB_2016_DEM,prof_DEM_JAK_2016_10km,distIB_2016,'cubic');





figure;
plot(dist_if_JAK,prof_DEM_JAK,'.r'); hold on
plot(distIB_2010,elev_IB2010_JAK,'.b');
plot(distIB_2016,elev_IB2016_JAK,'.k');


% figures

figure
subplot(2,2,1)
plot(dist_if_JAK,prof_DEM_JAK,'.g'); hold on
plot(distIB_2010_DEM,prof_DEM_JAK_2010,'.m');
plot(distIB_2016_DEM,prof_DEM_JAK_2016,'.k');
legend('my prof','GIMP2010','Gimp2016','location','northwest')
grid on
title('GIMP')

subplot(2,2,2)
plot(distIB_2010_DEM,prof_DEM_JAK_2010,'.m');
hold on
plot(distIB_2010,elev_IB2010_JAK,'.k');
grid on
legend('GIMP','IB','location','northwest')
title('2010')

subplot(2,2,3)
plot(distIB_2016_DEM,prof_DEM_JAK_2016,'.m');hold on
plot(distIB_2016,elev_IB2016_JAK,'.k');
title('2016')
legend('GIMP','IB','location','northwest')
grid on

print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/DEMs_profiles



figure
subplot(2,1,1)
plot(distIB_2010,(prof_DEM_JAK_2010_interp-elev_IB2010_JAK),'.')
title('GIMP-IB (2010 profile)')
grid on
ylim([-50 250])
xlim([-20 70])

subplot(2,1,2)
plot(distIB_2016,(prof_DEM_JAK_2016_interp-elev_IB2016_JAK),'.')
title('GIMP-IB (2016 profile)')
ylim([-50 250])
xlim([-20 70])
grid on

print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/DEMs_profiles_diff





figure
subplot(2,1,1)
plot(dist_if_JAK,prof_DEM_JAK,'.g'); hold on
plot(distIB_2010,prof_DEM_JAK_2010_interp_2km,'.m');
plot(distIB_2010,prof_DEM_JAK_2010_interp_5km,'.k');
plot(distIB_2010,elev_IB2010_JAK,'.b');
legend('GIMP','GIMP IB2010 2km','GIMP IB2010 5km','IB2010','location','northwest')
grid on
title('2010')
ylim([0 1500])
xlim([-20 70])

subplot(2,1,2)
plot(dist_if_JAK,prof_DEM_JAK,'.g'); hold on
plot(distIB_2016,prof_DEM_JAK_2016_interp_2km,'.m');
plot(distIB_2016,prof_DEM_JAK_2016_interp_5km,'.k');
plot(distIB_2016,elev_IB2016_JAK,'.b');
legend('GIMP','GIMP IB2016 2km','GIMP IB2016 5km','IB2016','location','northwest')
grid on
title('2016')
ylim([0 1500])
xlim([-20 70])

print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/DEMs_profiles_diff_2km_5km




figure
subplot(2,1,1)
plot(distIB_2010,(prof_DEM_JAK_2010_interp-elev_IB2010_JAK),'.'); hold on;
plot(distIB_2010,movmean((prof_DEM_JAK_2010_interp-elev_IB2010_JAK),[286 286]),'.r'); hold on;
plot(distIB_2010,movmean((prof_DEM_JAK_2010_interp-elev_IB2010_JAK),[714 714]),'.g');
plot(distIB_2010,movmean((prof_DEM_JAK_2010_interp-elev_IB2010_JAK),[1429 1429]),'.k')

title('GIMP-IB (2010 profile)')
ylim([-50 250])
xlim([-20 70])
grid on
legend('GIMP-IB','GIMP-IB (2km)','GIMP-IB (5km)','GIMP-IB (10km)','location','northeast')


subplot(2,1,2)
plot(distIB_2016,(prof_DEM_JAK_2016_interp-elev_IB2016_JAK),'.'); hold on;
plot(distIB_2016,movmean((prof_DEM_JAK_2016_interp-elev_IB2016_JAK),[286 286]),'.r')
plot(distIB_2016,movmean((prof_DEM_JAK_2016_interp-elev_IB2016_JAK),[714 714]),'.g');
plot(distIB_2016,movmean((prof_DEM_JAK_2016_interp-elev_IB2016_JAK),[1429 1429]),'.k')

title('GIMP-IB (2016 profile)')
ylim([-50 250])
xlim([-20 70])
grid on
legend('GIMP-IB','GIMP-IB (2km)','GIMP-IB (5km)','GIMP-IB (10km)','location','northeast')
print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/DEMs_profiles_diff_Mov_mean



%%%%%%%%%%%%%% Slope Correction

diff_2km_2010=movmean((prof_DEM_JAK_2010_interp-elev_IB2010_JAK),[286 286]);

diff_2km_2016=movmean((prof_DEM_JAK_2016_interp-elev_IB2016_JAK),[256 256]);

% plot(distIB_2016,movmean((prof_DEM_JAK_2016_interp-elev_IB2016_JAK),[286 286]),'.r')
% 
% plot(distIB_2016,diff_2km_2016,'.r')

diff_2km_2016_interp=interp1(distIB_2016,diff_2km_2016,dist_if_JAK);
diff_2km_2010_interp=interp1(distIB_2010,diff_2km_2010,dist_if_JAK);

gimp_corrected_2010= prof_DEM_JAK-diff_2km_2010_interp';

gimp_corrected_2016= prof_DEM_JAK-diff_2km_2016_interp';


figure
plot(dist_if_JAK,gimp_corrected_2010,'.'); hold on
plot(dist_if_JAK,gimp_corrected_2016,'.')
plot(dist_if_JAK,prof_DEM_JAK,'.')
grid on

coeff_2010= polyfit(dist_if_JAK*1000,gimp_corrected_2010', 1);
cos_slope_2010= cosd(asind(coeff_2010(1)))

coeff_2016= polyfit(dist_if_JAK*1000,gimp_corrected_2016', 1);
cos_slope_2016= cosd(asind(coeff_2016(1)))

coeff_gimp= polyfit(dist_if_JAK*1000,prof_DEM_JAK', 1);
slope_gimp= cosd(asind(coeff_gimp(1)))


% figure
% plot(dist_if_JAK*1000,gimp_corrected_2010,'.'); hold on
% plot(dist_if_JAK*1000,gimp_corrected_2016,'.')
% plot(dist_if_JAK*1000,prof_DEM_JAK,'.')

figure
plot(distIB_2016,prof_DEM_JAK_2016_interp,'.')
hold on
plot(distIB_2016,elev_IB2016_JAK,'.')


for i=1:128:size(elev_IB2016_JAK,2)

coeff_2016= polyfit(distIB_2016(i:i+127)*1000,elev_IB2016_JAK(i:i+127), 1);
coeff_gimp2016= polyfit(distIB_2016(i:i+127)*1000,prof_DEM_JAK_2016_interp(i:i+127), 1);

%cos_slope_2016(i:i+127)= ones(1,128)*((1-1/(cosd(asind(coeff_2016(1))))  )*100);
slope_2016(i:i+127)= ones(1,128)*(coeff_2016(1)*100);
slope_gimp2016(i:i+127)= ones(1,128)*(coeff_gimp2016(1)*100);

end

slope_2016_cos= cosd(atand(slope_2016/100));
slope_gimp2016_cos= cosd(atand(slope_gimp2016/100));


% 
% for i=1:256:size(elev_IB2016_JAK,2)
% 
% coeff_2016= polyfit(distIB_2016(i:i+255)*1000,elev_IB2016_JAK(i:i+255), 1);
% coeff_gimp2016= polyfit(distIB_2016(i:i+255)*1000,prof_DEM_JAK_2016_interp(i:i+255), 1);
% 
% %cos_slope_2016(i:i+127)= ones(1,128)*((1-1/(cosd(asind(coeff_2016(1))))  )*100);
% slope_2016(i:i+255)= ones(1,256)*(coeff_2016(1)*100);
% slope_gimp2016(i:i+255)= ones(1,256)*(coeff_gimp2016(1)*100);
% 
% end

figure
subplot(3,1,1)
plot(distIB_2016(1:6912),slope_gimp2016)
hold on
plot(distIB_2016(1:6912),slope_2016)
ylabel(gca,'slope [%]','fontsize',12,'fontweight','b','color','k')
grid on

subplot(3,1,3)
plot(distIB_2016,prof_DEM_JAK_2016_interp,'.')
hold on
plot(distIB_2016,elev_IB2016_JAK,'.')
grid on
ylabel(gca,'elevation [m]','fontsize',12,'fontweight','b','color','k')

legend('GIMP','IB','location','northwest')

subplot(3,1,2)
plot(dist_if_JAK,slope_gimp2016_cos_interp./slope_2016_cos_interp)
grid on
ylabel(gca,'cosGIMP / cosIB','fontsize',12,'fontweight','b','color','k')




figure
subplot(3,1,1)
plot(dist_if_JAK,(mean_velocity_JAK_profile'.*(slope_gimp2016_cos_interp./slope_2016_cos_interp)),'.'); hold on
plot(dist_if_JAK,mean_velocity_JAK_profile,'.')
grid on
ylabel(gca,'[m/yr]','fontsize',12,'fontweight','b','color','k')

subplot(3,1,2)
plot(dist_if_JAK,mean_velocity_JAK_profile'-(mean_velocity_JAK_profile'.*(slope_gimp2016_cos_interp./slope_2016_cos_interp)),'.'); hold on

subplot(3,1,3)
plot(dist_if_JAK,mean_velocity_JAK_profile'-(mean_velocity_JAK_profile'.*(1./slope_2016_cos_interp)),'.'); hold on



figure
plot(distIB_2016(1:6912),slope_gimp2016_cos)
hold on
plot(distIB_2016(1:6912),slope_2016_cos)

slope_2016_cos_interp=interp1(distIB_2016(1:6912),slope_2016_cos,dist_if_JAK);
slope_gimp2016_cos_interp=interp1(distIB_2016(1:6912),slope_gimp2016_cos,dist_if_JAK);


plot(dist_if_JAK,mean_velocity_JAK_profile,'.')

figure
plot(dist_if_JAK,(mean_velocity_JAK_profile'.*(slope_gimp2016_cos_interp./slope_2016_cos_interp)),'.'); hold on
plot(dist_if_JAK,mean_velocity_JAK_profile,'.')

figure
plot(dist_if_JAK,mean_velocity_JAK_profile'-(mean_velocity_JAK_profile'.*(slope_gimp2016_cos_interp./slope_2016_cos_interp)),'.'); hold on


figure
plot(dist_if_JAK,slope_gimp2016_cos_interp)
hold on
plot(dist_if_JAK,slope_2016_cos_interp)

figure
plot(dist_if_JAK,slope_gimp2016_cos_interp./slope_2016_cos_interp)
hold on
plot(dist_if_JAK,1./slope_2016_cos_interp)

figure
plot(dist_if_JAK,(mean_velocity_JAK_profile'.*(1./slope_2016_cos_interp)),'.'); hold on
plot(dist_if_JAK,mean_velocity_JAK_profile,'.')



