% Process the JAK data from the Portal

% Load the stack data

%cd /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated/stack/

[Vel_Stack,R_stack]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated/stack/Update_plus_Update2/Vel_Stack_JAK_Portal_updated1_plus_updated2.tif');

[Vel_Stack_part1,R_stack_part1]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated/stack/Update_plus_Update2/Vel_Stack_JAK_Portal_updated.tif');
[Vel_Stack_part2,R_stack_part2]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated/stack/Update_plus_Update2/Vel_Stack_JAK_Portal_updated_part2.tif');

Vel_Stack_part1(Vel_Stack_part1<=0)=nan;

Vel_Stack_part2(Vel_Stack_part2<=0)=nan;

Vel_Stack(Vel_Stack<=0)=nan;
Vel_Stack_mean=nanmean(Vel_Stack,3);

%Profile Curve JAK 1

prof_curve_read_JAK = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/ArcGIS/Profiles/Profile_JAK/Prof_curve_pt_JAK.shp');
X_p_curve_JAK=extractfield(prof_curve_read_JAK,'X');
Y_p_curve_JAK=extractfield(prof_curve_read_JAK,'Y');

X_p_curve_JAK=X_p_curve_JAK(~isnan(X_p_curve_JAK));
Y_p_curve_JAK=Y_p_curve_JAK(~isnan(Y_p_curve_JAK));


%Profile Across JAK 1

prof_across_JAK1 = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/ArcGIS/Profiles/Profile_JAK/Cross_prof_pt_JAK.shp');
X_across_JAK1=extractfield(prof_across_JAK1,'X');
Y_across_JAK1=extractfield(prof_across_JAK1,'Y');

X_across_JAK1=X_across_JAK1(~isnan(X_across_JAK1));
Y_across_JAK1=Y_across_JAK1(~isnan(Y_across_JAK1));

%Profile Across JAK 2

prof_across_JAK2 = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/ArcGIS/Profiles/Profile_JAK/cross_JAK_2_pt.shp');
X_across_JAK2=extractfield(prof_across_JAK2,'X');
Y_across_JAK2=extractfield(prof_across_JAK2,'Y');

X_across_JAK2=X_across_JAK2(~isnan(X_across_JAK2));
Y_across_JAK2=Y_across_JAK2(~isnan(Y_across_JAK2));

%Profile Across JAK 3

prof_across_JAK3 = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/ArcGIS/Profiles/Profile_JAK/cross_JAK_3_pt.shp');
X_across_JAK3=extractfield(prof_across_JAK3,'X');
Y_across_JAK3=extractfield(prof_across_JAK3,'Y');

X_across_JAK3=X_across_JAK3(~isnan(X_across_JAK3));
Y_across_JAK3=Y_across_JAK3(~isnan(Y_across_JAK3));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Extracting the profiles

prof_curve_JAK=nan(999,size(Vel_Stack,3));

prof_across_JAK1=nan(999,size(Vel_Stack,3));
prof_across_JAK2=nan(999,size(Vel_Stack,3));
prof_across_JAK3=nan(999,size(Vel_Stack,3));

for i=1:size(Vel_Stack,3)
prof_across_JAK1(:,i)=profile_ext_mean(X_across_JAK1,Y_across_JAK1,Vel_Stack(:,:,i),R_stack,5);
prof_across_JAK2(:,i)=profile_ext_mean(X_across_JAK2,Y_across_JAK2,Vel_Stack(:,:,i),R_stack,5);
prof_across_JAK3(:,i)=profile_ext_mean(X_across_JAK3,Y_across_JAK3,Vel_Stack(:,:,i),R_stack,5);

prof_curve_JAK(:,i)=profile_ext_mean(X_p_curve_JAK,Y_p_curve_JAK,Vel_Stack(:,:,i),R_stack,5);
end

%%%%%%%%%  plot profile across (IM_Figures.m)


%%%

dist=0:((0.048957*999)/(length(prof_curve_JAK)-1)):(0.048957*999);


std_velocity_stack_JAK=std(Vel_Stack,1,3);
std_velocity_stack_JAK(std_velocity_stack_JAK<=0)=nan;

%STD profile JAK

std_velocity_JAK_profile=nanstd(prof_curve_JAK,1,2);

%%% Mean and Median velocity

%median_velocity_stack_JAK=nanmedian(Vel_Stack,3);
mean_velocity_stack_JAK=Vel_Stack_mean;

%median_velocity_stack_JAK(median_velocity_stack_JAK<=0)=nan;
mean_velocity_stack_JAK(mean_velocity_stack_JAK<=0)=nan;
mean_velocity_stack_JAK_log=log10(mean_velocity_stack_JAK);

%median_velocity_JAK_profile=profile_ext_mean(X_p_curve_JAK,Y_p_curve_JAK,median_velocity_stack_JAK,R_stack,5);
mean_velocity_JAK_profile=profile_ext_mean(X_p_curve_JAK,Y_p_curve_JAK,mean_velocity_stack_JAK,R_stack,5);

info=geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated/stack/Update_plus_Update2/Vel_Stack_JAK_Portal_updated1_plus_updated2.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/mean_stack_JAK_log_PORTAL.tif', mean_velocity_stack_JAK_log, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/mean_stack_JAK_PORTAL.tif', mean_velocity_stack_JAK, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Changing the summer/winter months
%%%%%%%%%%%%%%%%%%%%%%%%%
% summer: Jun to Aug
% winter: Dec to Feb
%%%%%%%%%%%%%%%%%%%%%%%%%

