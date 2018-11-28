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
    
    ['mkdir /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing_150_150/' date1 '_' date2 '/']
    
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

pts_S2_Joughin_JAK_Npts = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/Profile_Projected/N_Points_JAK_pt_S2_V2.shp');
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


Vel_S2_JAK_mean=nanmean(Vel_S2_JAK(:,:,good),3);
mapshow(Vel_S2_JAK_mean,Rs2, 'DisplayType','surface'); hold on;
plot(X_pts_S2_Joughin_JAK_Npts(1,[11,17,28]),Y_pts_S2_Joughin_JAK_Npts(1,[11,17,28]),'.r','markersize',30);



for i=1:25
    
    figure(1)
    subplot(5,5,i)
    h=imagesc(vel_s2_JAK_stack(:,:,i)); tt=double(~isnan(vel_s2_JAK_stack(:,:,i))); set(h,'AlphaData', tt);
    colormap jet
    caxis([0 8000])
    title([datestr(n_S2(i,2),'ddmmmyy')])
    
%     figure(2)
%     subplot(5,5,i)
%     plot(dist_if_JAK,prof_curve_JAK_S2(:,i),'.')
%     ylim([0 18000])
%     xlim([-7 43])
%     title([datestr(n_S2(i,2),'ddmmmyy')])
end

j=1;
for i=26:size(Vel_S2_JAK,3)
    
    figure(3)
    subplot(5,5,j)
    h=imagesc(vel_s2_JAK_stack(:,:,i)); tt=double(~isnan(vel_s2_JAK_stack(:,:,i))); set(h,'AlphaData', tt);
    colormap jet
    caxis([0 8000])
    title([datestr(n_S2(i,2),'ddmmmyy')])
%     
%     figure(4)
%     subplot(5,5,j)
%     plot(dist_if_JAK,prof_curve_JAK_S2(:,i),'.')
%     ylim([0 18000])
%     xlim([-7 43])
%     title([datestr(n_S2(i,2),'ddmmmyy')])
     j=j+1;
end


info_JAKS2=geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/STACK/Vel_S2_stack_DuFil.tif');

geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S2/DensityMap_JAK_S2.tif',density_S2, Rs2,'GeoKeyDirectoryTag',info_JAKS2.GeoTIFFTags.GeoKeyDirectoryTag);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Plot comparing S1 and S1 JAK (IM_Paper)
load('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/IM_Paper_updated3.mat','n_sorted_update','pt_TSX_Joughin_JAK_Npts_updated', 'pt_S1_Joughin_JAK_Npts','date_pt_S1_Joughin_JAK','data_str_JAK')


 CM_PGs=['k' ; 'r'];

figure(1)
subplot(211)
j=3;k=1;
for i=[28]% 18 20]
  h(k)=plot(n_sorted_update(:,1),pt_TSX_Joughin_JAK_Npts_updated(:,i),'Marker','square','MarkerSize',5,'LineStyle','none','MarkerEdgeColor',[0.503 0.503 0.503],'color',[0.503 0.503 0.503]);hold on;%pad15
%  j=j+1;
k=k+1;
end
plot(n_S2(good,2),pt_S2_Joughin_JAK_Npts(good,28),'Marker','square','MarkerSize',5,'LineStyle','none','MarkerEdgeColor',[1 128/255 0],'MarkerFaceColor',[1 128/255 0]); hold on

ylim([7000 16000])
set(gca,'YTickLabel',[8000:2000:16000],'fontsize',10)
set(gca,'XGrid','on','YAxisLocation','left','XAxisLocation','top')
datetick('x','yyyy','keeplimits');
%ylabel('Velocity [m/yr]','fontsize',12,'fontweight','b')
xlim([datenum('122008','mmyyyy')  datenum('042017','mmyyyy')])
%set(gca,'Position',[0.13 0.409632352941176 0.775 0.240223554839803]);

for i=[28]% 18 20])
   h(k)=plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,i),'LineStyle','none','MarkerSize',7,'MarkerFaceColor','b','Marker','^','MarkerEdgeColor','k','color','b');hold on; %N6
k=k+1;
end
%legend('TSX','S1ab','location','northwest');


