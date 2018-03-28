figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
j=1;
for i=[2:11 13:length(list)];
    path1=[pathsate list{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    
    date=list{i,1};
    
cd(path1);

eval(['[Vel_map_'  num2str(j) ',Rs1_'  num2str(j) ']=geotiffread(''VEL_km_y_' date(1:17) '.tif'');']);
eval(['[ccp_map_'  num2str(j) ',Rs1_ccp_'  num2str(j) ']=geotiffread(''CCP_' date(1:17) '.tif'');']);

eval(['Vel_map=Vel_map_'  num2str(j) '; Rs1=Rs1_'  num2str(j) ';']);
eval(['ccp_map=ccp_map_'  num2str(j) '; Rs1_ccp=Rs1_ccp_'  num2str(j) ';']);

ccp=0.00;
ii=find(ccp_map<=ccp);
Vel_map(ii)=nan;


Vel_map_mov_med=moving_median_filter(Vel_map,11,0); % 200x250m resol & 2x2.5km window

eval(['Vel_map_mov_med' num2str(j) '=Vel_map_mov_med;']);

Vel_map_mov_med(Vel_map_mov_med<=0)=nan;
Vel_map(Vel_map<=0)=nan;

[row_S1,col_S1] = map2pix(Rs1,X_p,Y_p);
[row_S1_ccp,col_S1_ccp] = map2pix(Rs1_ccp,X_p,Y_p);

prof_S1(:,j)=improfile(Vel_map,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));
prof_S1_mov_med(:,j)=improfile(Vel_map_mov_med,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));

%prof_S1_ccp=improfile(ccp_map,col_S1_ccp,row_S1_ccp);

%%% Points

% [row_S1_pt,col_S1_pt] = map2pix(Rs1,X_points,Y_points);
% [row_S1_ccp_pt,col_S1_ccp_pt] = map2pix(Rs1_ccp,X_points,Y_points);

%%% o primeiro ponto, na realidade é o penultimo ponto do transecto (40km)

% point_S1(:,j)=improfile(Vel_map,col_S1_pt(~isnan(col_S1_pt)),row_S1_pt(~isnan(row_S1_pt)),length(row_S1_pt));
% point_S1_ccp(:,j)=improfile(ccp_map,col_S1_ccp_pt(~isnan(col_S1_ccp_pt)),row_S1_pt(~isnan(row_S1_ccp_pt)),length(row_S1_pt));


% %Importing the NSIDC Greenland velocity map and extracting the data along the profile:
% 
% % [NSIDC_map,Rnsidc]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/20141116_20141128_la_68/VEL_km_y_20141116_20141128.tif');
% % 
% % [row_NSIDC,col_NSIDC]=map2pix(Rnsidc,X_p,Y_p);
% % prof_NSIDC=improfile(NSIDC_map,col_NSIDC(~isnan(col_NSIDC)),row_NSIDC(~isnan(row_NSIDC)));

dist(j,:)=0:((0.047949*999)/(length(prof_S1)-1)):(0.047949*999);
%dist=0:((29.9439*999)/(length(prof_S1)-1)):(29.9439*999); %Joughin profile distance

% dist_nsidc=0:(160.75/(length(prof_S1)-1)):160.75;


% Plots Profiles

%%% mov median 1km
% subplot(2,2,1);
% plot(dist,(prof_S1*1000),'.');hold on;
% %hold on
% subplot(2,2,3);
% plot(dist,(prof_S1_mov_med*1000),'.');hold on;



%legend([date(1:8) '-' date(10:17)]);

clear row* col* ccp_map Rs1 Rs1_ccp Vel_map Vel_map_mov_med

%eval(['print -dpng -r300 /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/Profiles/JAK/ccp_002/profile_' date(1:8) '-' date(10:17)])
%print -dpng -r300 /DADOS/Uni_Leeds/PG/profile_snr5_1km
%close all
j=j+1;

end


figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
for i=1:19;
plot(dist(i,:),prof_S1_mov_med(:,i)*1000,'.');hold on;
end

