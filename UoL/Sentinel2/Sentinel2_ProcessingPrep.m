cd /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/download_pixel_website

% JAK
pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/download_pixel_website/'];
%destination=['/nfs/a59/eeagdl/date/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated/'];
d_opt=dir(pathsate_opt);
j=1;
for i=4:2:length(d_opt);
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, date);
end
clear d_opt i j name

destination1=['/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing_225_225/']
cd(pathsate_opt)
for i=1:size(list_opt,1)-1;
    path=[pathsate_opt];
%     path1=[pathsate_opt list_opt{i,1} '/'];
%     path2=[pathsate_opt list_opt{i+1,1} '/'];
    
    a1=list_opt{i,1}
    a2=list_opt{i+1,1}
    date1=a1(10:17);
    date2=a2(10:17);

    
    eval(['!mkdir ' destination1 date1 '_' date2 '/']);
    
    eval(['!cp ./*' date1 '* ' destination1 date1 '_' date2 '/']);
    eval(['!cp ./*' date2 '* ' destination1 date1 '_' date2 '/']);

    destination2=[destination1 date1 '_' date2 '/'];
    
    Tbaseline=num2str(datenum(date2,'yyyymmdd')-datenum(date1,'yyyymmdd'));

    %!cp ../S2_running.sh ./
    eval(['!cp /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing_225_225/S2_running.sh ' destination2]);
    eval(['!cp /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing_225_225/mask1.ras ' destination2]);

