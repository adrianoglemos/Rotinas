pathsate_opt=['/nfs/a41/S1_CPOM_www/IV_out/JAK/WWW/T162_0068_-050/FT_v30/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/JAK_S1_cpom/'];
d_opt=dir(pathsate_opt);
j=1;
for i=4:length(d_opt)-2;
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name


j=1;
for i=1:length(list_opt);
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    
cd(path1);

eval( ['!cp ./*mag_yrF.gc.tiff ' destination]);
 
eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' destination]);

eval( ['!cp ./*error_DuFil_yrF.gc.tiff ' destination]);
% eval( ['!cp ./*ccpN.gc.tiff ' destination]);
%  
% eval( ['!cp ./*ccsN.gc.tiff ' destination]);


% eval( ['!cp ./*real.gc.tiff ' destination]);
%  
% eval( ['!cp ./*im.gc.tiff ' destination]);

 
date_JAK_S1(i,:)=list_opt{i,1};
  list_opt{i,1}
end

cd /nfs/a59/eeagdl/Data/Available_Images/S2/


list_opt_JAK_S1=list_opt;
clear path1 list_opt pathsate_opt date data ans i j


%%%%%% Merge using gdal_merge.py (use in command line)

cd /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/JAK_S1_cpom/S2_Overlap/

ls -1 *mag_DuFil_yrF.gc.tiff > Mag_filtered_list.txt