B_=nan(2,3);
B_(:,1)=[-2;20000];
B_(:,2)=889*0.047949; % Ice front line position
% B_(:,3)=782*0.047949; % profile angle
%B_(:,2)=637*29.9439; % Ice front line position
%B_(:,3)=782*29.9439; % profile angle

title('JAK Profile mMedian filter','fontsize',12,'fontweight','b');
ylabel('velocity [m.yr^{-1}]','fontsize',12,'fontweight','b')

xlabel('distance [km]','fontsize',12,'fontweight','b')
plot(dist(1,:),prof_NSIDC_2009,'.')
hold on;
plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
%plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);

xlim([0 (0.047949*999)+1]);
%xlim([0 (29.9439*999)+1]);

ylim(gca,[0 12000]);

set(gca,'XTick',[0:5:45])
set(gca,'YTick',[0:2000:12000])
grid on;


%%%%%%%%%%%%%%
% Plot subplots profiles & transect

j=1;
for i=[1:11 13:length(list)];

    date=list{i,1};
    
ff=figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;

% ttt=['''JAK Profile ' date(1:8) '-' date(10:17) ''''];
% eval(['title(' ttt ',''fontsize'',12,''fontweight'',''b'')']);
% 
% eval(['Vel_map_mov_med' num2str(j) '=Vel_map_mov_med;']);
% 
% 
% prof_S1(:,j)=improfile(Vel_map,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));
% prof_S1_mov_med(:,j)=improfile(Vel_map_mov_med,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));
% 
% dist(j,:)=0:((0.047949*999)/(length(prof_S1)-1)):(0.047949*999);
%dist=0:((29.9439*999)/(length(prof_S1)-1)):(29.9439*999); %Joughin profile distance

% dist_nsidc=0:(160.75/(length(prof_S1)-1)):160.75;


% Plots Profiles
B_=nan(2,3);
B_(:,1)=[-2;20000];
B_(:,2)=889*0.047949; % Ice front line position
% B_(:,2)=637*29.9439; % Ice front line position Joughin's profile

%%% mov median 1km
s(1)=subplot(2,2,1);
plot(dist(j,:),(prof_S1(:,j)*1000),'.');hold on;
ylabel('velocity [m.yr^{-1}]','fontsize',12,'fontweight','b')
%xlabel('distance [km]','fontsize',12,'fontweight','b')
%xlabel('distance [km]','fontsize',12,'fontweight','b')
% plot(dist(j,:),prof_NSIDC_2000,'.')
% plot(dist(j,:),prof_NSIDC_2005,'.')
% plot(dist(j,:),prof_NSIDC_2007,'.')
% plot(dist(j,:),prof_NSIDC_2008,'.')
plot(dist(j,:),prof_NSIDC_2009,'.');
plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
%plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 (0.047949*999)+1]);
%xlim([0 (29.9439*999)+1]); %Joughin's profile
ylim(gca,[0 12000]);
set(gca,'XTick',[0:5:45])
set(gca,'YTick',[0:2000:12000])
grid on;
legend('S1','2009','location','northwest');


% %hold on
subplot(2,2,3);
plot(dist(j,:),(prof_S1_mov_med(:,j)*1000),'.');hold on;
ylabel('velocity [m.yr^{-1}]','fontsize',12,'fontweight','b')
xlabel('distance [km]','fontsize',12,'fontweight','b')
%xlabel('distance [km]','fontsize',12,'fontweight','b')
% plot(dist(j,:),prof_NSIDC_2000,'.')
% plot(dist(j,:),prof_NSIDC_2005,'.')
% plot(dist(j,:),prof_NSIDC_2007,'.')
% plot(dist(j,:),prof_NSIDC_2008,'.')
plot(dist(j,:),prof_NSIDC_2009,'.')
hold on;
plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
%plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 (0.047949*999)+1]);
%xlim([0 (29.9439*999)+1]); %Joughin's profile
ylim(gca,[0 12000]);
set(gca,'XTick',[0:5:45])
set(gca,'YTick',[0:2000:12000])
grid on;
legend('S1 mMedian','2009','location','northwest');