pathsate_opt_JAK=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated/'];
d_opt_JAK=dir(pathsate_opt_JAK);
j=1;
for i=4:size(d_opt_JAK,1)-1;
    name=d_opt_JAK(i,1).name;
    data_str_JAK1(j,:)=[name(1:6) '-' name(8:13)];
    data_JAK{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt_JAK1(j,1)=cellstr(data_JAK1{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt_JAK i j name

data_str_JAK_num1(:)=datenum(data_str_JAK1(:,1:6),'yymmdd');

pathsate_opt_JAK=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated_2/'];
d_opt_JAK=dir(pathsate_opt_JAK);
j=1;
for i=3:size(d_opt_JAK,1)-1;
    name=d_opt_JAK(i,1).name;
    data_str_JAK2(j,:)=[name(1:6) '-' name(8:13)];
    data_JAK2{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt_JAK2(j,1)=cellstr(data_JAK2{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt_JAK i j name

data_str_JAK_num2(:)=datenum(data_str_JAK2(:,1:6),'yymmdd');

data_str_JAK_num=[data_str_JAK_num1 data_str_JAK_num2];
%summer: [01062015 to 31082015] &  [01062016 to 31082016]
% winter : [01122014 to 28022015] & [01122015 to 28022016] & [01122016 to 28022017]

JAK_summer_find=find((data_str_JAK_num>=datenum('01062015','ddmmyyyy') & data_str_JAK_num<=datenum('31082015','ddmmyyyy')) | ((data_str_JAK_num>=datenum('01062016','ddmmyyyy') & data_str_JAK_num<=datenum('31082016','ddmmyyyy'))));
JAK_winter_find=find((data_str_JAK_num>=datenum('01122014','ddmmyyyy') & data_str_JAK_num<=datenum('28022015','ddmmyyyy')) | ((data_str_JAK_num>=datenum('01122015','ddmmyyyy') & data_str_JAK_num<=datenum('28022016','ddmmyyyy'))) | ((data_str_JAK_num>=datenum('01122016','ddmmyyyy') & data_str_JAK_num<=datenum('28022017','ddmmyyyy'))));


JAK_summer2= Vel_Stack(:,:,JAK_summer_find);
JAK_winter2= Vel_Stack(:,:,JAK_winter_find);

JAK_summer2(JAK_summer2<=0)=nan;
JAK_winter2(JAK_winter2<=0)=nan;

JAK_mean_summer2=nanmean(JAK_summer2,3);
JAK_mean_winter2=nanmean(JAK_winter2,3);

JAK_mean_summer2(JAK_mean_summer2<=0)=nan;
JAK_mean_winter2(JAK_mean_winter2<=0)=nan;

JAK_mean_summer2_log=log10(JAK_mean_summer2);
JAK_mean_winter2_log=log10(JAK_mean_winter2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Create a mask of density measurements
% JAK

for i=1:size(Vel_Stack,3)
Density_Measu_JAK(:,:,i)=~isnan(Vel_Stack(:,:,i));
end

Density_Measu_JAK=double(Density_Measu_JAK);
Density_Measu_JAK_sum=nansum(Density_Measu_JAK,3);
max(Density_Measu_JAK_sum(:))
% Createing a mask based on the measurements

% Mask containing at least 30% of data

Density_Measu_JAK_30=Density_Measu_JAK_sum;
Density_Measu_JAK_30(Density_Measu_JAK_30<27)=nan;
%imagesc(Density_Measu_JAK_30)
Mask_Density_Measu_JAK_30=Density_Measu_JAK_30;
Mask_Density_Measu_JAK_30(Mask_Density_Measu_JAK_30>=27)=1;

info=geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated/stack/Update_plus_Update2/Vel_Stack_JAK_Portal_updated1_plus_updated2.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/Density_Measu_JAK_30.tif', Density_Measu_JAK_30, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


% Mask containing at least 25% of data

Density_Measu_JAK_25=Density_Measu_JAK_sum;
Density_Measu_JAK_25(Density_Measu_JAK_25<22)=nan;
%imagesc(Density_Measu_JAK_25)
Mask_Density_Measu_JAK_25=Density_Measu_JAK_25;
Mask_Density_Measu_JAK_25(Mask_Density_Measu_JAK_25>=22)=1;

info=geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated/stack/Update_plus_Update2/Vel_Stack_JAK_Portal_updated1_plus_updated2.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/Density_Measu_JAK_25.tif', Density_Measu_JAK_25, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% masking based on the density of data  #### 30% #####

JAK_mean_summer2_masked_30p=JAK_mean_summer2;
JAK_mean_summer2_masked_30p(Mask_Density_Measu_JAK_30~=1)=nan;

JAK_mean_winter2_masked_30p=JAK_mean_winter2;
JAK_mean_winter2_masked_30p(Mask_Density_Measu_JAK_30~=1)=nan;

% just getting the values are not nan's values
JAK_mean_winter2_masked_30p(isnan(JAK_mean_summer2_masked_30p))=nan;
JAK_mean_summer2_masked_30p(isnan(JAK_mean_winter2_masked_30p))=nan;


% Calculate Summer-Winter and Winter/Summer

JAK_summer_mean_divided_winter=(1-(JAK_mean_winter2_masked_30p./JAK_mean_summer2_masked_30p))*100;
JAK_summer_mean_minus_winter=JAK_mean_summer2_masked_30p-JAK_mean_winter2_masked_30p;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% masking based on the density of data    #### 25% #####

JAK_mean_summer2_masked_25p=JAK_mean_summer2;
JAK_mean_summer2_masked_25p(Mask_Density_Measu_JAK_25~=1)=nan;

JAK_mean_winter2_masked_25p=JAK_mean_winter2;
JAK_mean_winter2_masked_25p(Mask_Density_Measu_JAK_25~=1)=nan;

% just getting the values are not nan's values
JAK_mean_winter2_masked_25p(isnan(JAK_mean_summer2_masked_25p))=nan;
JAK_mean_summer2_masked_25p(isnan(JAK_mean_winter2_masked_25p))=nan;


% Calculate Summer-Winter and Winter/Summer

JAK_summer_mean_divided_winter=(1-(JAK_mean_winter2_masked_25p./JAK_mean_summer2_masked_25p))*100;
JAK_summer_mean_minus_winter=JAK_mean_summer2_masked_25p-JAK_mean_winter2_masked_25p;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Getting just data inside 2 std's :
JAK_summer_mean_divided_winter(JAK_summer_mean_divided_winter>=(nanmean(JAK_summer_mean_divided_winter(:))+(2*nanstd(JAK_summer_mean_divided_winter(:)))))=nan;
JAK_summer_mean_divided_winter(JAK_summer_mean_divided_winter<=(nanmean(JAK_summer_mean_divided_winter(:))-(2*nanstd(JAK_summer_mean_divided_winter(:)))))=nan;

JAK_summer_mean_minus_winter(JAK_summer_mean_minus_winter>=(nanmean(JAK_summer_mean_minus_winter(:))+(2*nanstd(JAK_summer_mean_minus_winter(:)))))=nan;
JAK_summer_mean_minus_winter(JAK_summer_mean_minus_winter<=(nanmean(JAK_summer_mean_minus_winter(:))-(2*nanstd(JAK_summer_mean_minus_winter(:)))))=nan;


% figure;
% imagesc(JAK_summer_mean_divided_winter);
% caxis([0 25]);
% 
% figure;
% imagesc(JAK_summer_mean_minus_winter);
% caxis([-50 500])


%JAK_summer_minus_winter=JAK_mean_summer-JAK_mean_winter;
info=geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated/stack/Update_plus_Update2/Vel_Stack_JAK_Portal_updated1_plus_updated2.tif');

geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/JAK_mean_summer2_PORTAL.tif', JAK_mean_summer2, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/JAK_mean_winter2_PORTAL.tif', JAK_mean_winter2, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/JAK_mean_summer2_log_PORTAL.tif', JAK_mean_summer2_log, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/JAK_mean_winter2_log_PORTAL.tif', JAK_mean_winter2_log, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/JAK_mean_summer_mean_minus_winter_PORTAL_30p.tif', JAK_summer_mean_minus_winter, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/JAK_winter_mean_divided_summer_PORTAL_30p.tif', JAK_summer_mean_divided_winter, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


%%%%%%% Summer and Winter mean with STD shaded %%%%%%%%%%%%%%%%%

% JAK Summer & Winter

% JAK_summer2_profile=profile_ext_mean(X_p_curve_JAK,Y_p_curve_JAK,JAK_mean_summer2,R_stack,5);
% JAK_winter2_profile=profile_ext_mean(X_p_curve_JAK,Y_p_curve_JAK,JAK_mean_winter2,R_stack,5);

for i=1:size(JAK_summer_find,2)
JAK_summer2_profile(:,i)=profile_ext_mean(X_p_curve_JAK,Y_p_curve_JAK,JAK_summer2(:,:,i),R_stack,5);
end
for i=1:size(JAK_winter_find,2)
JAK_winter2_profile(:,i)=profile_ext_mean(X_p_curve_JAK,Y_p_curve_JAK,JAK_winter2(:,:,i),R_stack,5);
end
%plot((1-(JAK_winter2_profile./JAK_summer2_profile))*100,'.')

JAK_summer2_profile=JAK_summer2_profile/1000;
JAK_winter2_profile=JAK_winter2_profile/1000;




%%%%%%%%%%%%%%%%%%%%%%%%%% JAK1 ; JAK2 ; JAK3 points: %%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:size(Vel_Stack,3)
pt_JAK1_5window_mean(i)=prof_across_JAK1(577,i);
pt_JAK2_5window_mean(i)=prof_across_JAK2(484,i);
pt_JAK3_5window_mean(i)=prof_across_JAK3(433,i);
%pt_JAK_main(i)=prof_curve_JAK(10,i);
end


mdl_pt_JAK1_5window_mean = fitlm(data_str_JAK_num,pt_JAK1_5window_mean/1000);
mdl_pt_JAK2_5window_mean = fitlm(data_str_JAK_num,pt_JAK2_5window_mean/1000);
mdl_pt_JAK3_5window_mean = fitlm(data_str_JAK_num,pt_JAK3_5window_mean/1000);

%%%%%%%%%% Plot Pts (IM_Figures.m)


%%%%%%%%%%%%%%%%%%%%%%%%%% TerraSAR X dataset points: %%%%%%%%%%%%%%%%%%%%%%%%%

% pts_TSX_Joughin_JAK = shaperead('/nfs/a59/eeagdl/NRT_project/JkI/Joughin_Points/Joughin_pt_JAK_points_email_proj.shp');
% X_pts_TSX_Joughin_JAK=extractfield(pts_TSX_Joughin_JAK,'xx');
% Y_pts_TSX_Joughin_JAK=extractfield(pts_TSX_Joughin_JAK,'yy');

pts_TSX_Joughin_JAK_Npts = shaperead('/nfs/a59/eeagdl/NRT_project/JkI/Joughin_Points/N_Points_Joughin.shp');
X_pts_TSX_Joughin_JAK_Npts=extractfield(pts_TSX_Joughin_JAK_Npts,'X');
Y_pts_TSX_Joughin_JAK_Npts=extractfield(pts_TSX_Joughin_JAK_Npts,'Y');

name_JAK_pts=extractfield(pts_TSX_Joughin_JAK_Npts,'Name');

% pt_TSX_Joughin_JAK : 1:6 are the M points //// 7:11 are the N points //// 12:end --> Pad points

% for j=[1:length(Y_pts_TSX_Joughin_JAK)]
% for i=1:size(Vel_TSX,3) 
% pt_TSX_Joughin_JAK(i,j)=profile_ext_mean(X_pts_TSX_Joughin_JAK(1,j),Y_pts_TSX_Joughin_JAK(1,j),Vel_TSX(:,:,i),R_TSX,5);
% 
% end
% end
% 
% for j=[1:length(Y_pts_TSX_Joughin_JAK)]
% for i=1:size(Vel_Stack,3) 
% 
%     pt_S1_Joughin_JAK(i,j)=profile_ext_mean(X_pts_TSX_Joughin_JAK(1,j),Y_pts_TSX_Joughin_JAK(1,j),Vel_Stack(:,:,i),R_stack,5);
%     
% end
% end


for j=[1:length(Y_pts_TSX_Joughin_JAK_Npts)]
for i=1:size(Vel_TSX,3)

    pt_TSX_Joughin_JAK_Npts(i,j)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,j),Y_pts_TSX_Joughin_JAK_Npts(1,j),Vel_TSX(:,:,i),R_TSX,5);

end
end

for j=[1:length(Y_pts_TSX_Joughin_JAK_Npts)]
for i=1:size(Vel_Stack,3) 

    pt_S1_Joughin_JAK_Npts(i,j)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,j),Y_pts_TSX_Joughin_JAK_Npts(1,j),Vel_Stack(:,:,i),R_stack,5);

end
end

data_str_JAK=[data_str_JAK1;data_str_JAK2];
for i=1:length(data_str_JAK);

date_pt_S1_Joughin_JAK(i)=datenum(data_str_JAK(i,1:6),'yymmdd');

end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % Creating mask for intercomparison:
% 
% h=imagesc(mean_velocity_stack_JAK);
% tt=double(~isnan(mean_velocity_stack_JAK)); set(h,'AlphaData', tt);
% caxis([0 6000]);
% 
% % draw masks
% poly_JAK = imfreehand();
% mask_JAK = poly_JAK.createMask();
% 
% slow_mov_JAK_meanMap =mean_velocity_stack_JAK(mask_JAK_fast_areas==1);
% RMS_JAK_meanMap=rms(slow_mov_JAK_meanMap(~isnan(slow_mov_JAK_meanMap)))
% Mean_JAK_meanMap=nanmean(slow_mov_JAK_meanMap(~isnan(slow_mov_JAK_meanMap)))
% Median_JAK_meanMap=nanmedian(slow_mov_JAK_meanMap(~isnan(slow_mov_JAK_meanMap)))
% 
% slow_mov_JAK_summerMap =JAK_mean_summer2(mask_JAK_fast_areas==1);
% RMS_JAK_summerMap=rms(slow_mov_JAK_summerMap(~isnan(slow_mov_JAK_summerMap)))
% Mean_JAK_summerMap=nanmean(slow_mov_JAK_summerMap(~isnan(slow_mov_JAK_summerMap)))
% Median_JAK_summerMap=nanmedian(slow_mov_JAK_summerMap(~isnan(slow_mov_JAK_summerMap)))
% 
% slow_mov_JAK_winterMap =JAK_mean_winter2(mask_JAK_fast_areas==1);
% RMS_JAK_winterMap=rms(slow_mov_JAK_winterMap(~isnan(slow_mov_JAK_winterMap)))
% Mean_JAK_winterMap=nanmean(slow_mov_JAK_winterMap(~isnan(slow_mov_JAK_winterMap)))
% Median_JAK_winterMap=nanmedian(slow_mov_JAK_winterMap(~isnan(slow_mov_JAK_winterMap)))
% 
% 
% geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/JAK_slow_area_mask_PORTAL.tif', mask_JAK, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
% 

%%%%%%% Table %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% JAK
JAK_mean_winter2_backup=JAK_mean_winter2;
JAK_mean_summer2_backup=JAK_mean_summer2;

% JAK_mean_winter2(isnan(JAK_mean_summer2))=nan;
% JAK_mean_summer2(isnan(JAK_mean_winter2))=nan;

mean_velocity_stack_JAK=nanmean(Vel_Stack,3);

mean_velocity_JAK_profile=profile_ext_mean(X_p_curve_JAK,Y_p_curve_JAK,mean_velocity_stack_JAK,R_stack,5);

table3_5window_mean(1,1)=nanmean(mean_velocity_JAK_profile(:));
table3_5window_mean(2,1)=nanmean(prof_across_JAK1(:));
table3_5window_mean(3,1)=nanmean(prof_across_JAK2(:));
table3_5window_mean(4,1)=nanmean(prof_across_JAK3(:));

mean_velocity_JAK_profile_summer2=profile_ext_mean(X_p_curve_JAK,Y_p_curve_JAK,JAK_mean_summer2_masked_30p,R_stack,5);
table3_5window_mean(1,2)=nanmean(mean_velocity_JAK_profile_summer2(:));
table3_5window_mean(2,2)=nanmean(profile_ext_mean(X_across_JAK1,Y_across_JAK1,JAK_mean_summer2_masked_30p,R_stack,5));
table3_5window_mean(3,2)=nanmean(profile_ext_mean(X_across_JAK2,Y_across_JAK2,JAK_mean_summer2_masked_30p,R_stack,5));
table3_5window_mean(4,2)=nanmean(profile_ext_mean(X_across_JAK3,Y_across_JAK3,JAK_mean_summer2_masked_30p,R_stack,5));

mean_velocity_JAK_profile_winter2=profile_ext_mean(X_p_curve_JAK,Y_p_curve_JAK,JAK_mean_winter2_masked_30p,R_stack,5);
table3_5window_mean(1,3)=nanmean(mean_velocity_JAK_profile_winter2(:));

table3_5window_mean(2,3)=nanmean(profile_ext_mean(X_across_JAK1,Y_across_JAK1,JAK_mean_winter2_masked_30p,R_stack,5));
table3_5window_mean(3,3)=nanmean(profile_ext_mean(X_across_JAK2,Y_across_JAK2,JAK_mean_winter2_masked_30p,R_stack,5));
table3_5window_mean(4,3)=nanmean(profile_ext_mean(X_across_JAK3,Y_across_JAK3,JAK_mean_winter2_masked_30p,R_stack,5));


table3_5window_mean(1,4)=min(mean_velocity_JAK_profile(:));
table3_5window_mean(2,4)=min(prof_across_JAK1(:));
table3_5window_mean(3,4)=min(prof_across_JAK2(:));
table3_5window_mean(4,4)=min(prof_across_JAK3(:));

table3_5window_mean(1,5)=min(mean_velocity_JAK_profile_summer2(:));
table3_5window_mean(2,5)=min(profile_ext_mean(X_across_JAK1,Y_across_JAK1,JAK_mean_summer2_masked_30p,R_stack,5));
table3_5window_mean(3,5)=min(profile_ext_mean(X_across_JAK2,Y_across_JAK2,JAK_mean_summer2_masked_30p,R_stack,5));
table3_5window_mean(4,5)=min(profile_ext_mean(X_across_JAK3,Y_across_JAK3,JAK_mean_summer2_masked_30p,R_stack,5));

table3_5window_mean(1,6)=min(mean_velocity_JAK_profile_winter2(:));
table3_5window_mean(2,6)=min(profile_ext_mean(X_across_JAK1,Y_across_JAK1,JAK_mean_winter2_masked_30p,R_stack,5));
table3_5window_mean(3,6)=min(profile_ext_mean(X_across_JAK2,Y_across_JAK2,JAK_mean_winter2_masked_30p,R_stack,5));
table3_5window_mean(4,6)=min(profile_ext_mean(X_across_JAK3,Y_across_JAK3,JAK_mean_winter2_masked_30p,R_stack,5));


table3_5window_mean(1,7)=max(mean_velocity_JAK_profile(:));
table3_5window_mean(2,7)=max(prof_across_JAK1(:));
table3_5window_mean(3,7)=max(prof_across_JAK2(:));
table3_5window_mean(4,7)=max(prof_across_JAK3(:));

table3_5window_mean(1,8)=max(mean_velocity_JAK_profile_summer2(:));
table3_5window_mean(2,8)=max(profile_ext_mean(X_across_JAK1,Y_across_JAK1,JAK_mean_summer2_masked_30p,R_stack,5));
table3_5window_mean(3,8)=max(profile_ext_mean(X_across_JAK2,Y_across_JAK2,JAK_mean_summer2_masked_30p,R_stack,5));
table3_5window_mean(4,8)=max(profile_ext_mean(X_across_JAK3,Y_across_JAK3,JAK_mean_summer2_masked_30p,R_stack,5));

table3_5window_mean(1,9)=max(mean_velocity_JAK_profile_winter2(:));
table3_5window_mean(2,9)=max(profile_ext_mean(X_across_JAK1,Y_across_JAK1,JAK_mean_winter2_masked_30p,R_stack,5));
table3_5window_mean(3,9)=max(profile_ext_mean(X_across_JAK2,Y_across_JAK2,JAK_mean_winter2_masked_30p,R_stack,5));
table3_5window_mean(4,9)=max(profile_ext_mean(X_across_JAK3,Y_across_JAK3,JAK_mean_winter2_masked_30p,R_stack,5));

table3_5window_mean(1,10)=max(1-(mean_velocity_JAK_profile_winter2./mean_velocity_JAK_profile_summer2));%max percentage
table3_5window_mean(2,10)=find(percentage_JAK_profile>(table3_5window_mean(1,10)-0.0001));% location of Max percentage
% table3_5window_mean(3,10)=max(profile_ext_mean(X_across_JAK2,Y_across_JAK2,JAK_mean_winter2,R_stack,5));
% table3_5window_mean(4,10)=max(profile_ext_mean(X_across_JAK3,Y_across_JAK3,JAK_mean_winter2,R_stack,5));
table3_5window_mean(1:4,1:9)=table3_5window_mean(1:4,1:9)/1000;


% PG

mean_velocity_PG_profile=profile_ext_mean(X_p_curve_PG,Y_p_curve_PG,mean_velocity_stack_PG,Rstack_PG,5);

table3_5window_mean(5,1)=nanmean(mean_velocity_PG_profile(504:end)/1000);
table3_5window_mean(6,1)=nanmean(prof_across_PG1_5window_mean(:)/1000);
table3_5window_mean(7,1)=nanmean(prof_across_PG6_5window_mean(:)/1000);
table3_5window_mean(8,1)=nanmean(prof_across_PG5_5window_mean(:)/1000);

mean_velocity_PG_profile_summer2=profile_ext_mean(X_p_curve_PG,Y_p_curve_PG,PG_mean_summer2_masked_30p/1000,Rstack_PG,5);
table3_5window_mean(5,2)=nanmean(mean_velocity_PG_profile_summer2(504:end));

table3_5window_mean(6,2)=nanmean(profile_ext_mean(X_across_PG1,Y_across_PG1,PG_mean_summer2_masked_30p/1000,Rstack_PG,5));
table3_5window_mean(7,2)=nanmean(profile_ext_mean(X_across_PG6,Y_across_PG6,PG_mean_summer2_masked_30p/1000,Rstack_PG,5));
table3_5window_mean(8,2)=nanmean(profile_ext_mean(X_across_PG5,Y_across_PG5,PG_mean_summer2_masked_30p/1000,Rstack_PG,5));

mean_velocity_PG_profile_winter2=profile_ext_mean(X_p_curve_PG,Y_p_curve_PG,PG_mean_winter2_masked_30p/1000,Rstack_PG,5);
table3_5window_mean(5,3)=nanmean(mean_velocity_PG_profile_winter2(504:end));

table3_5window_mean(6,3)=nanmean(profile_ext_mean(X_across_PG1,Y_across_PG1,PG_mean_winter2_masked_30p/1000,Rstack_PG,5));
table3_5window_mean(7,3)=nanmean(profile_ext_mean(X_across_PG6,Y_across_PG6,PG_mean_winter2_masked_30p/1000,Rstack_PG,5));
table3_5window_mean(8,3)=nanmean(profile_ext_mean(X_across_PG5,Y_across_PG5,PG_mean_winter2_masked_30p/1000,Rstack_PG,5));


table3_5window_mean(5,4)=min(mean_velocity_PG_profile(504:end)/1000);
table3_5window_mean(6,4)=min(prof_across_PG1_5window_mean(:)/1000);
table3_5window_mean(7,4)=min(prof_across_PG6_5window_mean(:)/1000);
table3_5window_mean(8,4)=min(prof_across_PG5_5window_mean(:)/1000);

table3_5window_mean(5,5)=min(mean_velocity_PG_profile_summer2(504:end));
table3_5window_mean(6,5)=min(profile_ext_mean(X_across_PG1,Y_across_PG1,PG_mean_summer2_masked_30p/1000,Rstack_PG,5));
table3_5window_mean(7,5)=min(profile_ext_mean(X_across_PG6,Y_across_PG6,PG_mean_summer2_masked_30p/1000,Rstack_PG,5));
table3_5window_mean(8,5)=min(profile_ext_mean(X_across_PG5,Y_across_PG5,PG_mean_summer2_masked_30p/1000,Rstack_PG,5));

table3_5window_mean(5,6)=min(mean_velocity_PG_profile_winter2(504:end));
table3_5window_mean(6,6)=min(profile_ext_mean(X_across_PG1,Y_across_PG1,PG_mean_winter2_masked_30p/1000,Rstack_PG,5));
table3_5window_mean(7,6)=min(profile_ext_mean(X_across_PG6,Y_across_PG6,PG_mean_winter2_masked_30p/1000,Rstack_PG,5));
table3_5window_mean(8,6)=min(profile_ext_mean(X_across_PG5,Y_across_PG5,PG_mean_winter2_masked_30p/1000,Rstack_PG,5));

table3_5window_mean(5,7)=max(mean_velocity_PG_profile(504:end)/1000);
table3_5window_mean(6,7)=max(prof_across_PG1_5window_mean(:)/1000);
table3_5window_mean(7,7)=max(prof_across_PG6_5window_mean(:)/1000);
table3_5window_mean(8,7)=max(prof_across_PG5_5window_mean(:)/1000);

table3_5window_mean(5,8)=max(mean_velocity_PG_profile_summer2(504:end));
table3_5window_mean(6,8)=max(profile_ext_mean(X_across_PG1,Y_across_PG1,PG_mean_summer2_masked_30p/1000,Rstack_PG,5));
table3_5window_mean(7,8)=max(profile_ext_mean(X_across_PG6,Y_across_PG6,PG_mean_summer2_masked_30p/1000,Rstack_PG,5));
table3_5window_mean(8,8)=max(profile_ext_mean(X_across_PG5,Y_across_PG5,PG_mean_summer2_masked_30p/1000,Rstack_PG,5));

table3_5window_mean(5,9)=max(mean_velocity_PG_profile_winter2(504:end));
table3_5window_mean(6,9)=max(profile_ext_mean(X_across_PG1,Y_across_PG1,PG_mean_winter2_masked_30p/1000,Rstack_PG,5));
table3_5window_mean(7,9)=max(profile_ext_mean(X_across_PG6,Y_across_PG6,PG_mean_winter2_masked_30p/1000,Rstack_PG,5));
table3_5window_mean(8,9)=max(profile_ext_mean(X_across_PG5,Y_across_PG5,PG_mean_winter2_masked_30p/1000,Rstack_PG,5));


%FJ
mean_velocity_FJ_profile=profile_ext_mean(X_p_curve_FJ,Y_p_curve_FJ,mean_velocity_stack_FJ,Rstack_FJ,5);

table3_5window_mean(9,1)=nanmean(mean_velocity_FJ_profile/1000);
table3_5window_mean(10,1)=nanmean(prof_across_FJ1_5window_mean(:)/1000);
table3_5window_mean(11,1)=nanmean(prof_across_FJ2_5window_mean(:)/1000);
table3_5window_mean(12,1)=nanmean(prof_across_FJ3_5window_mean(:)/1000);

table3_5window_mean(9,2)=nanmean(profile_ext_mean(X_p_curve_FJ,Y_p_curve_FJ,FJ_mean_summer2_masked_30p/1000,Rstack_FJ,5));
table3_5window_mean(10,2)=nanmean(profile_ext_mean(X_across_FJ1,Y_across_FJ1,FJ_mean_summer2_masked_30p/1000,Rstack_FJ,5));
table3_5window_mean(11,2)=nanmean(profile_ext_mean(X_across_FJ2,Y_across_FJ2,FJ_mean_summer2_masked_30p/1000,Rstack_FJ,5));
table3_5window_mean(12,2)=nanmean(profile_ext_mean(X_across_FJ3,Y_across_FJ3,FJ_mean_summer2_masked_30p/1000,Rstack_FJ,5));

table3_5window_mean(9,3)=nanmean(profile_ext_mean(X_p_curve_FJ,Y_p_curve_FJ,FJ_mean_winter2_masked_30p/1000,Rstack_FJ,5));
table3_5window_mean(10,3)=nanmean(profile_ext_mean(X_across_FJ1,Y_across_FJ1,FJ_mean_winter2_masked_30p/1000,Rstack_FJ,5));
table3_5window_mean(11,3)=nanmean(profile_ext_mean(X_across_FJ2,Y_across_FJ2,FJ_mean_winter2_masked_30p/1000,Rstack_FJ,5));
table3_5window_mean(12,3)=nanmean(profile_ext_mean(X_across_FJ3,Y_across_FJ3,FJ_mean_winter2_masked_30p/1000,Rstack_FJ,5));

table3_5window_mean(9,4)=min(mean_velocity_FJ_profile/1000);
table3_5window_mean(10,4)=min(prof_across_FJ1_5window_mean(:)/1000);
table3_5window_mean(11,4)=min(prof_across_FJ2_5window_mean(:)/1000);
table3_5window_mean(12,4)=min(prof_across_FJ3_5window_mean(:)/1000);

table3_5window_mean(9,5)=min(profile_ext_mean(X_p_curve_FJ,Y_p_curve_FJ,FJ_mean_summer2_masked_30p/1000,Rstack_FJ,5));
table3_5window_mean(10,5)=min(profile_ext_mean(X_across_FJ1,Y_across_FJ1,FJ_mean_summer2_masked_30p/1000,Rstack_FJ,5));
table3_5window_mean(11,5)=min(profile_ext_mean(X_across_FJ2,Y_across_FJ2,FJ_mean_summer2_masked_30p/1000,Rstack_FJ,5));
table3_5window_mean(12,5)=min(profile_ext_mean(X_across_FJ3,Y_across_FJ3,FJ_mean_summer2_masked_30p/1000,Rstack_FJ,5));

table3_5window_mean(9,6)=min(profile_ext_mean(X_p_curve_FJ,Y_p_curve_FJ,FJ_mean_winter2_masked_30p/1000,Rstack_FJ,5));
table3_5window_mean(10,6)=min(profile_ext_mean(X_across_FJ1,Y_across_FJ1,FJ_mean_winter2_masked_30p/1000,Rstack_FJ,5));
table3_5window_mean(11,6)=min(profile_ext_mean(X_across_FJ2,Y_across_FJ2,FJ_mean_winter2_masked_30p/1000,Rstack_FJ,5));
table3_5window_mean(12,6)=min(profile_ext_mean(X_across_FJ3,Y_across_FJ3,FJ_mean_winter2_masked_30p/1000,Rstack_FJ,5));

table3_5window_mean(9,7)=max(mean_velocity_FJ_profile/1000);
table3_5window_mean(10,7)=max(prof_across_FJ1_5window_mean(:)/1000);
table3_5window_mean(11,7)=max(prof_across_FJ2_5window_mean(:)/1000);
table3_5window_mean(12,7)=max(prof_across_FJ3_5window_mean(:)/1000);

table3_5window_mean(9,8)=max(profile_ext_mean(X_p_curve_FJ,Y_p_curve_FJ,FJ_mean_summer2_masked_30p/1000,Rstack_FJ,5));
table3_5window_mean(10,8)=max(profile_ext_mean(X_across_FJ1,Y_across_FJ1,FJ_mean_summer2_masked_30p/1000,Rstack_FJ,5));
table3_5window_mean(11,8)=max(profile_ext_mean(X_across_FJ2,Y_across_FJ2,FJ_mean_summer2_masked_30p/1000,Rstack_FJ,5));
table3_5window_mean(12,8)=max(profile_ext_mean(X_across_FJ3,Y_across_FJ3,FJ_mean_summer2_masked_30p/1000,Rstack_FJ,5));

table3_5window_mean(9,9)=max(profile_ext_mean(X_p_curve_FJ,Y_p_curve_FJ,FJ_mean_winter2_masked_30p/1000,Rstack_FJ,5));
table3_5window_mean(10,9)=max(profile_ext_mean(X_across_FJ1,Y_across_FJ1,FJ_mean_winter2_masked_30p/1000,Rstack_FJ,5));
table3_5window_mean(11,9)=max(profile_ext_mean(X_across_FJ2,Y_across_FJ2,FJ_mean_winter2_masked_30p/1000,Rstack_FJ,5));
table3_5window_mean(12,9)=max(profile_ext_mean(X_across_FJ3,Y_across_FJ3,FJ_mean_winter2_masked_30p/1000,Rstack_FJ,5));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% Masking with the classification raster

%%%%%% Loading the class Masks

[JAK_class_Mask,R_JAK_class_Mask]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/QGIS/JAK_class_Mask_proj_clip.tif');
JAK_class_Mask(JAK_class_Mask>250)=nan;
%imagesc(JAK_class_Mask);

[PG_class_Mask,R_PG_class_Mask]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/Qgis/PG_Class_Mask_proj_clip.tif');
PG_class_Mask(PG_class_Mask>250)=nan;
%imagesc(PG_class_Mask);

[FJ_class_Mask,R_FJ_class_Mask]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/Qgis/FJ_Class_Mask_proj_clip.tif');
FJ_class_Mask(FJ_class_Mask>250)=nan;
%imagesc(FJ_class_Mask);

%%%%%% Loading the NSIDC dataset 


[JAK_NSIDC_100,R_JAK_NSIDC_100]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/QGIS/JAK_NSIDC_100.tif');
JAK_NSIDC_100(JAK_NSIDC_100<0)=nan;
% imagesc(JAK_NSIDC_100)

[PG_NSIDC_100,R_PG_NSIDC_100]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/Qgis/PG_NSIDC_100.tif');
PG_NSIDC_100(PG_NSIDC_100<0)=nan;
% imagesc(PG_NSIDC_100)

[FJ_NSIDC_100,R_FJ_NSIDC_100]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/Qgis/FJ_NSIDC_100.tif');
FJ_NSIDC_100(FJ_NSIDC_100<0)=nan;
% imagesc(FJ_NSIDC_100)

% Masking the mean maps appart of the Bed Rock areas:

% Rock areas values:
% JAK = 1
% PG = 1
% FJ = 1

%%%%% S1 data
mean_JAK_rock_Areas=mean_velocity_stack_JAK;
mean_JAK_rock_Areas(JAK_class_Mask~=1)=nan;

mean_JAK_summer_rock_Areas=JAK_mean_summer2;
mean_JAK_summer_rock_Areas(JAK_class_Mask~=1)=nan;
mean_JAK_winter_rock_Areas=JAK_mean_winter2;
mean_JAK_winter_rock_Areas(JAK_class_Mask~=1)=nan;

mean_PG_rock_Areas=mean_velocity_stack_PG;
mean_PG_rock_Areas(PG_class_Mask~=1)=nan;

mean_PG_summer_rock_Areas=PG_mean_summer2;
mean_PG_summer_rock_Areas(PG_class_Mask~=1)=nan;
mean_PG_winter_rock_Areas=PG_mean_winter2;
mean_PG_winter_rock_Areas(PG_class_Mask~=1)=nan;

mean_FJ_rock_Areas=mean_velocity_stack_FJ;
mean_FJ_rock_Areas(FJ_class_Mask~=1)=nan;

mean_FJ_summer_rock_Areas=FJ_mean_summer2;
mean_FJ_summer_rock_Areas(FJ_class_Mask~=1)=nan;
mean_FJ_winter_rock_Areas=FJ_mean_winter2;
mean_FJ_winter_rock_Areas(FJ_class_Mask~=1)=nan;

%%%%% NSIDC data
JAK_rock_Areas_NSIDC=JAK_NSIDC_100;
JAK_rock_Areas_NSIDC(JAK_class_Mask~=1)=nan;

PG_rock_Areas_NSIDC=PG_NSIDC_100;
PG_rock_Areas_NSIDC(PG_class_Mask~=1)=nan;

FJ_rock_Areas_NSIDC=FJ_NSIDC_100;
FJ_rock_Areas_NSIDC(FJ_class_Mask~=1)=nan;


S1_minus_Joughin_JAK_slow_area=mean_JAK_rock_Areas-JAK_rock_Areas_NSIDC;
S1_minus_Joughin_PG_slow_area=mean_PG_rock_Areas-PG_rock_Areas_NSIDC;
S1_minus_Joughin_FJ_slow_area=mean_FJ_rock_Areas-FJ_rock_Areas_NSIDC;


Table_S1_NSIDC_Compar(1,1)=nanmean(mean_JAK_rock_Areas(:));
Table_S1_NSIDC_Compar(1,2)=nanmedian(mean_JAK_rock_Areas(:));
Table_S1_NSIDC_Compar(1,3)=nanmean(JAK_rock_Areas_NSIDC(:));
Table_S1_NSIDC_Compar(1,4)=nanmedian(JAK_rock_Areas_NSIDC(:));

Table_S1_NSIDC_Compar(1,5)=nanmean(S1_minus_Joughin_JAK_slow_area(:));
Table_S1_NSIDC_Compar(1,6)=nanmedian(S1_minus_Joughin_JAK_slow_area(:));
Table_S1_NSIDC_Compar(1,7)=rms(S1_minus_Joughin_JAK_slow_area(~isnan(S1_minus_Joughin_JAK_slow_area)));

Table_S1_NSIDC_Compar(1,8)=rms(mean_JAK_summer_rock_Areas(~isnan(mean_JAK_summer_rock_Areas)));

Table_S1_NSIDC_Compar(1,9)=nanmean(mean_JAK_summer_rock_Areas(:));
Table_S1_NSIDC_Compar(1,10)=nanmedian(mean_JAK_summer_rock_Areas(:));
Table_S1_NSIDC_Compar(1,11)=nanstd(mean_JAK_summer_rock_Areas(:));
Table_S1_NSIDC_Compar(1,12)=rms(mean_JAK_rock_Areas(~isnan(mean_JAK_rock_Areas)));

Table_S1_NSIDC_Compar(1,13)=nanmean(mean_JAK_winter_rock_Areas(:));
Table_S1_NSIDC_Compar(1,14)=nanmedian(mean_JAK_winter_rock_Areas(:));
Table_S1_NSIDC_Compar(1,15)=nanstd(mean_JAK_winter_rock_Areas(:));
Table_S1_NSIDC_Compar(1,16)=rms(mean_JAK_winter_rock_Areas(~isnan(mean_JAK_winter_rock_Areas)));
Table_S1_NSIDC_Compar(1,17)=nanstd(mean_JAK_rock_Areas(:));

Table_S1_NSIDC_Compar(2,1)=nanmean(mean_PG_rock_Areas(:));
Table_S1_NSIDC_Compar(2,2)=nanmedian(mean_PG_rock_Areas(:));
Table_S1_NSIDC_Compar(2,3)=nanmean(PG_rock_Areas_NSIDC(:));
Table_S1_NSIDC_Compar(2,4)=nanmedian(PG_rock_Areas_NSIDC(:));

Table_S1_NSIDC_Compar(2,5)=nanmean(S1_minus_Joughin_PG_slow_area(:));
Table_S1_NSIDC_Compar(2,6)=nanmedian(S1_minus_Joughin_PG_slow_area(:));
Table_S1_NSIDC_Compar(2,7)=rms(S1_minus_Joughin_PG_slow_area(~isnan(S1_minus_Joughin_PG_slow_area)));

Table_S1_NSIDC_Compar(2,8)=rms(mean_PG_summer_rock_Areas(~isnan(mean_PG_summer_rock_Areas)));

Table_S1_NSIDC_Compar(2,9)=nanmean(mean_PG_summer_rock_Areas(:));
Table_S1_NSIDC_Compar(2,10)=nanmedian(mean_PG_summer_rock_Areas(:));
Table_S1_NSIDC_Compar(2,11)=nanstd(mean_PG_summer_rock_Areas(:));
Table_S1_NSIDC_Compar(2,12)=rms(mean_PG_rock_Areas(~isnan(mean_PG_rock_Areas)));

Table_S1_NSIDC_Compar(2,13)=nanmean(mean_PG_winter_rock_Areas(:));
Table_S1_NSIDC_Compar(2,14)=nanmedian(mean_PG_winter_rock_Areas(:));
Table_S1_NSIDC_Compar(2,15)=nanstd(mean_PG_winter_rock_Areas(:));
Table_S1_NSIDC_Compar(2,16)=rms(mean_PG_winter_rock_Areas(~isnan(mean_PG_winter_rock_Areas)));
Table_S1_NSIDC_Compar(2,17)=nanstd(mean_PG_rock_Areas(:));


Table_S1_NSIDC_Compar(3,1)=nanmean(mean_FJ_rock_Areas(:));
Table_S1_NSIDC_Compar(3,2)=nanmedian(mean_FJ_rock_Areas(:));
Table_S1_NSIDC_Compar(3,3)=nanmean(FJ_rock_Areas_NSIDC(:));
Table_S1_NSIDC_Compar(3,4)=nanmedian(FJ_rock_Areas_NSIDC(:));

Table_S1_NSIDC_Compar(3,5)=nanmean(S1_minus_Joughin_FJ_slow_area(:));
Table_S1_NSIDC_Compar(3,6)=nanmedian(S1_minus_Joughin_FJ_slow_area(:));
Table_S1_NSIDC_Compar(3,7)=rms(S1_minus_Joughin_FJ_slow_area(~isnan(S1_minus_Joughin_FJ_slow_area)));

Table_S1_NSIDC_Compar(3,8)=rms(mean_FJ_summer_rock_Areas(~isnan(mean_FJ_summer_rock_Areas)));

Table_S1_NSIDC_Compar(3,9)=nanmean(mean_FJ_summer_rock_Areas(:));
Table_S1_NSIDC_Compar(3,10)=nanmedian(mean_FJ_summer_rock_Areas(:));
Table_S1_NSIDC_Compar(3,11)=nanstd(mean_FJ_summer_rock_Areas(:));
Table_S1_NSIDC_Compar(3,12)=rms(mean_FJ_rock_Areas(~isnan(mean_FJ_rock_Areas)));

Table_S1_NSIDC_Compar(3,13)=nanmean(mean_FJ_winter_rock_Areas(:));
Table_S1_NSIDC_Compar(3,14)=nanmedian(mean_FJ_winter_rock_Areas(:));
Table_S1_NSIDC_Compar(3,15)=nanstd(mean_FJ_winter_rock_Areas(:));
Table_S1_NSIDC_Compar(3,16)=rms(mean_FJ_winter_rock_Areas(~isnan(mean_FJ_winter_rock_Areas)));
Table_S1_NSIDC_Compar(3,17)=nanstd(mean_FJ_rock_Areas(:));


%% PG
%%%%%%%%%%%% PG %%%%%%%%%%%%%%%%%%
% Load the stack data

cd /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/stack/

[stack_PG,Rstack_PG]=geotiffread('Vel_Stack_PG_Portal_updated.tif');


%Profile Curve PG 1

prof_curve_read_PG = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/Qgis/PG_prof_curve_pt.shp');
X_p_curve_PG=extractfield(prof_curve_read_PG,'X');
Y_p_curve_PG=extractfield(prof_curve_read_PG,'Y');

X_p_curve_PG=X_p_curve_PG(~isnan(X_p_curve_PG));
Y_p_curve_PG=Y_p_curve_PG(~isnan(Y_p_curve_PG));



%Profile Across PG 1

prof_across_PG1 = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/Qgis/PG1_cross_pt.shp');
X_across_PG1=extractfield(prof_across_PG1,'X');
Y_across_PG1=extractfield(prof_across_PG1,'Y');

X_across_PG1=X_across_PG1(~isnan(X_across_PG1));
Y_across_PG1=Y_across_PG1(~isnan(Y_across_PG1));

%Profile Across PG 2

prof_across_PG2 = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/Qgis/PG2_cross_pt.shp');
X_across_PG2=extractfield(prof_across_PG2,'X');
Y_across_PG2=extractfield(prof_across_PG2,'Y');

X_across_PG2=X_across_PG2(~isnan(X_across_PG2));
Y_across_PG2=Y_across_PG2(~isnan(Y_across_PG2));

%Profile Across PG 3

prof_across_PG3 = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/Qgis/PG3_cross_pt.shp');
X_across_PG3=extractfield(prof_across_PG3,'X');
Y_across_PG3=extractfield(prof_across_PG3,'Y');

X_across_PG3=X_across_PG3(~isnan(X_across_PG3));
Y_across_PG3=Y_across_PG3(~isnan(Y_across_PG3));

%Profile Across PG 4

prof_across_PG4 = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/Qgis/PG4_cross_pt.shp');
X_across_PG4=extractfield(prof_across_PG4,'X');
Y_across_PG4=extractfield(prof_across_PG4,'Y');

X_across_PG4=X_across_PG4(~isnan(X_across_PG4));
Y_across_PG4=Y_across_PG4(~isnan(Y_across_PG4));

%Profile Across PG 5

prof_across_PG5 = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/Qgis/PG5_cross_pt.shp');
X_across_PG5=extractfield(prof_across_PG5,'X');
Y_across_PG5=extractfield(prof_across_PG5,'Y');

X_across_PG5=X_across_PG5(~isnan(X_across_PG5));
Y_across_PG5=Y_across_PG5(~isnan(Y_across_PG5));

%Profile Across PG 6

prof_across_PG6 = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/Qgis/PG6_bh_GL_segmentada.shp');
X_across_PG6=extractfield(prof_across_PG6,'X');
Y_across_PG6=extractfield(prof_across_PG6,'Y');

X_across_PG6=X_across_PG6(~isnan(X_across_PG6));
Y_across_PG6=Y_across_PG6(~isnan(Y_across_PG6));


%Profile Tributary PG

prof_across_PG_tribut = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/Qgis/PG_tribut_pt.shp');
X_across_PG_tribut=extractfield(prof_across_PG_tribut,'X');
Y_across_PG_tribut=extractfield(prof_across_PG_tribut,'Y');

X_across_PG_tribut=X_across_PG_tribut(~isnan(X_across_PG_tribut));
Y_across_PG_tribut=Y_across_PG_tribut(~isnan(Y_across_PG_tribut));


% Introducing the nan's
stack_PG(stack_PG<=0)=nan;

% Extract the profiles

prof_curve_PG=nan(1997,size(stack_PG,3));

prof_across_PG1=nan(999,size(stack_PG,3));
prof_across_PG2=nan(999,size(stack_PG,3));
prof_across_PG3=nan(999,size(stack_PG,3));
prof_across_PG4=nan(999,size(stack_PG,3));
prof_across_PG5=nan(999,size(stack_PG,3));
prof_across_PG_tribut=nan(999,size(stack_PG,3));
prof_across_PG6=nan(1026,size(stack_PG,3));

for i=1:size(stack_PG,3) 
prof_across_PG1(:,i)=profile_ext_mean(X_across_PG1,Y_across_PG1,stack_PG(:,:,i),Rstack_PG,5);
prof_across_PG2(:,i)=profile_ext_mean(X_across_PG2,Y_across_PG2,stack_PG(:,:,i),Rstack_PG,5);
prof_across_PG3(:,i)=profile_ext_mean(X_across_PG3,Y_across_PG3,stack_PG(:,:,i),Rstack_PG,5);
prof_across_PG4(:,i)=profile_ext_mean(X_across_PG4,Y_across_PG4,stack_PG(:,:,i),Rstack_PG,5);
prof_across_PG5(:,i)=profile_ext_mean(X_across_PG5,Y_across_PG5,stack_PG(:,:,i),Rstack_PG,5);
prof_across_PG6(:,i)=profile_ext_mean(X_across_PG6,Y_across_PG6,stack_PG(:,:,i),Rstack_PG,5);
prof_across_PG_tribut(:,i)=profile_ext_mean(X_across_PG_tribut,Y_across_PG_tribut,stack_PG(:,:,i),Rstack_PG,5);

prof_curve_PG(:,i)=profile_ext_mean(X_p_curve_PG,Y_p_curve_PG,stack_PG(:,:,i),Rstack_PG,5);

end

% Plotting the profiles

%%% Dist relative to the prof_curve_PG

dist_PG=0:((0.1916*999)/(length(prof_curve_PG)-1)):(0.1916*999);

% Plot across profiles:
% PG4 and PG5 represent PG2 and PG3 in the map(fig1-paper)

dist_across_PG1=0:((24.82957)/(length(prof_across_PG1)-1)):(24.82957);
% dist_across_PG4=0:((24.8110)/(length(prof_across_PG4)-1)):(24.8110);
dist_across_PG5=0:((47.13382)/(length(prof_across_PG5)-1)):(47.13382);
dist_across_PG6=0:((25.9945)/(length(prof_across_PG6)-1)):(25.9945);

% setting the cross distances with the main profile as reference:
dist_across_PG1_=(-0.0249*506):((0.0249*999)/(length(prof_across_PG1)-1)):(0.0249*(999-506));
%dist_across_PG4_=-0.0248*423:((0.0248*999)/(length(prof_across_PG4)-1)):(0.0248*(999-423));
dist_across_PG5_=-0.0472*469:((0.0472*999)/(length(prof_across_PG5)-1)):(0.0472*(999-469));
dist_across_PG6_=-0.0260*444:((0.0260*1026)/(length(prof_across_PG6)-1)):(0.0260*(1026-444));

%%%%%%%%%  plot profile across (IM_Figures.m)

%%% Estimate STD for the stack data

std_velocity_stack_PG=std(stack_PG,1,3);
std_velocity_stack_PG(std_velocity_stack_PG<=0)=nan;

std_velocity_PG_profile=nanstd(prof_curve_PG,1,2);

%%% Mean and Median velocity

median_velocity_stack_PG=nanmedian(stack_PG,3);
mean_velocity_stack_PG=nanmean(stack_PG,3);

median_velocity_stack_PG(median_velocity_stack_PG<=0)=nan;
mean_velocity_stack_PG(mean_velocity_stack_PG<=0)=nan;

mean_velocity_stack_PG_log=log10(mean_velocity_stack_PG);

median_velocity_PG_profile=profile_ext_mean(X_p_curve_PG,Y_p_curve_PG,median_velocity_stack_PG,Rstack_PG,5);
mean_velocity_PG_profile=profile_ext_mean(X_p_curve_PG,Y_p_curve_PG,mean_velocity_stack_PG,Rstack_PG,5);


info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/stack/Vel_Stack_PG_Portal_updated.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/stack/mean_velocity_stack_PG.tif', mean_velocity_stack_PG, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/stack/mean_velocity_stack_PG_log.tif', mean_velocity_stack_PG_log, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

%%%%%%%%%%%%%%%%%  Density of data  %%%%%%%%%%%%%%%%%

Vel_Stack_PG=stack_PG;
for i=1:size(Vel_Stack_PG, 3)
Density_Measu_PG(:,:,i)=~isnan(Vel_Stack_PG(:,:,i));
end

Density_Measu_PG=double(Density_Measu_PG);
Density_Measu_PG_sum=nansum(Density_Measu_PG,3);

% Createing a mask based on the measurements

% Mask containing at least 30% of data

Density_Measu_PG_30=Density_Measu_PG_sum;
Density_Measu_PG_30(Density_Measu_PG_30<14)=nan;
%imagesc(Density_Measu_PG_30)
Mask_Density_Measu_PG_30=Density_Measu_PG_30;
Mask_Density_Measu_PG_30(Mask_Density_Measu_PG_30>=14)=1;

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/stack/Vel_Stack_PG_Portal_updated.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/stack/Density_Measu_PG_30.tif',Density_Measu_PG_30, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

% Mask containing at least 25% of data

Density_Measu_PG_25=Density_Measu_PG_sum;
Density_Measu_PG_25(Density_Measu_PG_25<12)=nan;
%imagesc(Density_Measu_PG_25)
Mask_Density_Measu_PG_25=Density_Measu_PG_25;
Mask_Density_Measu_PG_25(Mask_Density_Measu_PG_25>=12)=1;

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/stack/Vel_Stack_PG_Portal_updated.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/stack/Density_Measu_PG_25.tif',Density_Measu_PG_25, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pathsate_opt_PG=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/'];
d_opt_PG=dir(pathsate_opt_PG);
j=1;
for i=4:length(d_opt_PG)-1;
    name=d_opt_PG(i,1).name;
    data_str_PG(j,:)=['20' name(1:6) '-' '20' name(8:13)];
    data_PG{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt_PG(j,1)=cellstr(data_PG{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt_PG i j name

data_str_PG_num(:)=datenum(data_str_PG(:,1:8),'yyyymmdd');


PG_summer_find=find((data_str_PG_num>=datenum('15062015','ddmmyyyy') & data_str_PG_num<=datenum('15082015','ddmmyyyy')) | ((data_str_PG_num>=datenum('15062016','ddmmyyyy') & data_str_PG_num<=datenum('15082016','ddmmyyyy'))));
PG_winter_find=find((data_str_PG_num>=datenum('01122014','ddmmyyyy') & data_str_PG_num<=datenum('28022015','ddmmyyyy')) | ((data_str_PG_num>=datenum('01122015','ddmmyyyy') & data_str_PG_num<=datenum('28022016','ddmmyyyy'))) | ((data_str_PG_num>=datenum('01122016','ddmmyyyy') & data_str_PG_num<=datenum('28022017','ddmmyyyy'))));

PG_summer2= stack_PG(:,:,PG_summer_find);
PG_winter2= stack_PG(:,:,PG_winter_find);

PG_summer2(PG_summer2<=0)=nan;
PG_winter2(PG_winter2<=0)=nan;

PG_mean_summer2=nanmean(PG_summer2,3);
PG_mean_winter2=nanmean(PG_winter2,3);


PG_mean_summer2(PG_mean_summer2<=0)=nan;
PG_mean_winter2(PG_mean_winter2<=0)=nan;

PG_mean_summer2_log=log10(PG_mean_summer2);
PG_mean_winter2_log=log10(PG_mean_winter2);


% masking based on the density of data  #### 30% #####

PG_mean_summer2_masked_30p=PG_mean_summer2;
PG_mean_summer2_masked_30p(Mask_Density_Measu_PG_30~=1)=nan;

PG_mean_winter2_masked_30p=PG_mean_winter2;
PG_mean_winter2_masked_30p(Mask_Density_Measu_PG_30~=1)=nan;

% just getting the values are not nan's values
PG_mean_winter2_masked_30p(isnan(PG_mean_summer2_masked_30p))=nan;
PG_mean_summer2_masked_30p(isnan(PG_mean_winter2_masked_30p))=nan;


% Calculate Summer-Winter and Winter/Summer

PG_summer_mean_divided_winter=(1-(PG_mean_winter2_masked_30p./PG_mean_summer2_masked_30p))*100;
PG_summer_mean_minus_winter=PG_mean_summer2_masked_30p-PG_mean_winter2_masked_30p;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% masking based on the density of data    #### 25% #####

PG_mean_summer2_masked_25p=PG_mean_summer2;
PG_mean_summer2_masked_25p(Mask_Density_Measu_PG_25~=1)=nan;

PG_mean_winter2_masked_25p=PG_mean_winter2;
PG_mean_winter2_masked_25p(Mask_Density_Measu_PG_25~=1)=nan;

% just getting the values are not nan's values
PG_mean_winter2_masked_25p(isnan(PG_mean_summer2_masked_25p))=nan;
PG_mean_summer2_masked_25p(isnan(PG_mean_winter2_masked_25p))=nan;


% Calculate Summer-Winter and Winter/Summer

PG_summer_mean_divided_winter=(1-(PG_mean_winter2_masked_25p./PG_mean_summer2_masked_25p))*100;
PG_summer_mean_minus_winter=PG_mean_summer2_masked_25p-PG_mean_winter2_masked_25p;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Getting just data inside 2 std's :
PG_summer_mean_divided_winter(PG_summer_mean_divided_winter>=(nanmean(PG_summer_mean_divided_winter(:))+(2*nanstd(PG_summer_mean_divided_winter(:)))))=nan;
PG_summer_mean_divided_winter(PG_summer_mean_divided_winter<=(nanmean(PG_summer_mean_divided_winter(:))-(2*nanstd(PG_summer_mean_divided_winter(:)))))=nan;

PG_summer_mean_minus_winter(PG_summer_mean_minus_winter>=(nanmean(PG_summer_mean_minus_winter(:))+(2*nanstd(PG_summer_mean_minus_winter(:)))))=nan;
PG_summer_mean_minus_winter(PG_summer_mean_minus_winter<=(nanmean(PG_summer_mean_minus_winter(:))-(2*nanstd(PG_summer_mean_minus_winter(:)))))=nan;

PG_summer_mean_minus_winter_log=log10(PG_summer_mean_minus_winter);
%PG_summer_minus_winter=PG_mean_summer-PG_mean_winter;

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/stack/Vel_Stack_PG_Portal_updated.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/stack/PG_mean_summer_updated.tif', PG_mean_summer2, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/stack/PG_mean_winter_updated.tif', PG_mean_winter2, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/stack/PG_mean_summer_LOG_updated.tif', PG_mean_summer2_log, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/stack/PG_mean_winter_LOG_updated.tif', PG_mean_winter2_log, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/stack/PG_mean_summer_mean_minus_winter_updated.tif', PG_summer_mean_minus_winter, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/stack/PG_mean_summer_mean_minus_winter_LOG_updated.tif', PG_summer_mean_minus_winter_log, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/stack/PG_summer_mean_divided_winter_updated.tif', PG_summer_mean_divided_winter, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


%%%%%%%%%%%%%%%%%  Pts

%%%%% Calculating a mean in an moving mean, around 5 pixels (**profile_ext_mean** function)

stack_PG(stack_PG<=0)=nan;

% Extract the profiles

prof_curve_PG_5window_mean=nan(1997,24);

prof_across_PG1_5window_mean=nan(999,24);
prof_across_PG2_5window_mean=nan(999,24);
prof_across_PG3_5window_mean=nan(999,24);
prof_across_PG4_5window_mean=nan(999,24);
prof_across_PG5_5window_mean=nan(999,24);
prof_across_PG6_5window_mean=nan(1026,24);
prof_across_PG_tribut_5window_mean=nan(999,24);

for i=1:size(stack_PG,3) 
prof_across_PG1_5window_mean(:,i)=profile_ext_mean(X_across_PG1,Y_across_PG1,stack_PG(:,:,i),Rstack_PG,5);
prof_across_PG2_5window_mean(:,i)=profile_ext_mean(X_across_PG2,Y_across_PG2,stack_PG(:,:,i),Rstack_PG,5);
prof_across_PG3_5window_mean(:,i)=profile_ext_mean(X_across_PG3,Y_across_PG3,stack_PG(:,:,i),Rstack_PG,5);
prof_across_PG4_5window_mean(:,i)=profile_ext_mean(X_across_PG4,Y_across_PG4,stack_PG(:,:,i),Rstack_PG,5);
prof_across_PG5_5window_mean(:,i)=profile_ext_mean(X_across_PG5,Y_across_PG5,stack_PG(:,:,i),Rstack_PG,5);
prof_across_PG6_5window_mean(:,i)=profile_ext_mean(X_across_PG6,Y_across_PG6,stack_PG(:,:,i),Rstack_PG,5);
prof_across_PG_tribut_5window_mean(:,i)=profile_ext_mean(X_across_PG_tribut,Y_across_PG_tribut,stack_PG(:,:,i),Rstack_PG,5);

prof_curve_PG_5window_mean(:,i)=profile_ext_mean(X_p_curve_PG,Y_p_curve_PG,stack_PG(:,:,i),Rstack_PG,5);

end

for i=1:size(stack_PG,3) 
pt_PG1_5window_mean(i)=prof_across_PG1_5window_mean(507,i);
%pt_PG2_5window_mean(i)=prof_across_PG4_5window_mean(424,i);
pt_PG2_5window_mean(i)=prof_across_PG6_5window_mean(444,i);
pt_PG3_5window_mean(i)=prof_across_PG5_5window_mean(470,i);
pt_PG_main(i)=prof_curve_PG(10,i);
end

mdl_pt_PG1_5window_mean = fitlm(data_str_PG_num,pt_PG1_5window_mean/1000);
mdl_pt_PG2_5window_mean = fitlm(data_str_PG_num,pt_PG2_5window_mean/1000);
mdl_pt_PG3_5window_mean = fitlm(data_str_PG_num,pt_PG3_5window_mean/1000);

%%%%%%  Plot Pts (IM_Figures.m)

%%%%%%%% PG Terra_SAR_X points
%pts_TSX_Joughin_PG = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/Qgis/PG_Pts.shp');
pts_TSX_Joughin_PG = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/Qgis/PG_extras_Used.shp');

X_pts_TSX_Joughin_PG=extractfield(pts_TSX_Joughin_PG,'X');
Y_pts_TSX_Joughin_PG=extractfield(pts_TSX_Joughin_PG,'Y');

name_PG_pts=extractfield(pts_TSX_Joughin_PG,'Name');


for j=[1:length(Y_pts_TSX_Joughin_PG)]
for i=1:size(Vel_TSX_PG,3)
pt_TSX_Joughin_PG(i,j)=profile_ext_mean(X_pts_TSX_Joughin_PG(1,j),Y_pts_TSX_Joughin_PG(1,j),Vel_TSX_PG(:,:,i),R_TSX_PG,5);

%pt_JAK_main(i)=prof_curve_JAK(10,i);
end
end

for j=[1:length(Y_pts_TSX_Joughin_PG)]
for i=1:size(Vel_Stack_PG,3) 

    pt_S1_PG(i,j)=profile_ext_mean(X_pts_TSX_Joughin_PG(1,j),Y_pts_TSX_Joughin_PG(1,j),Vel_Stack_PG(:,:,i),Rstack_PG,5);

end
%pt_JAK_main(i)=prof_curve_JAK(10,i);
end

for i=1:length(data_str_PG);

date_pt_S1_PG(i)=datenum(data_str_PG(i,1:8),'yyyymmdd');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PG Summer & Winter

for i=1:size(PG_summer2,3)
PG_summer2_profile(:,i)=profile_ext_mean(X_p_curve_PG,Y_p_curve_PG,PG_summer2(:,:,i),Rstack_PG,5);
end


for i=1:size(PG_winter2,3)
PG_winter2_profile(:,i)=profile_ext_mean(X_p_curve_PG,Y_p_curve_PG,PG_winter2(:,:,i),Rstack_PG,5);
end



%% FJ

%cd /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/

[stack_FJ,Rstack_FJ]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/Vel_Stack_FJ_Portal_updated.tif');


%Profile Curve FJ 

prof_curve_read_FJ = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/Qgis/FJ_prof_curve_pt.shp');
X_p_curve_FJ=extractfield(prof_curve_read_FJ,'X');
Y_p_curve_FJ=extractfield(prof_curve_read_FJ,'Y');

X_p_curve_FJ=X_p_curve_FJ(~isnan(X_p_curve_FJ));
Y_p_curve_FJ=Y_p_curve_FJ(~isnan(Y_p_curve_FJ));



%Profile Across FJ 1

prof_across_FJ1 = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/Qgis/FJ1_cross_pt.shp');
X_across_FJ1=extractfield(prof_across_FJ1,'X');
Y_across_FJ1=extractfield(prof_across_FJ1,'Y');

X_across_FJ1=X_across_FJ1(~isnan(X_across_FJ1));
Y_across_FJ1=Y_across_FJ1(~isnan(Y_across_FJ1));

%Profile Across FJ 2

prof_across_FJ2 = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/Qgis/FJ2_cross_pt.shp');
X_across_FJ2=extractfield(prof_across_FJ2,'X');
Y_across_FJ2=extractfield(prof_across_FJ2,'Y');

X_across_FJ2=X_across_FJ2(~isnan(X_across_FJ2));
Y_across_FJ2=Y_across_FJ2(~isnan(Y_across_FJ2));

%Profile Across FJ 3

prof_across_FJ3 = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/Qgis/FJ3_cross_pt.shp');
X_across_FJ3=extractfield(prof_across_FJ3,'X');
Y_across_FJ3=extractfield(prof_across_FJ3,'Y');

X_across_FJ3=X_across_FJ3(~isnan(X_across_FJ3));
Y_across_FJ3=Y_across_FJ3(~isnan(Y_across_FJ3));


% Including nan's

stack_FJ(stack_FJ<=0)=nan;


% Extract the profiles

prof_curve_FJ=nan(1997,size(stack_FJ,3));

prof_across_FJ1=nan(999,size(stack_FJ,3));
prof_across_FJ2=nan(999,size(stack_FJ,3));
prof_across_FJ3=nan(999,size(stack_FJ,3));

for i=1:size(stack_FJ,3) 
prof_across_FJ1(:,i)=profile_ext_mean(X_across_FJ1,Y_across_FJ1,stack_FJ(:,:,i),Rstack_FJ,5);
prof_across_FJ2(:,i)=profile_ext_mean(X_across_FJ2,Y_across_FJ2,stack_FJ(:,:,i),Rstack_FJ,5);
prof_across_FJ3(:,i)=profile_ext_mean(X_across_FJ3,Y_across_FJ3,stack_FJ(:,:,i),Rstack_FJ,5);

prof_curve_FJ(:,i)=profile_ext_mean(X_p_curve_FJ,Y_p_curve_FJ,stack_FJ(:,:,i),Rstack_FJ,5);

end

dist_FJ=0:((0.1916*999)/(length(prof_curve_FJ)-1)):(0.1916*999);



%%%%%%%%%%%%%%%%%  Across Profiles


dist_across_FJ1_=0.0249*(-594):(0.0249*(999))/(length(prof_across_FJ1)-1):(0.0249*(999-594));
dist_across_FJ2_=(0.0317*(-598)):(0.0317*999)/(length(prof_across_FJ2)-1):(0.0317*(999-598));
dist_across_FJ3_=(0.0247*(-628)):(0.0247*999)/(length(prof_across_FJ3)-1):(0.0247*(999-628));

%%%%%%%%%  plot profile across (IM_Figures.m)

%%% Estimate STD for the stack data

std_velocity_stack_FJ=std(stack_FJ,1,3);
std_velocity_stack_FJ(std_velocity_stack_FJ<=0)=nan;

std_velocity_FJ_profile=nanstd(prof_curve_FJ,1,2);

%%% Mean and Median velocity

median_velocity_stack_FJ=nanmedian(stack_FJ,3);
mean_velocity_stack_FJ=nanmean(stack_FJ,3);

median_velocity_stack_FJ(median_velocity_stack_FJ<=0)=nan;
mean_velocity_stack_FJ(mean_velocity_stack_FJ<=0)=nan;

mean_velocity_stack_FJ_log=log10(mean_velocity_stack_FJ);

median_velocity_FJ_profile=profile_ext_mean(X_p_curve_FJ,Y_p_curve_FJ,median_velocity_stack_FJ,Rstack_FJ,5);
mean_velocity_FJ_profile=profile_ext_mean(X_p_curve_FJ,Y_p_curve_FJ,mean_velocity_stack_FJ,Rstack_FJ,5);

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/Vel_Stack_FJ_Portal_updated.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/mean_velocity_stack_FJ.tif', mean_velocity_stack_FJ, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/mean_velocity_stack_FJ_log.tif', mean_velocity_stack_FJ_log, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

%%%%%%%%%%%%%%%%%  Density of data  %%%%%%%%%%%%%%%%%

Vel_Stack_FJ=stack_FJ;
for i=1:size(Vel_Stack_FJ, 3)
Density_Measu_FJ(:,:,i)=~isnan(Vel_Stack_FJ(:,:,i));
end

Density_Measu_FJ=double(Density_Measu_FJ);
Density_Measu_FJ_sum=nansum(Density_Measu_FJ,3);
% imagesc(Density_Measu_FJ_sum)
% Createing a mask based on the measurements

% Mask containing at least 30% of data

Density_Measu_FJ_30=Density_Measu_FJ_sum;
Density_Measu_FJ_30(Density_Measu_FJ_30<11)=nan;
%imagesc(Density_Measu_FJ_30)
Mask_Density_Measu_FJ_30=Density_Measu_FJ_30;
Mask_Density_Measu_FJ_30(Mask_Density_Measu_FJ_30>=11)=1;

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/Vel_Stack_FJ_Portal_updated.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/Density_Measu_FJ_30.tif', Density_Measu_FJ_30, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

% Mask containing at least 25% of data

Density_Measu_FJ_25=Density_Measu_FJ_sum;
Density_Measu_FJ_25(Density_Measu_FJ_25<9)=nan;
%imagesc(Density_Measu_FJ_25)
Mask_Density_Measu_FJ_25=Density_Measu_FJ_25;
Mask_Density_Measu_FJ_25(Mask_Density_Measu_FJ_25>=9)=1;

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/Vel_Stack_FJ_Portal_updated.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/Density_Measu_FJ_25.tif', Density_Measu_FJ_25, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  Cretating the date vector:

pathsate_opt_FJ=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/'];
d_opt_FJ=dir(pathsate_opt_FJ);
j=1;
for i=4:length(d_opt_FJ)-1;
    name=d_opt_FJ(i,1).name;
    data_FJ{j,1}=cellstr(name);
    data_str_FJ(j,:)=['20' name(1:6) '-20' name(8:13)];
    %date{j,1}=cellstr(name(18:25));
    list_opt_FJ(j,1)=cellstr(data_FJ{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt_PG i j name

data_str_FJ_num(:)=datenum(data_str_FJ(:,1:8),'yyyymmdd');

%%%%%%%%%%%%%%%%%%%%%%%%%
% summer: 15/Jun to 15/Aug
% winter: DJF
%%%%%%%%%%%%%%%%%%%%%%%%%

FJ_summer_find=find((data_str_FJ_num>=datenum('15062015','ddmmyyyy') & data_str_FJ_num<=datenum('15082015','ddmmyyyy')) | ((data_str_FJ_num>=datenum('15062016','ddmmyyyy') & data_str_FJ_num<=datenum('15082016','ddmmyyyy'))));
FJ_winter_find=find((data_str_FJ_num>=datenum('01122014','ddmmyyyy') & data_str_FJ_num<=datenum('28022015','ddmmyyyy')) | ((data_str_FJ_num>=datenum('01122015','ddmmyyyy') & data_str_FJ_num<=datenum('28022016','ddmmyyyy'))) | ((data_str_FJ_num>=datenum('01122016','ddmmyyyy') & data_str_FJ_num<=datenum('28022017','ddmmyyyy'))));

FJ_summer2= stack_FJ(:,:,FJ_summer_find);
FJ_winter2= stack_FJ(:,:,FJ_winter_find);

FJ_summer2(FJ_summer2<=0)=nan;
FJ_winter2(FJ_winter2<=0)=nan;

FJ_mean_summer2=nanmean(FJ_summer2,3);
FJ_mean_winter2=nanmean(FJ_winter2,3);

FJ_mean_summer2(FJ_mean_summer2<=0)=nan;
FJ_mean_winter2(FJ_mean_winter2<=0)=nan;

FJ_mean_summer2_log=log10(FJ_mean_summer2);
FJ_mean_winter2_log=log10(FJ_mean_winter2);


% masking based on the density of data  #### 30% #####

FJ_mean_summer2_masked_30p=FJ_mean_summer2;
FJ_mean_summer2_masked_30p(Mask_Density_Measu_FJ_30~=1)=nan;

FJ_mean_winter2_masked_30p=FJ_mean_winter2;
FJ_mean_winter2_masked_30p(Mask_Density_Measu_FJ_30~=1)=nan;

% just getting the values are not nan's values
FJ_mean_winter2_masked_30p(isnan(FJ_mean_summer2_masked_30p))=nan;
FJ_mean_summer2_masked_30p(isnan(FJ_mean_winter2_masked_30p))=nan;


% Calculate Summer-Winter and Winter/Summer

FJ_summer_mean_divided_winter=(1-(FJ_mean_winter2_masked_30p./FJ_mean_summer2_masked_30p))*100;
FJ_summer_mean_minus_winter=FJ_mean_summer2_masked_30p-FJ_mean_winter2_masked_30p;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% masking based on the density of data    #### 25% #####

FJ_mean_summer2_masked_25p=FJ_mean_summer2;
FJ_mean_summer2_masked_25p(Mask_Density_Measu_FJ_25~=1)=nan;

FJ_mean_winter2_masked_25p=FJ_mean_winter2;
FJ_mean_winter2_masked_25p(Mask_Density_Measu_FJ_25~=1)=nan;

% just getting the values are not nan's values
FJ_mean_winter2_masked_25p(isnan(FJ_mean_summer2_masked_25p))=nan;
FJ_mean_summer2_masked_25p(isnan(FJ_mean_winter2_masked_25p))=nan;


% Calculate Summer-Winter and Winter/Summer

FJ_summer_mean_divided_winter_25p=(1-(FJ_mean_winter2_masked_25p./FJ_mean_summer2_masked_25p))*100;
FJ_summer_mean_minus_winter_25p=FJ_mean_summer2_masked_25p-FJ_mean_winter2_masked_25p;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Getting just data inside 2 std's :
FJ_summer_mean_divided_winter(FJ_summer_mean_divided_winter>=(nanmean(FJ_summer_mean_divided_winter(:))+(2*nanstd(FJ_summer_mean_divided_winter(:)))))=nan;
FJ_summer_mean_divided_winter(FJ_summer_mean_divided_winter<=(nanmean(FJ_summer_mean_divided_winter(:))-(2*nanstd(FJ_summer_mean_divided_winter(:)))))=nan;

FJ_summer_mean_minus_winter(FJ_summer_mean_minus_winter>=(nanmean(FJ_summer_mean_minus_winter(:))+(2*nanstd(FJ_summer_mean_minus_winter(:)))))=nan;
FJ_summer_mean_minus_winter(FJ_summer_mean_minus_winter<=(nanmean(FJ_summer_mean_minus_winter(:))-(2*nanstd(FJ_summer_mean_minus_winter(:)))))=nan;

FJ_summer_mean_minus_winter_log=real(log10(FJ_summer_mean_minus_winter));

imagesc(FJ_summer_mean_minus_winter_log)

%FJ_summer_minus_winter=FJ_mean_summer-FJ_mean_winter;

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/Vel_Stack_FJ_Portal_updated.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/FJ_mean_summer_updated.tif', FJ_mean_summer2, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/FJ_mean_winter_updated.tif', FJ_mean_winter2, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/FJ_mean_summer_LOG_updated.tif', FJ_mean_summer2_log, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/FJ_mean_winter_LOG_updated.tif', FJ_mean_winter2_log, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/FJ_mean_summer_mean_minus_winter_updated.tif', FJ_summer_mean_minus_winter, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/FJ_mean_summer_mean_minus_winter_LOG_updated.tif', FJ_summer_mean_minus_winter_log, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/FJ_summer_mean_divided_winter_updated.tif', FJ_summer_mean_divided_winter, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


%%%%%%%%%%%%%%%%%  Pts

%%%%% Calculating a mean in an moving mean, around 5 pixels (**profile_ext_mean** function)
% Including nan's

stack_FJ(stack_FJ<=0)=nan;

% Extract the profiles

prof_curve_FJ_5window_mean=nan(1997,size(stack_FJ,3) );

prof_across_FJ1_5window_mean=nan(999,size(stack_FJ,3) );
prof_across_FJ2_5window_mean=nan(999,size(stack_FJ,3) );
prof_across_FJ3_5window_mean=nan(999,size(stack_FJ,3) );

for i=1:size(stack_FJ,3) 
prof_across_FJ1_5window_mean(:,i)=profile_ext_mean(X_across_FJ1,Y_across_FJ1,stack_FJ(:,:,i),Rstack_FJ,5);
prof_across_FJ2_5window_mean(:,i)=profile_ext_mean(X_across_FJ2,Y_across_FJ2,stack_FJ(:,:,i),Rstack_FJ,5);
prof_across_FJ3_5window_mean(:,i)=profile_ext_mean(X_across_FJ3,Y_across_FJ3,stack_FJ(:,:,i),Rstack_FJ,5);

prof_curve_FJ_5window_mean(:,i)=profile_ext_mean(X_p_curve_FJ,Y_p_curve_FJ,stack_FJ(:,:,i),Rstack_FJ,5);

end

for i=1:size(stack_FJ,3) 
pt_FJ1_5window_mean(i)=prof_across_FJ1_5window_mean(595,i);
pt_FJ2_5window_mean(i)=prof_across_FJ2_5window_mean(599,i);
pt_FJ3_5window_mean(i)=prof_across_FJ3_5window_mean(629,i);

end

mdl_pt_FJ1_5window_mean = fitlm(data_str_FJ_num,pt_FJ1_5window_mean/1000);
mdl_pt_FJ2_5window_mean = fitlm(data_str_FJ_num,pt_FJ2_5window_mean/1000);
mdl_pt_FJ3_5window_mean = fitlm(data_str_FJ_num,pt_FJ3_5window_mean/1000);


%%%%%%  Plot Pts (IM_Figures.m)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FJ Summer & Winter

for i=1:size(FJ_summer2,3)
FJ_summer2_profile(:,i)=profile_ext_mean(X_p_curve_FJ,Y_p_curve_FJ,FJ_summer2(:,:,i),Rstack_FJ,5);
end

for i=1:size(FJ_winter2,3)
FJ_winter2_profile(:,i)=profile_ext_mean(X_p_curve_FJ,Y_p_curve_FJ,FJ_winter2(:,:,i),Rstack_FJ,5);
end

%%%%%%  Plot Summer and Winter (IM_Figures.m)


%%%%%%%% FJ Terra_SAR_X points
%pts_TSX_Joughin_PG = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/Qgis/PG_Pts.shp');
pts_TSX_Joughin_FJ = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/Qgis/FJ_Pts_used.shp');

X_pts_TSX_Joughin_FJ=extractfield(pts_TSX_Joughin_FJ,'X');
Y_pts_TSX_Joughin_FJ=extractfield(pts_TSX_Joughin_FJ,'Y');

name_FJ_pts=extractfield(pts_TSX_Joughin_FJ,'Name');


for j=[1:length(Y_pts_TSX_Joughin_FJ)]
for i=1:size(Vel_TSX_FJ,3)
pt_TSX_Joughin_FJ(i,j)=profile_ext_mean(X_pts_TSX_Joughin_FJ(1,j),Y_pts_TSX_Joughin_FJ(1,j),Vel_TSX_FJ(:,:,i),R_TSX_FJ,5);

%pt_JAK_main(i)=prof_curve_JAK(10,i);
end
end

for j=[1:length(Y_pts_TSX_Joughin_FJ)]
for i=1:size(Vel_Stack_FJ,3) 

    pt_S1_FJ(i,j)=profile_ext_mean(X_pts_TSX_Joughin_FJ(1,j),Y_pts_TSX_Joughin_FJ(1,j),Vel_Stack_FJ(:,:,i),Rstack_FJ,5);

end
%pt_JAK_main(i)=prof_curve_JAK(10,i);
end

for i=1:length(data_str_FJ);

date_pt_S1_FJ(i)=datenum(data_str_FJ(i,1:8),'yyyymmdd');

end