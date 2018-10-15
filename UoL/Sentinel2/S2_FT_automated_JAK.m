cd /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/download_pixel_website

% JAK
pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/download_pixel_website/'];
%destination=['/nfs/a59/eeagdl/date/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated/'];
d_opt=dir(pathsate_opt);
j=1;
for i=3:2:length(d_opt);
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, date);
end
clear d_opt i j name



for i=1:(size(data,1)-1)
 cd /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/download_pixel_website/

    temp1=char(data{i,1});
    date1=temp1(10:17);
   temp2=char(data{i+1,1});
    date2=temp2(10:17);
    
    date1='20170711';
    date2='20170721'
    spanning=datenum(date2,'yyyymmdd')-datenum(date1,'yyyymmdd');
    
    ['mkdir /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing/' date1 '_' date2 '/']
    
    ['cp ./*' date1 '* /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing/' date1 '_' date2 '/']
    ['cp ./*' date2 '* /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing/' date1 '_' date2 '/']

    ['cd /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing/' date1 '_' date2 '/']

    !app setup gamma/20170706
    ['par_data_geo *' date1 '*.jp2 ' date1 '.dem.par ' date1 '.geo']
    pause(5)
    ['par_data_geo *' date2 '*.jp2 ' date2 '.dem.par ' date2 '.geo']

    ['create_diff_par ' date1 '.dem.par ' date2 '.dem.par ' date1 '_' date2 '.off 2 0']

    ['init_offsetm ' date1 '.geo ' date2 '.geo ' date1 '_' date2 '.off - - - - - - 0.01 256']%128 64 - 1 64 64 7.0 4 0 0

    ['offset_pwrm ' date1 '.geo ' date2 '.geo ' date1 '_' date2 '.off ' date1 '_' date2 '_offs ' date1 '_' date2 '_ccp 32 32 ' date1 '_' date2 '_offsets 2 6 6 0.01 - - - - ' date1 '_' date2 '_ccp']

    ['offset_fitm ' date1 '_' date2 '_offs ' date1 '_' date2 '_ccp ' date1 '_' date2 '.off ' date1 '_' date2 '_coffs ' date1 '_' date2 '_coffsets 0.01']
    
    % tracking
   ['offset_pwr_trackingm ' date1 '.geo ' date2 '.geo ' date1 '_' date2 '.off ' date1 '_' date2 '_offs2 ' date1 '_' date2 '_ccp2 72 72 ' date1 '_' date2 '_offsets2 2 0.01 10 10 - - - - - - - - ' date1 '_' date2 '_ccs2']

    ['reallks ' date1 '.geo master_' date1 '_' date2 '.geo 10980 10 10']

['cpx_to_real ' date1 '_' date2 '_offs2 ' date1 '_' date2 '_real 1098 0']
['cpx_to_real ' date1 '_' date2 '_offs2 ' date1 '_' date2 '_imaginary 1098 1']
['cpx_to_real ' date1 '_' date2 '_offs2 ' date1 '_' date2 '_magnitude 1098 3']
['cpx_to_real ' date1 '_' date2 '_offs2 ' date1 '_' date2 '_phase 1098 4']


['rasdt_pwr24 ' date1 '_' date2 '_real master_' date1 '_' date2 '.geo 1098 1 1 0 1 1 55. 1. .35 1 ' date1 '_' date2 '_ground_range.bmp']
['rasdt_pwr24 ' date1 '_' date2 '_imaginary master_' date1 '_' date2 '.geo 1098 1 1 0 1 1 55. 1. .35 1 ' date1 '_' date2 '_azimuth.bmp']
['rasdt_pwr24 ' date1 '_' date2 '_magnitude master_' date1 '_' date2 '.geo 1098 1 1 0 1 1 55. 1. .35 1 ' date1 '_' date2 '_velocity.bmp']
['rasdt_pwr24 ' date1 '_' date2 '_phase master_' date1 '_' date2 '.geo 1098 1 1 0 1 1 55. 1. .35 1 ' date1 '_' date2 '_angle.bmp']