eval(['Vel_map=Vel_map_' num2str(j) '*1000;']);
Vel_map(Vel_map<=0)=nan;
s(2)=subplot(2,2,2);
h=imagesc(Vel_map);
tt=double(~isnan(Vel_map)); set(h,'AlphaData', tt);
axis off;
caxis([0 8000])

subplot(2,2,4);
eval(['h=imagesc((Vel_map_mov_med' num2str(j) '*1000));']);
eval(['tt=double(~isnan(Vel_map_mov_med' num2str(j) '));']);set(h,'AlphaData', tt);
axis off;
caxis([0 8000])

c=colorbar('location','south','Position',...
    [0.60150709219858 0.0485159817351597 0.299645390070922 0.045662100456621]);

annotation(gcf,'textbox',...
    [0.726190476190475 0.048382717100611 0.0992063466439803 0.0529100518588245],...
    'String',{'m.yr^{-1}'},...
    'LineStyle','none',...
    'FitBoxToText','off');

ttt=['JAK Profile ' date(1:8) '-' date(10:17) ''];

annotation(gcf,'textbox',...
    [0.337301587301587 0.941798941798942 0.386243386243386 0.0476190476190476],...
    'String',{ttt},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off');


clear row* col* ccp_map Rs1 Rs1_ccp Vel_map Vel_map_mov_med
pause(2)
eval(['print -djpeg -r300 /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/Profiles/JAK/Profile_and_Map/profile_map_' date(1:8) '-' date(10:17)])
%print -dpng -r300 /DADOS/Uni_Leeds/PG/profile_snr5_1km
close all
j=j+1;

end







%%%%%%%%%%%%%%
% Median

figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
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

m=[];
for rr=[-2:2];
   
   temp_row=improfile(Vel_map,col_S1,(row_S1+rr),length(row_S1));
   temp_col=improfile(Vel_map,(col_S1+rr),row_S1,length(row_S1));
   m=[m temp_row temp_col];
end
prof_S1=nanmean(m,2);

% prof_S1=improfile(Vel_map,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));
%prof_S1_ccp=improfile(ccp_map,col_S1_ccp(~isnan(col_S1_ccp)),row_S1(~isnan(row_S1_ccp)));

%%% Points

% [row_S1_pt,col_S1_pt] = map2pix(Rs1,X_points,Y_points);
% [row_S1_ccp_pt,col_S1_ccp_pt] = map2pix(Rs1_ccp,X_points,Y_points);

%%% o primeiro ponto, na realidade é o penultimo ponto do transecto (40km)

% point_S1(:,j)=improfile(Vel_map,col_S1_pt(~isnan(col_S1_pt)),row_S1_pt(~isnan(row_S1_pt)),length(row_S1_pt));
% point_S1_ccp(:,j)=improfile(ccp_map,col_S1_ccp_pt(~isnan(col_S1_ccp_pt)),row_S1_pt(~isnan(row_S1_ccp_pt)),length(row_S1_pt));


% %Importing the NSIDC Greenland velocity map and extracting the data along the profile:
% 
% % [NSIDC_map,Rnsidc]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/20141116_20141128_la_68/VEL_km_y_20141116_20141128.tif');
% % 
% % [row_NSIDC,col_NSIDC]=map2pix(Rnsidc,X_p,Y_p);
% % prof_NSIDC=improfile(NSIDC_map,col_NSIDC(~isnan(col_NSIDC)),row_NSIDC(~isnan(row_NSIDC)));

ccp=0.02;
dist=0:((0.047949*999)/(length(prof_S1)-1)):(0.047949*999);
% dist_nsidc=0:(160.75/(length(prof_S1)-1)):160.75;


% Plots Profiles

%%% mov median 1km

plot(dist,(prof_S1*1000),'.');
hold on


%legend([date(1:8) '-' date(10:17)]);

clear row* col* ccp_map* R* Vel* prof_S1* m temp*

%eval(['print -dpng -r300 /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/Profiles/JAK/ccp_002/profile_' date(1:8) '-' date(10:17)])
%print -dpng -r300 /DADOS/Uni_Leeds/PG/profile_snr5_1km
%close all
j=j+1;

