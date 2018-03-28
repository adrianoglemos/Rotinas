%% PIG
pathsate_opt=['/nfs/a41/S1_CPOM_www/IV_out/PIG/WWW/T137_-075_-098/FT_v28/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/PIG/Portal_Data_PIG/'];
d_opt=dir(pathsate_opt);
j=1;
for i=4:length(d_opt)-4;
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name

j=1;
for i=1:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    dest=[destination list_opt{i,1} '/'];    
    eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*ccpN.gc.tiff ' dest]);
% eval( ['!cp ./*ccsN.gc.tiff ' dest]);
 
 eval( ['!cp ./*mag_yrF.gc.tiff ' dest]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' dest]);
 
 eval( ['!cp ./*_SO.txt ' dest]);
 
 eval( ['!cp ./*.mligc.gc.tiff ' dest]);
 
 eval( ['!cp ./*.mliFgc.gc.tiff ' dest]);

eval( ['!cp ./*.mliFgc.gc.tiff ' dest]);

end



pathsate_opt=['/nfs/a41/S1_CPOM_www/IV_out/PIG/WWW/T137_-075_-099/FT_v28/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/PIG/Portal_Data_PIG_p2/'];
d_opt=dir(pathsate_opt);
j=1;
for i=1:size(d_opt,1);
    name=d_opt(i,1).name;
    data2{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt2(j,1)=cellstr(data2{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name

j=1;
for i=1:size(list_opt2,1);
    path1=[pathsate_opt list_opt2{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    dest=[destination list_opt2{i,1} '/'];    
    eval(['!mkdir ' dest]);

    date=list_opt2{i,1};
cd(path1);

% eval( ['!cp ./*ccsN.gc.tiff ' dest]);

eval( ['!cp ./*ccpN.gc.tiff ' dest]);
 
 eval( ['!cp ./*mag_yrF.gc.tiff ' dest]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' dest]);
 
 eval( ['!cp ./*_SO.txt ' dest]);
 
 eval( ['!cp ./*.mligc.gc.tiff ' dest]);
 
 eval( ['!cp ./*.mliFgc.gc.tiff ' dest]);


end



pathsate_opt=['/nfs/a41/S1_CPOM_www/IV_out/PIG/WWW/T137_-075_-100/FT_v28/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/PIG/Portal_Data_PIG_p3/'];
d_opt=dir(pathsate_opt);
j=1;
for i=1:size(d_opt,1);
    name=d_opt(i,1).name;
    data3{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt3(j,1)=cellstr(data3{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name

j=1;
for i=1:size(list_opt3,1);
    path1=[pathsate_opt list_opt3{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    dest=[destination list_opt3{i,1} '/'];    
    eval(['!mkdir ' dest]);

    date=list_opt3{i,1};
cd(path1);

% eval( ['!cp ./*ccsN.gc.tiff ' dest]);

eval( ['!cp ./*ccpN.gc.tiff ' dest]);
 
 eval( ['!cp ./*mag_yrF.gc.tiff ' dest]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' dest]);
 
 eval( ['!cp ./*_SO.txt ' dest]);
 
 eval( ['!cp ./*.mligc.gc.tiff ' dest]);
 
 eval( ['!cp ./*.mliFgc.gc.tiff ' dest]);


end



% #########################  THW


pathsate_opt=['/nfs/a41/S1_CPOM_www/IV_out/THW/WWW/T079_-075_-107/FT_v28/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/THW/Portal_Data_THW_p1/'];
d_opt=dir(pathsate_opt);
j=1;
for i=1:size(d_opt,1);
    name=d_opt(i,1).name;
    dataTHW1{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_optTHW1(j,1)=cellstr(dataTHW1{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name

j=1;
for i=1:size(list_optTHW1,1);
    path1=[pathsate_opt list_optTHW1{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    dest=[destination list_optTHW1{i,1} '/'];    
    eval(['!mkdir ' dest]);

    date=list_optTHW1{i,1};
cd(path1);

eval( ['!cp ./*ccsN.gc.tiff ' dest]);

eval( ['!cp ./*ccpN.gc.tiff ' dest]);
 
 eval( ['!cp ./*mag_yrF.gc.tiff ' dest]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' dest]);
 
 eval( ['!cp ./*_SO.txt ' dest]);
 
 eval( ['!cp ./*.mligc.gc.tiff ' dest]);
 
 eval( ['!cp ./*.mliFgc.gc.tiff ' dest]);


end


pathsate_opt=['/nfs/a41/S1_CPOM_www/IV_out/THW/WWW/T079_-075_-106/FT_v28/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/THW/Portal_Data_THW_p2/'];
d_opt=dir(pathsate_opt);
j=1;
for i=1:size(d_opt,1);
    name=d_opt(i,1).name;
    dataTHW2{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_optTHW2(j,1)=cellstr(dataTHW2{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name

j=1;
for i=1:size(list_optTHW2,1);
    path1=[pathsate_opt list_optTHW2{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    dest=[destination list_optTHW2{i,1} '/'];    
    eval(['!mkdir ' dest]);

    date=list_optTHW2{i,1};
cd(path1);

eval( ['!cp ./*ccsN.gc.tiff ' dest]);

eval( ['!cp ./*ccpN.gc.tiff ' dest]);
 
 eval( ['!cp ./*mag_yrF.gc.tiff ' dest]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' dest]);
 
 eval( ['!cp ./*_SO.txt ' dest]);
 
 eval( ['!cp ./*.mligc.gc.tiff ' dest]);
 
 eval( ['!cp ./*.mliFgc.gc.tiff ' dest]);


end




 







%% Separando vel magnitude


% PIG

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/PIG/Portal_Data_PIG/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/PIG/Portal_Data_PIG/stack/'];
d_opt=dir(pathsate_opt);
j=1;
for i=3:length(d_opt)-1;
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
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*mag_yrF.gc.tiff ' destination]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' destination]);
 

end

clear all


pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/PIG/Portal_Data_PIG_p2/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/PIG/Portal_Data_PIG_p2/stack/'];
d_opt=dir(pathsate_opt);
j=1;
for i=3:length(d_opt)-1;
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
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*mag_yrF.gc.tiff ' destination]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' destination]);
 

end

clear all



pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/PIG/Portal_Data_PIG_p3/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/PIG/Portal_Data_PIG_p3/stack/'];
d_opt=dir(pathsate_opt);
j=1;
for i=3:length(d_opt)-1;
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
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*mag_yrF.gc.tiff ' destination]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' destination]);
 

end

clear all


%##################### TWH

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/THW/Portal_Data_THW_p1/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/THW/Portal_Data_THW_p1/stack/'];
d_opt=dir(pathsate_opt);
j=1;
for i=3:length(d_opt)-1;
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
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*mag_yrF.gc.tiff ' destination]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' destination]);
 

end

clear all



pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/THW/Portal_Data_THW_p2/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/THW/Portal_Data_THW_p2/stack/'];
d_opt=dir(pathsate_opt);
j=1;
for i=3:length(d_opt)-1;
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
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*mag_yrF.gc.tiff ' destination]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' destination]);
 

end

clear all

T_data_079=cell2table(data_079,'VariableNames',{'sensor','track','date','lat','lon'});
writetable(T_data_079,'data_079.txt')

T_data_125=cell2table(data_125,'VariableNames',{'sensor','track','date','lat','lon'});
writetable(T_data_125,'data_125.txt')

T_data_137=cell2table(data_137,'VariableNames',{'sensor','track','date','lat','lon'});
writetable(T_data_137,'data_137.txt')

%%% ##### Finding the dataset in dat_XXX files

find_lat=strfind(data_079{:,4}, '-079') 
A=cellstr(data_079{1,4});
&& 
A = cellfun(func,C)


% Merge data using EVAL:

% gdal_merge.py -n -999 -a_nodata -999 -separate -of GTiff -o merge.tif im1tif im2.tif

gdal_merge.py -n -999 -a_nodata -999 -separate -of GTiff -o ./../merge.tif /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/THW/Processing/T1/170710_170722.coffsN_mag_DuFil_yrF.gc.tiff /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/THW/Processing/T2_dem_nan/170710_170722.coffsN_mag_DuFil_yrF.gc.tiff

[THW,Rthw]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/THW/stack/THW_portal_stack.tif');


xvel_PIG=[Rpig.XWorldLimits(1):100:Rpig.XWorldLimits(2)-100];
yvel_PIG=[Rpig.YWorldLimits(1):100:Rpig.YWorldLimits(2)-100];
%[Xvel,Yvel] = meshgrid(xvel,yvel);

xvel_THW=[Rthw.XWorldLimits(1):100:Rthw.XWorldLimits(2)-100];
yvel_THW=[Rthw.YWorldLimits(1):100:Rthw.YWorldLimits(2)-100];
%[Xvel,Yvel] = meshgrid(xvel,yvel);

xvel_mli=[Rmli.XWorldLimits(1):100:Rmli.XWorldLimits(2)];
yvel_mli=[Rmli.YWorldLimits(1):100:Rmli.YWorldLimits(2)];

PIG(PIG<=0.5)=nan;
THW(THW<=0.5)=nan;


PIG_mean_map=nanmean(PIG,3); PIG_mean_map=movmean(PIG_mean_map,[5 5]);
THW_mean_map=nanmean(THW,3); THW_mean_map=movmean(THW_mean_map,[5 5]);

info_PIG = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/PIG/stack/PIG_portal.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/Output/PIG_mean_map.tif', PIG_mean_map, Rpig,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
info_THW = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/THW/stack/THW_portal_stack.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/Output/THW_mean_map.tif', THW_mean_map, Rthw,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


%'######################################################################################################################
figure;
ha=imagesc(xvel_PIG,yvel_PIG,flip(PIG_mean_map)); hold on;
set(ha,'alphadata',~isnan(flip(PIG_mean_map)))
set(gca,'yDir','Normal');
ha=imagesc(xvel_THW,yvel_THW,flip(THW_mean_map));
set(ha,'alphadata',~isnan(flip(THW_mean_map)))
set(gca,'yDir','Normal')

ylim([-600000 -100000])
xlim([-1.8e+06 -1.3e+06]);


[x,y]=map2pix(Rpigp3,Rpigp1.XWorldLimits,Rpigp1.YWorldLimits)

%'######################################################################################################################

AMS_gate = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/Shapefiles/Rignot_GLL/Reprojected/GL_pig_thw_pts.shp');
X_AMS_gate=extractfield(AMS_gate,'X');
Y_AMS_gate=extractfield(AMS_gate,'Y');

X_AMS_gate=X_AMS_gate(~isnan(X_AMS_gate));
Y_AMS_gate=Y_AMS_gate(~isnan(Y_AMS_gate));


AMS_THW_gate_prof=profile_ext_mean(X_AMS_gate,Y_AMS_gate,THW_mean_map,Rthw,5);
AMS_PIG_gate_prof=profile_ext_mean(X_AMS_gate,Y_AMS_gate,PIG_mean_map,Rpig,5);

dist_AMS_gate=0:595/(size(AMS_THW_gate_prof,1)-1):595;

figure
plot(dist_AMS_gate,AMS_PIG_gate_prof,'k.'); hold on
plot(dist_AMS_gate,AMS_THW_gate_prof,'.');
ylabel('velocity [m.yr^{-1}]','fontsize',14,'fontweight','b');
xlabel('ditance along the the coast [km]','fontsize',14,'fontweight','b');
grid on
legend('PIG','THW')

print -djpeg -r300 /nfs/a59/eeagdl/Dropbox/Dropbox/Uni_Leeds/AMS_paper/Figures/Profile_along_coast_PIG_THW



% Import profile along the main flow and fixed locations


%############ PIG  ########

PIG_pts = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/Shapefiles/PIG_pts.shp');
X_PIG_pts=extractfield(PIG_pts,'X');
Y_PIG_pts=extractfield(PIG_pts,'Y');
name_PIG_pts=extractfield(PIG_pts,'Name');


k=1;
for j=[1:length(X_PIG_pts)]
for i=1:size(PIG,3)

PIG_pts_extract(i,k)=profile_ext_mean(X_PIG_pts(1,j),Y_PIG_pts(1,j),PIG(:,:,i),Rpig,5);

end
k=k+1;
end
%#########

for i=1:size(PIG,3)

AMS_PIG_gate_prof_all(:,i)=profile_ext_mean(X_AMS_gate,Y_AMS_gate,PIG(:,:,i),Rpig,5);

end

%#########
k=1;
for j=[1:length(X_PIG_pts)]
for i=1:size(PIG,3)

PIG_pts_extract10(i,k)=profile_ext_mean(X_PIG_pts(1,j),Y_PIG_pts(1,j),PIG(:,:,i),Rpig,10);

end
k=k+1;
end

[date_PIG_num_sorted,I]=sort(datePIG_num);
date_PIG_yymmdd_sorted=datePIG_yymmdd(I,:);

PIG_pts_extract10_sorted=PIG_pts_extract10(I,:);
AMS_PIG_gate_prof_all_sorted=AMS_PIG_gate_prof_all(:,I);
PIG_prof_extract_sorted=PIG_prof_extract(:,I);
PIG_sorted=PIG(:,:,I);

% sort THW data

for i=1:size(THW,3)

AMS_THW_gate_prof_all(:,i)=profile_ext_mean(X_AMS_gate,Y_AMS_gate,THW(:,:,i),Rthw,5);

end



[date_THW_num_sorted,I]=sort(dateTHW_num);
date_THW_yymmdd_sorted=dateTHW_yymmdd(I,:);

THW_pts_extract_sorted=THW_pts_extract(I,:);
AMS_THW_gate_prof_all_sorted=AMS_THW_gate_prof_all(:,I);
THW_prof_extract_sorted=THW_prof_extract(:,I);
THW_sorted=THW(:,:,I);

figure
j=1;
for i=1:18;
subplot(3,6,j)
    pcolor(THW_sorted(:,:,i))
    shading interp;
    j=j+1;
    caxis([0 4000])
end

% Considering summer (Nov-Feb)
% PIG:
%   14-15: 1:8
%   15-16: 25:30
%   16-17: 48:66
%
% Winter:
% 2015 -> 15:22
% 2016 -> [34:36 38:42]
% 2017 -> 77:end


%Seasonal profiles along grounding line
summer1PIG_gate=nanmean(AMS_PIG_gate_prof_all_sorted(:,1:8),2);
summer2PIG_gate=nanmean(AMS_PIG_gate_prof_all_sorted(:,25:30),2);
summer3PIG_gate=nanmean(AMS_PIG_gate_prof_all_sorted(:,48:66),2);

winter1PIG_gate=nanmean(AMS_PIG_gate_prof_all_sorted(:,15:22),2);
winter2PIG_gate=nanmean(AMS_PIG_gate_prof_all_sorted(:,[34:36 38:42]),2);
winter3PIG_gate=nanmean(AMS_PIG_gate_prof_all_sorted(:,77:end),2);

%Seasonal Profiles
summer1PIG_prof=nanmean(PIG_prof_extract_sorted(:,1:8),2);
summer2PIG_prof=nanmean(PIG_prof_extract_sorted(:,25:30),2);
summer3PIG_prof=nanmean(PIG_prof_extract_sorted(:,48:66),2);

winter1PIG_prof=nanmean(PIG_prof_extract_sorted(:,15:22),2);
winter2PIG_prof=nanmean(PIG_prof_extract_sorted(:,[34:36 38:42]),2);
winter3PIG_prof=nanmean(PIG_prof_extract_sorted(:,77:end),2);

% Seasonal Maps
summer1PIG_map=nanmean(PIG_sorted(:,:,1:8),2);
summer2PIG_map=nanmean(PIG_sorted(:,:,25:30),2);
summer3PIG_map=nanmean(PIG_sorted(:,:,48:66),2);

winter1PIG_map=nanmean(PIG_sorted(:,:,15:22),2);
winter2PIG_map=nanmean(PIG_sorted(:,:,[34:36 38:42]),2);
winter3PIG_map=nanmean(PIG_sorted(:,:,77:end),2);



figure
plot(dist_AMS_gate,summer1PIG_gate,'linestyle','-','marker','.'); hold on
plot(dist_AMS_gate,summer2PIG_gate,'linestyle','-','marker','.');
plot(dist_AMS_gate,summer3PIG_gate,'linestyle','-','marker','.');
legend('summer 14-15','summer 15-16','summer 16-17','winter 2015','winter 2016','winter 2017');

figure
plot(dist_AMS_gate,winter1PIG_gate,'linestyle','-','marker','.'); hold on
plot(dist_AMS_gate,winter2PIG_gate,'linestyle','-','marker','.');
plot(dist_AMS_gate,winter3PIG_gate,'linestyle','-','marker','.');
legend('winter 2015','winter 2016','winter 2017');


figure
plot(dist_prof_pig,summer1PIG_prof,'linestyle','-','marker','.'); hold on
plot(dist_prof_pig,summer2PIG_prof,'linestyle','-','marker','.');
plot(dist_prof_pig,summer3PIG_prof,'linestyle','-','marker','.');
legend('summer 14-15','summer 15-16','summer 16-17','winter 2015','winter 2016','winter 2017');

figure
plot(dist_prof_pig,winter1PIG_prof,'linestyle','-','marker','.'); hold on
plot(dist_prof_pig,winter2PIG_prof,'linestyle','-','marker','.');
plot(dist_prof_pig,winter3PIG_prof,'linestyle','-','marker','.');


figure
j=1;
for i=1:8;
subplot(2,4,j)
    imagesc(PIG_sorted(:,:,i))
    j=j+1;
    caxis([0 4000])
end

figure
j=1;
for i=25:30;
subplot(2,3,j)
    imagesc(PIG_sorted(:,:,i))
    j=j+1;
    caxis([0 4000])
end

figure
j=1;
for i=44:66;
subplot(3,8,j)
    imagesc(PIG_sorted(:,:,i))
    j=j+1;
    caxis([0 4000])
end

figure
j=1;
for i=30:46;
subplot(3,6,j)
    pcolor(PIG_sorted(:,:,i))
    shading interp;
    j=j+1;
    caxis([0 4000])
end


figure
j=1;
for i=82:89;
subplot(3,3,j)
    pcolor(PIG_sorted(:,:,i))
    shading interp;
    j=j+1;
    caxis([0 4000])
end


figure
Y_seasons=[-60 -60 5000 5000];
plot(date_PIG_num_sorted,PIG_pts_extract10_sorted,'.','LineStyle','-','MarkerSize',5,'Marker','.');hold on
fill(summer_2015,Y_seasons,'b','FaceAlpha', 0.1,'linestyle','none');
fill(summer_2016,Y_seasons,'b','FaceAlpha', 0.1,'linestyle','none');
fill(summer_2017,Y_seasons,'b','FaceAlpha', 0.1,'linestyle','none');
fill(winter_2014,Y_seasons,'r','FaceAlpha', 0.1,'linestyle','none');
fill(winter_2015,Y_seasons,'r','FaceAlpha', 0.1,'linestyle','none');
fill(winter_2016,Y_seasons,'r','FaceAlpha', 0.1,'linestyle','none');
ylim([2000 4500]);


plot(datePIG_num,PIG_pts_extract10,'.','LineStyle','-','MarkerSize',5,'Marker','.');

datetick('x','mmm-yy','keepticks');
xlim([datenum('01112014','ddmmyyyy')  datenum('01112017','ddmmyyyy')])

ylabel('velocity [m.yr^{-1}]','fontsize',14,'fontweight','b');
set(gca,'XGrid','on','YAxisLocation','left')



%########################################





% Dates PIG

datePIG=cat(1,dataPIG1,dataPIG2,dataPIG3);

for i=1:size(datePIG,1)
    
datePIG_yymmdd(i,:)=datePIG{i}{1};   
datePIG_num(i)=datenum(datePIG_yymmdd(i,8:13), 'yymmdd');
end

figure
plot(datePIG_num,PIG_pts_extract,'.','LineStyle','-','MarkerSize',5,'Marker','.');

datetick('x','mmm-yy','keepticks');
xlim([datenum('01112014','ddmmyyyy')  datenum('01112017','ddmmyyyy')])

ylabel('velocity [m.yr^{-1}]','fontsize',14,'fontweight','b');
set(gca,'XGrid','on','YAxisLocation','left')
box off
title('PIG','fontsize',12,'fontweight','b');
legend(name_PIG_pts)
set(gcf,'Paperorientation','landscape')
print -djpeg -r300 /nfs/a59/eeagdl/Dropbox/Dropbox/Uni_Leeds/AMS_paper/Figures/Fix_pts_PIG


for i=1:size(datePIG_num2,2)
    if (datePIG_num2(i)>=(736330+365))
        datePIG_num2(i)=datePIG_num2(i)-(365*2);
    
    else
        datePIG_num2(i)=datePIG_num2(i);
    end
    
end

for i=1:size(datePIG_num2,2)
    if (datePIG_num2(i)>=(736330))
        datePIG_num2(i)=datePIG_num2(i)-(365);
    
    else
        datePIG_num2(i)=datePIG_num2(i);
    end
    
end


PIG_prof = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/Shapefiles/PIG_profile_pts.shp');
X_PIG_prof=extractfield(PIG_prof,'X');
Y_PIG_prof=extractfield(PIG_prof,'Y');

X_PIG_prof=X_PIG_prof(~isnan(X_PIG_prof));
Y_PIG_prof=Y_PIG_prof(~isnan(Y_PIG_prof));


for i=1:size(PIG,3)
 PIG_prof_extract(:,i)=profile_ext_mean(X_PIG_prof,Y_PIG_prof,PIG(:,:,i),Rpig,5);
end

dist_prof_pig=[-77000:100:66400];


figure;
plot(dist_prof_pig/1000,nanmean(PIG_prof_extract,2),'.');hold on
plot([0,0],[0,6000],'r--');
ylabel('velocity [m.yr^{-1}]','fontsize',14,'fontweight','b');
xlabel('distance from the GL [km]','fontsize',14,'fontweight','b');
grid on;
print -djpeg -r300 /nfs/a59/eeagdl/Dropbox/Dropbox/Uni_Leeds/AMS_paper/Figures/PIG_all_profiles


THW_pts = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/Shapefiles/THW_pts.shp');
X_THW_pts=extractfield(THW_pts,'X');
Y_THW_pts=extractfield(THW_pts,'Y');
name_THW_pts=extractfield(THW_pts,'Name');

k=1;
for j=[1:length(X_THW_pts)]
for i=1:size(THW,3)

THW_pts_extract(i,k)=profile_ext_mean(X_THW_pts(1,j),Y_THW_pts(1,j),THW(:,:,i),Rthw,5);

end
k=k+1;
end

% Dates THW

dateTHW=cat(1,dataTHW1,dataTHW2);

for i=1:size(dateTHW,1)
    
dateTHW_yymmdd(i,:)=dateTHW{i}{1};   
dateTHW_num(i)=datenum(dateTHW_yymmdd(i,8:13), 'yymmdd');
end

figure
plot(dateTHW_num,THW_pts_extract,'.','LineStyle','-','MarkerSize',5,'Marker','.');

datetick('x','mmm-yy','keepticks');
xlim([datenum('01112014','ddmmyyyy')  datenum('01112017','ddmmyyyy')])

ylabel('velocity [m.yr^{-1}]','fontsize',14,'fontweight','b');
set(gca,'XGrid','on','YAxisLocation','left')
box off
title('THW','fontsize',12,'fontweight','b');
legend(name_THW_pts)
set(gcf,'Paperorientation','landscape')
print -djpeg -r300 /nfs/a59/eeagdl/Dropbox/Dropbox/Uni_Leeds/AMS_paper/Figures/Fix_pts_THW



THW_prof = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/Shapefiles/THW_profile_pts.shp');
X_THW_prof=extractfield(THW_prof,'X');
Y_THW_prof=extractfield(THW_prof,'Y');

X_THW_prof=X_THW_prof(~isnan(X_THW_prof));
Y_THW_prof=Y_THW_prof(~isnan(Y_THW_prof));

for i=1:size(THW,3)
 THW_prof_extract(:,i)=profile_ext_mean(X_THW_prof,Y_THW_prof,THW(:,:,i),Rthw,5);
end

dist_prof_thw=[-86700:100:75500];

figure;
plot(dist_prof_thw/1000,THW_prof_extract,'.');hold on
plot([0,0],[0,6000],'r--');
ylabel('velocity [m.yr^{-1}]','fontsize',14,'fontweight','b');
xlabel('distance from the GL [km]','fontsize',14,'fontweight','b');
print -djpeg -r300 /nfs/a59/eeagdl/Dropbox/Dropbox/Uni_Leeds/AMS_paper/Figures/THW_all_profiles

figure;
plot(dist_prof_pig/1000,nanmean(PIG_prof_extract,2),'.');hold on
plot(dist_prof_thw/1000,nanmean(THW_prof_extract,2),'.');
ylim([0 5000]);
plot([0,0],[0,6000],'r--');
legend('PIG', 'THW')
ylabel('velocity [m.yr^{-1}]','fontsize',14,'fontweight','b');
xlabel('distance from the GL [km]','fontsize',14,'fontweight','b');
grid on;
print -djpeg -r300 /nfs/a59/eeagdl/Dropbox/Dropbox/Uni_Leeds/AMS_paper/Figures/PIG_THW_mean_profiles



%%

pathsate_opt_079=['/nfs/a41/L0data/S1/079/'];
%destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/'];
d_opt_079=dir(pathsate_opt_079);
j=1;
for i=6:length(d_opt_079);
    name=d_opt_079(i,1).name;
    
    data_079{j,1}=cellstr(name(1:3));
    data_079{j,2}=cellstr(name(12:14));
    data_079{j,3}=cellstr(name(27:32));
    data_079{j,4}=cellstr(name(41:44));
    data_079{j,5}=cellstr(name(51:54));
 
%     data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
%     list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
% clear d_opt i j name data



pathsate_opt_125=['/nfs/a41/L0data/S1/125/'];
%destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/'];
d_opt_125=dir(pathsate_opt_125);
j=1;
for i=3:length(d_opt_125);
    name=d_opt_125(i,1).name;
    
    data_125{j,1}=cellstr(name(1:3));
    data_125{j,2}=cellstr(name(12:14));
    data_125{j,3}=cellstr(name(27:32));
    data_125{j,4}=cellstr(name(41:44));
    data_125{j,5}=cellstr(name(51:54));
 
%     data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
%     list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
% clear d_opt i j name data

pathsate_opt_137=['/nfs/a41/L0data/S1/137/'];
%destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/'];
d_opt_137=dir(pathsate_opt_137);

j=1;
for i=4:length(d_opt_137);
    name=d_opt_137(i,1).name;
    
    data_137{j,1}=cellstr(name(1:3));
    data_137{j,2}=cellstr(name(12:14));
    data_137{j,3}=cellstr(name(27:32));
    data_137{j,4}=cellstr(name(41:44));
    data_137{j,5}=cellstr(name(51:54));
 
%     data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
%     list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end



figure

h=imagesc(log10(real(THW_mean_map)))
tt=double(~isnan(THW_mean_map)); set(h,'AlphaData', tt);
colormap(flipud(colormap))
CT=cbrewer('div', 'RdYlBu',101)
colormap(CT)
colormap(flipud(colormap))
hh=colorbar
% Contours=[0 500 2000];
% Contours_name=[0 0.5 2];
Contours=[10 100 1000 3000];
Contours_name=[0 100 1000 3000];
caxis([log10(real(Contours(1))) log10(real(Contours(length(Contours))))]);
colorbar('FontSize',12,'YTick',[log10(real(Contours(1))) log10(real(Contours(2:end)))],'YTickLabel',Contours_name);



% Create a density map to identify the number of measurements per pixel


% PIG:
PIG(PIG<=0)=nan;

for i=1:size(PIG,3)
    
    no_nan_PIG(:,:,i)=~isnan(PIG(:,:,i));
        
end

density_PIG=sum(int16(no_nan_PIG),3);

info_PIG = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/PIG/stack/PIG_portal.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/Output/PIG_density.tif', density_PIG, Rpig,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


% THW:
THW(THW<=0)=nan;

for i=1:size(THW,3)
    
    no_nan_THW(:,:,i)=~isnan(THW(:,:,i));
        
end

density_THW=sum(int16(no_nan_THW),3);

info_THW = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/THW/stack/THW_portal_stack.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/Output/THW_density.tif', density_THW, Rthw,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);





%%


j=1;
for i=[1:length(list_opt)];
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*mag_yrF.gc.tiff ' destination]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' destination]);
 

end

clear all

% PG

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/stack/'];
d_opt=dir(pathsate_opt);
j=1;
for i=3:length(d_opt)-1;
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
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*mag_yrF.gc.tiff ' destination]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' destination]);
 

end
 
%% Separando Amplitude


% JAK
pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated/animation/'];
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
for i=[1:length(list_opt)];
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*mliFgc.gc.tiff ' destination]);
 

 

end

clear all


pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated_2/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated_2/animation/'];
d_opt=dir(pathsate_opt);
j=1;
for i=3:length(d_opt);
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
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*mliFgc.gc.tiff ' destination]);
 

 

end

clear all


% FJ

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/'];
d_opt=dir(pathsate_opt);
j=1;
for i=4:length(d_opt)-1;
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
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*mag_yrF.gc.tiff ' destination]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' destination]);
 

end

clear all

% PG

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/stack/'];
d_opt=dir(pathsate_opt);
j=1;
for i=3:length(d_opt)-1;
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
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*mag_yrF.gc.tiff ' destination]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' destination]);
 

end
 

%% Separando ccp ccn


% JAK
pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated/ccp_ccs/'];
d_opt=dir(pathsate_opt);
j=1;
for i=4:length(d_opt)-3;
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
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*.ccsN.gc.tiff ' destination]);
  eval( ['!cp ./*.ccpN.gc.tiff ' destination]);


 

end

clear all


pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated_2/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated_2/ccp_ccs_2/'];
d_opt=dir(pathsate_opt);
j=1;
for i=3:length(d_opt)-3;
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
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*.ccsN.gc.tiff ' destination]);
  eval( ['!cp ./*.ccpN.gc.tiff ' destination]);
 

 

end

clear all


% FJ

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/ccp_ccs/'];
destination2=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/animation/'];

d_opt=dir(pathsate_opt);
j=1;
for i=4:length(d_opt)-3;
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
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*.ccsN.gc.tiff ' destination]);
  eval( ['!cp ./*.ccpN.gc.tiff ' destination]);
  eval( ['!cp ./*mliFgc.gc.tiff ' destination2]);


end

clear all

% PG

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/ccp_ccs/'];
destination2=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/updated/animation/'];

d_opt=dir(pathsate_opt);
j=1;
for i=4:length(d_opt)-3;
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
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*.ccsN.gc.tiff ' destination]);
  eval( ['!cp ./*.ccpN.gc.tiff ' destination]);
  eval( ['!cp ./*mliFgc.gc.tiff ' destination2]);

 

end
 clear all
 
