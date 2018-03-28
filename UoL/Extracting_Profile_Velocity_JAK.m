pathsate=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/'];
d=dir(pathsate);
j=1;
for i=4:length(d);
    name=d(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d i j name

d=char([data{:}]);
% date2=datenum(str2num(d(:,1:4)),str2num(d(:,5:6)),str2num(d(:,7:8)));


prof_shp = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/ArcGIS/Profiles/Profile_JAK/New_prof_JAK.shp');
X_p=extractfield(prof_shp,'X');
Y_p=extractfield(prof_shp,'Y');

X_p=X_p(~isnan(X_p));
Y_p=Y_p(~isnan(Y_p));

points_shp = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/ArcGIS/Profiles/Profile_JAK/Profile_Points.shp');
X_points=extractfield(points_shp,'X');
Y_points=extractfield(points_shp,'Y');

%%% Points_Joughin
points_shp = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/ArcGIS/Profiles/Profile_JAK/Profile_Joughin/Points_Joughin.shp');
X_points=extractfield(points_shp,'X');
Y_points=extractfield(points_shp,'Y');

%%% Profile_Joughin
prof_shp = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/ArcGIS/Profiles/Profile_JAK/Profile_Joughin/Profile_Joughin.shp');
X_p=extractfield(prof_shp,'X');
Y_p=extractfield(prof_shp,'Y');



% %Importing the NSIDC Greenland velocity map and extracting the data along the profile:
% 
[NSIDC_map,Rnsidc]=geotiffread('/nfs/a59/eeagdl/Data/Velocity_NSIDC/greenland_vel_mosaic500_2008_2009_sp.tif');
[NSIDC_map_2000,Rnsidc_2000]=geotiffread('/nfs/a59/eeagdl/Data/Velocity_NSIDC/greenland_vel_mosaic500_2000_2001_v2.tif');
[NSIDC_map_2005,Rnsidc_2005]=geotiffread('/nfs/a59/eeagdl/Data/Velocity_NSIDC/greenland_vel_mosaic500_2005_2006_v2.tif');
[NSIDC_map_2007,Rnsidc_2007]=geotiffread('/nfs/a59/eeagdl/Data/Velocity_NSIDC/greenland_vel_mosaic500_2007_2008_v2.tif');
[NSIDC_map_2008,Rnsidc_2008]=geotiffread('/nfs/a59/eeagdl/Data/Velocity_NSIDC/greenland_vel_mosaic500_2008_2009_v2.tif');
[NSIDC_map_2009,Rnsidc_2009]=geotiffread('/nfs/a59/eeagdl/Data/Velocity_NSIDC/greenland_vel_mosaic500_2009_2010_v2.tif');


[row_NSIDC_2000,col_NSIDC_2000]=map2pix(Rnsidc_2000,X_p,Y_p);NSIDC_map_2000(NSIDC_map_2000<=0)=nan;
prof_NSIDC_2000=improfile(NSIDC_map_2000,col_NSIDC_2000(~isnan(col_NSIDC_2000)),row_NSIDC_2000(~isnan(row_NSIDC_2000)));

[row_NSIDC_2005,col_NSIDC_2005]=map2pix(Rnsidc_2005,X_p,Y_p);NSIDC_map_2005(NSIDC_map_2005<=0)=nan;
prof_NSIDC_2005=improfile(NSIDC_map_2005,col_NSIDC_2005(~isnan(col_NSIDC_2005)),row_NSIDC_2005(~isnan(row_NSIDC_2005)));

[row_NSIDC_2007,col_NSIDC_2007]=map2pix(Rnsidc_2007,X_p,Y_p);NSIDC_map_2007(NSIDC_map_2007<=0)=nan;
prof_NSIDC_2007=improfile(NSIDC_map_2007,col_NSIDC_2007(~isnan(col_NSIDC_2007)),row_NSIDC_2007(~isnan(row_NSIDC_2007)));

[row_NSIDC_2008,col_NSIDC_2008]=map2pix(Rnsidc_2008,X_p,Y_p);NSIDC_map_2008(NSIDC_map_2008<=0)=nan;
prof_NSIDC_2008=improfile(NSIDC_map_2008,col_NSIDC_2008(~isnan(col_NSIDC_2008)),row_NSIDC_2008(~isnan(row_NSIDC_2008)));

[row_NSIDC_2009,col_NSIDC_2009]=map2pix(Rnsidc_2009,X_p,Y_p);NSIDC_map_2009(NSIDC_map_2009<=0)=nan;
prof_NSIDC_2009=improfile(NSIDC_map_2009,col_NSIDC_2009(~isnan(col_NSIDC_2009)),row_NSIDC_2009(~isnan(row_NSIDC_2009)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Plotting the NSIDC data 

figure
plot(prof_NSIDC_2000,'.')
hold on
plot(prof_NSIDC_2005,'.')
plot(prof_NSIDC_2007,'.')
plot(prof_NSIDC_2008,'.')
plot(prof_NSIDC_2009,'.')
legend('00','05','07','08','09');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[row_NSIDC,col_NSIDC]=map2pix(Rnsidc,X_p,Y_p);
prof_NSIDC=improfile(NSIDC_map,col_NSIDC(~isnan(col_NSIDC)),row_NSIDC(~isnan(row_NSIDC)));

j=1;
for i=[1:11 13:length(list)];
    path1=[pathsate list{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    
    date=list{i,1};
    
cd(path1);

eval(['[Vel_map,Rs1]=geotiffread(''VEL_km_y_' date(1:17) '.tif'');']);
eval(['[ccp_map,Rs1_ccp]=geotiffread(''CCP_' date(1:17) '.tif'');']);

[row_S1,col_S1] = map2pix(Rs1,X_p,Y_p);
[row_S1_ccp,col_S1_ccp] = map2pix(Rs1_ccp,X_p,Y_p);

prof_S1=improfile(Vel_map,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));
prof_S1_ccp=improfile(ccp_map,col_S1_ccp(~isnan(col_S1_ccp)),row_S1(~isnan(row_S1_ccp)));

%%% Points

[row_S1_pt,col_S1_pt] = map2pix(Rs1,X_points,Y_points);
[row_S1_ccp_pt,col_S1_ccp_pt] = map2pix(Rs1_ccp,X_points,Y_points);

%%% o primeiro ponto, na realidade é o penultimo ponto do transecto (40km)

point_S1(:,j)=improfile(Vel_map,col_S1_pt(~isnan(col_S1_pt)),row_S1_pt(~isnan(row_S1_pt)),length(row_S1_pt));
point_S1_ccp(:,j)=improfile(ccp_map,col_S1_ccp_pt(~isnan(col_S1_ccp_pt)),row_S1_pt(~isnan(row_S1_ccp_pt)),length(row_S1_pt));


% %Importing the NSIDC Greenland velocity map and extracting the data along the profile:
% 
% % [NSIDC_map,Rnsidc]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/20141116_20141128_la_68/VEL_km_y_20141116_20141128.tif');
% % 
% % [row_NSIDC,col_NSIDC]=map2pix(Rnsidc,X_p,Y_p);
% % prof_NSIDC=improfile(NSIDC_map,col_NSIDC(~isnan(col_NSIDC)),row_NSIDC(~isnan(row_NSIDC)));

ccp=0.02;
dist=0:((0.047949*999)/(length(prof_S1)-1)):(0.047949*999);
% dist_nsidc=0:(160.75/(length(prof_S1)-1)):160.75;

B_=nan(2,3);
B_(:,1)=[-2;20000];
B_(:,2)=889*0.047949; % Ice front line position
B_(:,3)=782*0.047949; % profile angle

% Plots Profiles

%%% mov median 1km

figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
[hAx,hLine1,hLine2]=plotyy(dist(prof_S1_ccp>=ccp),(prof_S1(prof_S1_ccp>=ccp)*1000),dist(prof_S1_ccp>=ccp),(prof_S1_ccp(prof_S1_ccp>=ccp)));
hLine1.LineStyle = 'none';hLine1.Marker = '.'
hLine2.LineStyle = 'none';hLine2.Marker = '.'


ttt=['''JAK Profile ' date(1:8) '-' date(10:17) ''''];
eval(['title(' ttt ',''fontsize'',12,''fontweight'',''b'')']);
ylabel(hAx(1),'velocity [m.yr^{-1}]','fontsize',12,'fontweight','b')
ylabel(hAx(2),'Cross Correlation of each Patch','fontsize',12,'fontweight','b')

xlabel('distance [km]','fontsize',12,'fontweight','b')

hold on;
plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
%plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 (0.047949*999)+1]);
ylim(hAx(1),[0 11000]);
ylim(hAx(2),[0 0.5]);

set(gca,'XTick',[0:5:45])
set(hAx(1),'YTick',[0:2000:11000])
set(hAx(2),'YTick',[0:0.05:0.5])
grid on;
%legend([date(1:8) '-' date(10:17)]);

clear row* col* ccp_map* R* Vel* prof_S1*

eval(['print -dpng -r300 /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/Profiles/JAK/ccp_002/profile_' date(1:8) '-' date(10:17)])
%print -dpng -r300 /DADOS/Uni_Leeds/PG/profile_snr5_1km
close all
j=j+1;

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Extracting the points from Joughin 2014 calculating the median around
%%%the points

j=1;
for i=[1:11 13:length(list)];
    path1=[pathsate list{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    
    date=list{i,1};
    
cd(path1);

eval(['[Vel_map,Rs1]=geotiffread(''VEL_km_y_' date(1:17) '.tif'');']);
eval(['[ccp_map,Rs1_ccp]=geotiffread(''CCP_' date(1:17) '.tif'');']);

[row_S1,col_S1] = map2pix(Rs1,X_p,Y_p);
[row_S1_ccp,col_S1_ccp] = map2pix(Rs1_ccp,X_p,Y_p);

prof_S1=improfile(Vel_map,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));
prof_S1_ccp=improfile(ccp_map,col_S1_ccp(~isnan(col_S1_ccp)),row_S1(~isnan(row_S1_ccp)));

%%% Points

[row_S1_pt,col_S1_pt] = map2pix(Rs1,X_points,Y_points);
[row_S1_ccp_pt,col_S1_ccp_pt] = map2pix(Rs1_ccp,X_points,Y_points);

%%% o primeiro ponto, na realidade é o penultimo ponto do transecto (40km)

% point_S1(:,j)=improfile(Vel_map,col_S1_pt,row_S1_pt,length(row_S1_pt));
% point_S1_ccp(:,j)=improfile(ccp_map,col_S1_ccp_pt(~isnan(col_S1_ccp_pt)),row_S1_pt(~isnan(row_S1_ccp_pt)),length(row_S1_pt));


% 
% m=[];
% for rr=0;%[-2:2];
%    
%    pt_temp_row(:,j)=improfile(Vel_map,col_S1_pt,(row_S1_pt+rr),length(row_S1_pt));
%    pt_temp_col(:,j)=improfile(Vel_map,(col_S1_pt+rr),row_S1_pt,length(row_S1_pt));
%    m=[m pt_temp_row pt_temp_col];
% end

% point_S1(:,j)=mean(m,2);

eval(['point_S1(:,j)=improfile(Vel_map_' num2str(j) ',col_S1_pt,row_S1_pt,length(row_S1_pt));']);
eval(['point_S1_mov_med(:,j)=improfile(Vel_map_mov_med' num2str(j) ',col_S1_pt,row_S1_pt,length(row_S1_pt));']);

% %Importing the NSIDC Greenland velocity map and extracting the data along the profile:
% 
% % [NSIDC_map,Rnsidc]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/20141116_20141128_la_68/VEL_km_y_20141116_20141128.tif');
% % 
% % [row_NSIDC,col_NSIDC]=map2pix(Rnsidc,X_p,Y_p);
% % prof_NSIDC=improfile(NSIDC_map,col_NSIDC(~isnan(col_NSIDC)),row_NSIDC(~isnan(row_NSIDC)));

% ccp=0.05;
% dist=0:((0.047949*999)/(length(prof_S1)-1)):(0.047949*999);
% % dist_nsidc=0:(160.75/(length(prof_S1)-1)):160.75;
% 
% B_=nan(2,3);
% B_(:,1)=[-2;20000];
% B_(:,2)=889*0.047949; % Ice front line position
% B_(:,3)=782*0.047949; % profile angle
% 
% % Plots Profiles
% 
% %%% mov median 1km
% 
% figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
% plot(dist(prof_S1_ccp>=ccp),(prof_S1(prof_S1_ccp>=ccp)*1000),'.');
% title('JAK Profile','fontsize',12,'fontweight','b')
% ylabel('velocity [m.yr^{-1}]','fontsize',12,'fontweight','b')
% xlabel('distance [km]','fontsize',12,'fontweight','b')
% 
% hold on;
% plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
% %plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
% xlim([0 (0.047949*999)+1]);
% ylim([0 11000]);
% set(gca,'XTick',[0:5:45])
% grid on;
% %legend([date(1:8) '-' date(10:17)]);
% 
% clear row* col* ccp_map* R* Vel* prof_S1*
% 
% eval(['print -dpng -r300 /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/Profiles/JAK/ccp_005/profile_' date(1:8) '-' date(10:17)])
% %print -dpng -r300 /DADOS/Uni_Leeds/PG/profile_snr5_1km
% close all
j=j+1;

end

%% Test with the ltln2val

j=1;
for i=[1:11 13:length(list)];
    path1=[pathsate list{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    
    date=list{i,1};

cd(path1);

eval(['[Vel_map,Rs1]=geotiffread(''VEL_km_y_' date(1:17) '.tif'');']);
eval(['[ccp_map,Rs1_ccp]=geotiffread(''CCP_' date(1:17) '.tif'');']);
eval(['info=geotiffinfo(''VEL_km_y_' date(1:17) '.tif'');']);
ccp=0.02;
ii=find(ccp_map<=ccp);
Vel_map(ii)=nan;

%info = geotiffinfo('VEL_km_y_20160203_20160215.tif');
R = georasterref('RasterSize',size(Vel_map),'Latlim',[min(info.CornerCoords.Lat(:)) max(info.CornerCoords.Lat(:))],'Lonlim',[min(info.CornerCoords.Lon(:)) max(info.CornerCoords.Lon(:))],'ColumnsStartFrom','north');

Vel_map(Vel_map<=0)=nan;

%%% o primeiro ponto, na realidade é o penultimo ponto do transecto (40km)
point_S1(:,j)=ltln2val(Vel_map,R,PtJoughinlalo(:,1),PtJoughinlalo(:,2));
point_S1_ccp(:,j)=ltln2val(ccp_map,R,PtJoughinlalo(:,1),PtJoughinlalo(:,2));


j=j+1;

end

%%
figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
for i=[1:5];%9 1 10];
plot(point_S1(i,:)*1000,'.');

%title('JAK Points','fontsize',12,'fontweight','b');

%xlabel('distance [km]','fontsize',12,'fontweight','b')
hold on;
end

figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
plot(point_S1(1,:)*1000,'color','r','linestyle','none','marker','.','markersize',20);hold on
plot(point_S1(2,:)*1000,'color','y','linestyle','none','marker','.','markersize',20)
plot(point_S1(3,:)*1000,'color','m','linestyle','none','marker','.','markersize',20)
plot(point_S1(4,:)*1000,'color','g','linestyle','none','marker','.','markersize',20)
plot(point_S1(5,:)*1000,'color','c','linestyle','none','marker','.','markersize',20)
legend('M6', 'M9', 'M13', 'M17', 'M20','location','northwest')
grid on
ylim([0 18000])
ylabel('velocity [m.yr^{-1}]','fontsize',12,'fontweight','b')
dias=['nov/14';'apr/15';'fev/16'];
set(gca,'XTick',[1:9:19],'XTickLabel',dias,'XTickLabelRotation',-45,'fontsize',8)
title('Joughin Points','fontsize',12,'fontweight','b');
% legend('N6', 'N8', 'T09', 'T10', 'T11','T12','T13')

figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
plot(point_S1_mov_med(1,:)*1000,'color','r','linestyle','none','marker','.','markersize',20);hold on
plot(point_S1_mov_med(2,:)*1000,'color','y','linestyle','none','marker','.','markersize',20)
plot(point_S1_mov_med(3,:)*1000,'color','m','linestyle','none','marker','.','markersize',20)
plot(point_S1_mov_med(4,:)*1000,'color','g','linestyle','none','marker','.','markersize',20)
plot(point_S1_mov_med(5,:)*1000,'color','c','linestyle','none','marker','.','markersize',20)
legend('M6', 'M9', 'M13', 'M17', 'M20','location','northwest')
ylim([0 18000])
ylabel('velocity [m.yr^{-1}]','fontsize',12,'fontweight','b')
dias=['nov/14';'apr/15';'fev/16'];
set(gca,'XTick',[1:9:19],'XTickLabel',dias,'XTickLabelRotation',-45,'fontsize',8)
grid on
title('Joughin Points map smoothed','fontsize',12,'fontweight','b');



j=1;
for i=[1:11 13:length(list)]
   ff(j,:)=[d(i,1:8) '-' d(i,10:17)];
   j=j+1
  end

ylabel('velocity [m.yr^{-1}]','fontsize',12,'fontweight','b')
ylim([0 10000])
set(gca,'XTick',[1:1:19],'XTickLabel',ff,'XTickLabelRotation',-45,'fontsize',8)
grid on

legend('0 km','5 km','10 km','15 km','20 km')
legend('25 km','30 km','35 km','40 km','45 km')






s3=shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/ArcGIS/Profiles/Profile_JAK/Export_Output.shp');
lo=extractfield(s3,'lo')*10;
la=extractfield(s3,'la')*10;

%%%Plotting image in lat,lon

%%% Vel_mag
j=1;
for i=[1:11 13:length(list)];
    path1=[pathsate list{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    
    date=list{i,1};
    
cd(path1);

eval(['[Vel_map,Rs1]=geotiffread(''VEL_km_y_' date(1:17) '.tif'');']);
eval(['[ccp_map,Rs1_ccp]=geotiffread(''CCP_' date(1:17) '.tif'');']);
eval(['info=geotiffinfo(''VEL_km_y_' date(1:17) '.tif'');']);
ccp=0.02;
ii=find(ccp_map<=ccp);
Vel_map(ii)=nan;

%info = geotiffinfo('VEL_km_y_20160203_20160215.tif');
R = georasterref('RasterSize',size(Vel_map),'Latlim',[min(info.CornerCoords.Lat(:)) max(info.CornerCoords.Lat(:))],'Lonlim',[min(info.CornerCoords.Lon(:)) max(info.CornerCoords.Lon(:))],'ColumnsStartFrom','north','RasterInterpretation','postings');

Vel_map(Vel_map<=0)=nan;

figure('units', 'centimeters','position', [0 0 15 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
axesm('MapProjection','mercator', 'MapLatLimit',[68 70.7],'MapLonLimit',[-55 -47.8]);
h=geoshow((Vel_map*1000),R, 'DisplayType','surface');
tt=double(~isnan(Vel_map));set(h,'AlphaData', tt);
gridm('Grid','off','GLineWidth',1,'GLineStyle',':','PLineLocation', 1,'MLineLocation',4, 'fontsize',10);
framem;
mlabel('MeridianLabel','on','MLabelParallel', 'north','ParallelLabel','on','PLabelLocation',1,'MLabelLocation',4)
axis off;
caxis([0 8000])
ttt=['''Velocity Magnitude ' date(1:8) '-' date(10:17) ''''];
eval(['title(' ttt ',''fontsize'',10,''fontweight'',''b'')']);

pause(2);

eval(['print -dpng -r300 /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/Profiles/JAK/Vel_' date(1:8) '-' date(10:17)])
pause(2);
close all

end

%%% CCP

j=1;
for i=[1:11 13:length(list)];
    path1=[pathsate list{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    
    date=list{i,1};
    
cd(path1);

%eval(['[Vel_map,Rs1]=geotiffread(''VEL_km_y_' date(1:17) '.tif'');']);
eval(['[ccp_map,Rs1_ccp]=geotiffread(''CCP_' date(1:17) '.tif'');']);
eval(['info=geotiffinfo(''VEL_km_y_' date(1:17) '.tif'');']);
ccp=0.02;
% ii=find(ccp_map<=ccp);
% Vel_map(ii)=nan;

%info = geotiffinfo('VEL_km_y_20160203_20160215.tif');
R = georasterref('RasterSize',size(mapa),'Latlim',[min(info.CornerCoords.Lat(:)) max(info.CornerCoords.Lat(:))],'Lonlim',[min(info.CornerCoords.Lon(:)) max(info.CornerCoords.Lon(:))],'ColumnsStartFrom','north');

ccp_map(ccp_map<=ccp)=nan;

figure('units', 'centimeters','position', [0 0 15 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
axesm('MapProjection','mercator', 'MapLatLimit',[68 70.7],'MapLonLimit',[-55 -47.8]);
h=geoshow(ccp_map,R, 'DisplayType','surface');
tt=double(~isnan(Vel_map));set(h,'AlphaData', tt);
gridm('Grid','off','GLineWidth',1,'GLineStyle',':','PLineLocation', 1,'MLineLocation',4, 'fontsize',10);
framem;
mlabel('MeridianLabel','on','MLabelParallel', 'north','ParallelLabel','on','PLabelLocation',1,'MLabelLocation',4)
axis off;
caxis([0 0.6])
ttt=['''CCP' date(1:8) '-' date(10:17) ''''];
eval(['title(' ttt ',''fontsize'',10,''fontweight'',''b'')']);

pause(2);

eval(['print -dpng -r300 /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/Profiles/JAK/CCP_' date(1:8) '-' date(10:17)])
pause(2);
close all

end




j=1;
for i=[1:11 13:length(list)];
    path1=[pathsate list{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    
    date=list{i,1};
    
cd(path1);

eval(['[Vel_map,Rs1]=geotiffread(''VEL_km_y_' date(1:17) '.tif'');']);
eval(['[ccp_map,Rs1_ccp]=geotiffread(''CCP_' date(1:17) '.tif'');']);

%%% Points

[row_S1_pt,col_S1_pt] = map2pix(Rs1,X_points,Y_points);
[row_S1_ccp_pt,col_S1_ccp_pt] = map2pix(Rs1_ccp,X_points,Y_points);


Vel_map(Vel_map<=0)=nan;

figure('units', 'centimeters','position', [0 0 15 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
h=imagesc((Vel_map*1000));
tt=double(~isnan(Vel_map));set(h,'AlphaData', tt);
axis off;
caxis([0 8000])
ttt=['''Velocity Magnitude ' date(1:8) '-' date(10:17) ''''];
eval(['title(' ttt ',''fontsize'',10,''fontweight'',''b'')']);

hold on
plot(col_S1_pt(1),row_S1_pt(1),'color','r','linestyle','none','marker','.','markersize',5)
plot(col_S1_pt(2),row_S1_pt(2),'color','y','linestyle','none','marker','.','markersize',5)
plot(col_S1_pt(3),row_S1_pt(3),'color','m','linestyle','none','marker','.','markersize',5)
plot(col_S1_pt(4),row_S1_pt(4),'color','g','linestyle','none','marker','.','markersize',5)
plot(col_S1_pt(5),row_S1_pt(5),'color','c','linestyle','none','marker','.','markersize',5)

pause(2);

eval(['print -dpng -r300 /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/Profiles/JAK/no_proj/Vel_' date(1:8) '-' date(10:17)])

close all

end