figure(1)
subplot(212)
j=1;
for i=[11 17]% 18 20]
  h(k)=plot(n_sorted_update(:,1),pt_TSX_Joughin_JAK_Npts_updated(:,i),'Marker','square','MarkerSize',5,'LineStyle','none','MarkerEdgeColor',[0.502 0.502 0.502]);hold on;%pad15
 j=j+1;
 k=k+1;
end
   %legend('J1','J2','J3','J4','location','northwest');
   %legend('J1-TSX','J2-TSX','J1-S1ab','J2-S1ab','location','northwest');
   
%    legend('Pad6','Pad7','Pad8','Pad9','Pad11','Pad12','Pad13','Pad14','Pad15')%,'Pad16','Pad17','Pad18','Pad19','Pad20');
xlim([datenum('122008','mmyyyy')  datenum('042017','mmyyyy')])

ylim([2500 7000])

plot(n_S2(good,2),pt_S2_Joughin_JAK_Npts(good,11),'Marker','square','MarkerSize',5,'LineStyle','none','MarkerEdgeColor',[1 128/255 0],'MarkerFaceColor',[1 128/255 0]); hold on
plot(n_S2(good,2),pt_S2_Joughin_JAK_Npts(good,17),'Marker','square','MarkerSize',5,'LineStyle','none','MarkerEdgeColor',[153/255 51/255 1],'MarkerFaceColor',[153/255 51/255 1]); hold on

%plot([datenum('15082015','ddmmyyyy') datenum('15082015','ddmmyyyy')],[0 7000],'linestyle','--','color','r');

figure(1)
    %subplot(3,1,1)
    j=1;
for i=[11 17]% 18 20])
  h(k)= plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,i),'LineStyle','none','MarkerSize',7,'MarkerFaceColor',CM_PGs(j,:),'Marker','^','MarkerEdgeColor','k','color',CM_PGs(j,:));hold on; %N6
j=j+1;
k=k+1;
end
 set(gca,'Position',[0.13 0.0590778097982709 0.775 0.337175792507204]);

%    plot(n_sorted_2015_(:,2),pt_TSX_Joughin_JAK_Npts_2015_(:,1),'MarkerFaceColor','g','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');
%    plot(n_sorted_2015_(:,2),pt_TSX_Joughin_JAK_Npts_2015_(:,2),'MarkerFaceColor','m','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');

