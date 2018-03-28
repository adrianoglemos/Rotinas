offset_pwr_tracking2 20141116.slc.deramp 20141128.slc.deramp 20141116.slc.deramp.par 20141128.slc.deramp.par 20141116_20141128.deramp.off aDW3_256_20141116_20141128.deramp.offs aDW3_256_20141116_20141128.deramp.ccp DW320141116_20141128.deramp.off DW320141116_20141128.deramp.offs 256 256 aDW3_256_20141116_20141128.deramp.offsets 1 0 15 5 - - - - 4 0 0 aDW3_256_20141116_20141128.deramp.ccs


eval(['!offset_tracking aDW3_256_' data1 '_' data2 '.deramp.offs aDW3_256_' data1 '_' data2 '.deramp.ccp ' data1 '.slc.deramp.par ' data1 '_' data2 '.deramp.off aDW3_256_' data1 '_' data2 '.deramp.dis_map aDW3_256_' data1 '_' data2 '.deramp.dis_val 2 0.00 1']);

%eval(['!multi_look ' data1 '.slc.deramp ' data1 '.slc.deramp.par master_deramp.mli master_deramp.mli.par 20 4']);
eval(['!multi_look ' data1 '.slc.deramp ' data1 '.slc.deramp.par aDW3_256master_deramp.mli aDW3_256master_deramp.mli.par 50 15']);%Jak

%eval(['!multi_look ' data1 '.slc.deramp ' data1 '.slc.deramp.par master_deramp.mli master_deramp.mli.par 40 20']);

[s,widthMaster]=system(['grep range_samples: aDW3_256master_deramp.mli.par | cut -c33-36']);
widthMaster=num2str(widthMaster(1,1:4));


eval(['!cpx_to_real aDW3_256_' data1 '_' data2 '.deramp.dis_map aDW3_256ground_' data1 '_' data2 ' ' widthMaster ' 0']);
eval(['!cpx_to_real aDW3_256_' data1 '_' data2 '.deramp.dis_map aDW3_256azimuth_' data1 '_' data2 ' ' widthMaster ' 1']);         
eval(['!cpx_to_real aDW3_256_' data1 '_' data2 '.deramp.dis_map aDW3_256velocity_' data1 '_' data2 ' ' widthMaster ' 3']);
eval(['!cpx_to_real aDW3_256_' data1 '_' data2 '.deramp.dis_map aDW3_256angle_' data1 '_' data2 ' ' widthMaster ' 4']); 

%$col_ramp==10.0 instead of 30.0 (cycle) and also uses 100.0(col_ramp2)
eval(['!rasdt_pwr24 aDW3_256ground_' data1 '_' data2 ' aDW3_256master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 aDW3_256ground_' data1 '_' data2 '.bmp']);
eval(['!rasdt_pwr24 aDW3_256azimuth_' data1 '_' data2 ' aDW3_256master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 aDW3_256azimuth_' data1 '_' data2 '.bmp']);
eval(['!rasdt_pwr24 aDW3_256velocity_' data1 '_' data2 ' aDW3_256master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 aDW3_256velocity_' data1 '_' data2 '.bmp']);
eval(['!rasdt_pwr24 aDW3_256angle_' data1 '_' data2 ' aDW3_256master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 aDW3_256angle_' data1 '_' data2 '.bmp']);


ground_cor= ['aDW3_256ground_' data1 '_' data2]; 
azimuth_cor= ['aDW3_256azimuth_' data1 '_' data2]; 