ground_cor= [date1 '_' date2 '_real']; 
azimuth_cor= [date1 '_' date2 '_imaginary']; 

['float_math ' ground_cor ' - Multi_gro 1098 2 - - - - 10']
['float_math ' azimuth_cor ' - Multi_az 1098 2 - - - - 10']

['float_math Multi_gro Multi_gro Multi_gro2 1098 2']
['float_math Multi_az Multi_az Multi_az2 1098 2']
['float_math Multi_gro2 Multi_az2 Sum 1098 0']
['float_math Sum - squRo 1098 6']
['float_math squRo - VELOCITY_m_day 1098 3 - - - - ' num2str(spanning)] % days apart
['float_math VELOCITY_m_day - VEL_m_y_' date1 '_' date2 ' 1098 2 - - - - 365']

eval(['!cp ./' date1 '.dem.par ./master.dem.par'])

['float_math ' date1 '_' date2 '_ccp2 ' date1 '_' date2 '_ccs2 ' date1 '_' date2 '_SNR 1098 3']

!sed -i '7s/10980/1098/' master.dem.par
!sed -i '8s/10980/1098/' master.dem.par
!sed -i '11s/-10/-100/' master.dem.par
!sed -i '12s/10/100/' master.dem.par

%save in GeoTiff file



['app setup canopy python-libs && /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/Filters/gaussian_filter.py VEL_m_y_' date1 '_' date2 ' float32 1098 1098 VEL_m_y_' date1 '_' date2 '_Fil -w 10 -fmax 0.3']
['app setup canopy python-libs && /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/Filters/dust_filter.py VEL_m_y_' date1 '_' date2 '_Fil float32 1098 1098 VEL_m_y_' date1 '_' date2 '_DuFil']
['data2geotiff master.dem.par VEL_m_y_' date1 '_' date2 '_DuFil 2 VEL_m_y_' date1 '_' date2 '_DuFil.tif']

['data2geotiff master.dem.par VEL_m_y_' date1 '_' date2 ' 2 VEL_m_y_' date1 '_' date2 '.tif']
['data2geotiff master.dem.par master_' date1 '_' date2 '.geo 2 master_' date1 '_' date2 '.tif']

['data2geotiff master.dem.par ' date1 '_' date2 '_SNR 2 SNR_' date1 '_' date2 '.tif']

end


%% JAK

cd /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing
clear all
pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/STACK/'];
d_opt=dir(pathsate_opt);
j=1;
for i=1:length(d_opt);
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name

j=1;
for i=4:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    dest=[destination '/'];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

  eval( ['!cp ./VEL_m_*.tif ' dest]);
  eval( ['!cp ./VEL_m_*_DuFil.tif ' dest]);

  Vel_S2_JAK(:,:,j)=imread(['VEL_m_y_' date '_DuFil.tif']);
  j=j+1;
%  
%  eval( ['!cp ./*mag_yrF.gc.tiff ' dest]);
%  
%  eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' dest]);
%  
%  eval( ['!cp ./*_SO.txt ' dest]);
%  
%  eval( ['!cp ./*.mligc.gc.tiff ' dest]);
%  
%  eval( ['!cp ./*.mliFgc.gc.tiff ' dest]);

%eval( ['!cp ./*.mliFgc.gc.tiff ' dest]);
end

j=1;
for i=4: length(list_opt)
    
   date_S2=list_opt{i,1};
   n_S2(j,1) = datenum(date_S2(1:8),'yyyymmdd');
   n_S2(j,2)=  datenum(date_S2(10:17),'yyyymmdd');
   j=j+1;
end



[im,R_S2_JAK]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing/20170729_20170808/VEL_m_y_20170729_20170808.tif');
clear im
Vel_S2_JAK(Vel_S2_JAK<=50)=nan;
Vel_S2_JAK(Vel_S2_JAK>=20000)=nan;
Vel_S2_JAK_mean=nanmean(Vel_S2_JAK,3);