end
B_=nan(2,3);
B_(:,1)=[-2;20000];
B_(:,2)=889*0.047949; % Ice front line position
B_(:,3)=782*0.047949; % profile angle

ttt=['''JAK Profile ' date(1:8) '-' date(10:17) ''''];
eval(['title(' ttt ',''fontsize'',12,''fontweight'',''b'')']);
ylabel('velocity [m.yr^{-1}]','fontsize',12,'fontweight','b')

xlabel('distance [km]','fontsize',12,'fontweight','b')
plot(dist,prof_NSIDC,'.')
hold on;
plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
%plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 (0.047949*999)+1]);
ylim(gca,[0 12000]);

set(gca,'XTick',[0:5:45])
set(gca,'YTick',[0:2000:12000])
grid on;


%% 

% Applying the dust and gaussian filter

j=1;
for i=[1:11 13:length(list)];
    path1=[pathsate list{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    
    date=list{i,1};
    
cd(path1);


y2=['grep width: ' date(1:8) '.dem.par | cut -c23-26']
[s2,widthDEM]=system(y2);
widthDEM=num2str(widthDEM(1,1:4));

y3=['grep lines: ' date(1:8) '.dem.par | cut -c23-26']
[s3,linesDEM]=system(y3);
linesDEM=num2str(linesDEM(1,1:4));
%eval(['!app setup canopy python-libs && ../dust_filter.py vel_geoc_* float32 ' widthDEM ' ' linesDEM ' vel_geoc_dust']);

    for w=[5 10 20 40 80 100];
        
        for f=[0.1:0.1:0.9];
            for af=[50 100 250];
            eval(['!app setup canopy python-libs && ../gaussian_filter.py vel_geoc_dust float32 ' widthDEM ' ' linesDEM ' vel_geoc_dust_gauss_' num2str(w) '_' num2str(f) '_' num2str(af) ' -w ' num2str(w) ' -fmax ' num2str(f) ' -af ' num2str(af)]);
            eval(['!data2geotiff ' date(1:8) '.dem.par vel_geoc_dust_gauss_' num2str(w) '_' num2str(f) ' 2 VEL_km_y_' date(1:17) '_filter2_' num2str(w) '_' num2str(f) '_' num2str(af) '.tif']);
            end
        end
    end

clear widthDEM linesDEM y2 y3

end

% Extract the profile from filtered images

j=1;pathsate=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/'];

for i=[1:11 13:length(list)];
    path1=[pathsate list{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    
    date=list{i,1};
    
cd(path1);

eval(['[Vel_map_gauss'  num2str(j) ',Rs1_gauss_'  num2str(j) ']=geotiffread(''VEL_km_y_' date(1:17) '_filter_5_05.tif'');']);
%eval(['[ccp_map_'  num2str(j) ',Rs1_ccp_'  num2str(j) ']=geotiffread(''CCP_' date(1:17) '.tif'');']);

eval(['Vel_map=Vel_map_gauss'  num2str(j) '; Rs1=Rs1_gauss_'  num2str(j) ';']);

% ccp=0.00;
% ii=find(ccp_map<=ccp);
% Vel_map(ii)=nan;


% Vel_map_mov_med=moving_median_filter(Vel_map,11,0); % 200x250m resol & 2x2.5km window
% 
% eval(['Vel_map_mov_med' num2str(j) '=Vel_map_mov_med;']);

% Vel_map_mov_med(Vel_map_mov_med<=0)=nan;
Vel_map(Vel_map<=0)=nan;

[row_S1,col_S1] = map2pix(Rs1,X_p,Y_p);
%[row_S1_ccp,col_S1_ccp] = map2pix(Rs1_ccp,X_p,Y_p);

prof_S1_gauss(:,j)=improfile(Vel_map,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));
%prof_S1_mov_med(:,j)=improfile(Vel_map_mov_med,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));

%prof_S1_ccp=improfile(ccp_map,col_S1_ccp,row_S1_ccp);

%%% Points

% [row_S1_pt,col_S1_pt] = map2pix(Rs1,X_points,Y_points);
% [row_S1_ccp_pt,col_S1_ccp_pt] = map2pix(Rs1_ccp,X_points,Y_points);

%%% o primeiro ponto, na realidade é o penultimo ponto do transecto (40km)

% point_S1(:,j)=improfile(Vel_map,col_S1_pt(~isnan(col_S1_pt)),row_S1_pt(~isnan(row_S1_pt)),length(row_S1_pt));
% point_S1_ccp(:,j)=improfile(ccp_map,col_S1_ccp_pt(~isnan(col_S1_ccp_pt)),row_S1_pt(~isnan(row_S1_ccp_pt)),length(row_S1_pt));


% %Importing the NSIDC Greenland velocity map and extracting the data along the profile:
% 
% % [NSIDC_map,Rnsidc]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/20141116_20141128_la_68/VEL_km_y_20141116_20141128.tif');
% % 
% % [row_NSIDC,col_NSIDC]=map2pix(Rnsidc,X_p,Y_p);
% % prof_NSIDC=improfile(NSIDC_map,col_NSIDC(~isnan(col_NSIDC)),row_NSIDC(~isnan(row_NSIDC)));

%dist(j,:)=0:((0.047949*999)/(length(prof_S1_gauss)-1)):(0.047949*999);
%dist=0:((29.9439*999)/(length(prof_S1)-1)):(29.9439*999); %Joughin profile distance

% dist_nsidc=0:(160.75/(length(prof_S1)-1)):160.75;


% Plots Profiles

%%% mov median 1km
% subplot(2,2,1);
% plot(dist,(prof_S1*1000),'.');hold on;
% %hold on
% subplot(2,2,3);
% plot(dist,(prof_S1_mov_med*1000),'.');hold on;



%legend([date(1:8) '-' date(10:17)]);

clear row* col* ccp_map Rs1 Rs1_ccp Vel_map

%eval(['print -dpng -r300 /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/Profiles/JAK/ccp_002/profile_' date(1:8) '-' date(10:17)])
%print -dpng -r300 /DADOS/Uni_Leeds/PG/profile_snr5_1km
%close all
j=j+1;

end

% Plot map and profiles filtered and non-filtered images
j=1;
for i=[1:11 13:length(list)];

    date=list{i,1};
    
ff=figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;

% ttt=['''JAK Profile ' date(1:8) '-' date(10:17) ''''];
% eval(['title(' ttt ',''fontsize'',12,''fontweight'',''b'')']);
% 
% eval(['Vel_map_mov_med' num2str(j) '=Vel_map_mov_med;']);
% 
% 
% prof_S1(:,j)=improfile(Vel_map,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));
% prof_S1_mov_med(:,j)=improfile(Vel_map_mov_med,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));
% 
% dist(j,:)=0:((0.047949*999)/(length(prof_S1)-1)):(0.047949*999);
%dist=0:((29.9439*999)/(length(prof_S1)-1)):(29.9439*999); %Joughin profile distance

% dist_nsidc=0:(160.75/(length(prof_S1)-1)):160.75;


% Plots Profiles
B_=nan(2,3);
B_(:,1)=[-2;20000];
B_(:,2)=889*0.047949; % Ice front line position
% B_(:,2)=637*29.9439; % Ice front line position Joughin's profile

%%% mov median 1km
s(1)=subplot(2,2,1);
plot(dist(j,:),(prof_S1(:,j)*1000),'.');hold on;
ylabel('velocity [m.yr^{-1}]','fontsize',12,'fontweight','b')
%xlabel('distance [km]','fontsize',12,'fontweight','b')
plot(dist(j,:),prof_NSIDC_2000,'.')
plot(dist(j,:),prof_NSIDC_2005,'.')
plot(dist(j,:),prof_NSIDC_2007,'.')
plot(dist(j,:),prof_NSIDC_2008,'.')
plot(dist(j,:),prof_NSIDC_2009,'.')

hold on;
plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
%plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 (0.047949*999)+1]);
%xlim([0 (29.9439*999)+1]); %Joughin's profile
ylim(gca,[0 12000]);
set(gca,'XTick',[0:5:45])
set(gca,'YTick',[0:2000:12000])
grid on;
%legend('S1','2000','2005','2007','2008','2009','location','northwest');
legend('S1','2000','2005','2007','2008','2009','location','northwest');