gdal_merge.py -n -99999 -a_nodata -99999 -separate -of GTiff -o ../Vel_JAK_S1_cpom_.tif ./*mag_DuFil_yrF.gc.tiff


ls -1 *mag_yrF.gc.tiff > Mag_nofilter_list.txt

gdal_merge.py -n -99999 -a_nodata -99999 -separate -of GTiff -o  ../Vel_JAK_S1_cpom_NOfilter.tif ./*mag_yrF.gc.tiff



ls -1 *error_DuFil_yrF.gc.tiff > error_tiff_list.txt

gdal_merge.py -n -99999 -a_nodata -99999 -separate -of GTiff -o ../Error_JAK_S1_cpom.tif ./*error_DuFil_yrF.gc.tiff




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Importing Vel:

%%%%%Reprojecting S1 data to S2 projection:
% !gdalwarp -ot Float32 -s_srs EPSG:3413 -t_srs EPSG:32622 -r near -of GTiff -co COMPRESS=DEFLATE -co PREDICTOR=1 -co ZLEVEL=6 -wo OPTIMIZE_SIZE=TRUE /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/JAK_S1_cpom/Vel_JAK_S1_cpom_Overlap.tif /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/JAK_S1_cpom/Vel_JAK_S1_cpom_Overlap_reproj.tif
% 
% !gdalwarp -ot Float32 -s_srs EPSG:3413 -t_srs EPSG:32622 -r near -of GTiff -co COMPRESS=DEFLATE -co PREDICTOR=1 -co ZLEVEL=6 -wo OPTIMIZE_SIZE=TRUE /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/JAK_S1_cpom/Error_JAK_S1_cpom.tif /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/JAK_S1_cpom/Error_JAK_S1_cpom_Overlap_reproj.tif
!gdalwarp -ot Float32 -s_srs EPSG:32622 -t_srs EPSG:3413 -r near -of GTiff -co COMPRESS=DEFLATE -co PREDICTOR=1 -co ZLEVEL=6 -wo OPTIMIZE_SIZE=TRUE /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/STACK/Vel_S2_stack_DuFil.tif /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/STACK/Vel_S2_stack_DuFil_reprojected.tif

!gdalwarp -ot Float32 -s_srs EPSG:32622 -t_srs EPSG:3413 -r near -of GTiff -co COMPRESS=DEFLATE -co PREDICTOR=1 -co ZLEVEL=6 -wo OPTIMIZE_SIZE=TRUE /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/JAK_S1_cpom/Error_JAK_S1_cpom.tif /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/JAK_S1_cpom/Error_JAK_S1_cpom_Overlap_reproj.tif

%%%%%%

%Importing Sentinel-1 velocities
[Vel_S1_overlap,R_S1_overlap]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/JAK_S1_cpom/Vel_JAK_S1_cpom_Overlap.tif');

Error_S1_overlap=imread('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/JAK_S1_cpom/Error_JAK_S1_cpom.tif');


Vel_S1_overlap(Vel_S1_overlap<=0)=nan;
Error_S1_overlap(Error_S1_overlap<0)=nan;


[Vel_S2,R_S2]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/STACK/Vel_S2_stack_DuFil_reprojected.tif');
Vel_S2(Vel_S2<=0)=nan;
% vv=imread('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/STACK/Vel_S2_stack_DuFil.tif');
% vv(vv<=0)=nan;



load /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/JAK_S1_cpom/S2_Overlap/S1_Vel_JAK_overlaping_S2_13_11_2018.mat


[Vga,xga,yga,Ia]=geoimread('/nfs/a59/eeagdl/Data/Available_Images/S2/Russell/S1_reprojected/170814_170826_reproj.tif');
[Vga,Rga]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S2/Russell/S1_reprojected/170814_170826_reproj.tif');

% [Vga,xga,yga,Ia]=geoimread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/12days_processing/20170814_20170826/170814_170826.coffsN_mag_DuFil_yrF.gc.tiff');
% [Vga,Rga]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/12days_processing/20170814_20170826/170814_170826.coffsN_mag_DuFil_yrF.gc.tiff');
Vga(Vga<=0)=nan;
s1_int= interp2(xga,yga,Vga,px,py);




%%% Extract the velocity profiles S1:
addpath(genpath('/nfs/a59/eeagdl/DATABASE/MATLAB/matlab_biblioteca/'))
addpath('/nfs/a59/cryosat/output/py10ts/scripts/')


prof_curve_read_JAK = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/ArcGIS/Profiles/Profile_JAK/Prof_curve_pt_JAK.shp');
X_p_curve_JAK=extractfield(prof_curve_read_JAK,'X');
Y_p_curve_JAK=extractfield(prof_curve_read_JAK,'Y');

X_p_curve_JAK=X_p_curve_JAK(~isnan(X_p_curve_JAK));
Y_p_curve_JAK=Y_p_curve_JAK(~isnan(Y_p_curve_JAK));

for i=1:size(Vel_S1_overlap,3)
[prof_curve_JAK(:,i),N_s1(:,i)]=profile_ext_mean_V2(X_p_curve_JAK,Y_p_curve_JAK,Vel_S1_overlap(:,:,i),R_S1_overlap,11);

end

for i=1:size(Vel_S2,3)
[prof_curve_JAK_S2(:,i),N_s2(:,i)]=profile_ext_mean_V2(X_p_curve_JAK,Y_p_curve_JAK,Vel_S2(:,:,i),R_S2,11);

end
  

%%
%good data:
n_S2([2 4:6 8 10 13:14 16:18 20:24 27 30 32 33 35 36 38:43],2)
good=[2 4:6 8 10 13:14 16:18 20:24 27 30 32 33 35 36 38:43];

good2=[2 6 8 10 13:14 16:18 20:24 26 27 30 33 35 36 39:42];
good3=[2 5 8 10 14 16:18 20:21 23:24 27 33 35 36 39:40 42];

good4=[2 4 10 13 16 22 24 27 30 33 35 38 39:40 41 43];

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




























pts_TSX_Joughin_JAK_Npts = shaperead('/nfs/a59/eeagdl/NRT_project/JkI/Joughin_Points/N_Points_Joughin.shp');
X_pts_TSX_Joughin_JAK_Npts=extractfield(pts_TSX_Joughin_JAK_Npts,'X');
Y_pts_TSX_Joughin_JAK_Npts=extractfield(pts_TSX_Joughin_JAK_Npts,'Y');

% extracting the points:

for j=[1:length(Y_pts_TSX_Joughin_JAK_Npts)]
for i=1:size(Vel_S1_overlap,3)

    [pt_JAK_Npts_S1(i,j),N_points(i,j)]=profile_ext_mean_V2(X_pts_TSX_Joughin_JAK_Npts(1,j),Y_pts_TSX_Joughin_JAK_Npts(1,j),Vel_S1_overlap(:,:,i),R_S1_overlap,11);

end
end

for i=1:73
    imagesc(Vel_S1_overlap(:,:,i));
    i
    i
    pause(1)
end
    
    
    