%fill([date_pt_S1_Joughin_JAK(1) date_pt_S1_Joughin_JAK(1) n_sorted(end,1) n_sorted(end,1)],[0 7000 7000 0],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');
date_pt_S1_TSX_Joughin_JAK_combined=datestr([min(n_sorted_update(:,1)):max(date_pt_S1_Joughin_JAK)],'mmmyy');
datetick('x','yyyy','keeplimits');
ylabel('Velocity [m/yr]','fontsize',14,'fontweight','b')
set(gca,'XGrid','on','YAxisLocation','left')
%box off

l1=legend([h(1) h(2) h(5) h(6)],'TSX','Jif','J1','J2');
set(l1,'Location','northwest','EdgeColor',[1 1 1]);


set(gcf,'Paperorientation','portrait')
print -djpeg -r300 /nfs/a59/eeagdl/Pts_JAK_Js_S1_S2



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Reading profiles JAK Sentinel 2:

prof1=shaperead('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/Profile_Projected/prof1_pts_S2_split.shp');
Xp1=extractfield(prof1,'X');
Yp1=extractfield(prof1,'Y');

prof2=shaperead('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/Profile_Projected/prof2_pts_S2_split.shp');
Xp2=extractfield(prof2,'X');
Yp2=extractfield(prof2,'Y');

prof3=shaperead('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/Profile_Projected/prof3_pts_S2_split.shp');
Xp3=extractfield(prof3,'X');
Yp3=extractfield(prof3,'Y');

prof4=shaperead('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/Profile_Projected/prof4_pts_S2_split.shp');
Xp4=extractfield(prof4,'X');
Yp4=extractfield(prof4,'Y');

prof5=shaperead('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/Profile_Projected/prof5_pts_S2_split.shp');
Xp5=extractfield(prof5,'X');
Yp5=extractfield(prof5,'Y');

prof6=shaperead('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/Profile_Projected/prof6_pts_S2_split.shp');
Xp6=extractfield(prof6,'X');
Yp6=extractfield(prof6,'Y');



%%% Comparison between 2018 estimation:

[vel_2018_S1,R2018_s1]=geotiffread('VEL_portal_03082018_09082018_Filter.tif');
vs1p1=profile_ext_mean(Xp1,Yp1,vel_2018_S1,R2018_s1,5);
vs1p2=profile_ext_mean(Xp2,Yp2,vel_2018_S1,R2018_s1,5);
vs1p3=profile_ext_mean(Xp3,Yp3,vel_2018_S1,R2018_s1,5);
vs1p4=profile_ext_mean(Xp4,Yp4,vel_2018_S1,R2018_s1,5);
vs1p5=profile_ext_mean(Xp5,Yp5,vel_2018_S1,R2018_s1,5);
vs1p6=profile_ext_mean(Xp6,Yp6,vel_2018_S1,R2018_s1,5);

figure;
plot(flip(vs1p1),'.');hold on
plot(flip(vs1p2),'.')
plot(flip(vs1p3),'.')
plot(vs1p4,'.')
plot(vs1p5,'.')
plot(vs1p6,'.')

vs2p1=profile_ext_mean(Xp1,Yp1,vel_2018,R2018,5);
vs2p2=profile_ext_mean(Xp2,Yp2,vel_2018,R2018,5);
vs2p3=profile_ext_mean(Xp3,Yp3,vel_2018,R2018,5);
vs2p4=profile_ext_mean(Xp4,Yp4,vel_2018,R2018,5);
vs2p5=profile_ext_mean(Xp5,Yp5,vel_2018,R2018,5);
vs2p6=profile_ext_mean(Xp6,Yp6,vel_2018,R2018,5);

figure;
plot(flip(vs2p1),'.');hold on
plot(flip(vs2p2),'.')
plot(flip(vs2p3),'.')
plot(vs2p4,'.')
plot(vs2p5,'.')
plot(vs2p6,'.')


figure;
subplot(231)
plot(flip(vs2p1),'.');hold on
plot(flip(vs1p1),'.');hold on
title('Profile 1');
ylim([0 14000])

subplot(232)
plot(flip(vs2p2),'.');hold on
plot(flip(vs1p2),'.')
title('Profile 2');
ylim([0 14000])

subplot(233)
plot(flip(vs2p3),'.');hold on
plot(flip(vs1p3),'.')
title('Profile 3');
ylim([0 14000])

subplot(234)
plot(vs2p4,'.');hold on
plot(vs1p4,'.')
title('Profile 4');
ylim([0 14000])

subplot(235)
plot(vs2p5,'.');hold on
plot(vs1p5,'.')
title('Profile 5');
ylim([0 14000])

subplot(236)
plot(vs2p6,'.');hold on
plot(vs1p6,'.')
title('Profile 6');
legend('S2','S1')
ylim([0 14000])

load('IM_Paper_updated3.mat', 'pt_S1_Joughin_JAK_Npts','date_pt_S1_Joughin_JAK')


density_S2=Vel_S2_JAK./Vel_S2_JAK; density_S2=nansum(density_S2,3);

figure
imagesc(density_S2)


figure

plot(squeeze(Vel_S2_JAK(316,597,good)),'.'); hold on

plot(squeeze(Vel_S2_JAK(324,601,good)),'.')

717,319

plot(n_S2(good,2),squeeze(Vel_S2_JAK(316,597,good)),'Marker','square','MarkerSize',5,'LineStyle','none','MarkerEdgeColor',[1 128/255 0],'MarkerFaceColor',[1 128/255 0]); hold on

plot(n_S2(good,2),squeeze(Vel_S2_JAK(325,603,good)),'Marker','square','MarkerSize',5,'LineStyle','none','MarkerEdgeColor',[1 1 0],'MarkerFaceColor',[1 1 0]); hold on


plot(n_S2(good,2),squeeze(Vel_S2_JAK(319,717,good)),'Marker','square','MarkerSize',5,'LineStyle','none','MarkerEdgeColor',[1 128/255 0],'MarkerFaceColor',[1 128/255 0]); hold on




grep range_samples: 20170729.slc.mli.par | cut -c33-36