% %hold on
subplot(2,2,3);
plot(dist(j,:),(prof_S1_gauss(:,j)*1000),'.');hold on;
ylabel('velocity [m.yr^{-1}]','fontsize',12,'fontweight','b')
xlabel('distance [km]','fontsize',12,'fontweight','b')
plot(dist(j,:),prof_NSIDC_2000,'.')
plot(dist(j,:),prof_NSIDC_2005,'.')
plot(dist(j,:),prof_NSIDC_2007,'.')
plot(dist(j,:),prof_NSIDC_2008,'.')
plot(dist(j,:),prof_NSIDC_2009,'.')

plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
%plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 (0.047949*999)+1]);
%xlim([0 (29.9439*999)+1]); %Joughin's profile
ylim(gca,[0 12000]);
set(gca,'XTick',[0:5:45])
set(gca,'YTick',[0:2000:12000])
grid on;
%legend('S1 filter','2000','2005','2007','2008','2009','location','northwest');
legend('S1 gaussian','2000','2005','2007','2008','2009','location','northwest');


eval(['Vel_map=Vel_map_' num2str(j) '*1000;']);
Vel_map(Vel_map<=0)=nan;
s(2)=subplot(2,2,2);
h=imagesc(Vel_map);
tt=double(~isnan(Vel_map)); set(h,'AlphaData', tt);
axis off;
caxis([0 8000])

