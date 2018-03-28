%% D30_Oct_2016

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D30_Oct_2016/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D30_Oct_2016/'];
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
for i=1:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    dest=[destination];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*zip ' dest]);

i
end

for i=1:16
    
    eval(['!mkdir ./i' num2str(i)]);
    
end
    
%

 pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D30_Oct_2016/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D30_Oct_2016/'];
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

j=3;
for i=1:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1} '/'];
    cd(path1)
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    d=dir(pwd);
    name1=d(j,1).name; name1=name1(end-7:end-4);
    name2=d(j+1,1).name; name2=name2(end-7:end-4);
    
    !cp ../S1_running_PIG.sh ./
    
    eval(['!sed -i ''' '9s/D9D4/' name1 '/' ''' S1_running_PIG.sh'])
    eval(['!sed -i ''' '10s/78D9/' name2 '/' ''' S1_running_PIG.sh'])
    
    %dest=[destination];    
    %eval(['!mkdir ' dest]);

i
end










%% D120_2016

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D120_2016/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D120_2016/'];
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
for i=1:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    dest=[destination];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*zip ' dest]);

i
end

cd(pathsate_opt)

for i=1:14
    
    eval(['!mkdir ./i' num2str(i)]);
    
end


%

%  pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D30_Oct_2016/'];
% destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D30_Oct_2016/'];
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

j=3;
for i=1:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1} '/'];
    cd(path1)
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    d=dir(pwd);
    name1=d(j,1).name; name1=name1(end-7:end-4);
    name2=d(j+1,1).name; name2=name2(end-7:end-4);
    
    !cp ../S1_running_PIG.sh ./
    
    eval(['!sed -i ''' '9s/D9D4/' name1 '/' ''' S1_running_PIG.sh'])
    eval(['!sed -i ''' '10s/78D9/' name2 '/' ''' S1_running_PIG.sh'])
    
    %dest=[destination];    
    %eval(['!mkdir ' dest]);

i
end


%% D240_2016

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D240_2016/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D240_2016/'];
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
for i=1:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    dest=[destination];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*zip ' dest]);

i
end

cd(pathsate_opt)

for i=1:13
    
    eval(['!mkdir ./i' num2str(i)]);
    
end


%

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D240_2016/'];
% destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D30_Oct_2016/'];
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

j=3;
for i=1:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1} '/'];
    cd(path1)
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    d=dir(pwd);
    name1=d(j,1).name; name1=name1(end-7:end-4);
    name2=d(j+1,1).name; name2=name2(end-7:end-4);
    
    !cp ../S1_running_PIG.sh ./
    
    eval(['!sed -i ''' '9s/D9D4/' name1 '/' ''' S1_running_PIG.sh'])
    eval(['!sed -i ''' '10s/78D9/' name2 '/' ''' S1_running_PIG.sh'])
    
    %dest=[destination];    
    %eval(['!mkdir ' dest]);

i
end

%%
for i=1:14
    
    eval(['!mkdir ./i' num2str(i)]);
    
end

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D120_D240/'];
pathsate_opt1=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D120_2016/'];
pathsate_opt2=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D240_2016/'];

destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D120_D240/'];
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

date1=num2str('20160427')
date2=num2str('20160825')


for i=1:size(list_opt,1);
    path=[pathsate_opt list_opt{i,1} '/'];
    path1=[pathsate_opt1 list_opt{i,1} '/'];
    path2=[pathsate_opt2 list_opt{i,1} '/'];
  

    %date=list_opt{i,1};

    %cd(path1);

 eval( ['!cp ' path1 '*' date1 '*.zip ' path]);
 eval( ['!cp ' path2 '*' date2 '*.zip ' path]);

i
end

Tbaseline=num2str(datenum(date2,'yyyymmdd')-datenum(date1,'yyyymmdd'));
%

j=3;
for i=2:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1} '/'];
    cd(path1)
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    d=dir(pwd);
    name1=d(j,1).name; name1=name1(end-7:end-4);
    name2=d(j+1,1).name; name2=name2(end-7:end-4);
    
    !cp ../S1_running_PIG.sh ./
    
    eval(['!sed -i ''' '4s/20160427/' date1 '/' ''' S1_running_PIG.sh'])
    eval(['!sed -i ''' '5s/20160825/' date2 '/' ''' S1_running_PIG.sh'])

    eval(['!sed -i ''' '9s/D642/' name1 '/' ''' S1_running_PIG.sh'])
    eval(['!sed -i ''' '10s/3B97/' name2 '/' ''' S1_running_PIG.sh'])
    
    eval(['!sed -i ''' '36s/120/' Tbaseline '/' ''' S1_running_PIG.sh'])
   
    %dest=[destination];    
    %eval(['!mkdir ' dest]);

i
end


%%
for i=1:14
    
    eval(['!mkdir ./i' num2str(i)]);
    
end

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D120_D180/'];
pathsate_opt1=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D120_2016/'];
pathsate_opt2=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D180_2016/'];

destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D120_D180/'];
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

date1=num2str('20160415')
date2=num2str('20160614')

%36 days
% date1=num2str('20160427')
% date2=num2str('20160602')

for i=1:size(list_opt,1);
    path=[pathsate_opt list_opt{i,1} '/'];
    path1=[pathsate_opt1 list_opt{i,1} '/'];
    path2=[pathsate_opt2 list_opt{i,1} '/'];
  

    %date=list_opt{i,1};

    %cd(path1);

 eval( ['!cp ' path1 '*' date1 '*.zip ' path]);
 eval( ['!cp ' path2 '*' date2 '*.zip ' path]);

i
end

Tbaseline=num2str(datenum(date2,'yyyymmdd')-datenum(date1,'yyyymmdd'));
%

j=3;
for i=1:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1} '/'];
    cd(path1)
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    d=dir(pwd);
    name1=d(j,1).name; name1=name1(end-7:end-4);
    name2=d(j+1,1).name; name2=name2(end-7:end-4);
    
    !cp ../S1_running_PIG.sh ./
    
    eval(['!sed -i ''' '4s/20160427/' date1 '/' ''' S1_running_PIG.sh'])
    eval(['!sed -i ''' '5s/20160825/' date2 '/' ''' S1_running_PIG.sh'])

    eval(['!sed -i ''' '9s/D642/' name1 '/' ''' S1_running_PIG.sh'])
    eval(['!sed -i ''' '10s/3B97/' name2 '/' ''' S1_running_PIG.sh'])
    
    eval(['!sed -i ''' '36s/120/' Tbaseline '/' ''' S1_running_PIG.sh'])
   
    %dest=[destination];    
    %eval(['!mkdir ' dest]);

i
end



%%
for i=1:14
    
    eval(['!mkdir ./i' num2str(i)]);
    
end

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D170_2017/'];
pathsate_opt1=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Summer_2017/'];
%pathsate_opt2=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D240_2016/'];

destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D170_2017/'];
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

date1=num2str('20170528')
date2=num2str('20170603')


for i=2:size(list_opt,1);
    %path=[pathsate_opt];
    path=[pathsate_opt list_opt{i,1} '/'];
  
    %path1=[pathsate_opt1 list_opt{i,1} '/'];
    %path2=[pathsate_opt2 list_opt{i,1} '/'];
  

    %date=list_opt{i,1};

    %cd(path1);

 eval( ['!mv ' path '*.zip ' destination]);
 %eval( ['!mv ' path2 '*' date2 '*.zip ' path]);

i
end

Tbaseline=num2str(datenum(date2,'yyyymmdd')-datenum(date1,'yyyymmdd'));
%

j=3;
for i=1:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1} '/'];
    cd(path1)
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    d=dir(pwd);
    name1=d(j,1).name; name1=name1(end-7:end-4);
    name2=d(j+1,1).name; name2=name2(end-7:end-4);
    
    !cp ../S1_running_PIG.sh ./
    
    eval(['!sed -i ''' '4s/20160427/' date1 '/' ''' S1_running_PIG.sh'])
    eval(['!sed -i ''' '5s/20160825/' date2 '/' ''' S1_running_PIG.sh'])

    eval(['!sed -i ''' '9s/D642/' name1 '/' ''' S1_running_PIG.sh'])
    eval(['!sed -i ''' '10s/3B97/' name2 '/' ''' S1_running_PIG.sh'])
    
    eval(['!sed -i ''' '36s/120/' Tbaseline '/' ''' S1_running_PIG.sh'])
   
    %dest=[destination];    
    %eval(['!mkdir ' dest]);

i
end




%%
[SAR_mosaic]=imread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/SAR_100mCbandmultiyearSigma.tif');
[Summer_2016_minus_winter_2017,Rs16_w17]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/SUMMER_2016_minus_WINTER_jan2017.tiff');
Rsar=Rs16_w17;

clear Summer_2016_minus_winter_2017 Rs16_w17

xSAR=[Rsar.XWorldLimits(1):Rsar.CellExtentInWorldX:Rsar.XWorldLimits(2)-Rsar.CellExtentInWorldX];
ySAR=[Rsar.YWorldLimits(1):Rsar.CellExtentInWorldY:Rsar.YWorldLimits(2)-Rsar.CellExtentInWorldY];
[XSAR,YSAR] = meshgrid(xSAR,ySAR);


% figure
% h=imagesc(Summer_2016_minus_winter_2017); tt=double(~isnan(Summer_2016_minus_winter_2017)); set(h,'AlphaData', tt);
% caxis([-200 200]);

CT=cbrewer('div', 'RdYlGn',9);
colormap(flip(CT))
cb=colorbar
set(cb,'XTick',[-200:100:200],'Xticklabel',[])

CT=cbrewer('div', 'RdYlBu',9);
colormap(flip(CT))
cb=colorbar
set(cb,'XTick',[-200:100:200])


imshow(SAR_mosaic)
caxis([-30 -3.44625])

h(1)=imagesc(xSAR,ySAR,flipud(SAR_mosaic));
caxis([-30 -3.44625])
colormap(gray)
hold on
plot(X_coast,Y_coast,'k')
set(gca,'Ydir','Normal')


xlim([-500000 50000])
ylim([-3500000 -500000])

h(2)=imagesc(xd300,yd300,winter_mean); tt=double(~isnan(winter_mean)); set(h(2),'AlphaData', tt);
imagesc(xd300,yd300,winter_mean);
hold off

CT=cbrewer('div', 'RdYlGn',9);
colormap(flip(CT))
cb=colorbar


% Create two axes
ax1 = axes;
imagesc(ax1,xSAR,ySAR,flipud(SAR_mosaic));
set(ax1,'Ydir','Normal')
ax2 = axes;
h=imagesc(ax2,xd300,yd300,winter_mean); tt=double(~isnan(winter_mean)); set(h,'AlphaData', tt);

% Link them together
linkaxes([ax1,ax2])
% Hide the top axes
ax2.Visible = 'off';
ax2.XTick = [];
ax2.YTick = [];
% Give each one its own colormap
colormap(ax1,'gray')
colormap(ax2,flip(CT))


caxis(ax1,[-30 -3.44625])
caxis(ax2,[0 500]);

xlim(ax1,[-500000 50000])
ylim(ax1,[-3500000 -500000])

xlim(ax2,[-500000 50000])
ylim(ax2,[-3500000 -500000])


% Then add colorbars and get everything lined up
set([ax1,ax2],'Position',[.17 .11 .685 .815]);
cb1 = colorbar(ax1,'Position',[.05 .11 .0675 .815]);
cb2 = colorbar(ax2,'Position',[.88 .11 .0675 .815]);




% 
% [d120,Rd120]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D120_2016/D120_2016_mosaic.tiff');
% 
% [d240,Rd240]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D240_2016/D240_2016_mosaic.tiff');
% 
% d240(d240==-99999)=nan;

G_coastline=shaperead('/nfs/a59/eeagdl/DATABASE/GREENLAND/Coastline/Greenland_Cosatline.shp');

X_coast=extractfield(G_coastline,'X');
Y_coast=extractfield(G_coastline,'Y');


xd240=[Rd240.XWorldLimits(1):Rd240.CellExtentInWorldX:Rd240.XWorldLimits(2)-Rd240.CellExtentInWorldX];
yd240=[Rd240.YWorldLimits(1):Rd240.CellExtentInWorldY:Rd240.YWorldLimits(2)-Rd240.CellExtentInWorldY];
[Xd240,Yd240] = meshgrid(xd240,yd240);



title('Day 240','fontsize',14,'fontweight','bold');
plot(X_coast,Y_coast,'k')
hold on
h=imagesc(xd240,flip(yd240),d240); tt=double(~isnan(d240)); set(h,'AlphaData', tt);
xlim([-500000 50000])
ylim([-3500000 -500000])
cb=colorbar('location','north');
xlabel(cb,'[m yr^{-1}]','fontsize',14,'fontweight','bold')
set(gca,'fontsize',14)



%%%
% Summer
!gdal_merge.py -n 0 -a_nodata -99999 -separate -of GTiff -o /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D180_2016_2017.tiff /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D180_2016/D180_2016_mosaic.tiff /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Summer_2017/D180_2017_mosaic.tiff

% Winter
!gdal_merge.py -n 0 -a_nodata -99999 -separate -of GTiff -o /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D300_2016_D20_2017.tiff /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D300_2016/D300_2016_mosaic.tiff /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Winter_jan2017/D20_2017_mosaic.tiff /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D300_2016/12days/D300_12days_2016_mosaic.tiff



[d180,Rd180]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D180_2016_2017.tiff');
d180(d180==-99999)=nan;
summer_mean=nanmean(d180,3);

info_d180 = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D180_2016_2017.tiff');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D180_2016_2017_mean.tif', summer_mean, Rd180,'GeoKeyDirectoryTag',info_d180.GeoTIFFTags.GeoKeyDirectoryTag);


[d300_20,Rd_300_20]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D300_2016_D20_2017_2.tiff');
d300_20(d300_20==-99999)=nan;
winter_mean=nanmean(d300_20,3);

info_d300_d20 = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D300_2016_D20_2017.tiff');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D300_2016_D20_2017_mean.tif', winter_mean, Rd_300_20,'GeoKeyDirectoryTag',info_d300_d20.GeoTIFFTags.GeoKeyDirectoryTag);

geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Summer_mean_MINUS_Winter_mean.tif', S_minus_W, Rd_300_20,'GeoKeyDirectoryTag',info_d300_d20.GeoTIFFTags.GeoKeyDirectoryTag);



xd300=[Rd_300_20.XWorldLimits(1):Rd_300_20.CellExtentInWorldX:Rd_300_20.XWorldLimits(2)-Rd_300_20.CellExtentInWorldX];
yd300=[Rd_300_20.YWorldLimits(1):Rd_300_20.CellExtentInWorldY:Rd_300_20.YWorldLimits(2)-Rd_300_20.CellExtentInWorldY];
[XSAR,YSAR] = meshgrid(xSAR,ySAR);







h=imagesc(winter_mean); tt=double(~isnan(winter_mean)); set(h,'AlphaData', tt);
caxis([0 500]);
CT=cbrewer('div', 'RdYlGn',9);
colormap(flip(CT))
cb=colorbar





h=imagesc(summer_mean); tt=double(~isnan(summer_mean)); set(h,'AlphaData', tt);
caxis([0 500]);
CT=cbrewer('div', 'RdYlGn',9);
colormap(flip(CT))
cb=colorbar






h=imagesc(summer_mean(2:end,:,:)-winter_mean); tt=double(~isnan(summer_mean(2:end,:,:)-winter_mean)); set(h,'AlphaData', tt);
caxis([-150 150]);
CT=cbrewer('div', 'RdYlBu',9);
colormap(flip(CT))
cb=colorbar

S_minus_W=summer_mean(2:end,:,:)-winter_mean;