prof_curve_S2_JAK = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/Profile_Projected/Prof_JAK_pt_S2.shp');
X_p_curve_JAK=extractfield(prof_curve_S2_JAK,'X');
Y_p_curve_JAK=extractfield(prof_curve_S2_JAK,'Y');

X_p_curve_JAK=X_p_curve_JAK(~isnan(X_p_curve_JAK));
Y_p_curve_JAK=Y_p_curve_JAK(~isnan(Y_p_curve_JAK));

%Fixed points 11, 17 , 28

pts_S2_Joughin_JAK_Npts = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/Profile_Projected/N_Points_JAK_pt_S2.shp');
X_pts_S2_Joughin_JAK_Npts=extractfield(pts_S2_Joughin_JAK_Npts,'X');
Y_pts_S2_Joughin_JAK_Npts=extractfield(pts_S2_Joughin_JAK_Npts,'Y');

name_JAK_pts=extractfield(pts_S2_Joughin_JAK_Npts,'Name');


k=1;
for j=[1:length(Y_pts_S2_Joughin_JAK_Npts)]
for i=1:size(Vel_S2_JAK,3)

    pt_S2_Joughin_JAK_Npts(i,k)=profile_ext_mean(X_pts_S2_Joughin_JAK_Npts(1,j),Y_pts_S2_Joughin_JAK_Npts(1,j),Vel_S2_JAK(:,:,i),R_S2_JAK,9);
    %pt_Error_TSX_Joughin_JAK_Npts_updated(i,k)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,j),Y_pts_TSX_Joughin_JAK_Npts(1,j),Error_TSX_updated(:,:,i),R_TSX,12);

end
k=k+1;
end

prof_curve_JAK_S2=nan(999,43);
for i=1:size(vel_s2_JAK_stack,3)
prof_curve_JAK_S2(:,i)=profile_ext_mean(X_p_curve_JAK,Y_p_curve_JAK,vel_s2_JAK_stack(:,:,i),R_stack,11);
end

%%

%good data:
n_S2([2 4:6 8 10 13:14 16:18 20:24 27 30 32 33 35 36 38:43],2)
good=[2 4:6 8 10 13:14 16:18 20:24 27 30 32 33 35 36 38:43];


figure
plot(n_S2(good,2),pt_S2_Joughin_JAK_Npts(good,28),'.'); hold on
plot(n_S2(good,2),pt_S2_Joughin_JAK_Npts(good,11),'.');
plot(n_S2(good,2),pt_S2_Joughin_JAK_Npts(good,17),'.');


for i=1:25
    
    figure(1)
    subplot(5,5,i)
    h=imagesc(vel_s2_JAK_stack(:,:,i)); tt=double(~isnan(vel_s2_JAK_stack(:,:,i))); set(h,'AlphaData', tt);
    colormap jet
    caxis([0 8000])
    title([datestr(n_S2(i,2),'ddmmmyy')])
    
    figure(2)
    subplot(5,5,i)
    plot(dist_if_JAK,prof_curve_JAK_S2(:,i),'.')
    ylim([0 18000])
    xlim([-7 43])
    title([datestr(n_S2(i,2),'ddmmmyy')])
end

j=1;
for i=26:size(Vel_S2_JAK,3)
    
    figure(3)
    subplot(5,5,j)
    h=imagesc(vel_s2_JAK_stack(:,:,i)); tt=double(~isnan(vel_s2_JAK_stack(:,:,i))); set(h,'AlphaData', tt);
    colormap jet
    caxis([0 8000])
    title([datestr(n_S2(i,2),'ddmmmyy')])
    
    figure(4)
    subplot(5,5,j)
    plot(dist_if_JAK,prof_curve_JAK_S2(:,i),'.')
    ylim([0 18000])
    xlim([-7 43])
    title([datestr(n_S2(i,2),'ddmmmyy')])
    j=j+1;
end