subplot(2,2,4);
eval(['Vel_map_gauss=Vel_map_gauss' num2str(j) ';']);
Vel_map_gauss(Vel_map_gauss<=0)=nan;
h=imagesc(Vel_map_gauss*1000);
tt=double(~isnan(Vel_map_gauss));set(h,'AlphaData', tt);
axis off;
caxis([0 8000])

c=colorbar('location','south','Position',...
    [0.60150709219858 0.0485159817351597 0.299645390070922 0.045662100456621]);

annotation(gcf,'textbox',...
    [0.726190476190475 0.048382717100611 0.0992063466439803 0.0529100518588245],...
    'String',{'m.yr^{-1}'},...
    'LineStyle','none',...
    'FitBoxToText','off');

ttt=['JAK Profile ' date(1:8) '-' date(10:17) ''];

annotation(gcf,'textbox',...
    [0.337301587301587 0.941798941798942 0.386243386243386 0.0476190476190476],...
    'String',{ttt},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off');


clear row* col* ccp_map Rs1 Rs1_ccp Vel_map Vel_map_gauss
pause(2)
eval(['print -djpeg -r300 /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/Profiles/JAK/Profile_and_Map_gauss/w5_f05/profile_map_' date(1:8) '-' date(10:17)])
%print -dpng -r300 /DADOS/Uni_Leeds/PG/profile_snr5_1km
close all
j=j+1;

end

% Plot all profiles

figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
for i=1:19;
plot(dist(i,:),prof_S1_gauss(:,i)*1000,'.');hold on;
end

B_=nan(2,3);
B_(:,1)=[-2;20000];
B_(:,2)=889*0.047949; % Ice front line position
% B_(:,3)=782*0.047949; % profile angle
% B_(:,2)=637*29.9439; % Ice front line position
% B_(:,3)=782*29.9439; % profile angle

title('JAK Profile dust+gaussian filter w5 f05','fontsize',12,'fontweight','b');
ylabel('velocity [m.yr^{-1}]','fontsize',12,'fontweight','b')

xlabel('distance [km]','fontsize',12,'fontweight','b')
plot(dist(1,:),prof_NSIDC_2009,'.')
hold on;
plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
%plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);

xlim([0 (0.047949*999)+1]);
% xlim([0 (29.9439*999)+1]);

ylim(gca,[0 12000]);

set(gca,'XTick',[0:5:45])
set(gca,'YTick',[0:2000:12000])
grid on;

% Extracting the Joughin's points

for j=[1:19];
    
%%% Points