eval(['!float_math ' ground_cor ' ' ground_cor ' aDW3_256Multi_gro ' widthMaster ' 2']);
eval(['!float_math ' azimuth_cor ' ' azimuth_cor ' aDW3_256Multi_az ' widthMaster ' 2']);
eval(['!float_math aDW3_256Multi_gro aDW3_256Multi_az aDW3_256Sum ' widthMaster ' 0']);
eval(['!float_math aDW3_256Sum - aDW3_256squRo ' widthMaster ' 6']);
%eval(['!float_math squRo - VELOCITY ' widthMaster ' 3 - - - - 36'])% 36 days
eval(['!float_math aDW3_256squRo - aDW3_256VELOCITY ' widthMaster ' 3 - - - - 12'])%12days [m/dia]
eval(['!float_math aDW3_256VELOCITY - aDW3_256VEL_km_y_' data1 '_' data2 ' ' widthMaster ' 2 - - - - 0.365']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Geocoding %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

eval(['!gc_map aDW3_256master_deramp.mli.par - /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem.par /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem aDW3_256' data1 '.dem.par aDW3_256' data1 '.dem aDW3_256' data1 '.lt']);

y2=['grep width: aDW3_256' data1 '.dem.par | cut -c23-26']
[s2,widthDEM]=system(y2);
widthDEM=num2str(widthDEM(1,1:4));

y3=['grep lines: aDW3_256' data1 '.dem.par | cut -c23-26']
[s3,linesDEM]=system(y3);
linesDEM=num2str(linesDEM(1,1:4));

eval(['!geocode_back aDW3_256VEL_km_y_' data1 '_' data2 ' ' widthMaster ' aDW3_256' data1 '.lt aDW3_256vel_geoc_' data1 '_' data2 ' ' widthDEM ' ' linesDEM ' 2 0'])

eval(['!data2geotiff aDW3_256' data1 '.dem.par aDW3_256vel_geoc_' data1 '_' data2 ' 2 aDW3_256VEL_km_y_' data1 '_' data2 '.tif']);


prof_shp = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/ArcGIS/Profiles/Profile_JAK/New_prof_JAK.shp');
X_p=extractfield(prof_shp,'X');
Y_p=extractfield(prof_shp,'Y');

X_p=X_p(~isnan(X_p));
Y_p=Y_p(~isnan(Y_p));


%%% Filtering the product dust and gaussian filter:

%         w=5;  f=0.5;  af=0;
%         
%         eval(['!app setup canopy python-libs && ../../dust_filter.py aDW3_256vel_geoc_* float32 ' widthDEM ' ' linesDEM ' aDW3_256vel_geoc_dust']);
%         eval(['!app setup canopy python-libs && ../../gaussian_filter.py aDW3_256vel_geoc_dust float32 ' widthDEM ' ' linesDEM ' aDW3_256vel_geoc_dust_gauss_' num2str(w) '_' num2str(f) '_' num2str(af) ' -w ' num2str(w) ' -fmax ' num2str(f) ' -af ' num2str(af)]);
%         eval(['!data2geotiff aDW3_25620141116.dem.par aDW3_256vel_geoc_dust_gauss_' num2str(w) '_' num2str(f) '_' num2str(af) ' 2 aDW3_256VEL_km_y_2014111620141128_filter_' num2str(w) '_' num2str(f) '_' num2str(af) '.tif']);

[Vel_dw,R_dw]=geotiffread('aDW3_256VEL_km_y_20141116_20141128.tif');
%[Vel_dw_filt,R_dw_filt]=geotiffread('aDW3_256VEL_km_y_2014111620141128_filter_5_05_0.tif');

Vel_dw(Vel_dw<=0)=nan;
%Vel_dw_filt(Vel_dw_filt<=0)=nan;

[row_S1,col_S1] = map2pix(R_dw,X_p,Y_p);

prof_S1_adw=improfile(Vel_dw,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));
%prof_S1_adw_filt=improfile(Vel_dw_filt,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));

load('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/Velocities_JAK.mat','dist','B_','prof_S1')

figure;
subplot(2,1,1);
plot(dist(1,:),1000*prof_S1_adw(:,1),'.');
hold on
ylabel('velocity [m.yr^{-1}]','fontsize',10,'fontweight','b')
xlabel('distance [km]','fontsize',10,'fontweight','b')
B_=nan(2,3);
B_(:,1)=[-2000;20000];
B_(:,2)=889*0.047949;
plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
xlim([0 (0.047949*999)+1]);
ylim(gca,[0 18000]);
        set(gca,'XTick',[0:5:45])
        set(gca,'YTick',[0:2000:18000])
        grid on;
        title('adaptive script (input 800x100 50x10) 600x80 50X15', 'FontWeight','bold','FontSize',10)

subplot(2,1,2);
% plot(dist(1,:),1000*prof_S1_adw_filt(:,1),'.');
% hold on
% ylabel('velocity [m.yr^{-1}]','fontsize',10,'fontweight','b')
% xlabel('distance [km]','fontsize',10,'fontweight','b')
% B_=nan(2,3);
% B_(:,1)=[-2000;20000];
% B_(:,2)=889*0.047949;
% plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
% xlim([0 (0.047949*999)+1]);
% ylim(gca,[0 18000]);
%         set(gca,'XTick',[0:5:45])
%         set(gca,'YTick',[0:2000:18000])
%         grid on;
%         title('adaptive script 128x128 15x5 filtered', 'FontWeight','bold','FontSize',10)
% 
        



plot(dist(1,:),1000*prof_S1(:,1),'.','color','r');
hold on
ylabel('velocity [m.yr^{-1}]','fontsize',10,'fontweight','b')
xlabel('distance [km]','fontsize',10,'fontweight','b')
B_=nan(2,3);
B_(:,1)=[-2000;20000];
B_(:,2)=889*0.047949;
plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
xlim([0 (0.047949*999)+1]);
ylim(gca,[0 18000]);
        set(gca,'XTick',[0:5:45])
        set(gca,'YTick',[0:2000:18000])
        grid on;
        title('regular script', 'FontWeight','bold','FontSize',10)


legend('1','ice front','2','4','5','6','7','10','12');
