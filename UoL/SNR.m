

%%% JAK SNR

cd /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/20141116_20141128_la_68

ccp=imread('CCP_20141116_20141128.tif');
[ccs,R]=geotiffread('CCS_std_20141116_20141128.tif');
vel_jak=imread('VEL_km_y_20141116_20141128.tif');


cd /nfs/a59/eeagdl/NRT_project/SNR_test/JAK
% SNR based on Tazio's email (snr_gamma function)
[snr1_jak,snr2_jak]=snr_gamma(ccs,ccp,50,10);
[snr1_jak,snr2_jak]=snr_gamma(ccs,ccp,1,1);


prof_shp = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/ArcGIS/Profiles/Profile_JAK/New_prof_JAK.shp');
X_p=extractfield(prof_shp,'X');
Y_p=extractfield(prof_shp,'Y');

X_p=X_p(~isnan(X_p));
Y_p=Y_p(~isnan(Y_p));


% Extract the profile
jak_vel_prof=profile_ext(X_p,Y_p,vel_jak,R);
jak_snr1_prof=profile_ext(X_p,Y_p,snr1_jak,R);
jak_snr2_prof=profile_ext(X_p,Y_p,snr2_jak,R);


dist_jak=[1:1006]';
sp = interp1(dist_jak,jak_vel_prof*(1000),dist_jak,'cubic');
sp_snr1 = interp1(dist_jak,jak_snr1_prof*32.9848,dist_jak,'cubic');


figure; subplot(4,1,1);plot(jak_snr1_prof(1:650)*32.9848,'.');
title('Snr1');grid on
%ylim([0 18/12]);%[0 (0.047949*999)+1]);

subplot(4,1,2);plot(jak_snr2_prof(1:650)*32.9848,'.');
title('Snr2');grid on
%ylim([0 18/12]);%[0 (0.047949*999)+1]);

subplot(4,1,3:4);
dados=[sp(1:650)+(sp_snr1(1:650)); flipud(sp(1:650)-(sp_snr1(1:650)))];
fill([dist_jak(1:650) ; flipud(dist_jak(1:650))],dados(:),'r','FaceAlpha', 0.3,'linestyle','none');
hold on
plot(jak_vel_prof(1:650)*(1000),'.','markersize',2.5,'color','k');
ylabel('[m/day]');
title('Velocity & SNR1');grid on


subplot(1,2,1);
imagesc(snr1_jak/12);
caxis([0 50/12]);
title('SNR1')
axis off


subplot(1,2,2);
imagesc(snr2_jak/12);
caxis([0 50/12]);
title('SNR2');
axis off
colorbar('location','south');



%%% PIG SNR

cd /nfs/a59/eeagdl/NRT_project/SNR_test/PIG

vel_pig=imread('150303_150315.coffsN_mag.gc.tiff');
ccs_PIG=imread('150303_150315.ccsN.gc.tiff');
[ccp_PIG,R_PIG]=geotiffread('150303_150315.ccpN.gc.tiff');


% SNR based on Tazio's email (snr_gamma function)
[snr1_pig,snr2_pig]=snr_gamma(ccs_PIG,ccp_PIG,20,4);

% Extract the profile
pig_vel_prof=profile_ext(PIG_transect(:,1),PIG_transect(:,2),vel_pig,R_PIG);
pig_snr1_prof=profile_ext(PIG_transect(:,1),PIG_transect(:,2),snr1_pig,R_PIG);
pig_snr2_prof=profile_ext(PIG_transect(:,1),PIG_transect(:,2),snr2_pig,R_PIG);


dist=[1:1802]';
sp = interp1(dist,pig_vel_prof/12,dist,'cubic');
sp_snr1 = interp1(dist,pig_snr1_prof/12,dist,'cubic');


figure; subplot(4,1,1);plot(pig_snr1_prof/12,'.');
title('Snr1');grid on
ylim([0 18/12]);%[0 (0.047949*999)+1]);

subplot(4,1,2);plot(pig_snr2_prof/12,'.');
title('Snr2');grid on
ylim([0 18/12]);%[0 (0.047949*999)+1]);

subplot(4,1,3:4);
dados=[sp+(sp_snr1);flipud(sp-(sp_snr1))];
fill([dist ; flipud(dist)],dados(:),'r','FaceAlpha', 0.3,'linestyle','none');
hold on
plot(pig_vel_prof/12,'.','color','k','markersize',2.5);
ylabel('[m/day]');
title('Velocity & SNR1');grid on
ylim([0 15]);xlim([0 1801]);
%dist=[[1:1802]';[1802:-1:1]'];

figure
subplot(1,2,1);
imagesc(snr1_pig/12);
caxis([0 30/12]);
title('SNR1')
axis off


subplot(1,2,2);
imagesc(snr2_pig/12);
caxis([0 30/12]);
title('SNR2');
axis off
colorbar('location','south');




%   PIG & JAK
dist=[1:1802]';
sp = interp1(dist,pig_vel_prof/12*(365/1000),dist,'cubic');
sp_snr1 = interp1(dist,pig_snr1_prof/12*(365/1000),dist,'cubic');

subplot(2,1,1);
dados=[sp+(sp_snr1);flipud(sp-(sp_snr1))];
fill([dist ; flipud(dist)],dados(:),'r','FaceAlpha', 0.3,'linestyle','none');
hold on
plot(pig_vel_prof/12*(365/1000),'.','color','k','markersize',2.5);
ylabel('[km/yr]');
title('PIG Velocity & SNR1');grid on
%ylim([0 15]);
xlim([0 1801]);


dist_jak=[1:1006]';
sp = interp1(dist_jak,jak_vel_prof,dist,'cubic');