cd(destination2);
    eval(['!sed -i ''' '4s/20150816/' date1 '/' ''' S2_running.sh'])
    eval(['!sed -i ''' '5s/20150908/' date2 '/' ''' S2_running.sh'])

%     eval(['!sed -i ''' '9s/D642/' name1 '/' ''' S1_running_PIG.sh'])
%     eval(['!sed -i ''' '10s/3B97/' name2 '/' ''' S1_running_PIG.sh'])
%     
    eval(['!sed -i ''' '36s/23/' Tbaseline '/' ''' S2_running.sh'])

cd(pathsate_opt);
%   eval(['!mkdir ./' date1 '_' date2]); 
% 
%   cd(['./' date1 '_' date2])
%   
%   eval(['!cp ' path1 '*zip ./'])
%   eval(['!cp ' path2 '*zip ./'])
%   
    date(i,:)=date1;

%     cd(path1);

%  eval( ['!mv ' path '*.zip ' destination]);
%  eval( ['!mv ' path2 '*' date2 '*.zip ' path]);

i
end



%%%%%%%%%%%
% Copy the S1_running_PIG.sh script
%%%%%%%%%%%
% 
% clear all
% 
% pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2014/'];
% 
% d_opt=dir(pathsate_opt);
% j=1;
% for i=3:length(d_opt)-1;
%     name=d_opt(i,1).name;
%     data{j,1}=cellstr(name);
%     %date{j,1}=cellstr(name(18:25));
%     list_opt(j,1)=cellstr(data{j,1});
%     j=j+1;
% %folder=char(folder, data);
% end
% clear d_opt i j name


%%%%%%%%
% Prepare a shell file to run
%%%%%%%%


pathsate_opt2=['/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing_225_225/'];

d_opt2=dir(pathsate_opt2);
j=1;
for i=4:length(d_opt2);%-3;
    name=d_opt2(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt2(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt2 i j name2


for i=1:5:size(list_opt2,1);
    path1=[pathsate_opt2 list_opt2{i,1}];
    path2=[pathsate_opt2 list_opt2{i+1,1}];
    path3=[pathsate_opt2 list_opt2{i+2,1}];
    path4=[pathsate_opt2 list_opt2{i+3,1}];
    path5=[pathsate_opt2 list_opt2{i+4,1}];

    
    cd(pathsate_opt2)
    
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
%     d=dir(pwd);
%     name1=d(j,1).name; name1=name1(end-7:end-4);
%     name2=d(j+1,1).name; name2=name2(end-7:end-4);
    
     a1=list_opt2{i,1};
     a2=list_opt2{i+1,1};
     a3=list_opt2{i+2,1};
     a4=list_opt2{i+3,1};
     a5=list_opt2{i+4,1};
     
%      date1=a(1:6);
%      date2=a(8:end);
    
    %Tbaseline=num2str(datenum(date2,'yymmdd')-datenum(date1,'yymmdd'));

    eval(['!cp ./Automatic_S2.sh ./Automatic_S2_im_run_' a1(1:8) '_' a5(10:end) '.sh']);
    
    eval(['!sed -i ''' '3s/i1/' a1 '/' ''' Automatic_S2_im_run_' a1(1:8) '_' a5(10:end) '.sh']);
    
    eval(['!sed -i ''' '6s/i2/' a2 '/' ''' Automatic_S2_im_run_' a1(1:8) '_' a5(10:end) '.sh']);
    
    eval(['!sed -i ''' '9s/i3/' a3 '/' ''' Automatic_S2_im_run_' a1(1:8) '_' a5(10:end) '.sh']);
        
    eval(['!sed -i ''' '12s/i4/' a4 '/' ''' Automatic_S2_im_run_' a1(1:8) '_' a5(10:end) '.sh']);
        
    eval(['!sed -i ''' '15s/i5/' a5 '/' ''' Automatic_S2_im_run_' a1(1:8) '_' a5(10:end) '.sh']);
    

i
end

%%%## Stacking:

% cd /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing
% clear all
pathsate_stack=['/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing_150_150/'];
destination_stack=['/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing_150_150/STACK/'];
d_stack=dir(pathsate_stack);
j=1;
for i=1:length(d_stack);
    name=d_stack(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_stack(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_stack i j name

j=1;
for i=1:size(list_stack,1);
    path1=[pathsate_stack list_stack{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    dest=[destination_stack];    
    %eval(['!mkdir ' dest]);

    date=list_stack{i,1};
   n_S2_150x150(j,1) = datenum(date(1:8),'yyyymmdd');
   n_S2_150x150(j,2)=  datenum(date(10:17),'yyyymmdd');
  
    
cd(path1);

  eval( ['!cp ./VEL_m_*.tif ' dest]);
  eval( ['!cp ./SNR*.tif ' dest]);
  eval( ['!cp ./master*.tif ' dest]);

  Vel_S2_JAK_DuFil(:,:,j)=imread(['VEL_m_y_' date '.DuFil.tif']);
  Vel_S2_JAK_150x150(:,:,j)=imread(['VEL_m_y_' date '.tif']);
  SNR_S2_JAK(:,:,j)=imread(['SNR_' date '.tif']);

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


[im,R_S2]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing_150_150/STACK/VEL_m_y_20170729_20170808.DuFil.tif');
clear im


Vel_S2_JAK_DuFil(Vel_S2_JAK_DuFil==0)=nan;


% Extracting the profiles:

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



for i=1:size(Vel_S2_JAK_150x150,3)

vs2p1(:,i)=profile_ext_mean(Xp1,Yp1,Vel_S2_JAK_DuFil(:,:,i),R_S2,7);
vs2p2(:,i)=profile_ext_mean(Xp2,Yp2,Vel_S2_JAK_DuFil(:,:,i),R_S2,7);
vs2p3(:,i)=profile_ext_mean(Xp3,Yp3,Vel_S2_JAK_DuFil(:,:,i),R_S2,7);
vs2p4(:,i)=profile_ext_mean(Xp4,Yp4,Vel_S2_JAK_DuFil(:,:,i),R_S2,7);
vs2p5(:,i)=profile_ext_mean(Xp5,Yp5,Vel_S2_JAK_DuFil(:,:,i),R_S2,7);
vs2p6(:,i)=profile_ext_mean(Xp6,Yp6,Vel_S2_JAK_DuFil(:,:,i),R_S2,7);

end


%%
%%
%%

velp1=imread('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing/20160721_20160724/VEL_m_y_20160721_20160724_DuFil.tif');
velp2=imread('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing_150_150/20160721_20160724/VEL_m_y_20160721_20160724.DuFil.tif');

figure;
imagesc(velp2-velp1)

imagesc(velp1)

figure
imagesc(velp2)


for i=1:25
    
    figure(2)
    subplot(5,5,i)
    h=imagesc(Vel_S2_JAK_DuFil(:,:,i)); tt=double(~isnan(Vel_S2_JAK_DuFil(:,:,i))); set(h,'AlphaData', tt);
    colormap jet
    caxis([0 8000])
    title([datestr(n_S2_150x150(i,2),'ddmmmyy')])
    
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
    h=imagesc(Vel_S2_JAK_DuFil(:,:,i)); tt=double(~isnan(Vel_S2_JAK_DuFil(:,:,i))); set(h,'AlphaData', tt);
    colormap jet
    caxis([0 8000])
    title([datestr(n_S2_150x150(i,2),'ddmmmyy')])
%     
%     figure(4)
%     subplot(5,5,j)
%     plot(dist_if_JAK,prof_curve_JAK_S2(:,i),'.')
%     ylim([0 18000])
%     xlim([-7 43])
%     title([datestr(n_S2(i,2),'ddmmmyy')])
     j=j+1;
end





for i=1:25
    
    figure(1)
    subplot(5,5,i)
    
    h=imagesc(nanmean(cat(3,Vel_S2_JAK_DuFil(:,:,i),Vel_S2_JAK(:,:,i)),3)); tt=double(~isnan(nanmean(cat(3,Vel_S2_JAK_DuFil(:,:,i),Vel_S2_JAK(:,:,i)),3))); set(h,'AlphaData', tt);
    
    colormap jet


    caxis([0 8000])
    title([datestr(n_S2_150x150(i,2),'ddmmmyy')])
    
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
    h=imagesc(nanmean(cat(3,Vel_S2_JAK_DuFil(:,:,i),Vel_S2_JAK(:,:,i)),3)); tt=double(~isnan(nanmean(cat(3,Vel_S2_JAK_DuFil(:,:,i),Vel_S2_JAK(:,:,i)),3))); set(h,'AlphaData', tt);
    colormap jet
    caxis([0 8000])
    title([datestr(n_S2_150x150(i,2),'ddmmmyy')])
%     
%     figure(4)
%     subplot(5,5,j)
%     plot(dist_if_JAK,prof_curve_JAK_S2(:,i),'.')
%     ylim([0 18000])
%     xlim([-7 43])
%     title([datestr(n_S2(i,2),'ddmmmyy')])
     j=j+1;
end


%% Plot of individual frames:

for i=1:size(Vel_S2_JAK,3)
    
    figure('units','centimeters','position',[0 0 15 15]);    %subplot(5,5,i)
    h=imagesc(Vel_S2_JAK(:,:,i)); tt=double(~isnan(Vel_S2_JAK(:,:,i))); set(h,'AlphaData', tt);
    colormap jet
    caxis([0 10000])
    colorbar
    title([datestr(n_S2_150x150(i,2),'ddmmmyy')])
    
%     figure(2)
%     subplot(5,5,i)
%     plot(dist_if_JAK,prof_curve_JAK_S2(:,i),'.')
%     ylim([0 18000])
%     xlim([-7 43])
%     title([datestr(n_S2(i,2),'ddmmmyy')])
eval(['print -djpeg -r300 /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/individual_frames/JAK_Frame' num2str(i)])
i
close all

end


pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/JAK_S2_Images/'];
%destination=['/nfs/a59/eeagdl/date/Available_Images/S1/Processing/IM_paper_processing/JAK/IV_Portal_JAK_updated/'];
d_opt=dir(pathsate_opt);
j=1;
for i=3:1:length(d_opt);
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, date);
end
clear d_opt i j name

for i=2:size(list_opt,1)
    
    im_name1=[pathsate_opt list_opt{i,1}];
    im_name2=[pathsate_opt list_opt{i+1,1}];

%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    dest=['/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/RawImages/'];    
    %eval(['!mkdir ' dest]);
   
im1=imread(im_name1);    
im2=imread(im_name2);    
    
    figure('units','centimeters','position',[0 0 35 10]);
    subplot(1,3,1)
    h=imagesc(im1); %tt=double(~isnan(Vel_S2_JAK(:,:,i))); set(h,'AlphaData', tt);
    colormap gray
    caxis([0 10000])
    axis off
    %title([im_name(67:74)])
    title([im_name1(75:82)])
    
    subplot(1,3,2)
    h=imagesc(im2); %tt=double(~isnan(Vel_S2_JAK(:,:,i))); set(h,'AlphaData', tt);
    colormap gray
    caxis([0 10000])
    axis off
    %title([im_name(67:74)])
    title([im_name2(75:82)])

    subplot(1,3,3)
    h=imagesc(Vel_S2_JAK(:,:,i)); tt=double(~isnan(Vel_S2_JAK(:,:,i))); set(h,'AlphaData', tt);
    colormap(gca,jet);
    caxis([0 10000])
    cb=colorbar('location','east')
    set(cb, 'Position',[0.946334089191232 0.144620811287478 0.016124968505921 0.758377425044092])
    title([im_name1(75:82) '-' im_name2(75:82)])

    
%     figure(2)
%     subplot(5,5,i)
%     plot(dist_if_JAK,prof_curve_JAK_S2(:,i),'.')
%     ylim([0 18000])
%     xlim([-7 43])
%     title([datestr(n_S2(i,2),'ddmmmyy')])
eval(['print -djpeg -r300 /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/RawImages/JAK_Frame_' im_name1(75:82) '_' im_name2(75:82)])
i
close all

end


%% Median Filter
for i=14:size(Vel_S2_JAK,3)
vel_S2_med11W(:,:,i)=nanmedfilt2(Vel_S2_JAK(:,:,i),[11 11]);
end

k=1;
for j=[1:length(Y_pts_S2_Joughin_JAK_Npts)]
for i=1:size(Vel_S2_JAK,3)

    pt_S2_Joughin_JAK_Npts_medFilt(i,k)=profile_ext(X_pts_S2_Joughin_JAK_Npts(1,j),Y_pts_S2_Joughin_JAK_Npts(1,j),vel_S2_med11W(:,:,i),R_S2_JAK);
    %pt_Error_TSX_Joughin_JAK_Npts_updated(i,k)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,j),Y_pts_TSX_Joughin_JAK_Npts(1,j),Error_TSX_updated(:,:,i),R_TSX,12);

end
k=k+1;
end



figure
j=1;
for i=pts_trunk
h(j)=plot(n_S2(good,2),pt_S2_Joughin_JAK_Npts_medFilt(good,i),'LineStyle','none','MarkerSize',15,'Marker','.'); hold on
j=j+1;

end

for i=pts_trunk
h(k)=plot(n_sorted_update(:,1),pt_TSX_Joughin_JAK_Npts_updated(:,i),'Marker','square','MarkerSize',5,'LineStyle','none','MarkerEdgeColor',[0.503 0.503 0.503],'color',[0.503 0.503 0.503]);hold on;%pad15
end

legend([h(1:size(pts_trunk,2))],name_JAK_pts{pts_trunk})
xlim([datenum('122014','mmyyyy')  datenum('102017','mmyyyy')])
datetick('x','yyyy','keeplimits');
ylabel('Velocity [m/yr]','fontsize',14,'fontweight','b')
set(gca,'XGrid','on','YAxisLocation','left')
print -djpeg -r300 /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/ifSji_pts_JAK_Sentinel2_MedFilt_W11




for i=1:25
    
    figure(1)
    subplot(5,5,i)
    
    h=imagesc(vel_S2_med11W(:,:,i)); tt=double(~isnan(vel_S2_med11W(:,:,i))); set(h,'AlphaData', tt);
    
    colormap jet


    caxis([0 8000])
    title([datestr(n_S2_150x150(i,2),'ddmmmyy')])

end


%% Mean of both processings:

vel_mean_process=Vel_S2_JAK

for i=1:size(Vel_S2_JAK,3)
vel_mean_process(:,:,i)=nanmean(cat(3,Vel_S2_JAK_DuFil(:,:,i),Vel_S2_JAK(:,:,i)),3);
end


k=1;
for j=[1:length(Y_pts_S2_Joughin_JAK_Npts)]
for i=1:size(Vel_S2_JAK,3)

    pt_S2_Joughin_JAK_Npts_mean_process(i,k)=profile_ext(X_pts_S2_Joughin_JAK_Npts(1,j),Y_pts_S2_Joughin_JAK_Npts(1,j),vel_mean_process(:,:,i),R_S2_JAK);
    %pt_Error_TSX_Joughin_JAK_Npts_updated(i,k)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,j),Y_pts_TSX_Joughin_JAK_Npts(1,j),Error_TSX_updated(:,:,i),R_TSX,12);

end
k=k+1;
end



figure
j=1;
for i=pts_trunk
h(j)=plot(n_S2(good,2),pt_S2_Joughin_JAK_Npts_mean_process(good,i),'LineStyle','none','MarkerSize',15,'Marker','.'); hold on
j=j+1;

end

for i=pts_trunk
h(k)=plot(n_sorted_update(:,1),pt_TSX_Joughin_JAK_Npts_updated(:,i),'Marker','square','MarkerSize',5,'LineStyle','none','MarkerEdgeColor',[0.503 0.503 0.503],'color',[0.503 0.503 0.503]);hold on;%pad15
end

legend([h(1:size(pts_trunk,2))],name_JAK_pts{pts_trunk})
xlim([datenum('122014','mmyyyy')  datenum('102017','mmyyyy')])
datetick('x','yyyy','keeplimits');
ylabel('Velocity [m/yr]','fontsize',14,'fontweight','b')
set(gca,'XGrid','on','YAxisLocation','left')
% print -djpeg -r300 /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/ifSji_pts_JAK_Sentinel2_MedFilt_W11




%%

k=1;
for j=[1:length(Y_pts_S2_Joughin_JAK_Npts)]
for i=1:size(Vel_S2_JAK,3)

    pt_S2_Joughin_JAK_Npts_150(i,k)=profile_ext_mean(X_pts_S2_Joughin_JAK_Npts(1,j),Y_pts_S2_Joughin_JAK_Npts(1,j),Vel_S2_JAK_DuFil(:,:,i),R_S2_JAK,9);
    %pt_Error_TSX_Joughin_JAK_Npts_updated(i,k)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,j),Y_pts_TSX_Joughin_JAK_Npts(1,j),Error_TSX_updated(:,:,i),R_TSX,12);

end
k=k+1;
end

 CM_PGs=['k' ; 'r'];

figure(1)
subplot(211)
j=3;k=1;
for i=[28]% 18 20]
  h(k)=plot(n_sorted_update(:,1),pt_TSX_Joughin_JAK_Npts_updated(:,i),'Marker','square','MarkerSize',5,'LineStyle','none','MarkerEdgeColor',[0.503 0.503 0.503],'color',[0.503 0.503 0.503]);hold on;%pad15
%  j=j+1;
k=k+1;
end
plot(n_S2(good,2),pt_S2_Joughin_JAK_Npts_150(good,28),'Marker','square','MarkerSize',5,'LineStyle','none','MarkerEdgeColor',[1 128/255 0],'MarkerFaceColor',[1 128/255 0]); hold on

ylim([7000 19000])
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

ylim([2500 9000])

plot(n_S2(good,2),pt_S2_Joughin_JAK_Npts_150(good,11),'Marker','square','MarkerSize',5,'LineStyle','none','MarkerEdgeColor',[1 128/255 0],'MarkerFaceColor',[1 128/255 0]); hold on
plot(n_S2(good,2),pt_S2_Joughin_JAK_Npts_150(good,17),'Marker','square','MarkerSize',5,'LineStyle','none','MarkerEdgeColor',[153/255 51/255 1],'MarkerFaceColor',[153/255 51/255 1]); hold on

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



pts_trunk=[11:14, 16:20, 25, 28:31]
pts_trunk=[11, 14, 17,18, 20] 28:31]
pts_trunk=[28:31]

figure
j=1;
for i=pts_trunk
h(j)=plot(n_S2(good,2),pt_S2_Joughin_JAK_Npts(good,i),'LineStyle','none','MarkerSize',15,'Marker','.'); hold on
j=j+1;

end

for i=pts_trunk
h(k)=plot(n_sorted_update(:,1),pt_TSX_Joughin_JAK_Npts_updated(:,i),'Marker','square','MarkerSize',5,'LineStyle','none','MarkerEdgeColor',[0.503 0.503 0.503],'color',[0.503 0.503 0.503]);hold on;%pad15
end

legend([h(1:size(pts_trunk,2))],name_JAK_pts{pts_trunk})
xlim([datenum('122014','mmyyyy')  datenum('102017','mmyyyy')])
datetick('x','yyyy','keeplimits');
ylabel('Velocity [m/yr]','fontsize',14,'fontweight','b')
set(gca,'XGrid','on','YAxisLocation','left')


%% Different Time steps Tests:

cd /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing_150_150/Diff_TimeSteps


[V6days_filt,R6days]=geotiffread('VEL_m_y_20160708_20160714.DuFil.tif');
[V6days,R6days]=geotiffread('VEL_m_y_20160708_20160714.tif');

cd /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing_150_150/Diff_TimeSteps/20160708_20160718
[V10days_filt,R10days]=geotiffread('VEL_m_y_20160708_20160718.DuFil.tif');
[V10days,R10days]=geotiffread('VEL_m_y_20160708_20160718.tif');

cd /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing_150_150/Diff_TimeSteps/20160708_20160721
[V13days_filt,R13days]=geotiffread('VEL_m_y_20160708_20160721.DuFil.tif');
[V13days,R13days]=geotiffread('VEL_m_y_20160708_20160721.tif');

cd /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing_150_150/Diff_TimeSteps/20160708_20160724
[V16days_filt,R16days]=geotiffread('VEL_m_y_20160708_20160724.DuFil.tif');
[V16days,R16days]=geotiffread('VEL_m_y_20160708_20160724.tif');

V6days_filt(V6days_filt<=0)=nan;
V10days_filt(V10days_filt<=0)=nan;
V13days_filt(V13days_filt<=0)=nan;
V16days_filt(V16days_filt<=0)=nan;

V6days(V6days<=0)=nan;
V10days(V10days<=0)=nan;
V13days(V13days<=0)=nan;
V16days(V16days<=0)=nan;

%%% Plot Filtered:

figure('units','centimeters','position',[0 0 35 8]);
subplot(141)
h=imagesc(V6days_filt); tt=double(~isnan(V6days_filt)); set(h,'AlphaData', tt);
caxis([0 14000])
colormap jet
axis off
title('6 days','fontsize',14)

subplot(142)
h=imagesc(V10days_filt); tt=double(~isnan(V10days_filt)); set(h,'AlphaData', tt);
caxis([0 14000])
colormap jet
axis off
title('10 days','fontsize',14)


subplot(143)
h=imagesc(V13days_filt); tt=double(~isnan(V13days_filt)); set(h,'AlphaData', tt);
caxis([0 14000])
colormap jet
axis off
title('13 days','fontsize',14)

subplot(144)
h=imagesc(V16days_filt); tt=double(~isnan(V16days_filt)); set(h,'AlphaData', tt);
caxis([0 14000])
colormap jet
axis off
title('16 days','fontsize',14)
colorbar('location','east')
set(gca,'fontsize',14)

print -dpng -r600 /nfs/a59/eeagdl/Figures_temp/S2_JAK/DiffTimeSteps_S2_JAK_Filtered

%%% Not filtered:

figure('units','centimeters','position',[0 0 35 8]);
subplot(141)
h=imagesc(V6days); tt=double(~isnan(V6days)); set(h,'AlphaData', tt);
caxis([0 14000])
colormap jet
axis off
title('6 days','fontsize',14)

subplot(142)
h=imagesc(V10days); tt=double(~isnan(V10days)); set(h,'AlphaData', tt);
caxis([0 14000])
colormap jet
axis off
title('10 days','fontsize',14)


subplot(143)
h=imagesc(V13days); tt=double(~isnan(V13days)); set(h,'AlphaData', tt);
caxis([0 14000])
colormap jet
axis off
title('13 days','fontsize',14)

subplot(144)
h=imagesc(V16days); tt=double(~isnan(V16days)); set(h,'AlphaData', tt);
caxis([0 14000])
colormap jet
axis off
title('16 days','fontsize',14)
colorbar
set(gca,'fontsize',14)

print -dpng -r600 /nfs/a59/eeagdl/Figures_temp/S2_JAK/DiffTimeSteps_S2_JAK




%%%% Compare coverage S2 vs S1


maskS2=imread('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/QGis_S2/Mask_S2_JAK_raster.tif');

figure
imagesc(maskS2)

temp=V6days_filt;
temp(maskS2==0)=nan;


imagesc(temp)