eval(['[row_S1_pt,col_S1_pt] = map2pix(Rs1_gauss_' num2str(j) ',X_points,Y_points);']);

eval(['vel=Vel_map_gauss' num2str(j) ';']);
vel(vel<=0)=nan;
point_S1_gauss(:,j)=improfile(vel,col_S1_pt,row_S1_pt,length(row_S1_pt));

clear row_S1_pt col_S1_pt vel

end

% Plot the points
figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
plot(point_S1_gauss(1,:)*1000,'color','r','linestyle','none','marker','.','markersize',20);hold on
plot(point_S1_gauss(2,:)*1000,'color','y','linestyle','none','marker','.','markersize',20)
plot(point_S1_gauss(3,:)*1000,'color','m','linestyle','none','marker','.','markersize',20)
plot(point_S1_gauss(4,:)*1000,'color','g','linestyle','none','marker','.','markersize',20)
plot(point_S1_gauss(5,:)*1000,'color','c','linestyle','none','marker','.','markersize',20)
legend('M6', 'M9', 'M13', 'M17', 'M20','location','northwest')
ylim([0 18000])
ylabel('velocity [m.yr^{-1}]','fontsize',12,'fontweight','b')
dias=['nov/14';'apr/15';'fev/16'];
set(gca,'XTick',[1:9:19],'XTickLabel',dias,'XTickLabelRotation',-45,'fontsize',8)
grid on
title('Joughin Points map filtered','fontsize',12,'fontweight','b');

on=ones(1,101);
plot([0:100],on*point_nsidc2009(1,1),'color','r','linestyle','-');hold on
plot([0:100],on*point_nsidc2009(2,1),'color','y')
plot([0:100],on*point_nsidc2009(3,1),'color','m')
plot([0:100],on*point_nsidc2009(4,1),'color','g')
plot([0:100],on*point_nsidc2009(5,1),'color','c')
xlim([0 20]);



[row_S1_pt,col_S1_pt] = map2pix(Rnsidc_2009,X_points,Y_points);
point_nsidc2009=impixel(NSIDC_map_2009,col_S1_pt,row_S1_pt)



%% Testing different filters values: dust + gaussian
% window: [5 10 20 40 80 100]
% f : 0.1000    0.2000    0.3000    0.4000    0.5000    0.6000    0.7000    0.8000    0.9000


ff=['01';'02';'03';'04';'05';'06';'07';'08';'09'];
for af=[50 100 250];
for w=[5 10 20 40 80 100];
        n=1;
        for f=[0.1:0.1:0.9];
           eval(['[Vel_map_gauss_' num2str(w) '_' num2str(ff(n,:)) '_' num2str(af) ',Rs1_gauss_' num2str(w) '_' num2str(ff(n,:)) '_' num2str(af) ']=geotiffread(''VEL_km_y_' date(1:17) '_filter2_' num2str(w) '_' num2str(f) '_' num2str(af) '.tif'');']);
        
           eval(['Vel_map=Vel_map_gauss_' num2str(w) '_' num2str(ff(n,:)) '_' num2str(af) '; Rs1=Rs1_gauss_' num2str(w) '_' num2str(ff(n,:)) '_' num2str(af) ';']);
           
           Vel_map(Vel_map<=0)=nan;

           [row_S1,col_S1] = map2pix(Rs1,X_p,Y_p);

           eval(['prof_S1_gauss_' num2str(w) '_' num2str(ff(n,:)) '_' num2str(af) '=improfile(Vel_map,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));']);
           
           clear row* col* ccp_map Rs1 Rs1_ccp Vel_map
           
           n=n+1;
        end
end
end


% Plotting the profiles in different combinations
w=5;f=0.1;n=1;subplot(3,3,1)
w=10;f=0.2;n=2;subplot(3,3,2)
w=10;f=0.3;n=3;subplot(3,3,3)
w=10;f=0.4;n=4;subplot(3,3,4)
w=40;f=0.4;n=4;subplot(3,3,5)
w=80;f=0.5;n=5;subplot(3,3,6)
w=80;f=0.6;n=6;subplot(3,3,7)
w=100;f=0.6;n=6;subplot(3,3,8)