subplot(2,1,2);
dados_jak=[sp(1:650)+(sp_snr1(1:650)*(365/1000)) ; flipud(sp(1:650)-(sp_snr1(1:650)*(365/1000)))];
fill([dist_jak(1:650) ; flipud(dist(1:650))],dados_jak(:),'r','FaceAlpha', 0.3,'linestyle','none');
hold on
plot(jak_vel_prof(1:650),'.','markersize',2.5,'color','k');
ylabel('[km/yr]');
title('JAK Velocity & SNR1');grid on



%   PIG & JAK
dist=flip([1:1802]');
sp = interp1(dist,pig_vel_prof/12*(365),dist,'cubic');%[m/yr]
sp_snr1 = interp1(dist,(pig_snr1_prof/12)*(365),dist,'cubic');%[m/yr]

subplot(2,1,1);
dados=flip([sp+(sp_snr1);flipud(sp-(sp_snr1))]);%[m/yr]
fill([dist ; flipud(dist)],dados(:),'r','FaceAlpha', 0.3,'linestyle','none');
hold on
plot(flip(pig_vel_prof/12)*(365),'.','color','k','markersize',2.5);
ylabel('[m/yr]');
title('PIG Velocity & SNR1');grid on
%ylim([0 15]);
xlim([0 1801]);


dist_jak=[1:1006]';
sp_jak = interp1(dist_jak,jak_vel_prof*(1000),dist_jak,'cubic');%[m/yr]
sp_snr1_jak = interp1(dist_jak,jak_snr1_prof/12*(365),dist_jak,'cubic');%[m/yr]

subplot(2,1,2);
dados_jak=[sp_jak(1:650)+(sp_snr1_jak(1:650)) ; flipud(sp_jak(1:650)-(sp_snr1_jak(1:650)))];
flip(fill([dist_jak(1:650) ; flipud(dist_jak(1:650))],flip(dados_jak(:)),'r','FaceAlpha', 0.3,'linestyle','none'),1);
hold on
plot(jak_vel_prof(1:650)*1000,'.','markersize',2.5,'color','k');
ylabel('[m/yr]');
title('JAK Velocity & SNR1');grid on






N=600*80;
err=(sqrt(3/(10*N)))*(((sqrt(2+(5*(ccp.^2))-(7*(ccp.^4)))))/(pi*(ccp.^2)));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filtering the data
% Hi Adriano,
% 
% Sorry, I forgot to reply and I don't know if you got the parameters from Anna, but here they are:
% 
% # -----------------------------
%  # filter and dust the IV result
%  # -----------------------------
%  # set var's
%  set fmax = 0.3
%  echo "fmax"
%  echo $fmax
%  
%  set win = 10
%  echo "win"
%  echo $win
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=[2:11 13:length(list)];
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

%w=[10]; f=[0.3];
eval(['!app setup canopy python-libs && ../gaussian_filter.py -w 10 -fmax 0.3 vel_geoc_' date(1:17) ' float32 ' widthDEM ' ' linesDEM ' ./vel_geoc_gauss_EMMA > ./stats_gauss.txt']);

eval(['!app setup canopy python-libs && ../dust_filter.py ./vel_geoc_gauss_EMMA float32 ' widthDEM ' ' linesDEM ' ./vel_geoc_dust_gauss_EMMA > ./stats_dust.txt']);
eval(['!data2geotiff ' date(1:8) '.dem.par ./vel_geoc_dust_gauss_EMMA 2 ./VEL_km_y_' date(1:17) '_dust_gauss_EMMA.tif']);
eval(['!cp ./VEL_km_y_' date(1:17) '_dust_gauss_EMMA.tif /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/Stack_Data/filtered/']);

end

% Stacking the data filtered 

cd /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/Stack_Data/filtered
load('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/Velocities_JAK.mat','dist','B_','prof_S1')

[Vel_Stack,R_stack]=geotiffread('stack_filtered3.tif');
im2=Vel_Stack;
im2(im2<=0)=nan;

Vel_mean=nanmean(im2,3);
std_stack=nanstd(im2,1,3);

%%%%%%%%
% Data stacked and filtered:
%%%%%%%%

% extract the profile from the filtered data: 

for i=1:19
prof_S1(:,i)=profile_ext(X_p,Y_p,Vel_Stack(:,:,i),R_stack);
end

% Winter time
% 16/nov/2014 -> 28/march/2015  &  11/11/2015 -> 03/02/2016
% 1:8 && 18:19

Vel_mean_Winter=nanmean(im2(:,:,[1:8 18:19]),3);
std_Winter=nanstd(im2(:,:,[1:8 18:19]),1,3);

figure; imagesc(Vel_mean);caxis([0 14]); title('Mean all data'); colorbar
figure; imagesc(Vel_mean_Winter);caxis([0 14]); title('Mean Winter'); colorbar
figure; imagesc(std_stack);caxis([0 5]); colorbar; title('STD all data');
figure; imagesc(std_Winter);caxis([0 5]); colorbar; title('STD Winter');


!cp /nfs/a59/eeagdl/Dropbox/Rotinas/UoL/profile_ext.m ./
jak_STDstack_prof=profile_ext(X_p,Y_p,std_stack,R_stack);
jak_STDstack_Winter_prof=profile_ext(X_p,Y_p,std_Winter,R_stack);

figure; plot(dist(1,:),jak_STDstack_prof,'.'); hold on;
plot(dist(1,:),jak_STDstack_Winter_prof,'.');
legend('STD all data','STD Winter');
title('STD profile');
grid on



for i=1:length(prof_S1)

det(i,:)=detrend(prof_S1(i,:));

end







