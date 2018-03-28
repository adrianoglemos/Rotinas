%%%% Profiles

cd /nfs/a59/eeagdl/Petterman_S1/Profiles/Geocoded

% Data from Sentinel:
load('Profiles_S1_N7_geocoded.mat');

%%%Creating distance line:

%vetor distancia N7:
p1_N7=(P1N7geoc(:,2)./1000)+2;
p2_N7=(P2N7geoc(:,2)./1000)+30.38;

%%%pontos no mapa

B=nan(7,4);
B(:,1)=[0:6];
B(:,2)=p1_N7(1,1);
B(:,3)=p1_N7(end);
B(:,4)=108.78; % Ice front line position

%%%Profile 1
figure
figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;

subplot(2,1,1);
plot(P1S1geoc(:,2)./1000,P1S1geoc(:,3),'k', 'LineWidth',2);
hold on;
plot(p1_N7,P1N7geoc(:,3),'color',[0.5 0.5 0.5], 'Linestyle', '--','LineWidth',2);
ylim([0 2]);
%xlim([0 160]);
plot(B(:,2),B(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
plot(B(:,3),B(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
plot(B(:,4),B(:,1),'color','g', 'Linestyle', '--','LineWidth',2);


 title('Profile 1', 'fontsize',14,'fontweight','b')
 %xlabel('Distance [km]','fontsize',12,'fontweight','b')
 ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
 legend('Sentinel-1A','ERS-1');
 
 %%%Profile 2
 
 B_=nan(7,4);
B_(:,1)=[0:6];
B_(:,2)=p2_N7(1,1);
B_(:,3)=p2_N7(end);
B_(:,4)=135.24; % Ice front line position

subplot(2,1,2);
%figure
plot(P2S1geoc(:,2)./1000,P2S1geoc(:,3),'k', 'LineWidth',2);
hold on;
plot(p2_N7,P2N7geoc(:,3),'color',[0.5 0.5 0.5], 'Linestyle', '--','LineWidth',2);
ylim([0 2]);
plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
plot(B_(:,3),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
plot(B_(:,4),B_(:,1),'color','g', 'Linestyle', '--','LineWidth',2);


 title('Profile 2', 'fontsize',14,'fontweight','b')
 xlabel('Distance [km]','fontsize',12,'fontweight','b')
 ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
 %legend('Sentinel-1A','ERS-1');

 print -dpng -r300 Profiles

 
 
 
 
 
 
 
 % Data from ERS:
figure
plot(Profile1N7(:,2),'k', 'LineWidth',2);
hold on;
plot(Profile2N7(:,2),'color',[0.5 0.5 0.5], 'Linestyle', '--','LineWidth',2);


title('ERS-1', 'fontsize',14,'fontweight','b')
 %xlabel('Tempo [anos]','fontsize',14,'fontweight','b')
 ylabel('m.day^-1','fontsize',14,'fontweight','b')
 legend('Profile 1','Profile 2');


 
 w=nan(27,2);
 teste=[w;Profile1N7];
 plot(Profile1(:,2),'k', 'LineWidth',2);
hold on;
 plot(teste(:,2),'r', 'LineWidth',2);

 

max(MN1(:,1)) % 67600
min(MN1(:,1)) % 1100
x=min(MN1(:,1))-100:max(MN1(:,1))+100;

max(MN1(:,2)) % 13180
min(MN1(:,2)) % 100
y=min(MN1(:,2))-100:max(MN1(:,2))+100;


[X,Y]=meshgrid(x,y);

z=griddata(MN1(:,1),MN1(:,2),(movMN1/12),X,Y);

load('z.mat');

pcolor(z(1000:5000,1000:10000));

a=z(2000:end,50000:65000);
im3=im1(2000:11282,50000:66000);

h1=imagesc(im3)
colormap(gray)
freezeColors
hold on
h=imagesc(a)
colormap(jet)
caxis([0 6]);
hold off
%set(h, 'AlphaData', 0.6);
alpha(h,0.85);

h1=imshow(im3)
colormap(gray)
freezeColors
hold on
h=imshow(a)
colormap(jet)
caxis([0 6]);
colorbar
hold off
alpha(h,0.85);

set(h, 'FaceAlpha', 0.85);


ras3=z;
teste=nan(13341,67772);
teste(Vel_zero==1)= ras3(Vel_zero==1);

section=nan(13341,67772);
section(trans==1)= ras3(trans==1);

hist(teste(Vel_zero==1), [-2:2:18]);



%%%% Plotting image GEOCODED
 cd  /nfs/a59/eeagdl/Petterman_S1/v1/offset_geocoded
[Vel_S1,Rs1]=geotiffread('VEL_km_y.tif');
mapshow(Vel_S1, Rs1, 'DisplayType','surface');
% or: mapshow(Vel_S1, Rs1, 'DisplayType','mesh');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Importing SNR and Velocities inside the polygon

%cd /nfs/a59/eeagdl/Data/Tests/N7 & cd  /nfs/a59/eeagdl/Petterman_S1/v1/offset_geocoded


% SNR_poly_geo_S1.txt
filename = '/nfs/a59/eeagdl/Petterman_S1/v1/offset_geocoded/SNR_poly_geo_S1.txt';
formatSpec = '%7f%8f%8f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
SNRpolygeoS1 = [dataArray{1:end-1}];
clearvars filename formatSpec fileID dataArray ans;

% Velocidades_poly_geo_S1_noSelection.txt
filename = '/nfs/a59/eeagdl/Petterman_S1/v1/offset_geocoded/Velocidades_poly_geo_S1_noSelection.txt';
formatSpec = '%7f%8f%8f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
VelocidadespolygeoS1noSelection = [dataArray{1:end-1}];
clearvars filename formatSpec fileID dataArray ans;

% SNR_poly_geo_ERS.txt
filename = '/nfs/a59/eeagdl/Data/Tests/N7/SNR_poly_geo_ERS.txt';
formatSpec = '%7f%8f%8f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
SNRpolygeoERS = [dataArray{1:end-1}];
clearvars filename formatSpec fileID dataArray ans;

% Velocidades_poly_geo_ERS.txt
filename = '/nfs/a59/eeagdl/Data/Tests/N7/Velocidades_poly_geo_ERS.txt';
formatSpec = '%7f%8f%8f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
VelocidadespolygeoERS = [dataArray{1:end-1}];
clearvars filename formatSpec fileID dataArray ans;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% extracting the polygon and its position:
poly = imfreehand();
pos = poly.getPosition();
mask=poly.createMask();
cd /nfs/a59/eeagdl/Data/Tests/N7 % or cd  /nfs/a59/eeagdl/Petterman_S1/v1/offset_geocoded
load Polygon_Geocoded.mat

% plot(VelocidadespolygeoERS(:,3),flipud(VelocidadespolygeoERS(:,4)),'.')
% hold on
% plot(VelocidadespolygeoS1(:,3),flipud(VelocidadespolygeoS1(:,4)),'LineStyle','none','marker','.','color','red')
% legend('ERS','S1');
% ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
% xlabel('Flow ->','fontsize',12,'fontweight','b')
% 
% 
% figure; subplot(2,1,1);
% plot(VelocidadespolygeoS1noSelection(:,3),flipud(VelocidadespolygeoS1noSelection(:,4)),'LineStyle','none','marker','.','color','red')
% ylabel('km.yr^{-1} S1','fontsize',12,'fontweight','b')
% grid on
% 
% subplot(2,1,2);
% plot(SNRpolygeoS1(:,3),flipud(SNRpolygeoS1(:,4)),'LineStyle','none','marker','.','color','b')
% ylabel('SNR','fontsize',12,'fontweight','b')
% grid on

%%%% Filtering data

% Sentinel 1 data
Vel_SNR=[SNRpolygeoS1(:,2) SNRpolygeoS1(:,3) SNRpolygeoS1(:,4) VelocidadespolygeoS1noSelection(:,4)];

snr_5=find(Vel_SNR(:,3)>=5);
snr_7=find(Vel_SNR(:,3)>=7);
snr_10=find(Vel_SNR(:,3)>=10);
snr_15=find(Vel_SNR(:,3)>=15);
snr_20=find(Vel_SNR(:,3)>=20);

figure; subplot(5,1,1);
plot(Vel_SNR(snr_5,2),flipud(Vel_SNR(snr_5,4)),'LineStyle','none','marker','.','color','red')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
title('SNR >= 5', 'fontsize',14,'fontweight','b')
grid on

subplot(5,1,2);
plot(Vel_SNR(snr_7,2),flipud(Vel_SNR(snr_7,4)),'LineStyle','none','marker','.','color','red')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
title('SNR >= 7', 'fontsize',14,'fontweight','b')
grid on

subplot(5,1,3);
plot(Vel_SNR(snr_10,2),flipud(Vel_SNR(snr_10,4)),'LineStyle','none','marker','.','color','red')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
title('SNR >= 10', 'fontsize',14,'fontweight','b')
grid on

subplot(5,1,4);
plot(Vel_SNR(snr_15,2),flipud(Vel_SNR(snr_15,4)),'LineStyle','none','marker','.','color','red')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
title('SNR >= 15', 'fontsize',14,'fontweight','b')
grid on

subplot(5,1,5);
plot(Vel_SNR(snr_20,2),flipud(Vel_SNR(snr_20,4)),'LineStyle','none','marker','.','color','red')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
title('SNR >= 20', 'fontsize',14,'fontweight','b')
grid on

perc_5=1-(length(snr_5)/length(Vel_SNR))
perc_7=1-(length(snr_7)/length(Vel_SNR))
perc_10=1-(length(snr_10)/length(Vel_SNR))
perc_15=1-(length(snr_15)/length(Vel_SNR))
perc_20=1-(length(snr_20)/length(Vel_SNR))

% ERS data:
Vel_SNR_ERS=[SNRpolygeoERS(:,2) SNRpolygeoERS(:,3) SNRpolygeoERS(:,4) VelocidadespolygeoERS(:,4)];

snr_5_ERS=find(Vel_SNR_ERS(:,3)>=5);
snr_7_ERS=find(Vel_SNR_ERS(:,3)>=7);
snr_10_ERS=find(Vel_SNR_ERS(:,3)>=10);
snr_15_ERS=find(Vel_SNR_ERS(:,3)>=15);
snr_20_ERS=find(Vel_SNR_ERS(:,3)>=20);

figure; subplot(5,1,1);
plot(Vel_SNR_ERS(snr_5_ERS,2),flipud(Vel_SNR_ERS(snr_5_ERS,4)),'LineStyle','none','marker','.','color','red')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
title('SNR ERS >= 5', 'fontsize',14,'fontweight','b')
grid on

subplot(5,1,2);
plot(Vel_SNR_ERS(snr_7_ERS,2),flipud(Vel_SNR_ERS(snr_7_ERS,4)),'LineStyle','none','marker','.','color','red')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
title('SNR ERS >= 7', 'fontsize',14,'fontweight','b')
grid on

subplot(5,1,3);
plot(Vel_SNR_ERS(snr_10_ERS,2),flipud(Vel_SNR_ERS(snr_10_ERS,4)),'LineStyle','none','marker','.','color','red')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
title('SNR ERS >= 10', 'fontsize',14,'fontweight','b')
grid on

subplot(5,1,4);
plot(Vel_SNR_ERS(snr_15_ERS,2),flipud(Vel_SNR_ERS(snr_15_ERS,4)),'LineStyle','none','marker','.','color','red')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
title('SNR ERS >= 15', 'fontsize',14,'fontweight','b')
grid on

subplot(5,1,5);
plot(Vel_SNR_ERS(snr_20_ERS,2),flipud(Vel_SNR_ERS(snr_20_ERS,4)),'LineStyle','none','marker','.','color','red')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
title('SNR ERS >= 20', 'fontsize',14,'fontweight','b')
grid on

perc_5_ERS=1-(length(snr_5_ERS)/length(Vel_SNR_ERS))
perc_7_ERS=1-(length(snr_7_ERS)/length(Vel_SNR_ERS))
perc_10_ERS=1-(length(snr_10_ERS)/length(Vel_SNR_ERS))
perc_15_ERS=1-(length(snr_15_ERS)/length(Vel_SNR_ERS))
perc_20_ERS=1-(length(snr_20_ERS)/length(Vel_SNR_ERS))


%%% Plotting th SNR > 10 for the S1 and ERS in the same plot:

B_=nan(4,3);
B_(:,1)=[0:3];
B_(:,2)=79.5+min(Vel_SNR(snr_10,2))/10; % Ice front line position
B_(:,3)=39.35+min(Vel_SNR(snr_10,2))/10; % Grounding line position


%plot(cS1,flipud(Vel_SNR(snr_10,4)),'LineStyle','none','marker','.','color','red')
plot(Vel_SNR(snr_10,2)/10,flipud(Vel_SNR(snr_10,4)),'LineStyle','none','marker','.','color','red')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
hold on;
%plot(cERS,flipud(Vel_SNR_ERS(snr_10_ERS,4)),'LineStyle','none','marker','.','color','blue')
plot((Vel_SNR_ERS(snr_10_ERS,2)/10),flipud(Vel_SNR_ERS(snr_10_ERS,4)),'LineStyle','none','marker','.','color','blue')
plot(B_(:,2),B_(:,1),'color','g', 'Linestyle', '--','LineWidth',2);
plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
title('SNR >= 10', 'fontsize',14,'fontweight','b');
xlabel('Northing [m]','fontsize',12,'fontweight','b')
grid on;
legend('S1','ERS')%,'Ice Front','GL');

%subplot:
figure;
subplot(2,1,1);
plot(Vel_SNR(snr_10,2)/10,flipud(Vel_SNR(snr_10,4)),'LineStyle','none','marker','.','color','red')
%plot(cS1,flipud(Vel_SNR(snr_10,4)),'LineStyle','none','marker','.','color','red')
hold on;
plot(B_(:,2),B_(:,1),'color','g', 'Linestyle', '--','LineWidth',2);
plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
grid on;
title('SNR >= 10', 'fontsize',14,'fontweight','b')
legend('S1');


subplot(2,1,2);
%plot(cERS,flipud(Vel_SNR_ERS(snr_10_ERS,4)),'LineStyle','none','marker','.','color','blue')
plot(Vel_SNR_ERS(snr_10_ERS,2)/10,flipud(Vel_SNR_ERS(snr_10_ERS,4)),'LineStyle','none','marker','.','color','blue')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
xlabel('Northing [m]','fontsize',12,'fontweight','b')

hold on;
plot(B_(:,2),B_(:,1),'color','g', 'Linestyle', '--','LineWidth',2);
plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 140]);
ylim([0 3]);
grid on;
legend('ERS');



%%% Importing images km/year

 cd  /nfs/a59/eeagdl/Petterman_S1/v1/offset_geocoded
[Vel_S1,Rs1]=geotiffread('VEL_km_y.tif');
[SNR,Rsnr]=geotiffread('SNR.tif');
[Vel_ERS,Rers]=geotiffread('/nfs/a59/eeagdl/Data/Tests/N7/VEL_N7.tif');
[SNR_ERS,R_snr_ers]=geotiffread('/nfs/a59/eeagdl/Data/Tests/N7/SNR_geo_ERS.tif');

info = geotiffinfo('VEL_km_y.tif');
info_ers = geotiffinfo('/nfs/a59/eeagdl/Data/Tests/N7/VEL_N7.tif');


%Creating coordinates positons:
X=[info.BoundingBox(1,1):info.RefMatrix(2,1):info.BoundingBox(2,1)];
Y=[info.BoundingBox(2,2):info.RefMatrix(1,2):info.BoundingBox(1,2)];
X_ers=[info_ers.BoundingBox(1,1):info_ers.RefMatrix(2,1):info_ers.BoundingBox(2,1)];
Y_ers=[info_ers.BoundingBox(2,2):info_ers.RefMatrix(1,2):info_ers.BoundingBox(1,2)];
[Xi,Yi] = meshgrid(X,Y);
[Xi_ers,Yi_ers] = meshgrid(X_ers,Y_ers);


% imagesc(log10(SNR_));
% y=get(colorbar,'YTick');
% colorbar('YTickLabel',10.^y);
% colormap(hsv)

%%% Filtering the image

%SNR>2
snr_image_2= find(SNR(:)<2);
vel_s1_2=Vel_S1;
snr_s1_2=SNR;
vel_s1_2(snr_image_2)=nan;  %%%% Seting -0.0001 as NAN
snr_s1_2(snr_image_2)=nan;

snr_img_2_ERS= find(SNR_ERS(:)<2);
vel_ers_2=Vel_ERS;
snr_ers_2=SNR_ERS;
vel_ers_2(snr_img_2_ERS)=nan;%%%% Seting -0.0001 as NAN
snr_ers_2(snr_img_2_ERS)=nan;

%SNR>5
snr_image_5= find(SNR(:)<5);
vel_s1_5=Vel_S1;
snr_s1_5=SNR;
vel_s1_5(snr_image_5)=nan;  %%%% Seting -0.0001 as NAN
snr_s1_5(snr_image_5)=nan;

snr_img_5_ERS= find(SNR_ERS(:)<5);
vel_ers_5=Vel_ERS;
snr_ers_5=SNR_ERS;
vel_ers_5(snr_img_5_ERS)=nan;%%%% Seting -0.0001 as NAN
snr_ers_5(snr_img_5_ERS)=nan;

%SNR>7
snr_image_7= find(SNR(:)<7);
vel_s1_7=Vel_S1;
snr_s1_7=SNR;
vel_s1_7(snr_image_7)=nan;  %%%% Seting -0.0001 as NAN
snr_s1_7(snr_image_7)=nan;

snr_img_7_ERS= find(SNR_ERS(:)<7);
vel_ers_7=Vel_ERS;
snr_ers_7=SNR_ERS;
vel_ers_7(snr_img_7_ERS)=nan;%%%% Seting -0.0001 as NAN
snr_ers_7(snr_img_7_ERS)=nan;

%SNR>10
snr_image_10= find(SNR(:)<10);
vel_s1=Vel_S1;
snr_s1_10=SNR;
vel_s1(snr_image_10)=nan;-0.0001;   %%%% Seting -0.0001 as NAN
snr_s1_10(snr_image_10)=nan;

snr_img_10_ERS= find(SNR_ERS(:)<10);
vel_ers=Vel_ERS;
snr_ers_10=SNR_ERS;
vel_ers(snr_img_10_ERS)=nan;%-0.0001; %%%% Seting -0.0001 as NAN
snr_ers_10(snr_img_10_ERS)=nan;

%SNR>15
snr_image_15= find(SNR(:)<15);
vel_s1_15=Vel_S1;
snr_s1_15=SNR;
vel_s1_15(snr_image_15)=nan;  %%%% Seting -0.0001 as NAN
snr_s1_15(snr_image_15)=nan;

snr_img_15_ERS= find(SNR_ERS(:)<15);
vel_ers_15=Vel_ERS;
snr_ers_15=SNR_ERS;
vel_ers_15(snr_img_15_ERS)=nan;%%%% Seting -0.0001 as NAN
snr_ers_15(snr_img_15_ERS)=nan;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Transparency in imagesc and imshow:
h=imagesc(vel_s1_2); % or h=imshow(vel_s1_2)
teste=double(~isnan(vel_s1_2));
%set(h,'AlphaData',teste, 'AlphaDataMapping',teste);
set(h,'AlphaData', teste);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Ploting the velocities with the different SNR's filters

% Loading the different SNRs:
load('/nfs/a59/eeagdl/Petterman_S1/SNRs.mat');


%Velocities from S1:
figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto');

subplot(2,3,1);
h1=imagesc(vel_s1_2); t1=double(~isnan(vel_s1_2));
caxis([0 2]);
set(h1,'AlphaData', t1);
title('SNR >= 2', 'fontsize',12,'fontweight','b')

subplot(2,3,2);
h2=imagesc(vel_s1_5); t2=double(~isnan(vel_s1_5));
caxis([0 2]);
set(h2,'AlphaData', t2);
title('SNR >= 5', 'fontsize',12,'fontweight','b')

subplot(2,3,3);
h3=imagesc(vel_s1_7); t3=double(~isnan(vel_s1_7));
caxis([0 2]);
set(h3,'AlphaData', t3);
title('SNR >= 7', 'fontsize',12,'fontweight','b')

subplot(2,3,4.5);
h4=imagesc(vel_s1); t4=double(~isnan(vel_s1));
caxis([0 2]);
set(h4,'AlphaData', t4);
title('SNR >= 10', 'fontsize',12,'fontweight','b')

subplot(2,3,5.5);
h5=imagesc(vel_s1_15); t5=double(~isnan(vel_s1_15));
caxis([0 2]);
set(h5,'AlphaData', t5);
title('SNR >= 15', 'fontsize',12,'fontweight','b')

Cb=colorbar('location','South', 'FontName','times','FontSize',10);
set(Cb,'position',[0.222348021739709 0.00133147783752626 0.580551403421359 0.0278606140932231]);


%Velocities from ERS:
figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto');

subplot(2,3,1);
h1=imagesc(vel_ers_2); t1=double(~isnan(vel_ers_2));
caxis([0 2]);
set(h1,'AlphaData', t1);
title('SNR >= 2', 'fontsize',12,'fontweight','b')

subplot(2,3,2);
h2=imagesc(vel_ers_5); t2=double(~isnan(vel_ers_5));
caxis([0 2]);
set(h2,'AlphaData', t2);
title('SNR >= 5', 'fontsize',12,'fontweight','b')

subplot(2,3,3);
h3=imagesc(vel_ers_7); t3=double(~isnan(vel_ers_7));
caxis([0 2]);
set(h3,'AlphaData', t3);
title('SNR >= 7', 'fontsize',12,'fontweight','b')

subplot(2,3,4.5);
h4=imagesc(vel_ers); t4=double(~isnan(vel_ers));
caxis([0 2]);
set(h4,'AlphaData', t4);
title('SNR >= 10', 'fontsize',12,'fontweight','b')

subplot(2,3,5.5);
h5=imagesc(vel_ers_15); t5=double(~isnan(vel_ers_15));
caxis([0 2]);
set(h5,'AlphaData', t5);
title('SNR >= 15', 'fontsize',12,'fontweight','b')

Cb=colorbar('location','South', 'FontName','times','FontSize',10);
set(Cb,'position',[0.222348021739709 0.00133147783752626 0.580551403421359 0.0278606140932231]);


%% Smoothing the data (moving_median_filter function)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sentinel resolution: 20m (azm) X 5m (ground-range)
%  -> Multi-look -> 40m(azm) X 50m(ground-range)
%
% ERS resolution: 25mX25m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Smoothing in a 5 km Radius -> S1(~100pixel) & ERS(~200pixel)

% S1 & ERS to SNR = 5 , 7 , 10:

mov_med_S1_snr5_5km=moving_median_filter(vel_s1_5,101,0);
mov_med_S1_snr7_5km=moving_median_filter(vel_s1_7,101,0);
mov_med_S1_snr10_5km=moving_median_filter(vel_s1,101,0);

mov_med_ERS_snr5_5km=moving_median_filter(vel_ers_5,201,0);
mov_med_ERS_snr7_5km=moving_median_filter(vel_ers_7,201,0);
mov_med_ERS_snr10_5km=moving_median_filter(vel_ers,201,0);

% Smoothing in a 1 km Radius  -> S1(~20pixel) & ERS(~40pixel)
% S1 & ERS to SNR = 5 , 7 , 10:

mov_med_S1_snr5_1km=moving_median_filter(vel_s1_5,21,0);
mov_med_S1_snr7_1km=moving_median_filter(vel_s1_7,21,0);
mov_med_S1_snr10_1km=moving_median_filter(vel_s1,21,0);

mov_med_ERS_snr5_1km=moving_median_filter(vel_ers_5,41,0);
mov_med_ERS_snr7_1km=moving_median_filter(vel_ers_7,41,0);
mov_med_ERS_snr10_1km=moving_median_filter(vel_ers,41,0);


% Plots 5km radius:

load('/nfs/a59/eeagdl/Petterman_S1/mov_median_S1_ERS.mat');

figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto');

subplot(2,2,1);
h1=imagesc(mov_med_S1_snr5_5km); t1=double(~isnan(mov_med_S1_snr5_5km));
caxis([0 2]);
set(h1,'AlphaData', t1);
title('SNR >= 5', 'fontsize',12,'fontweight','b')

subplot(2,2,2);
h2=imagesc(mov_med_S1_snr7_5km); t2=double(~isnan(mov_med_S1_snr7_5km));
caxis([0 2]);
set(h2,'AlphaData', t2);
title('SNR >= 7', 'fontsize',12,'fontweight','b')

subplot(2,2,3.5);
h3=imagesc(mov_med_S1_snr10_5km); t3=double(~isnan(mov_med_S1_snr10_5km));
caxis([0 2]);
set(h3,'AlphaData', t3);
title('SNR >= 10', 'fontsize',12,'fontweight','b')

Cb=colorbar('location','South', 'FontName','times','FontSize',10);
set(Cb,'position',[0.222348021739709 0.00133147783752626 0.580551403421359 0.0278606140932231]);

print -dpng -r300 /nfs/a59/eeagdl/Petterman_S1/mov_med_S1_5km


figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto');

subplot(2,2,1);
h1=imagesc(mov_med_ERS_snr5_5km); t1=double(~isnan(mov_med_ERS_snr5_5km));
caxis([0 2]);
set(h1,'AlphaData', t1);
title('SNR >= 5', 'fontsize',12,'fontweight','b')

subplot(2,2,2);
h2=imagesc(mov_med_ERS_snr7_5km); t2=double(~isnan(mov_med_ERS_snr7_5km));
caxis([0 2]);
set(h2,'AlphaData', t2);
title('SNR >= 7', 'fontsize',12,'fontweight','b')

subplot(2,2,3.5);
h3=imagesc(mov_med_ERS_snr10_5km); t3=double(~isnan(mov_med_ERS_snr10_5km));
caxis([0 2]);
set(h3,'AlphaData', t3);
title('SNR >= 10', 'fontsize',12,'fontweight','b')

Cb=colorbar('location','South', 'FontName','times','FontSize',10);
set(Cb,'position',[0.222348021739709 0.00133147783752626 0.580551403421359 0.0278606140932231]);

print -dpng -r300 /nfs/a59/eeagdl/Petterman_S1/mov_med_ERS_5km

% Plots 1km radius:

figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto');

subplot(2,2,1);
h1=imagesc(mov_med_S1_snr5_1km); t1=double(~isnan(mov_med_S1_snr5_1km));
caxis([0 2]);
set(h1,'AlphaData', t1);
title('SNR >= 5', 'fontsize',12,'fontweight','b')

subplot(2,2,2);
h2=imagesc(mov_med_S1_snr7_1km); t2=double(~isnan(mov_med_S1_snr7_1km));
caxis([0 2]);
set(h2,'AlphaData', t2);
title('SNR >= 7', 'fontsize',12,'fontweight','b')

subplot(2,2,3.5);
h3=imagesc(mov_med_S1_snr10_1km); t3=double(~isnan(mov_med_S1_snr10_1km));
caxis([0 2]);
set(h3,'AlphaData', t3);
title('SNR >= 10', 'fontsize',12,'fontweight','b')

Cb=colorbar('location','South', 'FontName','times','FontSize',10);
set(Cb,'position',[0.222348021739709 0.00133147783752626 0.580551403421359 0.0278606140932231]);

print -dpng -r300 /nfs/a59/eeagdl/Petterman_S1/mov_med_S1_1km


figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto');

subplot(2,2,1);
h1=imagesc(mov_med_ERS_snr5_1km); t1=double(~isnan(mov_med_ERS_snr5_1km));
caxis([0 2]);
set(h1,'AlphaData', t1);
title('SNR >= 5', 'fontsize',12,'fontweight','b')

subplot(2,2,2);
h2=imagesc(mov_med_ERS_snr7_1km); t2=double(~isnan(mov_med_ERS_snr7_1km));
caxis([0 2]);
set(h2,'AlphaData', t2);
title('SNR >= 7', 'fontsize',12,'fontweight','b')

subplot(2,2,3.5);
h3=imagesc(mov_med_ERS_snr10_1km); t3=double(~isnan(mov_med_ERS_snr10_1km));
caxis([0 2]);
set(h3,'AlphaData', t3);
title('SNR >= 10', 'fontsize',12,'fontweight','b')

Cb=colorbar('location','South', 'FontName','times','FontSize',10);
set(Cb,'position',[0.222348021739709 0.00133147783752626 0.580551403421359 0.0278606140932231]);

print -dpng -r300 /nfs/a59/eeagdl/Petterman_S1/mov_med_ERS_1km



%%
%%%Velocities above 2 km/day
vel_s1(vel_s1>2)=2;
vel_ers(vel_ers>2)=2;

%Export to geotiff:

info = geotiffinfo('VEL_km_y_20160203_20160215.tif');
geotiffwrite('Vel_SNR10_Filter.tif', vel_s1, Rsnr,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

info_ers = geotiffinfo('/nfs/a59/eeagdl/Data/Tests/N7/VEL_N7.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Tests/N7/Vel_SNR10_Filter_ERS.tif', vel_ers, R_snr_ers,'GeoKeyDirectoryTag',info_ers.GeoTIFFTags.GeoKeyDirectoryTag);



%%% Read the calving front shapefile:
% cd /nfs/a59/eeagdl/Petterman_S1/S1_arcgis
% s3=shaperead('Calving_Front.shp');%,'UseGeoCoords',true);



% figure;
% subplot(1,2,1);
figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto');
mapshow(vel_s1, Rs1, 'DisplayType','mesh');
y=get(colorbar,'YTick');
colorbar('YTickLabel',10.^y);
hold on;
mapshow(s3,'Color','k', 'LineWidth',4);
%caxis([0 2]);colorbar;
%plot(pos(:,1),pos(:,2), 'r','linewidth',2);
grid on
pause(2);
print -depsc -r300 /nfs/a59/eeagdl/Petterman_S1/v1/offset_geocoded/Vel_Filter_10


%imagesc(vel_s1)
%colormap(hsv)
%caxis([0 2]);


x1_ers=Xi_ers(~isnan(vel_ers));
y1_ers=Yi_ers(~isnan(vel_ers));
w1_ers=vel_ers(~isnan(vel_ers));
vel_interp_ers=griddata(x1_ers,y1_ers,double(w1_ers),Xi_ers,Yi_ers);

x1_s1=Xi(~isnan(vel_s1));
y1_s1=Yi(~isnan(vel_s1));
w1_s1=vel_s1(~isnan(vel_s1));
vel_interp_s1=griddata(x1_s1,y1_s1,double(w1_s1),Xi,Yi);

vel_interp_s1(vel_interp_s1<0)=0;
vel_interp_ers(vel_interp_ers<0)=0;

vel_interp_s1(isnan(vel_interp_s1))=-0.00002;
vel_interp_ers(isnan(vel_interp_ers))=-0.00001;


info = geotiffinfo('VEL_km_y.tif');
geotiffwrite('vel_interp_s1.tif', vel_interp_s1, Rsnr,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

info_ers = geotiffinfo('/nfs/a59/eeagdl/Data/Tests/N7/VEL_N7.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Tests/N7/vel_interp_ers.tif', vel_interp_ers, R_snr_ers,'GeoKeyDirectoryTag',info_ers.GeoTIFFTags.GeoKeyDirectoryTag);


[sub,Rsub]=geotiffread('/nfs/a59/eeagdl/Petterman_S1/S1_arcgis/S1_minus_ERS_interp.tif');

%% Profile FRINGE
%%%% Importing data from profile (the profile used was PROFILE 2)

filename = '/nfs/a59/eeagdl/Petterman_S1/S1_arcgis/p2_s1_interp.csv';
delimiter = ',';
formatSpec = '%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);
p2s1interp = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;


filename = '/nfs/a59/eeagdl/Petterman_S1/S1_arcgis/p2_ERS_interp.csv';
delimiter = ',';
formatSpec = '%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);
p2ERSinterp = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;




dist1=29.8:((143-29.8)/1453):143;

%dist1=0:(160.75/1813):160.75;
dist2=0:(160.75/1822):160.75;

B_=nan(4,3);
B_(:,1)=[0:3];
B_(:,2)=138*0.98; % Ice front line position
B_(:,3)=90*0.98; % Grounding line position

vel_arrumada_ERS=p2ERSinterp(214:1667,3);

figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
plot(dist1,flipud(vel_arrumada_ERS)); hold on; 
plot(dist2,flipud(p2s1interp(:,3)),'r')
ylabel('km.yr^{-1}','fontsize',12,'fontweight','b')
xlabel('km','fontsize',12,'fontweight','b')

hold on;
plot(B_(:,2),B_(:,1),'color','g', 'Linestyle', '--','LineWidth',2);
plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 165]);
ylim([0 2]);
set(gca,'XTick',[0:10:165])
grid on;
legend('ERS','Sentinel 1');