for w=[5 10 20 40 80 100];
        n=1;
                
figure('units', 'centimeters','position', [0 0 30 40] , 'paperpositionmode', 'auto');        
        for f=[0.1:0.1:0.9];

        subplot(3,3,n)
        plot(dist(1,:),1000*prof_S1(:,1),'color',[0 0.45 0.74], 'Linestyle', 'none','marker','.');hold on;
        eval(['plot(dist(1,:),1000*prof_S1_gauss_' num2str(w) '_' num2str(ff(n,:)) ',''.'');']);hold on;
        B_=nan(2,3);
        B_(:,1)=[-2;20000];
        B_(:,2)=889*0.047949;
        ylabel('velocity [m.yr^{-1}]','fontsize',8,'fontweight','b')
        xlabel('distance [km]','fontsize',8,'fontweight','b')
        hold on;
        plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
        xlim([0 (0.047949*999)+1]);
        ylim(gca,[0 12000]);
        set(gca,'XTick',[0:5:45])
        set(gca,'YTick',[0:2000:12000])
        grid on;
        ttt=['w=' num2str(w) ' f=' num2str(f) ];
        title(ttt, 'FontWeight','bold','FontSize',8)
%         legend('0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','location','northwest');
        
        n=n+1;
        end
        
%         B_=nan(2,3);
%         B_(:,1)=[-2;20000];
%         B_(:,2)=889*0.047949;
%         ylabel('velocity [m.yr^{-1}]','fontsize',12,'fontweight','b')
%         xlabel('distance [km]','fontsize',12,'fontweight','b')
%         hold on;
%         plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
%         xlim([0 (0.047949*999)+1]);
%         ylim(gca,[0 12000]);
%         set(gca,'XTick',[0:5:45])
%         set(gca,'YTick',[0:2000:12000])
%         grid on;
%         ttt=['Dust + Gaussian filter: w=' num2str(w)];
%         title(ttt, 'FontWeight','bold','FontSize',12)
%         legend('0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','location','northwest');
pause(2);
eval(['print -djpeg -r300 /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/Profiles/JAK/Profile_and_Map_gauss/filters_w' num2str(w)])
close all
end

% Plotting the maps filtered
for af=[50 100 250];
for w=[5 10 20 40 80 100];
        n=1;
                
figure('units', 'centimeters','position', [0 0 30 40] , 'paperpositionmode', 'auto');        
        for f=[0.1:0.1:0.9];

        subplot(3,3,n)
        %eval(['[Vel_map_gauss_' num2str(w) '_' num2str(ff(n,:)) ',Rs1_gauss_' num2str(w) '_' num2str(ff(n,:)) ']=geotiffread(''VEL_km_y_' date(1:17) '_filter_' num2str(w) '_' num2str(f) '.tif'');']);
        
           eval(['Vel_map=Vel_map_gauss_' num2str(w) '_' num2str(ff(n,:)) '_' num2str(af) '; Rs1=Rs1_gauss_' num2str(w) '_' num2str(ff(n,:)) '_' num2str(af) ';']);
           
           Vel_map(Vel_map<=0)=nan;
           
           h=imagesc(Vel_map*1000);
tt=double(~isnan(Vel_map));set(h,'AlphaData', tt);
axis off;
caxis([0 8000])


        ttt=['w=' num2str(w) ' f=' num2str(f) ' af=' num2str(af)];
        title(ttt, 'FontWeight','bold','FontSize',8)
%         legend('0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','location','northwest');
        
        n=n+1;
        end
        
        c=colorbar('location','south','Position',...
    [0.60150709219858 0.0485159817351597 0.299645390070922 0.045662100456621]);
        
annotation(gcf,'textbox',...
    [0.726190476190475 0.035 0.0992063466439803 0.0529100518588245],...
    'String',{'m.yr^{-1}'},...
    'LineStyle','none',...
    'FitBoxToText','off');


pause(3);
eval(['print -djpeg -r300 /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/Profiles/JAK/Profile_and_Map_gauss/filters_maps_w' num2str(w) '_af_' num2str(af)])
close all
end
end

