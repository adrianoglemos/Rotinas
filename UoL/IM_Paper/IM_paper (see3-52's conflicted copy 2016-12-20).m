%% GIMP - DEM

[GIMP_DEM,R_gimp]=geotiffread('/nfs/a59/eeagdl/DATABASE/GREENLAND/GIMP_DEM/gimpdem_90m.tif');


% JAK 

prof_DEM_JAK=profile_ext(X_p_curve_JAK,Y_p_curve_JAK,GIMP_DEM,R_gimp);

figure;
[AX_JAK,H1_JAK,H2_JAK] = plotyy(dist,mean_velocity_JAK_profile,dist,prof_DEM_JAK);

set(H1_JAK,'LineStyle','none','marker','.','color','k','markersize',3);hold on;
set(H2_JAK,'LineStyle','--','marker','none','color',[0.5 0.5 0.5],'linewidth',2);hold on;
box off
set(AX_JAK(1),'ylim',[0 20],'Ycolor','k');
set(AX_JAK(2),'ylim',[0 1300],'Ycolor',[0.5 0.5 0.5]);
xlim([0 50]);
%ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
grid off;
title('Jakobshavn Isbræ','fontsize',12,'fontweight','b');
xlabel('distance [km]','fontsize',12,'fontweight','b')
ylabel(AX_JAK(1),'velocity [km/yr]','fontsize',12,'fontweight','b','color','k')
ylabel(AX_JAK(2),'elevation [m]','fontsize',12,'fontweight','b','color','k')

set(AX_JAK(1),'YTick',[0:2:20],'YTickLabel',[0:2:20],'fontsize',12)
set(AX_JAK(2),'YTick',[0:200:1300],'YTickLabel',[0:200:1300],'fontsize',12)

hold on

% Across profiles:
%JAK1:
plot([dist(365) dist(365)], [0 1], 'color','b','linestyle','-','linewidth',3);
%JAK2:
plot([dist(516) dist(516)], [0 1], 'color','k','linestyle','-','linewidth',3);
%JAK3:
plot([dist(801) dist(801)], [0 1], 'color','r','linestyle','-','linewidth',3);


% Floating area (Just a line for JAK -> Rosenau, R. et al., 2013. Grounding line migration and high-resolution calving dynamics of Jakobshavn Isbræ, West Greenland. Journal of Geophysical Research: Earth Surface, 118(2), pp.382–395.
% the ice front / GL referent to 19/08/2015 (after the calving event)

X_floating_JAK=[dist(137) dist(137)];
Y_floating_JAK=[0 20];

plot(X_floating_JAK,Y_floating_JAK,'color',[0.5 0.5 0.5],'linestyle','--');


X_floating_JAK=[dist(1):((0.048957*999)/(length(prof_curve_JAK)-1)):dist(137)];
Y_floating_JAK=[zeros(1,length(X_floating_JAK)) ones(1,length(X_floating_JAK))*20];
X_floating_JAK=[X_floating_JAK flip(X_floating_JAK)];
fill(X_floating_JAK,Y_floating_JAK,[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');


% STD shaded JAK

hold on
std_velocity_JAK_profile_interp= fillgaps(interp1(dist,std_velocity_JAK_profile,dist,'PCHIP'));
%F = fillgaps(double(std_velocity_FJ_profile/1000));

fill_STD_JAK=[(fillgaps(mean_velocity_JAK_profile)'+std_velocity_JAK_profile_interp), flip((fillgaps(mean_velocity_JAK_profile')-std_velocity_JAK_profile_interp))];
dist_JAK_fill=[dist , flip(dist)];
fill(dist_JAK_fill,fill_STD_JAK,[0.5 0.5 0.5],'FaceAlpha', 0.3,'linestyle','none');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PG
prof_DEM_PG=profile_ext(X_p_curve_PG,Y_p_curve_PG,GIMP_DEM,R_gimp);
prof_DEM_PG_dist_temp=0:((0.1916*999)/(length(prof_DEM_PG)-1)):(0.1916*999);
prof_DEM_PG=interp1(prof_DEM_PG_dist_temp,prof_DEM_PG,dist_PG,'cubic');

figure;
[AX_PG,H1_PG,H2_PG] = plotyy(dist_PG,mean_velocity_PG_profile/1000,dist_PG,prof_DEM_PG);

set(H1_PG,'LineStyle','none','marker','.','color','k','markersize',3);hold on;
set(H2_PG,'LineStyle','--','marker','none','color',[0.5 0.5 0.5],'linewidth',2);hold on;
box off
set(AX_PG(1),'ylim',[0 1.8],'Ycolor','k');
set(AX_PG(2),'ylim',[0 1400],'Ycolor',[0.5 0.5 0.5]);
xlim([0 200]);
%ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
grid off;
title('Petermann','fontsize',12,'fontweight','b');
xlabel('distance [km]','fontsize',12,'fontweight','b')
ylabel(AX_PG(1),'velocity [km/yr]','fontsize',12,'fontweight','b','color','k')
ylabel(AX_PG(2),'elevation [m]','fontsize',12,'fontweight','b','color','k')

set(AX_PG(1),'YTick',[0:0.2:1.8],'YTickLabel',[0:0.2:1.8],'fontsize',12)
set(AX_PG(2),'YTick',[0:200:1400],'YTickLabel',[0:200:1400],'fontsize',12)

hold on

% Across profiles:
%PG1:
plot([dist_PG2(268) dist_PG2(268)], [0 0.1], 'color','b','linestyle','-','linewidth',3);
%PG4:
plot([dist_PG2(489) dist_PG2(489)], [0 0.1], 'color','k','linestyle','-','linewidth',3);
%PG5:
plot([dist_PG2(771) dist_PG2(771)], [0 0.1], 'color','r','linestyle','-','linewidth',3);


% Floating area
% considering the most recent Ice front position (CCI) and the grounding line from

X_floating_PG=[dist_PG(504) dist_PG(504)];
Y_floating_PG=[-0.1 1.8];

plot(X_floating_PG,Y_floating_PG,'color',[0.5 0.5 0.5],'linestyle','--');


X_floating_PG=[dist_PG(1):((0.1916*1997)/(length(prof_curve_PG)-1)):dist_PG(998)];
Y_floating_PG=[ones(1,length(X_floating_PG))*-0.1 ones(1,length(X_floating_PG))*1.8];
X_floating_PG=[X_floating_PG flip(X_floating_PG)];
fill(X_floating_PG,Y_floating_PG,[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');



%%% Plot the STD shaded
hold on
std_velocity_PG_profile_interp= fillgaps(interp1(dist_PG,std_velocity_PG_profile/1000,dist_PG,'PCHIP'));
%F = fillgaps(double(std_velocity_FJ_profile/1000));

fill_STD_PG=[(fillgaps(mean_velocity_PG_profile)'/1000+std_velocity_PG_profile_interp), flip((fillgaps(mean_velocity_PG_profile')/1000-std_velocity_PG_profile_interp))];
dist_PG_fill=[dist_PG , flip(dist_PG)];
fill(dist_PG_fill,fill_STD_PG,[0.5 0.5 0.5],'FaceAlpha', 0.3,'linestyle','none');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% FJ
prof_DEM_FJ=profile_ext(X_p_curve_FJ,Y_p_curve_FJ,GIMP_DEM,R_gimp);
prof_DEM_FJ_dist_temp=0:((0.1916*999)/(length(prof_DEM_FJ)-1)):(0.1916*999);
prof_DEM_FJ=interp1(prof_DEM_FJ_dist_temp,prof_DEM_FJ,dist_FJ,'cubic');

figure;
[AX_FJ,H1_FJ,H2_FJ] = plotyy(dist_FJ,mean_velocity_FJ_profile/1000,dist_FJ,prof_DEM_FJ);
set(H1_FJ,'LineStyle','none','marker','.','color','k','markersize',3);hold on;
set(H2_FJ,'LineStyle','--','marker','none','color',[0.5 0.5 0.5],'linewidth',2);hold on;
box off
set(AX_FJ(1),'ylim',[0 1.6],'Ycolor','k');
set(AX_FJ(2),'ylim',[0 1600],'Ycolor',[0.5 0.5 0.5]);
xlim([0 200]);
%ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
grid off;
title('79-Fjord','fontsize',12,'fontweight','b');
xlabel('distance [km]','fontsize',12,'fontweight','b')
ylabel(AX_FJ(1),'velocity [km/yr]','fontsize',12,'fontweight','b','color','k')
ylabel(AX_FJ(2),'elevation [m]','fontsize',12,'fontweight','b','color','k')

set(AX_FJ(1),'YTick',[0:0.2:1.6],'YTickLabel',[0:0.2:1.6],'fontsize',12)
set(AX_FJ(2),'YTick',[0:200:1600],'YTickLabel',[0:200:1600],'fontsize',12)

hold on

% Across profiles:
%FJ1:
plot([dist_FJ2(48) dist_FJ2(48)], [0 0.1], 'color','b','linestyle','-','linewidth',3);
%FJ2:
plot([dist_FJ2(171) dist_FJ2(171)], [0 0.1], 'color','k','linestyle','-','linewidth',3);
%FJ3:
plot([dist_FJ2(479) dist_FJ2(479)], [0 0.1], 'color','r','linestyle','-','linewidth',3);


% Floating area
% considering the most recent Ice front position (CCI) and the grounding line from 
X_floating_FJ=[dist_FJ(1):((0.1916*999*2)/(length(prof_curve_FJ)-1)):dist_FJ(193*2)];
Y_floating_FJ=[zeros(1,length(X_floating_FJ)) ones(1,length(X_floating_FJ))*1.8];
X_floating_FJ=[X_floating_FJ flip(X_floating_FJ)];
fill(X_floating_FJ,Y_floating_FJ,[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');

%%% Plot the STD shaded
hold on
std_velocity_FJ_profile_interp= fillgaps(interp1(dist_FJ,std_velocity_FJ_profile/1000,dist_FJ,'PCHIP'));
%F = fillgaps(double(std_velocity_FJ_profile/1000));

fill_STD_FJ=[(fillgaps(mean_velocity_FJ_profile)'/1000+std_velocity_FJ_profile_interp), flip((fillgaps(mean_velocity_FJ_profile')/1000-std_velocity_FJ_profile_interp))];
dist_FJ_fill=[dist_FJ , flip(dist_FJ)];
fill(dist_FJ_fill,fill_STD_FJ,[0.5 0.5 0.5],'FaceAlpha', 0.3,'linestyle','none');



%% JAK

cd /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/Stack_Data/filtered

[Vel_Stack,R_stack]=geotiffread('stack_filtered3.tif');

%Profile JAK 1

% prof_shp = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/ArcGIS/Profiles/Profile_JAK/New_prof_JAK.shp');
% X_p=extractfield(prof_shp,'X');
% Y_p=extractfield(prof_shp,'Y');
% 
% X_p=X_p(~isnan(X_p));
% Y_p=Y_p(~isnan(Y_p));


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

%%% Introducing the nan's

Vel_Stack(Vel_Stack<=0)=nan;


%%% Extracting the profiles

prof_curve_JAK=nan(999,19);

prof_across_JAK1=nan(999,19);
prof_across_JAK2=nan(999,19);
prof_across_JAK3=nan(999,19);

for i=1:19 
prof_across_JAK1(:,i)=profile_ext(X_across_JAK1,Y_across_JAK1,Vel_Stack(:,:,i),R_stack);
prof_across_JAK2(:,i)=profile_ext(X_across_JAK2,Y_across_JAK2,Vel_Stack(:,:,i),R_stack);
prof_across_JAK3(:,i)=profile_ext(X_across_JAK3,Y_across_JAK3,Vel_Stack(:,:,i),R_stack);

prof_curve_JAK(:,i)=profile_ext(X_p_curve_JAK,Y_p_curve_JAK,Vel_Stack(:,:,i),R_stack);
end


% Plotting

for i= 1:19
figure(1);plot(prof_across_JAK1(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
title('JAK1','fontsize',12,'fontweight','b');

figure(2);plot(prof_across_JAK2(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
title('JAK2','fontsize',12,'fontweight','b');

figure(3);plot(prof_across_JAK3(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
title('JAK3','fontsize',12,'fontweight','b');

% figure(4);plot(prof_shp_JAK(:,i),'.');hold on;
% ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
% title('profile','fontsize',12,'fontweight','b');

figure(5);plot(prof_curve_JAK(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
title('Velocity Profile','fontsize',12,'fontweight','b');
end

% Plot across profiles:

dist_across_JAK1=0:((0.0112*999)/(length(prof_across_JAK1)-1)):(0.0112*999);
dist_across_JAK2=0:((0.0165*999)/(length(prof_across_JAK2)-1)):(0.0165*999);
dist_across_JAK3=0:((0.0137*999)/(length(prof_across_JAK3)-1)):(0.0137*999);

dist_across_JAK1_=(-0.0112*576):((0.0112*999)/(length(prof_across_JAK1)-1)):(0.0112*(999-576));
dist_across_JAK2_=(-0.0165*483):((0.0165*999)/(length(prof_across_JAK2)-1)):(0.0165*(999-483));
dist_across_JAK3_=(-0.0137*432):((0.0137*999)/(length(prof_across_JAK3)-1)):(0.0137*(999-432));


figure;
plot(dist_across_JAK1,nanmean(prof_across_JAK1,2),'.','color','b');hold on
plot(dist_across_JAK2,nanmean(prof_across_JAK2,2),'.','color','k');
plot(dist_across_JAK3,nanmean(prof_across_JAK3,2),'.','color','r');
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
xlabel('distance [km]','fontsize',12,'fontweight','b')
%title('Velocity Profile','fontsize',12,'fontweight','b');
legend('JAK1','JAK2','JAK3');
grid on;

% plot cross profile with the main profile as reference

    % The image product resolution is 90m and the across profiles are in
    % high spatial resolution, so I have to undersample them in order to
    % not get repeatedly values

prof_across_JAK1_mean= nanmean(prof_across_JAK1,2);
prof_across_JAK2_mean= nanmean(prof_across_JAK2,2);  
prof_across_JAK3_mean= nanmean(prof_across_JAK3,2);


figure;
plot(flip(dist_across_JAK1_(1:8:end))*(-1),flip(prof_across_JAK1_mean(1:8:end)),'color','b', 'LineWidth',2);hold on
plot(flip(dist_across_JAK2_(1:6:end))*(-1),flip(prof_across_JAK2_mean(1:6:end)),'color','k','LineWidth',2);
plot(flip(dist_across_JAK3_(1:6:end))*(-1),flip(prof_across_JAK3_mean(1:6:end)),'color','r','LineWidth',2);
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
xlabel('distance [km]','fontsize',12,'fontweight','b')
%title('Velocity Profile','fontsize',12,'fontweight','b');
legend('JAK1','JAK2','JAK3');

hold on

annotation(gcf,'textarrow',[0.198214285714286 0.2],...
    [0.718047619047619 0.826190476190476],'String',{'Flow'});

plot([0 0],[0 9],'color',[0 0.5 0],'linewidth',2);

% Plotting the spread variation (min & max) in the across profiles:

%JAK1
prof_across_JAK1_max = interp1(dist_across_JAK1_(1:8:end),nanmax(prof_across_JAK1(1:8:end,:),[],2),dist_across_JAK1_(1:8:end),'spline');
prof_across_JAK1_min = interp1(dist_across_JAK1_(1:8:end),nanmin(prof_across_JAK1(1:8:end,:),[],2),dist_across_JAK1_(1:8:end),'spline');

fill_across_JAK1=[prof_across_JAK1_max, flip(prof_across_JAK1_min)];
dist_across_JAK1_fill=[dist_across_JAK1_(1:8:end) , flip(dist_across_JAK1_(1:8:end))];
fill(flip(dist_across_JAK1_fill)*(-1),flip(fill_across_JAK1),'b','FaceAlpha', 0.3,'linestyle','none');

%JAK2
prof_across_JAK2_max = interp1(dist_across_JAK2_(1:6:end),nanmax(prof_across_JAK2(1:6:end,:),[],2),dist_across_JAK2_(1:6:end),'spline');
prof_across_JAK2_min = interp1(dist_across_JAK2_(1:6:end),nanmin(prof_across_JAK2(1:6:end,:),[],2),dist_across_JAK2_(1:6:end),'spline');

fill_across_JAK2=[prof_across_JAK2_max, flip(prof_across_JAK2_min)];
dist_across_JAK2_fill=[dist_across_JAK2_(1:6:end) , flip(dist_across_JAK2_(1:6:end))];
fill(flip(dist_across_JAK2_fill)*(-1),flip(fill_across_JAK2),[0.5 0.5 0.5],'FaceAlpha', 0.3,'linestyle','none');

%JAK3
prof_across_JAK3_max = interp1(dist_across_JAK3_(1:6:end),nanmax(prof_across_JAK3(1:6:end,:),[],2),dist_across_JAK3_(1:6:end),'spline');
prof_across_JAK3_min = interp1(dist_across_JAK3_(1:6:end),nanmin(prof_across_JAK3(1:6:end,:),[],2),dist_across_JAK3_(1:6:end),'spline');

fill_across_JAK3=[prof_across_JAK3_max, flip(prof_across_JAK3_min)];
dist_across_JAK3_fill=[dist_across_JAK3_(1:6:end) , flip(dist_across_JAK3_(1:6:end))];
fill(flip(dist_across_JAK3_fill)*(-1),flip(fill_across_JAK3),'r','FaceAlpha', 0.3,'linestyle','none');


% STD shading
% Plotting across profiles with the main profile as reference 

figure;
plot(flip(dist_across_JAK1_(1:8:end))*(-1),flip(prof_across_JAK1_mean(1:8:end)),'color','b', 'LineWidth',2);hold on
plot(flip(dist_across_JAK2_(1:6:end))*(-1),flip(prof_across_JAK2_mean(1:6:end)),'color','k','LineWidth',2);
plot(flip(dist_across_JAK3_(1:6:end))*(-1),flip(prof_across_JAK3_mean(1:6:end)),'color','r','LineWidth',2);
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
xlabel('distance [km]','fontsize',12,'fontweight','b')
%title('Velocity Profile','fontsize',12,'fontweight','b');
legend('JAK1','JAK2','JAK3');

hold on

% Plotting the spread variation (min & max) in the across profiles:

%JAK1

std_velocity_JAK1_across=nanstd(prof_across_JAK1(1:8:end,:),1,2);
std_velocity_JAK1_across_interp = flip(interp1(dist_across_JAK1_(1:8:end),std_velocity_JAK1_across,dist_across_JAK1_(1:8:end),'spline'));

fill_across_JAK1_STD=fillgaps([prof_across_JAK1_mean(1:8:end)'+std_velocity_JAK1_across_interp, flip(prof_across_JAK1_mean(1:8:end)'-std_velocity_JAK1_across_interp)]);
dist_across_JAK1_fill=fillgaps([dist_across_JAK1_(1:8:end) , flip(dist_across_JAK1_(1:8:end))]);
fill(flip(dist_across_JAK1_fill)*(-1),flip(fill_across_JAK1_STD),'b','FaceAlpha', 0.3,'linestyle','none');

%JAK2
std_velocity_JAK2_across=nanstd(prof_across_JAK2(1:6:end,:),1,2);
std_velocity_JAK2_across_interp = flip(interp1(dist_across_JAK2_(1:6:end),std_velocity_JAK2_across,dist_across_JAK2_(1:6:end),'spline'));

fill_across_JAK2_STD=fillgaps([prof_across_JAK2_mean(1:6:end)'+std_velocity_JAK2_across_interp, flip(prof_across_JAK2_mean(1:6:end)'-std_velocity_JAK2_across_interp)]);
dist_across_JAK2_fill=fillgaps([dist_across_JAK2_(1:6:end) , flip(dist_across_JAK2_(1:6:end))]);
fill(flip(dist_across_JAK2_fill)*(-1),flip(fill_across_JAK2_STD),[0.5 0.5 0.5],'FaceAlpha', 0.3,'linestyle','none');

%JAK3
std_velocity_JAK3_across=nanstd(prof_across_JAK3(1:6:end,:),1,2);
std_velocity_JAK3_across_interp = flip(interp1(dist_across_JAK3_(1:6:end),std_velocity_JAK3_across,dist_across_JAK3_(1:6:end),'spline'));

fill_across_JAK3_STD=fillgaps([prof_across_JAK3_mean(1:6:end)'+std_velocity_JAK3_across_interp, flip(prof_across_JAK3_mean(1:6:end)'-std_velocity_JAK3_across_interp)]);
dist_across_JAK3_fill=fillgaps([dist_across_JAK3_(1:6:end) , flip(dist_across_JAK3_(1:6:end))]);
fill(flip(dist_across_JAK3_fill)*(-1),flip(fill_across_JAK3_STD),'r','FaceAlpha', 0.3,'linestyle','none');

annotation(gcf,'textarrow',[0.226785714285714 0.226785714285714],...
    [0.710904761904762 0.842857142857143],'String',{'Flow'});

plot([0 0],[0 7],'color',[0 0.5 0],'linewidth',2);




% Remove the mean from the time serie
remov_mean_prof_curve=nan(999,19);
for i=1:19
remov_mean_prof_curve(:,i)=prof_curve_JAK(:,i)-(nanmean(prof_curve_JAK,2));
plot(remov_mean_prof_curve(:,i),'.');hold on;
ylim([-5 5])
end

%%% Dist relative to the prof_curve_JAK
dist=0:((0.048957*999)/(length(prof_curve_JAK)-1)):(0.048957*999);


% figure;
% plot(dist,prof_S1_fev,'.'); hold on;
% plot(dist,prof_S1_mar,'.');
% plot(dist,prof_S1_apr,'.');
% plot(dist,prof_S1_may,'.');
% plot(dist,prof_S1_jun,'.');
% plot(dist,prof_S1_jul,'.');
% plot(dist,prof_S1_aug,'.');
% 
% ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
% xlabel('distance [km]','fontsize',12,'fontweight','b')
% legend('fev', 'mar', 'apr', 'may', 'jun', 'jul','aug')



vel=stack;
vel(vel<=0)=nan;

for i=1:19

subplot(7,3,i);
h=imagesc(vel(:,:,i));
tt=double(~isnan(vel(:,:,i))); set(h,'AlphaData', tt);
axis off;

caxis([0 5])

end

%%% Plot profiles from profile curve:
for i=1:19
figure(5);plot(dist,prof_curve_JAK(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
title('Velocity Profile','fontsize',12,'fontweight','b');
grid on
xlabel('distance [km]','fontsize',12,'fontweight','b')

end


%%% Estimate STD for the stack data

std_velocity_stack_JAK=std(stack,1,3);
std_velocity_stack_JAK(std_velocity_stack_JAK<=0)=nan;

%STD profile JAK

std_velocity_JAK_profile=nanstd(prof_curve_JAK,1,2);

figure;plot(dist,std_velocity_JAK_profile,'.');hold on;
%ylabel('std JAK [km/yr]','fontsize',12,'fontweight','b')
ylim([0 6])
grid on;
title('STD profile','fontsize',12,'fontweight','b');

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/Stack_Data/filtered/stack_filtered3.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/std_stack_JAK.tif', std_velocity_stack_JAK, Rstack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


%%% Mean and Median velocity

median_velocity_stack_JAK=nanmedian(Vel_Stack,3);
mean_velocity_stack_JAK=nanmean(Vel_Stack,3);

median_velocity_stack_JAK(median_velocity_stack_JAK<=0)=nan;
mean_velocity_stack_JAK(mean_velocity_stack_JAK<=0)=nan;
mean_velocity_stack_JAK_log=log10(mean_velocity_stack_JAK);

median_velocity_JAK_profile=profile_ext(X_p_curve_JAK,Y_p_curve_JAK,median_velocity_stack_JAK,R_stack);
mean_velocity_JAK_profile=profile_ext(X_p_curve_JAK,Y_p_curve_JAK,mean_velocity_stack_JAK,R_stack);

% subplot(1,2,1);plot(dist,median_velocity_JAK_profile,'.');hold on;
% ylim([0 20]);
% xlim([0 60]);
% grid on;
% title('Median velocity profile','fontsize',12,'fontweight','b');
% 
% subplot(1,2,2);
plot(dist,mean_velocity_JAK_profile,'.','color','k','markersize',3);hold on;
ylim([0 20]);
xlim([0 55]);
%ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
grid on;
title('Mean velocity profile','fontsize',12,'fontweight','b');
xlabel('distance [km]','fontsize',12,'fontweight','b')
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')

hold on

% Floating area (Just a line for JAK -> Rosenau, R. et al., 2013. Grounding line migration and high-resolution calving dynamics of Jakobshavn Isbræ, West Greenland. Journal of Geophysical Research: Earth Surface, 118(2), pp.382–395.
% the ice front / GL referent to 19/08/2015 (after the calving event)

X_floating_JAK=[dist(137) dist(137)];
Y_floating_JAK=[0 20];

plot(X_floating_JAK,Y_floating_JAK,'color',[0.5 0.5 0.5],'linestyle','--');


X_floating_JAK=[dist(1):((0.048957*999)/(length(prof_curve_JAK)-1)):dist(137)];
Y_floating_JAK=[zeros(1,length(X_floating_JAK)) ones(1,length(X_floating_JAK))*20];
X_floating_JAK=[X_floating_JAK flip(X_floating_JAK)];
fill(X_floating_JAK,Y_floating_JAK,[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');


% STD shaded JAK

hold on
std_velocity_JAK_profile_interp= fillgaps(interp1(dist,std_velocity_JAK_profile,dist,'PCHIP'));
%F = fillgaps(double(std_velocity_FJ_profile/1000));

fill_STD_JAK=[(fillgaps(mean_velocity_JAK_profile)'+std_velocity_JAK_profile_interp), flip((fillgaps(mean_velocity_JAK_profile')-std_velocity_JAK_profile_interp))];
dist_JAK_fill=[dist , flip(dist)];
fill(dist_JAK_fill,fill_STD_JAK,[0.5 0.5 0.5],'FaceAlpha', 0.3,'linestyle','none');

% temporal variation shaded JAK

hold on
prof_curve_JAK_max = interp1(dist,max(prof_curve_JAK,[],2),dist,'PCHIP');
prof_curve_JAK_min = interp1(dist,min(prof_curve_JAK,[],2),dist,'PCHIP');

fill_JAK=[prof_curve_JAK_max, flip(prof_curve_JAK_min)];
dist_JAK_fill=[dist , flip(dist)];
fill(dist_JAK_fill,fill_JAK,[0.5 0.5 0.5],'FaceAlpha', 0.3,'linestyle','none');

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/Stack_Data/filtered/stack_filtered3.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/median_stack_JAK.tif', median_velocity_stack_JAK, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/mean_stack_JAK.tif', mean_velocity_stack_JAK, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/mean_stack_JAK_log.tif', mean_velocity_stack_JAK_log, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


% Seasonal Map JAK

%%%%%%%%%%%%%%%%%%%%%%%%%
%Sole, A. et al., 2013. Winter motion mediates dynamic response of the Greenland Ice Sheet to warmer summers. Geophysical Research Letters, 40(15), pp.3940–3944.
% Summer May-Aug
% Winter Sept-April Oct-March
%%%%%%%%%%%%%%%%%%%%%%%%%
JAK_summer= Vel_Stack(:,:,[11:15]);
JAK_winter= Vel_Stack(:,:,[1:10 16:19]);

JAK_summer(JAK_summer<=0)=nan;
JAK_winter(JAK_winter<=0)=nan;

JAK_mean_summer=nanmean(JAK_summer,3);
JAK_mean_winter=nanmean(JAK_winter,3);

JAK_mean_summer(JAK_mean_summer<=0)=nan;

%JAK_summer_minus_winter=JAK_mean_summer-JAK_mean_winter(~isnan(JAK_mean_summer));
JAK_summer_minus_winter_temp=JAK_mean_summer(~isnan(JAK_mean_summer))-JAK_mean_winter(~isnan(JAK_mean_summer));
JAK_summer_minus_winter=nan(size(JAK_mean_summer,1),size(JAK_mean_summer,2));
JAK_summer_minus_winter(~isnan(JAK_mean_summer))=JAK_summer_minus_winter_temp;


info = geotiffinfo('./stack_filtered3.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/JAK_summer.tif', JAK_mean_summer, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/JAK_winter.tif', JAK_mean_winter, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/JAK_summer_minus_winter.tif', JAK_summer_minus_winter, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Changing the summer/winter months
%%%%%%%%%%%%%%%%%%%%%%%%%
% summer: Jun to Aug
% winter: November to Mar
%%%%%%%%%%%%%%%%%%%%%%%%%
JAK_summer2= Vel_Stack(:,:,[12:15]);
JAK_winter2= Vel_Stack(:,:,[1:8 18:19]);

JAK_summer2(JAK_summer2<=0)=nan;
JAK_winter2(JAK_summer2<=0)=nan;

JAK_mean_summer2=nanmean(JAK_summer2,3);
JAK_mean_winter2=nanmean(JAK_winter2,3);


JAK_mean_summer2(JAK_mean_summer2<=0)=nan;

%JAK_summer_minus_winter=JAK_mean_summer-JAK_mean_winter(~isnan(JAK_mean_summer));
JAK_summer_mean_minus_winter_temp2=JAK_mean_summer2(~isnan(JAK_mean_summer2))-JAK_mean_winter2(~isnan(JAK_mean_summer2));
JAK_summer_mean_minus_winter2=nan(size(JAK_mean_summer2,1),size(JAK_mean_summer2,2));
JAK_summer_mean_minus_winter2(~isnan(JAK_mean_summer2))=JAK_summer_mean_minus_winter_temp2;

JAK_summer_mean_divided_winter_temp2=JAK_mean_summer2(~isnan(JAK_mean_summer2))./JAK_mean_winter2(~isnan(JAK_mean_summer2));
JAK_summer_mean_divided_winter2=nan(size(JAK_mean_summer2,1),size(JAK_mean_summer2,2));
JAK_summer_mean_divided_winter2(~isnan(JAK_mean_summer2))=JAK_summer_mean_divided_winter_temp2;


%JAK_summer_minus_winter=JAK_mean_summer-JAK_mean_winter;

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/Stack_Data/filtered/stack_filtered3.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/JAK_mean_summer2.tif', JAK_mean_summer2, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/JAK_mean_winter2.tif', JAK_mean_winter2, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/JAK_mean_summer_mean_minus_winter2.tif', JAK_summer_mean_minus_winter2, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/JAK_summer_mean_divided_winter22.tif', JAK_summer_mean_divided_winter2, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

% median

JAK_median_summer2=nanmedian(JAK_summer2,3);
JAK_median_winter2=nanmedian(JAK_winter2,3);

JAK_median_summer2(JAK_median_summer2<=0)=nan;

JAK_summer_median_minus_winter_temp2=JAK_median_summer2(~isnan(JAK_median_summer2))-JAK_median_winter2(~isnan(JAK_median_summer2));
JAK_summer_median_minus_winter2=nan(size(JAK_median_summer2,1),size(JAK_median_summer2,2));
JAK_summer_median_minus_winter2(~isnan(JAK_median_summer2))=JAK_summer_median_minus_winter_temp2;

JAK_summer_median_divided_winter_temp2=JAK_median_summer2(~isnan(JAK_median_summer2))./JAK_median_winter2(~isnan(JAK_median_summer2));
JAK_summer_median_divided_winter2=nan(size(JAK_median_summer2,1),size(JAK_median_summer2,2));
JAK_summer_median_divided_winter2(~isnan(JAK_median_summer2))=JAK_summer_median_divided_winter_temp2;


%JAK_summer_minus_winter=JAK_median_summer-JAK_median_winter;

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/Stack_Data/filtered/stack_filtered3.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/JAK_median_summer2.tif', JAK_median_summer2, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/JAK_median_winter2.tif', JAK_median_winter2, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/JAK_median_summer_median_minus_winter2.tif', JAK_summer_median_minus_winter2, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PG

% Load the stack data

cd /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/

[stack_PG,Rstack_PG]=geotiffread('PG_stack_DuFil.tif');


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


%Profile Tributary PG

prof_across_PG_tribut = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/Qgis/PG_tribut_pt.shp');
X_across_PG_tribut=extractfield(prof_across_PG_tribut,'X');
Y_across_PG_tribut=extractfield(prof_across_PG_tribut,'Y');

X_across_PG_tribut=X_across_PG_tribut(~isnan(X_across_PG_tribut));
Y_across_PG_tribut=Y_across_PG_tribut(~isnan(Y_across_PG_tribut));


% Introducing the nan's
stack_PG(stack_PG<=0)=nan;

% Extract the profiles

prof_curve_PG=nan(1997,24);

prof_across_PG1=nan(999,24);
prof_across_PG2=nan(999,24);
prof_across_PG3=nan(999,24);
prof_across_PG4=nan(999,24);
prof_across_PG5=nan(999,24);
prof_across_PG_tribut=nan(999,24);

for i=1:24 
prof_across_PG1(:,i)=profile_ext(X_across_PG1,Y_across_PG1,stack_PG(:,:,i),Rstack_PG);
prof_across_PG2(:,i)=profile_ext(X_across_PG2,Y_across_PG2,stack_PG(:,:,i),Rstack_PG);
prof_across_PG3(:,i)=profile_ext(X_across_PG3,Y_across_PG3,stack_PG(:,:,i),Rstack_PG);
prof_across_PG4(:,i)=profile_ext(X_across_PG4,Y_across_PG4,stack_PG(:,:,i),Rstack_PG);
prof_across_PG5(:,i)=profile_ext(X_across_PG5,Y_across_PG5,stack_PG(:,:,i),Rstack_PG);
prof_across_PG_tribut(:,i)=profile_ext(X_across_PG_tribut,Y_across_PG_tribut,stack_PG(:,:,i),Rstack_PG);

prof_curve_PG(:,i)=profile_ext(X_p_curve_PG,Y_p_curve_PG,stack_PG(:,:,i),Rstack_PG);

end

% Plotting the profiles

%%% Dist relative to the prof_curve_PG

dist_PG=0:((0.1916*999)/(length(prof_curve_PG)-1)):(0.1916*999);


for i=1:24 

figure(1);plot(prof_across_PG1(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
title('PG1','fontsize',12,'fontweight','b');

figure(2);plot(prof_across_PG2(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
title('PG2','fontsize',12,'fontweight','b');

figure(3);plot(prof_across_PG3(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
title('PG3','fontsize',12,'fontweight','b');

figure(4);plot(prof_across_PG4(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
title('PG4','fontsize',12,'fontweight','b');

figure(5);plot(prof_across_PG5(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
title('PG5','fontsize',12,'fontweight','b');

figure(6);plot(prof_across_PG_tribut(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
title('PG tributary','fontsize',12,'fontweight','b');

figure(7);plot(dist_PG, prof_curve_PG(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b');
xlabel('distance [km]','fontsize',12,'fontweight','b');

title('Velocity Profile','fontsize',12,'fontweight','b');
end


% Plot across profiles:
% PG4 and PG5 represent PG2 and PG3 in the map(fig1-paper)

dist_across_PG1=0:((24.82957)/(length(prof_across_PG1)-1)):(24.82957);
dist_across_PG4=0:((24.8110)/(length(prof_across_PG4)-1)):(24.8110);
dist_across_PG5=0:((47.13382)/(length(prof_across_PG5)-1)):(47.13382);

% setting the cross distances with the main profile as reference:
dist_across_PG1_=(-0.0249*506):((0.0249*999)/(length(prof_across_PG1)-1)):(0.0249*(999-506));
dist_across_PG4_=-0.0248*423:((0.0248*999)/(length(prof_across_PG4)-1)):(0.0248*(999-423));
dist_across_PG5_=-0.0472*469:((0.0472*999)/(length(prof_across_PG5)-1)):(0.0472*(999-469));


figure;
plot(dist_across_PG1,nanmean(prof_across_PG1/1000,2),'.','color','b');hold on
plot(dist_across_PG4,nanmean(prof_across_PG4/1000,2),'.','color','k');
plot(dist_across_PG5,nanmean(prof_across_PG5/1000,2),'.','color','r');
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
xlabel('distance [km]','fontsize',12,'fontweight','b')
%title('Velocity Profile','fontsize',12,'fontweight','b');
legend('PG1','PG2','PG3');
grid on;

% Plotting the cross profs with the main profile as reference:

    % The image product resolution is 90m and the across profiles are in
    % high spatial resolution, so I have to undersample them in order to
    % not get repeatedly values

prof_across_PG1_mean= nanmean(prof_across_PG1/1000,2);
prof_across_PG4_mean= nanmean(prof_across_PG4/1000,2);  
prof_across_PG5_mean= nanmean(prof_across_PG5/1000,2);

figure;
plot(dist_across_PG1_(1:4:end),fillgaps(prof_across_PG1_mean(1:4:end)),'color','b','LineWidth',2);hold on
plot(dist_across_PG4_(1:4:end),fillgaps(prof_across_PG4_mean(1:4:end)),'color','k','LineWidth',2);
plot(dist_across_PG5_(1:2:end),fillgaps(prof_across_PG5_mean(1:2:end)),'color','r','LineWidth',2);
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
xlabel('distance [km]','fontsize',12,'fontweight','b')
%title('Velocity Profile','fontsize',12,'fontweight','b');
legend('PG1','PG2','PG3');
grid off;

annotation(gcf,'textarrow',[0.198214285714286 0.2],...
    [0.718047619047619 0.826190476190476],'String',{'Flow'});

plot([0 0],[0 1.6],'color',[0 0.5 0],'linewidth',2);


    % Plotting the spread variation (min & max) in the across profiles:
hold on

%PG1
prof_across_PG1_max = interp1(dist_across_PG1_(1:4:end),nanmax(prof_across_PG1(1:4:end,:),[],2),dist_across_PG1_(1:4:end),'spline');
prof_across_PG1_min = interp1(dist_across_PG1_(1:4:end),nanmin(prof_across_PG1(1:4:end,:),[],2),dist_across_PG1_(1:4:end),'spline');

fill_across_PG1=[prof_across_PG1_max, flip(prof_across_PG1_min)];
dist_across_PG1_fill=[dist_across_PG1_(1:4:end) , flip(dist_across_PG1_(1:4:end))];
fill(dist_across_PG1_fill,fill_across_PG1/1000,'b','FaceAlpha', 0.3,'linestyle','none');

%PG4
prof_across_PG4_max = interp1(dist_across_PG4_(1:4:end),nanmax(prof_across_PG4(1:4:end,:),[],2),dist_across_PG4_(1:4:end),'spline');
prof_across_PG4_min = interp1(dist_across_PG4_(1:4:end),nanmin(prof_across_PG4(1:4:end,:),[],2),dist_across_PG4_(1:4:end),'spline');

fill_across_PG4=[prof_across_PG4_max, flip(prof_across_PG4_min)];
dist_across_PG4_fill=[dist_across_PG4_(1:4:end) , flip(dist_across_PG4_(1:4:end))];
fill(dist_across_PG4_fill,fill_across_PG4/1000,[0.5 0.5 0.5],'FaceAlpha', 0.3,'linestyle','none');

%PG5
prof_across_PG5_max = interp1(dist_across_PG5_(1:2:end),nanmax(prof_across_PG5(1:2:end,:),[],2),dist_across_PG5_(1:2:end),'spline');
prof_across_PG5_min = interp1(dist_across_PG5_(1:2:end),nanmin(prof_across_PG5(1:2:end,:),[],2),dist_across_PG5_(1:2:end),'spline');

fill_across_PG5=[prof_across_PG5_max, flip(prof_across_PG5_min)];
dist_across_PG5_fill=[dist_across_PG5_(1:2:end) , flip(dist_across_PG5_(1:2:end))];
fill(dist_across_PG5_fill,fill_across_PG5/1000,'r','FaceAlpha', 0.3,'linestyle','none');

%%% Plotting the STD shadow across profiles

figure;
plot(dist_across_PG1_(1:4:end),fillgaps(prof_across_PG1_mean(1:4:end)),'color','b','LineWidth',2);hold on
plot(dist_across_PG4_(1:4:end),fillgaps(prof_across_PG4_mean(1:4:end)),'color','k','LineWidth',2);
plot(dist_across_PG5_(1:2:end),fillgaps(prof_across_PG5_mean(1:2:end)),'color','r','LineWidth',2);
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
xlabel('distance [km]','fontsize',12,'fontweight','b')
%title('Velocity Profile','fontsize',12,'fontweight','b');
legend('PG1','PG2','PG3');
grid off;

annotation(gcf,'textarrow',[0.24910394265233 0.24910394265233],...
    [0.707830548926014 0.818615751789976],'String',{'Flow'});

plot([0 0],[0 1.6],'color',[0 0.5 0],'linewidth',2);


%PG1
std_velocity_PG1_across=nanstd(prof_across_PG1(1:4:end,:),1,2);
std_velocity_PG1_across_interp = interp1(dist_across_PG1_(1:4:end),std_velocity_PG1_across,dist_across_PG1_(1:4:end),'spline');

fill_across_PG1_STD=[fillgaps(prof_across_PG1_mean(1:4:end))+std_velocity_PG1_across_interp'/1000; fillgaps(flip(prof_across_PG1_mean(1:4:end)))-std_velocity_PG1_across_interp'/1000];
dist_across_PG1_fill=fillgaps([dist_across_PG1_(1:4:end) , flip(dist_across_PG1_(1:4:end))]);
fill(dist_across_PG1_fill,fill_across_PG1_STD,'b','FaceAlpha', 0.3,'linestyle','none');


%PG4
std_velocity_PG4_across=nanstd(prof_across_PG4(1:4:end,:),1,2);
std_velocity_PG4_across_interp = interp1(dist_across_PG4_(1:4:end),std_velocity_PG4_across,dist_across_PG4_(1:4:end),'spline');

fill_across_PG4_STD=fillgaps([prof_across_PG4_mean(1:4:end)'+std_velocity_PG4_across_interp/1000, flip(prof_across_PG4_mean(1:4:end)'-std_velocity_PG4_across_interp/1000)]);
dist_across_PG4_fill=fillgaps([dist_across_PG4_(1:4:end) , flip(dist_across_PG4_(1:4:end))]);
fill(dist_across_PG4_fill,fill_across_PG4_STD,[0.5 0.5 0.5],'FaceAlpha', 0.3,'linestyle','none');

%PG5
std_velocity_PG5_across=nanstd(prof_across_PG5(1:2:end,:),1,2);
std_velocity_PG5_across_interp = interp1(dist_across_PG5_(1:2:end),std_velocity_PG5_across,dist_across_PG5_(1:2:end),'spline');

fill_across_PG5_STD=fillgaps([prof_across_PG5_mean(1:2:end)'+std_velocity_PG5_across_interp/1000, flip(prof_across_PG5_mean(1:2:end)'-std_velocity_PG5_across_interp/1000)]);
dist_across_PG5_fill=fillgaps([dist_across_PG5_(1:2:end) , flip(dist_across_PG5_(1:2:end))]);
fill(dist_across_PG5_fill,fill_across_PG5_STD,'r','FaceAlpha', 0.3,'linestyle','none');

ylim([0 1.6])




vel=stack_PG;
vel(vel<=0)=nan;

for i=1:24

subplot(7,4,i);
h=imagesc(vel(:,:,i)/1000);
tt=double(~isnan(vel(:,:,i))); set(h,'AlphaData', tt);
axis off;

caxis([0 1.2])

end

%%% Plot profiles from profile curve:
for i=1:24
figure(5);plot(dist_PG,prof_curve_PG(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
title('Velocity Profile','fontsize',12,'fontweight','b');
grid on
xlabel('distance [km]','fontsize',12,'fontweight','b')

end


%%% Estimate STD for the stack data

std_velocity_stack_PG=std(stack_PG,1,3);
std_velocity_stack_PG(std_velocity_stack_PG<=0)=nan;

std_velocity_PG_profile=nanstd(prof_curve_PG,1,2);

figure;plot(dist,std_velocity_PG_profile,'.');hold on;
%ylabel('std PG [km/yr]','fontsize',12,'fontweight','b')
ylim([0 6])
grid on;
title('STD profile','fontsize',12,'fontweight','b');

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/Stack_Data/filtered/stack_filtered3.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/std_stack_PG.tif', std_velocity_stack_PG, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


%%% Mean and Median velocity

median_velocity_stack_PG=nanmedian(stack_PG,3);
mean_velocity_stack_PG=nanmean(stack_PG,3);

median_velocity_stack_PG(median_velocity_stack_PG<=0)=nan;
mean_velocity_stack_PG(mean_velocity_stack_PG<=0)=nan;
mean_velocity_stack_PG_log=log10(mean_velocity_stack_PG/1000);


median_velocity_PG_profile=profile_ext(X_p_curve_PG,Y_p_curve_PG,median_velocity_stack_PG,Rstack_PG);
mean_velocity_PG_profile=profile_ext(X_p_curve_PG,Y_p_curve_PG,mean_velocity_stack_PG,Rstack_PG);

% subplot(1,2,1);
% plot(dist_PG,median_velocity_PG_profile/1000,'.');
% ylim([0 1.3]);
% xlim([0 200])
% ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
% grid on;
% title('Median velocity profile','fontsize',12,'fontweight','b');
% xlabel('distance [km]','fontsize',12,'fontweight','b')
% 
% subplot(1,2,2);
plot(dist_PG,mean_velocity_PG_profile/1000,'.','color','k','MARKERSIZE',3);
ylim([-0.1 1.8]);
xlim([0 200])
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
grid on;
title('Mean velocity profile','fontsize',12,'fontweight','b');
xlabel('distance [km]','fontsize',12,'fontweight','b')

hold on

% Floating area
% considering the most recent Ice front position (CCI) and the grounding line from

X_floating_PG=[dist_PG(504) dist_PG(504)];
Y_floating_PG=[-0.1 1.8];

plot(X_floating_PG,Y_floating_PG,'color',[0.5 0.5 0.5],'linestyle','--');


X_floating_PG=[dist_PG(1):((0.1916*1997)/(length(prof_curve_PG)-1)):dist_PG(998)];
Y_floating_PG=[ones(1,length(X_floating_PG))*-0.1 ones(1,length(X_floating_PG))*1.8];
X_floating_PG=[X_floating_PG flip(X_floating_PG)];
fill(X_floating_PG,Y_floating_PG,[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');



%%% Plot the STD shaded
hold on
std_velocity_PG_profile_interp= fillgaps(interp1(dist_PG,std_velocity_PG_profile/1000,dist_PG,'PCHIP'));
%F = fillgaps(double(std_velocity_FJ_profile/1000));

fill_STD_PG=[(fillgaps(mean_velocity_PG_profile)'/1000+std_velocity_PG_profile_interp), flip((fillgaps(mean_velocity_PG_profile')/1000-std_velocity_PG_profile_interp))];
dist_PG_fill=[dist_PG , flip(dist_PG)];
fill(dist_PG_fill,fill_STD_PG,[0.5 0.5 0.5],'FaceAlpha', 0.3,'linestyle','none');


%%% Plot the Time variation shaded

hold on
prof_curve_PG_max = interp1(dist_PG,max(prof_curve_PG,[],2),dist_PG,'PCHIP');
prof_curve_PG_min = interp1(dist_PG,min(prof_curve_PG,[],2),dist_PG,'PCHIP');

fill_PG=[prof_curve_PG_max, flip(prof_curve_PG_min)];
dist_PG_fill=[dist_PG , flip(dist_PG)];
fill(dist_PG_fill,fill_PG/1000,[0.5 0.5 0.5],'FaceAlpha', 0.3,'linestyle','none');


info = geotiffinfo('./PG_stack_DuFil.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/median_stack_PG.tif', median_velocity_stack_PG/1000, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/mean_stack_PG.tif', mean_velocity_stack_PG/1000, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/mean_stack_PG_log.tif', mean_velocity_stack_PG_log, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


% Seasonal Map PG

%%%%%%%%%%%%%%%%%%%%%%%%%
%Sole, A. et al., 2013. Winter motion mediates dynamic response of the Greenland Ice Sheet to warmer summers. Geophysical Research Letters, 40(15), pp.3940–3944.
% Summer Jun-Aug
% Winter Sept-April

%%%%%%%%%%%%%%%%%%%%%%%%%
PG_summer= stack_PG(:,:,[3:7 20:23]);
PG_winter= stack_PG(:,:,[1:2 8:19 24]);

PG_summer(PG_summer<=0)=nan;
PG_winter(PG_winter<=0)=nan;

PG_mean_summer=nanmean(PG_summer,3);
PG_mean_winter=nanmean(PG_winter,3);

PG_mean_summer(PG_mean_summer<=0)=nan;

%JAK_summer_minus_winter=JAK_mean_summer-JAK_mean_winter(~isnan(JAK_mean_summer));
PG_summer_minus_winter_temp=PG_mean_summer(~isnan(PG_mean_summer))-PG_mean_winter(~isnan(PG_mean_summer));
PG_summer_minus_winter=nan(size(PG_mean_summer,1),size(PG_mean_summer,2));
PG_summer_minus_winter(~isnan(PG_mean_summer))=PG_summer_minus_winter_temp;

%PG_summer_minus_winter=PG_mean_summer-PG_mean_winter;

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_stack_DuFil.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_summer.tif', PG_mean_summer/1000, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_winter.tif', PG_mean_winter/1000, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_summer_minus_winter.tif', PG_summer_minus_winter/1000, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Changing the summer/winter months

%%%%%%%%%%%%%%%%%%%%%%%%%
% summer: Jun to Aug
% winter: November to Mar
%%%%%%%%%%%%%%%%%%%%%%%%%
PG_summer2= stack_PG(:,:,[4:7 21:23]);
PG_winter2= stack_PG(:,:,[1:2 13:18]);

PG_summer2(PG_summer2<=0)=nan;
PG_winter2(PG_winter2<=0)=nan;

PG_mean_summer2=nanmean(PG_summer2,3);
PG_mean_winter2=nanmean(PG_winter2,3);


PG_mean_summer2(PG_mean_summer2<=0)=nan;

%JAK_summer_minus_winter=JAK_mean_summer-JAK_mean_winter(~isnan(JAK_mean_summer));
PG_summer_mean_minus_winter_temp2=PG_mean_summer2(~isnan(PG_mean_summer2))-PG_mean_winter2(~isnan(PG_mean_summer2));
PG_summer_mean_minus_winter2=nan(size(PG_mean_summer2,1),size(PG_mean_summer2,2));
PG_summer_mean_minus_winter2(~isnan(PG_mean_summer2))=PG_summer_mean_minus_winter_temp2;


PG_summer_mean_divided_winter_temp2=PG_mean_summer2(~isnan(PG_mean_summer2))./PG_mean_winter2(~isnan(PG_mean_summer2));
PG_summer_mean_divided_winter2=nan(size(PG_mean_summer2,1),size(PG_mean_summer2,2));
PG_summer_mean_divided_winter2(~isnan(PG_mean_summer2))=PG_summer_mean_divided_winter_temp2;


%PG_summer_minus_winter=PG_mean_summer-PG_mean_winter;

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_stack_DuFil.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_mean_summer2.tif', PG_mean_summer2/1000, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_mean_winter2.tif', PG_mean_winter2/1000, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_mean_summer_mean_minus_winter2.tif', PG_summer_mean_minus_winter2/1000, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_summer_mean_divided_winter2.tif', PG_summer_mean_divided_winter2, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

% median

PG_median_summer2=nanmedian(PG_summer2,3);
PG_median_winter2=nanmedian(PG_winter2,3);

PG_median_summer2(PG_median_summer2<=0)=nan;

PG_summer_median_minus_winter_temp2=PG_median_summer2(~isnan(PG_median_summer2))-PG_median_winter2(~isnan(PG_median_summer2));
PG_summer_median_minus_winter2=nan(size(PG_median_summer2,1),size(PG_median_summer2,2));
PG_summer_median_minus_winter2(~isnan(PG_median_summer2))=PG_summer_median_minus_winter_temp2;

%PG_summer_minus_winter=PG_median_summer-PG_median_winter;

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_stack_DuFil.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_median_summer2.tif', PG_median_summer2/1000, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_median_winter2.tif', PG_median_winter2/1000, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_median_summer_median_minus_winter2.tif', PG_summer_median_minus_winter2/1000, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);




%% FJ

% Load the stack data

cd /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/

[stack_FJ,Rstack_FJ]=geotiffread('FJ_stack_DuFil.tif');


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

prof_curve_FJ=nan(1997,23);

prof_across_FJ1=nan(999,23);
prof_across_FJ2=nan(999,23);
prof_across_FJ3=nan(999,23);

for i=1:23 
prof_across_FJ1(:,i)=profile_ext(X_across_FJ1,Y_across_FJ1,stack_FJ(:,:,i),Rstack_FJ);
prof_across_FJ2(:,i)=profile_ext(X_across_FJ2,Y_across_FJ2,stack_FJ(:,:,i),Rstack_FJ);
prof_across_FJ3(:,i)=profile_ext(X_across_FJ3,Y_across_FJ3,stack_FJ(:,:,i),Rstack_FJ);

prof_curve_FJ(:,i)=profile_ext(X_p_curve_FJ,Y_p_curve_FJ,stack_FJ(:,:,i),Rstack_FJ);

end

% Plotting the profiles

%%% Dist relative to the prof_curve_FJ

dist_FJ=0:((0.1916*999)/(length(prof_curve_FJ)-1)):(0.1916*999);


for i=1:23 

figure(1);plot(prof_across_FJ1(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
title('FJ1','fontsize',12,'fontweight','b');

figure(2);plot(prof_across_FJ2(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
title('FJ2','fontsize',12,'fontweight','b');

figure(3);plot(prof_across_FJ3(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
title('FJ3','fontsize',12,'fontweight','b');

figure(4);plot(prof_across_FJ4(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
title('FJ4','fontsize',12,'fontweight','b');

figure(5);plot(prof_across_FJ5(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
title('FJ5','fontsize',12,'fontweight','b');

figure(6);plot(prof_across_FJ_tribut(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
title('FJ tributary','fontsize',12,'fontweight','b');

figure(7);plot(dist_FJ, prof_curve_FJ(:,i),'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b');
xlabel('distance [km]','fontsize',12,'fontweight','b');

title('Velocity Profile','fontsize',12,'fontweight','b');
end


% Plot across profiles:
% 

dist_across_FJ1=0:((24.82957)/(length(prof_across_FJ1)-1)):(24.82957);
dist_across_FJ2=0:((31.655171)/(length(prof_across_FJ2)-1)):(31.655171);
dist_across_FJ3=0:((24.683047)/(length(prof_across_FJ3)-1)):(24.683047);

dist_across_FJ1_=0.0249*(-594):(0.0249*(999))/(length(prof_across_FJ1)-1):(0.0249*(999-594));
dist_across_FJ2_=(0.0317*(-598)):(0.0317*999)/(length(prof_across_FJ2)-1):(0.0317*(999-598));
dist_across_FJ3_=(0.0247*(-628)):(0.0247*999)/(length(prof_across_FJ3)-1):(0.0247*(999-628));

figure;
plot(dist_across_FJ1,nanmean(prof_across_FJ1/1000,2),'.','color','b');hold on
plot(dist_across_FJ2,nanmean(prof_across_FJ2/1000,2),'.','color','k');
plot(dist_across_FJ3,nanmean(prof_across_FJ3/1000,2),'.','color','r');
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
xlabel('distance [km]','fontsize',12,'fontweight','b')
%title('Velocity Profile','fontsize',12,'fontweight','b');
legend('FJ1','FJ2','FJ3');
grid on;

% Plot the across profiles with the main profile as reference

    % The image product resolution is 90m and the across profiles are in
    % high spatial resolution, so I have to undersample them in order to
    % not get repeatedly values

prof_across_FJ1_mean= nanmean(prof_across_FJ1/1000,2);
prof_across_FJ2_mean= nanmean(prof_across_FJ2/1000,2);  
prof_across_FJ3_mean= nanmean(prof_across_FJ3/1000,2);


figure;
plot(dist_across_FJ1_(1:4:end),prof_across_FJ1_mean(1:4:end),'color','b','LineWidth',2);hold on
plot(dist_across_FJ2_(1:3:end),fillgaps(prof_across_FJ2_mean(1:3:end)),'color','k','LineWidth',2);
plot(dist_across_FJ3_(1:4:end),fillgaps(prof_across_FJ3_mean(1:4:end)),'color','r','LineWidth',2);
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
xlabel('distance [km]','fontsize',12,'fontweight','b')
%title('Velocity Profile','fontsize',12,'fontweight','b');
legend('FJ1','FJ2','FJ3');
grid off;

annotation(gcf,'textarrow',[0.198214285714286 0.2],...
    [0.718047619047619 0.826190476190476],'String',{'Flow'});

plot([0 0],[0 2],'color',[0 0.5 0],'linewidth',2);


    % Plotting the spread variation (min & max) in the across profiles:
hold on

%FJ1
prof_across_FJ1_max = nanmax(prof_across_FJ1(108:4:937,:),[],2);
prof_across_FJ1_min = nanmin(prof_across_FJ1(108:4:937,:),[],2);

fill_across_FJ1=[fillgaps(prof_across_FJ1_max); flip(fillgaps(prof_across_FJ1_min))];
dist_across_FJ1_fill=[dist_across_FJ1_(108:4:937) , flip(dist_across_FJ1_(108:4:937))];
fill(dist_across_FJ1_fill,fillgaps(fill_across_FJ1/1000),'b','FaceAlpha', 0.3,'linestyle','none');

%FJ2
prof_across_FJ2_max = nanmax(prof_across_FJ2(1:3:end,:),[],2);
prof_across_FJ2_min = nanmin(prof_across_FJ2(1:3:end,:),[],2);

fill_across_FJ2=[prof_across_FJ2_max; flip(prof_across_FJ2_min)];
dist_across_FJ2_fill=[dist_across_FJ2_(1:3:end) , flip(dist_across_FJ2_(1:3:end))];
fill(dist_across_FJ2_fill,fillgaps(fill_across_FJ2/1000),[0.5 0.5 0.5],'FaceAlpha', 0.3,'linestyle','none');

%FJ3
prof_across_FJ3_max = nanmax(prof_across_FJ3(1:4:end,:),[],2);
prof_across_FJ3_min = nanmin(prof_across_FJ3(1:4:end,:),[],2);

fill_across_FJ3=[prof_across_FJ3_max; flip(prof_across_FJ3_min)];
dist_across_FJ3_fill=[dist_across_FJ3_(1:4:end) , flip(dist_across_FJ3_(1:4:end))];
fill(dist_across_FJ3_fill,fillgaps(fill_across_FJ3/1000),'r','FaceAlpha', 0.3,'linestyle','none');

%%% STD shadow & FJ mean velocities across the main flow

figure;
plot(dist_across_FJ1_(1:4:end),prof_across_FJ1_mean(1:4:end),'color','b','LineWidth',2);hold on
plot(dist_across_FJ2_(1:3:end),fillgaps(prof_across_FJ2_mean(1:3:end)),'color','k','LineWidth',2);
plot(dist_across_FJ3_(1:4:end),fillgaps(prof_across_FJ3_mean(1:4:end)),'color','r','LineWidth',2);
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
xlabel('distance [km]','fontsize',12,'fontweight','b')
%title('Velocity Profile','fontsize',12,'fontweight','b');
legend('FJ1','FJ2','FJ3');
grid off;

annotation(gcf,'textarrow',[0.198214285714286 0.2],...
    [0.718047619047619 0.826190476190476],'String',{'Flow'});

plot([0 0],[0 2],'color',[0 0.5 0],'linewidth',2);

hold on

%FJ1
std_velocity_FJ1_across = nanstd(prof_across_FJ1(108:4:937,:),1,2);
std_velocity_FJ1_across_interp = interp1(dist_across_FJ1_(108:4:937),std_velocity_FJ1_across,dist_across_FJ1_(108:4:937),'spline');

fill_across_FJ1_STD=[fillgaps(prof_across_FJ1_mean(108:4:937))+std_velocity_FJ1_across_interp'/1000; flip(fillgaps(prof_across_FJ1_mean(108:4:937))-std_velocity_FJ1_across_interp'/1000)];
dist_across_FJ1_fill=[dist_across_FJ1_(108:4:937) , flip(dist_across_FJ1_(108:4:937))];
fill(dist_across_FJ1_fill,fill_across_FJ1_STD,'b','FaceAlpha', 0.3,'linestyle','none');

%FJ2
std_velocity_FJ2_across = nanstd(prof_across_FJ2(1:3:end,:),1,2);
std_velocity_FJ2_across_interp = interp1(dist_across_FJ2_(1:3:end),std_velocity_FJ2_across,dist_across_FJ2_(1:3:end),'spline');

fill_across_FJ2_STD=[fillgaps(prof_across_FJ2_mean(1:3:end))+std_velocity_FJ2_across/1000; flip(fillgaps(prof_across_FJ2_mean(1:3:end))-std_velocity_FJ2_across/1000)];
dist_across_FJ2_fill=[dist_across_FJ2_(1:3:end) , flip(dist_across_FJ2_(1:3:end))];
fill(dist_across_FJ2_fill,fillgaps(fill_across_FJ2_STD),[0.5 0.5 0.5],'FaceAlpha', 0.3,'linestyle','none');

%FJ3
std_velocity_FJ3_across = nanstd(prof_across_FJ3(1:4:end,:),1,2);
%std_velocity_FJ3_across_interp = interp1(dist_across_FJ3_(1:4:end,:),std_velocity_FJ3_across,dist_across_FJ3_(1:4:end,:),'spline');

fill_across_FJ3_STD=[fillgaps(prof_across_FJ3_mean(1:4:end))+std_velocity_FJ3_across/1000; flip(fillgaps(prof_across_FJ3_mean(1:4:end))-std_velocity_FJ3_across/1000)];
dist_across_FJ3_fill=[dist_across_FJ3_(1:4:end) , flip(dist_across_FJ3_(1:4:end))];
fill(dist_across_FJ3_fill,fillgaps(fill_across_FJ3_STD),'r','FaceAlpha', 0.3,'linestyle','none');





vel=stack_FJ;
vel(vel<=0)=nan;

for i=1:23

subplot(7,3,i);
h=imagesc(vel(:,:,i));
tt=double(~isnan(vel(:,:,i))); set(h,'AlphaData', tt);
axis off;

caxis([0 5])

end

%%% Plot profiles from profile curve:
for i=1:23
figure(5);plot(dist_FJ,prof_curve_FJ(:,i)/1000,'.');hold on;
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
title('Velocity Profile','fontsize',12,'fontweight','b');
grid on
xlabel('distance [km]','fontsize',12,'fontweight','b')

end


%%% Estimate STD for the stack data

std_velocity_stack_FJ=std(stack_FJ,1,3);
std_velocity_stack_FJ(std_velocity_stack_FJ<=0)=nan;

std_velocity_FJ_profile=nanstd(prof_curve_FJ,1,2);

figure;plot(dist_FJ,std_velocity_FJ_profile/1000,'.');hold on;
%ylabel('std FJ [km/yr]','fontsize',12,'fontweight','b')
ylim([0 6])
grid on;
title('STD profile','fontsize',12,'fontweight','b');

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/FJ_stack_DuFil.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/std_stack_FJ.tif', std_velocity_stack_FJ, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


%%% Mean and Median velocity

median_velocity_stack_FJ=nanmedian(stack_FJ,3);
mean_velocity_stack_FJ=nanmean(stack_FJ,3);

median_velocity_stack_FJ(median_velocity_stack_FJ<=0)=nan;
mean_velocity_stack_FJ(mean_velocity_stack_FJ<=0)=nan;

mean_velocity_stack_FJ_log=log10(mean_velocity_stack_FJ/1000);

median_velocity_FJ_profile=profile_ext(X_p_curve_FJ,Y_p_curve_FJ,median_velocity_stack_FJ,Rstack_FJ);
mean_velocity_FJ_profile=profile_ext(X_p_curve_FJ,Y_p_curve_FJ,mean_velocity_stack_FJ,Rstack_FJ);

% subplot(1,2,1);
% plot(dist_FJ,median_velocity_FJ_profile/1000,'.');
% ylim([0 1.6]);
% xlim([0 200])
% ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
% grid on;
% title('Median velocity profile','fontsize',12,'fontweight','b');
% xlabel('distance [km]','fontsize',12,'fontweight','b')

%subplot(1,2,2);
plot(dist_FJ,mean_velocity_FJ_profile/1000,'.','color','k','markersize',3);
ylim([0 1.6]);
xlim([0 200])
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
grid on;
title('Mean velocity profile','fontsize',12,'fontweight','b');
xlabel('distance [km]','fontsize',12,'fontweight','b')
hold on

% Floating area
% considering the most recent Ice front position (CCI) and the grounding line from 
X_floating_FJ=[dist_FJ(1):((0.1916*999*2)/(length(prof_curve_FJ)-1)):dist_FJ(193*2)];
Y_floating_FJ=[zeros(1,length(X_floating_FJ)) ones(1,length(X_floating_FJ))*1.8];
X_floating_FJ=[X_floating_FJ flip(X_floating_FJ)];
fill(X_floating_FJ,Y_floating_FJ,[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');

%%% Plot the STD shaded
hold on
std_velocity_FJ_profile_interp= fillgaps(interp1(dist_FJ,std_velocity_FJ_profile/1000,dist_FJ,'PCHIP'));
%F = fillgaps(double(std_velocity_FJ_profile/1000));

fill_STD_FJ=[(fillgaps(mean_velocity_FJ_profile)'/1000+std_velocity_FJ_profile_interp), flip((fillgaps(mean_velocity_FJ_profile')/1000-std_velocity_FJ_profile_interp))];
dist_FJ_fill=[dist_FJ , flip(dist_FJ)];
fill(dist_FJ_fill,fill_STD_FJ,[0.5 0.5 0.5],'FaceAlpha', 0.3,'linestyle','none');

%%% Plot the time variation shaded
hold on;
prof_curve_FJ_max = interp1(dist_FJ,max(prof_curve_FJ,[],2),dist_FJ,'PCHIP');
prof_curve_FJ_min = interp1(dist_FJ,min(prof_curve_FJ,[],2),dist_FJ,'PCHIP');

fill_FJ=[prof_curve_FJ_max, flip(prof_curve_FJ_min)];
dist_FJ_fill=[dist_FJ , flip(dist_FJ)];
fill(dist_FJ_fill,fill_FJ/1000,[0.5 0.5 0.5],'FaceAlpha', 0.3,'linestyle','none');


info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/FJ_stack_DuFil.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/median_stack_FJ.tif', median_velocity_stack_FJ/1000, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/mean_stack_FJ.tif', mean_velocity_stack_FJ/1000, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/mean_stack_FJ_log.tif', mean_velocity_stack_FJ_log, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


% Seasonal Map FJ

%%%%%%%%%%%%%%%%%%%%%%%%%
%Sole, A. et al., 2013. Winter motion mediates dynamic response of the Greenland Ice Sheet to warmer summers. Geophysical Research Letters, 40(15), pp.3940–3944.
% Summer May-Aug
% Winter Sept-April
%%%%%%%%%%%%%%%%%%%%%%%%%
FJ_summer= stack_FJ(:,:,[1:2 13:23]);
FJ_winter= stack_FJ(:,:,[3:12]);

FJ_summer(FJ_summer<=0)=nan;
FJ_winter(FJ_winter<=0)=nan;


FJ_mean_summer=nanmean(FJ_summer,3);
FJ_mean_winter=nanmean(FJ_winter,3);

FJ_summer_minus_winter=FJ_mean_summer-FJ_mean_winter;

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/FJ_stack_DuFil.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/FJ_summer.tif', FJ_mean_summer/1000, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/FJ_winter.tif', FJ_mean_winter/1000, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/FJ_summer_minus_winter.tif', FJ_summer_minus_winter/1000, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Changing the summer/winter months

%%%%%%%%%%%%%%%%%%%%%%%%%
% summer: Jun to Aug
% winter: November to Mar
%%%%%%%%%%%%%%%%%%%%%%%%%
FJ_summer2= stack_FJ(:,:,[1 18:23]);
FJ_winter2= stack_FJ(:,:,[6:13]);

FJ_summer2(FJ_summer2<=0)=nan;
FJ_winter2(FJ_winter2<=0)=nan;

FJ_mean_summer2=nanmean(FJ_summer2,3);
FJ_mean_winter2=nanmean(FJ_winter2,3);


FJ_mean_summer2(FJ_mean_summer2<=0)=nan;

%JAK_summer_minus_winter=JAK_mean_summer-JAK_mean_winter(~isnan(JAK_mean_summer));
FJ_summer_mean_minus_winter_temp2=FJ_mean_summer2(~isnan(FJ_mean_summer2))-FJ_mean_winter2(~isnan(FJ_mean_summer2));
FJ_summer_mean_minus_winter2=nan(size(FJ_mean_summer2,1),size(FJ_mean_summer2,2));
FJ_summer_mean_minus_winter2(~isnan(FJ_mean_summer2))=FJ_summer_mean_minus_winter_temp2;

FJ_summer_mean_divided_winter_temp2=FJ_mean_summer2(~isnan(FJ_mean_summer2))./FJ_mean_winter2(~isnan(FJ_mean_summer2));
FJ_summer_mean_divided_winter2=nan(size(FJ_mean_summer2,1),size(FJ_mean_summer2,2));
FJ_summer_mean_divided_winter2(~isnan(FJ_mean_summer2))=FJ_summer_mean_divided_winter_temp2;


%FJ_summer_minus_winter=FJ_mean_summer-FJ_mean_winter;

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/FJ_stack_DuFil.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/FJ_mean_summer2.tif', FJ_mean_summer2/1000, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/FJ_mean_winter2.tif', FJ_mean_winter2/1000, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/FJ_mean_summer_mean_minus_winter2.tif', FJ_summer_mean_minus_winter2/1000, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/FJ_summer_mean_divided_winter2.tif', FJ_summer_mean_divided_winter2, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

% median

FJ_median_summer2=nanmedian(FJ_summer2,3);
FJ_median_winter2=nanmedian(FJ_winter2,3);

FJ_median_summer2(FJ_median_summer2<=0)=nan;

FJ_summer_median_minus_winter_temp2=FJ_median_summer2(~isnan(FJ_median_summer2))-FJ_median_winter2(~isnan(FJ_median_summer2));
FJ_summer_median_minus_winter2=nan(size(FJ_median_summer2,1),size(FJ_median_summer2,2));
FJ_summer_median_minus_winter2(~isnan(FJ_median_summer2))=FJ_summer_median_minus_winter_temp2;

%FJ_summer_minus_winter=FJ_median_summer-FJ_median_winter;

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/FJ_stack_DuFil.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/FJ_median_summer2.tif', FJ_median_summer2/1000, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/FJ_median_winter2.tif', FJ_median_winter2/1000, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/FJ_median_summer_median_minus_winter2.tif', FJ_summer_median_minus_winter2/1000, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


%% Table 3:

%                mean                     min                     max
%          mean  summer  winter   mean  summer  winter    mean  summer  winter
%JAK  p_cur
%      jak1
%      jak2
%      jak3
%PG

%FJ

table3=nan(12,9);

% JAK
table3(1,1)=nanmean(mean_velocity_JAK_profile);
table3(2,1)=nanmean(prof_across_JAK1(:));
table3(3,1)=nanmean(prof_across_JAK2(:));
table3(4,1)=nanmean(prof_across_JAK3(:));

table3(1,2)=nanmean(profile_ext(X_p_curve_JAK,Y_p_curve_JAK,JAK_mean_summer2,R_stack));
table3(2,2)=nanmean(profile_ext(X_across_JAK1,Y_across_JAK1,JAK_mean_summer2,R_stack));
table3(3,2)=nanmean(profile_ext(X_across_JAK2,Y_across_JAK2,JAK_mean_summer2,R_stack));
table3(4,2)=nanmean(profile_ext(X_across_JAK3,Y_across_JAK3,JAK_mean_summer2,R_stack));

table3(1,3)=nanmean(profile_ext(X_p_curve_JAK,Y_p_curve_JAK,JAK_mean_winter2,R_stack));
table3(2,3)=nanmean(profile_ext(X_across_JAK1,Y_across_JAK1,JAK_mean_winter2,R_stack));
table3(3,3)=nanmean(profile_ext(X_across_JAK2,Y_across_JAK2,JAK_mean_winter2,R_stack));
table3(4,3)=nanmean(profile_ext(X_across_JAK3,Y_across_JAK3,JAK_mean_winter2,R_stack));


table3(1,4)=min(mean_velocity_JAK_profile);
table3(2,4)=min(prof_across_JAK1(:));
table3(3,4)=min(prof_across_JAK2(:));
table3(4,4)=min(prof_across_JAK3(:));

table3(1,5)=min(profile_ext(X_p_curve_JAK,Y_p_curve_JAK,JAK_mean_summer2,R_stack));
table3(2,5)=min(profile_ext(X_across_JAK1,Y_across_JAK1,JAK_mean_summer2,R_stack));
table3(3,5)=min(profile_ext(X_across_JAK2,Y_across_JAK2,JAK_mean_summer2,R_stack));
table3(4,5)=min(profile_ext(X_across_JAK3,Y_across_JAK3,JAK_mean_summer2,R_stack));

table3(1,6)=min(profile_ext(X_p_curve_JAK,Y_p_curve_JAK,JAK_mean_winter2,R_stack));
table3(2,6)=min(profile_ext(X_across_JAK1,Y_across_JAK1,JAK_mean_winter2,R_stack));
table3(3,6)=min(profile_ext(X_across_JAK2,Y_across_JAK2,JAK_mean_winter2,R_stack));
table3(4,6)=min(profile_ext(X_across_JAK3,Y_across_JAK3,JAK_mean_winter2,R_stack));


table3(1,7)=max(mean_velocity_JAK_profile);
table3(2,7)=max(prof_across_JAK1(:));
table3(3,7)=max(prof_across_JAK2(:));
table3(4,7)=max(prof_across_JAK3(:));

table3(1,8)=max(profile_ext(X_p_curve_JAK,Y_p_curve_JAK,JAK_mean_summer2,R_stack));
table3(2,8)=max(profile_ext(X_across_JAK1,Y_across_JAK1,JAK_mean_summer2,R_stack));
table3(3,8)=max(profile_ext(X_across_JAK2,Y_across_JAK2,JAK_mean_summer2,R_stack));
table3(4,8)=max(profile_ext(X_across_JAK3,Y_across_JAK3,JAK_mean_summer2,R_stack));

table3(1,9)=max(profile_ext(X_p_curve_JAK,Y_p_curve_JAK,JAK_mean_winter2,R_stack));
table3(2,9)=max(profile_ext(X_across_JAK1,Y_across_JAK1,JAK_mean_winter2,R_stack));
table3(3,9)=max(profile_ext(X_across_JAK2,Y_across_JAK2,JAK_mean_winter2,R_stack));
table3(4,9)=max(profile_ext(X_across_JAK3,Y_across_JAK3,JAK_mean_winter2,R_stack));



% PG
table3(5,1)=nanmean(mean_velocity_PG_profile/1000);
table3(6,1)=nanmean(prof_across_PG1(:)/1000);
table3(7,1)=nanmean(prof_across_PG4(:)/1000);
table3(8,1)=nanmean(prof_across_PG5(:)/1000);

table3(5,2)=nanmean(profile_ext(X_p_curve_PG,Y_p_curve_PG,PG_mean_summer2/1000,Rstack_PG));
table3(6,2)=nanmean(profile_ext(X_across_PG1,Y_across_PG1,PG_mean_summer2/1000,Rstack_PG));
table3(7,2)=nanmean(profile_ext(X_across_PG4,Y_across_PG4,PG_mean_summer2/1000,Rstack_PG));
table3(8,2)=nanmean(profile_ext(X_across_PG5,Y_across_PG5,PG_mean_summer2/1000,Rstack_PG));

table3(5,3)=nanmean(profile_ext(X_p_curve_PG,Y_p_curve_PG,PG_mean_winter2/1000,Rstack_PG));
table3(6,3)=nanmean(profile_ext(X_across_PG1,Y_across_PG1,PG_mean_winter2/1000,Rstack_PG));
table3(7,3)=nanmean(profile_ext(X_across_PG4,Y_across_PG4,PG_mean_winter2/1000,Rstack_PG));
table3(8,3)=nanmean(profile_ext(X_across_PG5,Y_across_PG5,PG_mean_winter2/1000,Rstack_PG));


table3(5,4)=min(mean_velocity_PG_profile/1000);
table3(6,4)=min(prof_across_PG1(:)/1000);
table3(7,4)=min(prof_across_PG4(:)/1000);
table3(8,4)=min(prof_across_PG5(:)/1000);

table3(5,5)=min(profile_ext(X_p_curve_PG,Y_p_curve_PG,PG_mean_summer2/1000,Rstack_PG));
table3(6,5)=min(profile_ext(X_across_PG1,Y_across_PG1,PG_mean_summer2/1000,Rstack_PG));
table3(7,5)=min(profile_ext(X_across_PG4,Y_across_PG4,PG_mean_summer2/1000,Rstack_PG));
table3(8,5)=min(profile_ext(X_across_PG5,Y_across_PG5,PG_mean_summer2/1000,Rstack_PG));

table3(5,6)=min(profile_ext(X_p_curve_PG,Y_p_curve_PG,PG_mean_winter2/1000,Rstack_PG));
table3(6,6)=min(profile_ext(X_across_PG1,Y_across_PG1,PG_mean_winter2/1000,Rstack_PG));
table3(7,6)=min(profile_ext(X_across_PG4,Y_across_PG4,PG_mean_winter2/1000,Rstack_PG));
table3(8,6)=min(profile_ext(X_across_PG5,Y_across_PG5,PG_mean_winter2/1000,Rstack_PG));

table3(5,7)=max(mean_velocity_PG_profile/1000);
table3(6,7)=max(prof_across_PG1(:)/1000);
table3(7,7)=max(prof_across_PG4(:)/1000);
table3(8,7)=max(prof_across_PG5(:)/1000);

table3(5,8)=max(profile_ext(X_p_curve_PG,Y_p_curve_PG,PG_mean_summer2/1000,Rstack_PG));
table3(6,8)=max(profile_ext(X_across_PG1,Y_across_PG1,PG_mean_summer2/1000,Rstack_PG));
table3(7,8)=max(profile_ext(X_across_PG4,Y_across_PG4,PG_mean_summer2/1000,Rstack_PG));
table3(8,8)=max(profile_ext(X_across_PG5,Y_across_PG5,PG_mean_summer2/1000,Rstack_PG));

table3(5,9)=max(profile_ext(X_p_curve_PG,Y_p_curve_PG,PG_mean_winter2/1000,Rstack_PG));
table3(6,9)=max(profile_ext(X_across_PG1,Y_across_PG1,PG_mean_winter2/1000,Rstack_PG));
table3(7,9)=max(profile_ext(X_across_PG4,Y_across_PG4,PG_mean_winter2/1000,Rstack_PG));
table3(8,9)=max(profile_ext(X_across_PG5,Y_across_PG5,PG_mean_winter2/1000,Rstack_PG));


%FJ
table3(9,1)=nanmean(mean_velocity_FJ_profile/1000);
table3(10,1)=nanmean(prof_across_FJ1(:)/1000);
table3(11,1)=nanmean(prof_across_FJ2(:)/1000);
table3(12,1)=nanmean(prof_across_FJ3(:)/1000);

table3(9,2)=nanmean(profile_ext(X_p_curve_FJ,Y_p_curve_FJ,FJ_mean_summer2/1000,Rstack_FJ));
table3(10,2)=nanmean(profile_ext(X_across_FJ1,Y_across_FJ1,FJ_mean_summer2/1000,Rstack_FJ));
table3(11,2)=nanmean(profile_ext(X_across_FJ2,Y_across_FJ2,FJ_mean_summer2/1000,Rstack_FJ));
table3(12,2)=nanmean(profile_ext(X_across_FJ3,Y_across_FJ3,FJ_mean_summer2/1000,Rstack_FJ));

table3(9,3)=nanmean(profile_ext(X_p_curve_FJ,Y_p_curve_FJ,FJ_mean_winter2/1000,Rstack_FJ));
table3(10,3)=nanmean(profile_ext(X_across_FJ1,Y_across_FJ1,FJ_mean_winter2/1000,Rstack_FJ));
table3(11,3)=nanmean(profile_ext(X_across_FJ2,Y_across_FJ2,FJ_mean_winter2/1000,Rstack_FJ));
table3(12,3)=nanmean(profile_ext(X_across_FJ3,Y_across_FJ3,FJ_mean_winter2/1000,Rstack_FJ));

table3(9,4)=min(mean_velocity_FJ_profile/1000);
table3(10,4)=min(prof_across_FJ1(:)/1000);
table3(11,4)=min(prof_across_FJ2(:)/1000);
table3(12,4)=min(prof_across_FJ3(:)/1000);

table3(9,5)=min(profile_ext(X_p_curve_FJ,Y_p_curve_FJ,FJ_mean_summer2/1000,Rstack_FJ));
table3(10,5)=min(profile_ext(X_across_FJ1,Y_across_FJ1,FJ_mean_summer2/1000,Rstack_FJ));
table3(11,5)=min(profile_ext(X_across_FJ2,Y_across_FJ2,FJ_mean_summer2/1000,Rstack_FJ));
table3(12,5)=min(profile_ext(X_across_FJ3,Y_across_FJ3,FJ_mean_summer2/1000,Rstack_FJ));

table3(9,6)=min(profile_ext(X_p_curve_FJ,Y_p_curve_FJ,FJ_mean_winter2/1000,Rstack_FJ));
table3(10,6)=min(profile_ext(X_across_FJ1,Y_across_FJ1,FJ_mean_winter2/1000,Rstack_FJ));
table3(11,6)=min(profile_ext(X_across_FJ2,Y_across_FJ2,FJ_mean_winter2/1000,Rstack_FJ));
table3(12,6)=min(profile_ext(X_across_FJ3,Y_across_FJ3,FJ_mean_winter2/1000,Rstack_FJ));

table3(9,7)=max(mean_velocity_FJ_profile/1000);
table3(10,7)=max(prof_across_FJ1(:)/1000);
table3(11,7)=max(prof_across_FJ2(:)/1000);
table3(12,7)=max(prof_across_FJ3(:)/1000);

table3(9,8)=max(profile_ext(X_p_curve_FJ,Y_p_curve_FJ,FJ_mean_summer2/1000,Rstack_FJ));
table3(10,8)=max(profile_ext(X_across_FJ1,Y_across_FJ1,FJ_mean_summer2/1000,Rstack_FJ));
table3(11,8)=max(profile_ext(X_across_FJ2,Y_across_FJ2,FJ_mean_summer2/1000,Rstack_FJ));
table3(12,8)=max(profile_ext(X_across_FJ3,Y_across_FJ3,FJ_mean_summer2/1000,Rstack_FJ));

table3(9,9)=max(profile_ext(X_p_curve_FJ,Y_p_curve_FJ,FJ_mean_winter2/1000,Rstack_FJ));
table3(10,9)=max(profile_ext(X_across_FJ1,Y_across_FJ1,FJ_mean_winter2/1000,Rstack_FJ));
table3(11,9)=max(profile_ext(X_across_FJ2,Y_across_FJ2,FJ_mean_winter2/1000,Rstack_FJ));
table3(12,9)=max(profile_ext(X_across_FJ3,Y_across_FJ3,FJ_mean_winter2/1000,Rstack_FJ));



%% Extract points JAK1,2&3 ; PG1,2(4)&3(5) ; FJ1,2&3
% 
% JAK1_main:365 (0.0490)
% JAK1_cross:577 (0.01115)
% 
% JAK2_main:516
% JAK2_cross:484 (0.01654)
% 
% JAK3_main:801
% JAK3_cross:433 (0.01374)
% 
% PG1_main:268 (0.1916)
% PG1_cross:507 (0.02485)
% 
% (PG4)PG2_main:489
% (PG4)PG2_cross:424 (0.02484)
% 
% (PG5)PG3_main:771
% (PG5)PG3_cross:470 (0.4718)
% 
% FJ1_main:48 (0.1952)
% FJ1_cross:595 (0.02470)
% 
% FJ2_main:171
% FJ2_cross:599 (0.03160)
% 
% FJ3_main:479
% FJ3_cross:629 (0.02670)


% JAK


for i=1:19 
pt_JAK1(i)=prof_across_JAK1(577,i);
pt_JAK2(i)=prof_across_JAK2(484,i);
pt_JAK3(i)=prof_across_JAK3(433,i);
%pt_JAK_main(i)=prof_curve_JAK(10,i);
end


%%%%% Calculating a mean in an moving mean, around 5 pixels (**profile_ext_mean** function)

prof_curve_JAK_5window_mean=nan(999,19);

prof_across_JAK1_5window_mean=nan(999,19);
prof_across_JAK2_5window_mean=nan(999,19);
prof_across_JAK3_5window_mean=nan(999,19);

for i=1:19 
prof_across_JAK1_5window_mean(:,i)=profile_ext_mean(X_across_JAK1,Y_across_JAK1,Vel_Stack(:,:,i),R_stack,5);
prof_across_JAK2_5window_mean(:,i)=profile_ext_mean(X_across_JAK2,Y_across_JAK2,Vel_Stack(:,:,i),R_stack,5);
prof_across_JAK3_5window_mean(:,i)=profile_ext_mean(X_across_JAK3,Y_across_JAK3,Vel_Stack(:,:,i),R_stack,5);

prof_curve_JAK_5window_mean(:,i)=profile_ext_mean(X_p_curve_JAK,Y_p_curve_JAK,Vel_Stack(:,:,i),R_stack,5);
end

for i=1:19 
pt_JAK1_5window_mean(i)=prof_across_JAK1_5window_mean(577,i);
pt_JAK2_5window_mean(i)=prof_across_JAK2_5window_mean(484,i);
pt_JAK3_5window_mean(i)=prof_across_JAK3_5window_mean(433,i);
%pt_JAK_main(i)=prof_curve_JAK(10,i);
end


pathsate_opt_JAK=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/'];
d_opt_JAK=dir(pathsate_opt_JAK);
j=1;
for i=[5:15 17:length(d_opt_JAK)-13];
    name=d_opt_JAK(i,1).name;
    data_str_JAK(j,:)=[name(1:8) '-' name(10:17)];
    data_JAK{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt_JAK(j,1)=cellstr(data_JAK{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt_JAK i j name


%figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;

figure(1)
subplot(2,2,1)
plot(pt_JAK1,'color','b','linestyle','none','marker','.','markersize',20);hold on
plot(pt_JAK2,'color','k','linestyle','none','marker','.','markersize',20)
plot(pt_JAK3,'color','r','linestyle','none','marker','.','markersize',20)
legend('JAK1', 'JAK2', 'JAK3','location','northwest')
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
ylim([0 7])
%dias=['nov/14';'apr/15';'fev/16'];
set(gca,'XTick',[1:2:19],'XTickLabel',data_str_JAK(1:2:19,:),'XTickLabelRotation',-45,'fontsize',8)
grid on
title('Jakobshavn Isbræ','fontsize',12,'fontweight','b');

figure(2)
%figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
subplot(2,2,1)
plot(pt_JAK1_5window_mean,'color','b','linestyle','none','marker','.','markersize',20);hold on
plot(pt_JAK2_5window_mean,'color','k','linestyle','none','marker','.','markersize',20)
plot(pt_JAK3_5window_mean,'color','r','linestyle','none','marker','.','markersize',20)
legend('JAK1', 'JAK2', 'JAK3','location','northwest')
plot([1:length(pt_JAK1_5window_mean)],mdl_pt_JAK1_5window_mean.Fitted,'b');
plot([1:length(pt_JAK2_5window_mean)],mdl_pt_JAK2_5window_mean.Fitted,'k');
plot([1:length(pt_JAK3_5window_mean)],mdl_pt_JAK3_5window_mean.Fitted,'r');
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
ylim([0 7])
%dias=['nov/14';'apr/15';'fev/16'];
set(gca,'XTick',[1:2:19],'XTickLabel',data_str_JAK(1:2:19,:),'XTickLabelRotation',-45,'fontsize',8)
grid on
title('Jakobshavn Isbræ','fontsize',12,'fontweight','b');


% PG

for i=1:24 
pt_PG1(i)=prof_across_PG1(507,i);
pt_PG2(i)=prof_across_PG4(424,i);
pt_PG3(i)=prof_across_PG5(470,i);
%pt_PG_main(i)=prof_curve_PG(10,i);
end

%%%%% Calculating a mean in an moving mean, around 5 pixels (**profile_ext_mean** function)

stack_PG(stack_PG<=0)=nan;

% Extract the profiles

prof_curve_PG_5window_mean=nan(1997,24);

prof_across_PG1_5window_mean=nan(999,24);
prof_across_PG2_5window_mean=nan(999,24);
prof_across_PG3_5window_mean=nan(999,24);
prof_across_PG4_5window_mean=nan(999,24);
prof_across_PG5_5window_mean=nan(999,24);
prof_across_PG_tribut_5window_mean=nan(999,24);

for i=1:24 
prof_across_PG1_5window_mean(:,i)=profile_ext_mean(X_across_PG1,Y_across_PG1,stack_PG(:,:,i),Rstack_PG,5);
prof_across_PG2_5window_mean(:,i)=profile_ext_mean(X_across_PG2,Y_across_PG2,stack_PG(:,:,i),Rstack_PG,5);
prof_across_PG3_5window_mean(:,i)=profile_ext_mean(X_across_PG3,Y_across_PG3,stack_PG(:,:,i),Rstack_PG,5);
prof_across_PG4_5window_mean(:,i)=profile_ext_mean(X_across_PG4,Y_across_PG4,stack_PG(:,:,i),Rstack_PG,5);
prof_across_PG5_5window_mean(:,i)=profile_ext_mean(X_across_PG5,Y_across_PG5,stack_PG(:,:,i),Rstack_PG,5);
prof_across_PG_tribut_5window_mean(:,i)=profile_ext_mean(X_across_PG_tribut,Y_across_PG_tribut,stack_PG(:,:,i),Rstack_PG,5);

prof_curve_PG_5window_mean(:,i)=profile_ext_mean(X_p_curve_PG,Y_p_curve_PG,stack_PG(:,:,i),Rstack_PG,5);

end

for i=1:24 
pt_PG1_5window_mean(i)=prof_across_PG1_5window_mean(507,i);
pt_PG2_5window_mean(i)=prof_across_PG4_5window_mean(424,i);
pt_PG3_5window_mean(i)=prof_across_PG5_5window_mean(470,i);
%pt_PG_main(i)=prof_curve_PG(10,i);
end


pathsate_opt_PG=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/'];
d_opt_PG=dir(pathsate_opt_PG);
j=1;
for i=7:length(d_opt_PG)-2;
    name=d_opt_PG(i,1).name;
    data_str_PG(j,:)=['20' name(1:6) '-' '20' name(8:13)];
    data_PG{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt_PG(j,1)=cellstr(data_PG{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt_PG i j name

%figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
figure(1)
subplot(2,2,2)
plot(pt_PG1/1000,'color','b','linestyle','none','marker','.','markersize',20);hold on
plot(pt_PG2/1000,'color','k','linestyle','none','marker','.','markersize',20)
plot(pt_PG3/1000,'color','r','linestyle','none','marker','.','markersize',20)
legend('PG1', 'PG2', 'PG3','location','northwest')
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
ylim([0 1.6])
%dias=['Jan/15';'apr/15';'Sep/16'];
set(gca,'XTick',[1:2:24],'XTickLabel',data_str_PG(1:2:24,:),'XTickLabelRotation',-45,'fontsize',8)
grid on
title('Petermann Glacier','fontsize',12,'fontweight','b');

%figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
figure(2)
subplot(2,2,2)
plot(pt_PG1_5window_mean/1000,'color','b','linestyle','none','marker','.','markersize',20);hold on
plot(pt_PG2_5window_mean/1000,'color','k','linestyle','none','marker','.','markersize',20)
plot(pt_PG3_5window_mean/1000,'color','r','linestyle','none','marker','.','markersize',20)
legend('PG1', 'PG2', 'PG3','location','northwest')
plot([1:length(pt_PG1_5window_mean)],mdl_pt_PG1_5window_mean.Fitted,'b');
plot([1:length(pt_PG2_5window_mean)],mdl_pt_PG2_5window_mean.Fitted,'k');
plot([1:length(pt_PG3_5window_mean)],mdl_pt_PG3_5window_mean.Fitted,'r');
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
ylim([0 1.6])
%dias=['Jan/15';'apr/15';'Sep/16'];
set(gca,'XTick',[1:2:24],'XTickLabel',data_str_PG(1:2:24,:),'XTickLabelRotation',-45,'fontsize',8)
grid on
title('Petermann Glacier','fontsize',12,'fontweight','b');


% FJ

for i=1:23 
pt_FJ1(i)=prof_across_FJ1(595,i);
pt_FJ2(i)=prof_across_FJ2(599,i);
pt_FJ3(i)=prof_across_FJ3(629,i);

end

%%%%% Calculating a mean in an moving mean, around 5 pixels (**profile_ext_mean** function)
% Including nan's

stack_FJ(stack_FJ<=0)=nan;

% Extract the profiles

prof_curve_FJ_5window_mean=nan(1997,23);

prof_across_FJ1_5window_mean=nan(999,23);
prof_across_FJ2_5window_mean=nan(999,23);
prof_across_FJ3_5window_mean=nan(999,23);

for i=1:23 
prof_across_FJ1_5window_mean(:,i)=profile_ext_mean(X_across_FJ1,Y_across_FJ1,stack_FJ(:,:,i),Rstack_FJ,5);
prof_across_FJ2_5window_mean(:,i)=profile_ext_mean(X_across_FJ2,Y_across_FJ2,stack_FJ(:,:,i),Rstack_FJ,5);
prof_across_FJ3_5window_mean(:,i)=profile_ext_mean(X_across_FJ3,Y_across_FJ3,stack_FJ(:,:,i),Rstack_FJ,5);

prof_curve_FJ_5window_mean(:,i)=profile_ext_mean(X_p_curve_FJ,Y_p_curve_FJ,stack_FJ(:,:,i),Rstack_FJ,5);

end

for i=1:23 
pt_FJ1_5window_mean(i)=prof_across_FJ1_5window_mean(595,i);
pt_FJ2_5window_mean(i)=prof_across_FJ2_5window_mean(599,i);
pt_FJ3_5window_mean(i)=prof_across_FJ3_5window_mean(629,i);

end


pathsate_opt_FJ=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/'];
d_opt_FJ=dir(pathsate_opt_FJ);
j=1;
for i=5:length(d_opt_FJ)-4;
    name=d_opt_FJ(i,1).name;
    data_FJ{j,1}=cellstr(name);
    data_str_FJ(j,:)=['20' name(1:6) '-20' name(8:13)];
    %date{j,1}=cellstr(name(18:25));
    list_opt_FJ(j,1)=cellstr(data_FJ{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt_PG i j name

%figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
figure(1)
subplot(2,2,3.5)
plot(pt_FJ1/1000,'color','b','linestyle','none','marker','.','markersize',20);hold on
plot(pt_FJ2/1000,'color','k','linestyle','none','marker','.','markersize',20)
plot(pt_FJ3/1000,'color','r','linestyle','none','marker','.','markersize',20)
legend('FJ1', 'FJ2', 'FJ3','location','northwest')
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
ylim([0 1.65])
%dias=['Jan/15';'apr/15';'Sep/16'];
set(gca,'XTick',[1:2:23],'XTickLabel',data_str_FJ(1:2:23,:),'XTickLabelRotation',-45,'fontsize',8)
grid on
title('79-Fjord','fontsize',12,'fontweight','b');

%figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
figure(2)
subplot(2,2,3.5)
plot(pt_FJ1_5window_mean/1000,'color','b','linestyle','none','marker','.','markersize',20);hold on
plot(pt_FJ2_5window_mean/1000,'color','k','linestyle','none','marker','.','markersize',20)
plot(pt_FJ3_5window_mean/1000,'color','r','linestyle','none','marker','.','markersize',20)
legend('FJ1', 'FJ2', 'FJ3','location','northwest')
plot([1:length(pt_FJ1_5window_mean)],mdl_pt_FJ1_5window_mean.Fitted,'b');
plot([1:length(pt_FJ2_5window_mean)],mdl_pt_FJ2_5window_mean.Fitted,'k');
plot([1:length(pt_FJ3_5window_mean)],mdl_pt_FJ3_5window_mean.Fitted,'r');
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
ylim([0 1.65])
%dias=['Jan/15';'apr/15';'Sep/16'];
set(gca,'XTick',[1:2:23],'XTickLabel',data_str_FJ(1:2:23,:),'XTickLabelRotation',-45,'fontsize',8)
grid on
title('79-Fjord','fontsize',12,'fontweight','b');


%%% Linear trend:

mdl_pt_JAK1 = fitlm([1:length(pt_JAK1)],pt_JAK1);
mdl_pt_JAK2 = fitlm([1:length(pt_JAK2)],pt_JAK2);
mdl_pt_JAK3 = fitlm([1:length(pt_JAK3)],pt_JAK3);

mdl_pt_PG1 = fitlm([1:length(pt_PG1)],pt_PG1/1000);
mdl_pt_PG2 = fitlm([1:length(pt_PG2)],pt_PG2/1000);
mdl_pt_PG3 = fitlm([1:length(pt_PG3)],pt_PG3/1000);

mdl_pt_FJ1 = fitlm([1:length(pt_FJ1)],pt_FJ1/1000);
mdl_pt_FJ2 = fitlm([1:length(pt_FJ2)],pt_FJ2/1000);
mdl_pt_FJ3 = fitlm([1:length(pt_FJ3)],pt_FJ3/1000);

mdl_pt_JAK1_5window_mean = fitlm([1:length(pt_JAK1_5window_mean)],pt_JAK1_5window_mean);
mdl_pt_JAK2_5window_mean = fitlm([1:length(pt_JAK2_5window_mean)],pt_JAK2_5window_mean);
mdl_pt_JAK3_5window_mean = fitlm([1:length(pt_JAK3_5window_mean)],pt_JAK3_5window_mean);

mdl_pt_PG1_5window_mean = fitlm([1:length(pt_PG1_5window_mean)],pt_PG1_5window_mean/1000);
mdl_pt_PG2_5window_mean = fitlm([1:length(pt_PG2_5window_mean)],pt_PG2_5window_mean/1000);
mdl_pt_PG3_5window_mean = fitlm([1:length(pt_PG3_5window_mean)],pt_PG3_5window_mean/1000);

mdl_pt_FJ1_5window_mean = fitlm([1:length(pt_FJ1_5window_mean)],pt_FJ1_5window_mean/1000);
mdl_pt_FJ2_5window_mean = fitlm([1:length(pt_FJ2_5window_mean)],pt_FJ2_5window_mean/1000);
mdl_pt_FJ3_5window_mean = fitlm([1:length(pt_FJ3_5window_mean)],pt_FJ3_5window_mean/1000);

%%% Monthly
% month=['N';'D';'D'; 'J';'F';'F';'M';'M';'A';'A';'A';'M';'J';'J';'J';'A';'A';'S';'S';'S';'O';'O';'N';'D';'D'; 'J'; 'J'; 'J';'F';'F';'M';'M';'A';'A';'M';'M'; 'J'; 'J'; 'J'; 'J';'A';'A';'S'];
% year14=['/14';'/14';'/14'];
% year15=['/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15'];
% year16=['/16';'/16';'/16';'/16';'/16';'/16';'/16';'/16';'/16';'/16';'/16';'/16';'/16';'/16';'/16';'/16';'/16';'/16';'/16';'/16';'/16'];
% 
% monthly=[month(1:length(year14)),year14;month(length(year14)+1: (length(year14)+length(year15))),year15;month(length(year15)+1: (length(year15)+length(year16))),year16]

month=['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'];
year14=['/14';'/14'];
year15=['/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15';'/15'];
year16=['/16';'/16';'/16';'/16';'/16';'/16';'/16';'/16';'/16';'/16';'/16';'/16'];

monthly=[month(11:12),year14;month,year15;month(1:9),year16(1:9,:)];

%JAK
JAK1_monthly=[pt_JAK1_5window_mean(1) nanmean(pt_JAK1_5window_mean(2:3)) nan nanmean(pt_JAK1_5window_mean(4:5)) nanmean(pt_JAK1_5window_mean(6:7)) nanmean(pt_JAK1_5window_mean(8:10)) nanmean(pt_JAK1_5window_mean(11)) nanmean(pt_JAK1_5window_mean(12)) nanmean(pt_JAK1_5window_mean(13)) nanmean(pt_JAK1_5window_mean(14:15)) nanmean(pt_JAK1_5window_mean(16:17)) nan nanmean(pt_JAK1_5window_mean(18)) nan nan nanmean(pt_JAK1_5window_mean(19)) nan nan nan nan nan nan nan];
JAK2_monthly=[pt_JAK2_5window_mean(1) nanmean(pt_JAK2_5window_mean(2:3)) nan nanmean(pt_JAK2_5window_mean(4:5)) nanmean(pt_JAK2_5window_mean(6:7)) nanmean(pt_JAK2_5window_mean(8:10)) nanmean(pt_JAK2_5window_mean(11)) nanmean(pt_JAK2_5window_mean(12)) nanmean(pt_JAK2_5window_mean(13)) nanmean(pt_JAK2_5window_mean(14:15)) nanmean(pt_JAK2_5window_mean(16:17)) nan nanmean(pt_JAK2_5window_mean(18)) nan nan nanmean(pt_JAK2_5window_mean(19)) nan nan nan nan nan nan nan];
JAK3_monthly=[pt_JAK3_5window_mean(1) nanmean(pt_JAK3_5window_mean(2:3)) nan nanmean(pt_JAK3_5window_mean(4:5)) nanmean(pt_JAK3_5window_mean(6:7)) nanmean(pt_JAK3_5window_mean(8:10)) nanmean(pt_JAK3_5window_mean(11)) nanmean(pt_JAK3_5window_mean(12)) nanmean(pt_JAK3_5window_mean(13)) nanmean(pt_JAK3_5window_mean(14:15)) nanmean(pt_JAK3_5window_mean(16:17)) nan nanmean(pt_JAK3_5window_mean(18)) nan nan nanmean(pt_JAK3_5window_mean(19)) nan nan nan nan nan nan nan];


%PG
PG1_monthly=[nan nan pt_PG1_5window_mean(1) nanmean(pt_PG1_5window_mean(2)) nan nan mean(pt_PG1_5window_mean(3)) nanmean(pt_PG1_5window_mean(4:5)) nanmean(pt_PG1_5window_mean(6)) nanmean(pt_PG1_5window_mean(7)) nanmean(pt_PG1_5window_mean(8:9)) nanmean(pt_PG1_5window_mean(10:11)) nanmean(pt_PG1_5window_mean(12)) nanmean(pt_PG1_5window_mean(13:14)) nanmean(pt_PG1_5window_mean(15)) nanmean(pt_PG1_5window_mean(16)) nanmean(pt_PG1_5window_mean(17:18)) nanmean(pt_PG1_5window_mean(19)) nanmean(pt_PG1_5window_mean(20)) nanmean(pt_PG1_5window_mean(21)) nanmean(pt_PG1_5window_mean(22)) nanmean(pt_PG1_5window_mean(23)) nanmean(pt_PG1_5window_mean(24))];
PG2_monthly=[nan nan pt_PG2_5window_mean(1) nanmean(pt_PG2_5window_mean(2)) nan nan mean(pt_PG2_5window_mean(3)) nanmean(pt_PG2_5window_mean(4:5)) nanmean(pt_PG2_5window_mean(6)) nanmean(pt_PG2_5window_mean(7)) nanmean(pt_PG2_5window_mean(8:9)) nanmean(pt_PG2_5window_mean(10:11)) nanmean(pt_PG2_5window_mean(12)) nanmean(pt_PG2_5window_mean(13:14)) nanmean(pt_PG2_5window_mean(15)) nanmean(pt_PG2_5window_mean(16)) nanmean(pt_PG2_5window_mean(17:18)) nanmean(pt_PG2_5window_mean(19)) nanmean(pt_PG2_5window_mean(20)) nanmean(pt_PG2_5window_mean(21)) nanmean(pt_PG2_5window_mean(22)) nanmean(pt_PG2_5window_mean(23)) nanmean(pt_PG2_5window_mean(24))];
PG3_monthly=[nan nan pt_PG3_5window_mean(1) nanmean(pt_PG3_5window_mean(2)) nan nan mean(pt_PG3_5window_mean(3)) nanmean(pt_PG3_5window_mean(4:5)) nanmean(pt_PG3_5window_mean(6)) nanmean(pt_PG3_5window_mean(7)) nanmean(pt_PG3_5window_mean(8:9)) nanmean(pt_PG3_5window_mean(10:11)) nanmean(pt_PG3_5window_mean(12)) nanmean(pt_PG3_5window_mean(13:14)) nanmean(pt_PG3_5window_mean(15)) nanmean(pt_PG3_5window_mean(16)) nanmean(pt_PG3_5window_mean(17:18)) nanmean(pt_PG3_5window_mean(19)) nanmean(pt_PG3_5window_mean(20)) nanmean(pt_PG3_5window_mean(21)) nanmean(pt_PG3_5window_mean(22)) nanmean(pt_PG3_5window_mean(23)) nanmean(pt_PG3_5window_mean(24))];

%FJ
FJ1_monthly=[nan nan nan nan nan nan nan nan nan pt_FJ1_5window_mean(1) nanmean(pt_FJ1_5window_mean(2:4)) pt_FJ1_5window_mean(5) nan nanmean(pt_FJ1_5window_mean(6:7)) nanmean(pt_FJ1_5window_mean(8:10)) nanmean(pt_FJ1_5window_mean(11:12)) nanmean(pt_FJ1_5window_mean(13)) nanmean(pt_FJ1_5window_mean(14:15)) nanmean(pt_FJ1_5window_mean(16:17)) nanmean(pt_FJ1_5window_mean(18:19)) nanmean(pt_FJ1_5window_mean(20:21)) nanmean(pt_FJ1_5window_mean(22:23)) nan];
FJ2_monthly=[nan nan nan nan nan nan nan nan nan pt_FJ2_5window_mean(1) nanmean(pt_FJ2_5window_mean(2:4)) pt_FJ2_5window_mean(5) nan nanmean(pt_FJ2_5window_mean(6:7)) nanmean(pt_FJ2_5window_mean(8:10)) nanmean(pt_FJ2_5window_mean(11:12)) nanmean(pt_FJ2_5window_mean(13)) nanmean(pt_FJ2_5window_mean(14:15)) nanmean(pt_FJ2_5window_mean(16:17)) nanmean(pt_FJ2_5window_mean(18:19)) nanmean(pt_FJ2_5window_mean(20:21)) nanmean(pt_FJ2_5window_mean(22:23)) nan];
FJ3_monthly=[nan nan nan nan nan nan nan nan nan pt_FJ3_5window_mean(1) nanmean(pt_FJ3_5window_mean(2:4)) pt_FJ3_5window_mean(5) nan nanmean(pt_FJ3_5window_mean(6:7)) nanmean(pt_FJ1_5window_mean(8:10)) nanmean(pt_FJ1_5window_mean(11:12)) nanmean(pt_FJ1_5window_mean(13)) nanmean(pt_FJ1_5window_mean(14:15)) nanmean(pt_FJ1_5window_mean(16:17)) nanmean(pt_FJ1_5window_mean(18:19)) nanmean(pt_FJ1_5window_mean(20:21)) nanmean(pt_FJ1_5window_mean(22:23)) nan];

% FJ1_DailyMonthly=[nan nan nan nan nan nan nan nan nan pt_FJ1_5window_mean(1:5) nan pt_FJ1_5window_mean(6:23) nan];
% FJ2_DailyMonthly=[nan nan nan nan nan nan nan nan nan pt_FJ2_5window_mean(1:5) nan pt_FJ2_5window_mean(6:23) nan];
% FJ3_DailyMonthly=[nan nan nan nan nan nan nan nan nan pt_FJ3_5window_mean(1:5) nan pt_FJ3_5window_mean(6:23) nan];


figure(2)
subplot(3,1,1)
plot([1:23],JAK1_monthly,'color','b','linestyle','none','marker','.','markersize',20);hold on
plot([1:23],JAK2_monthly,'color','k','linestyle','none','marker','.','markersize',20)
plot([1:23],JAK3_monthly,'color','r','linestyle','none','marker','.','markersize',20)
legend('JAK1', 'JAK2', 'JAK3','location','northwest')
% plot([1:length(pt_FJ1_5window_mean)],mdl_pt_FJ1_5window_mean.Fitted,'b');
% plot([1:length(pt_FJ2_5window_mean)],mdl_pt_FJ2_5window_mean.Fitted,'k');
% plot([1:length(pt_FJ3_5window_mean)],mdl_pt_FJ3_5window_mean.Fitted,'r');
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
xlim([0 24])
ylim([0 7])
set(gca,'XTick',[1:23],'XTickLabel',monthly(1:23,:),'fontsize',8)%,'XTickLabelRotation',-45
grid on
title('Jakobshavn Isbræ','fontsize',12,'fontweight','b');


figure(2)
subplot(3,1,2)
plot([1:23],PG1_monthly/1000,'color','b','linestyle','none','marker','.','markersize',20);hold on
plot([1:23],PG2_monthly/1000,'color','k','linestyle','none','marker','.','markersize',20)
plot([1:23],PG3_monthly/1000,'color','r','linestyle','none','marker','.','markersize',20)
legend('PG1', 'PG2', 'PG3','location','northwest')
% plot([1:length(pt_FJ1_5window_mean)],mdl_pt_FJ1_5window_mean.Fitted,'b');
% plot([1:length(pt_FJ2_5window_mean)],mdl_pt_FJ2_5window_mean.Fitted,'k');
% plot([1:length(pt_FJ3_5window_mean)],mdl_pt_FJ3_5window_mean.Fitted,'r');
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
xlim([0 24])
ylim([0 1.6])
set(gca,'XTick',[1:23],'XTickLabel',monthly(1:23,:),'fontsize',8)%,'XTickLabelRotation',-45
grid on
title('Petermann Glacier','fontsize',12,'fontweight','b');

subplot(3,1,3)
plot([1:23],FJ1_monthly/1000,'color','b','linestyle','none','marker','.','markersize',20);hold on
plot([1:23],FJ2_monthly/1000,'color','k','linestyle','none','marker','.','markersize',20)
plot([1:23],FJ3_monthly/1000,'color','r','linestyle','none','marker','.','markersize',20)
legend('FJ1', 'FJ2', 'FJ3','location','northwest')
% plot([1:length(pt_FJ1_5window_mean)],mdl_pt_FJ1_5window_mean.Fitted,'b');
% plot([1:length(pt_FJ2_5window_mean)],mdl_pt_FJ2_5window_mean.Fitted,'k');
% plot([1:length(pt_FJ3_5window_mean)],mdl_pt_FJ3_5window_mean.Fitted,'r');
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
ylim([0 1.65])
xlim([0 24])
%dias=['Jan/15';'apr/15';'Sep/16'];
set(gca,'XTick',[1:23],'XTickLabel',monthly(1:23,:),'fontsize',8)%,'XTickLabelRotation',-45
grid on
title('79-Fjord','fontsize',12,'fontweight','b');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alternative Plot:
%
%
% figure
% subplot(3,1,1)
% plot(pt_JAK1,'color','b','linestyle','none','marker','.','markersize',20);
% subplot(3,1,2)
% plot(pt_JAK2,'color','k','linestyle','none','marker','.','markersize',20)
% subplot(3,1,3)
% plot(pt_JAK3,'color','r','linestyle','none','marker','.','markersize',20)
% legend('JAK1', 'JAK2', 'JAK3','location','northwest')
% ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
% %ylim([0 7])
% %dias=['nov/14';'apr/15';'fev/16'];
% set(gca,'XTick',[1:2:19],'XTickLabel',data_str_JAK(1:2:19,:),'XTickLabelRotation',-45,'fontsize',8)
% grid on
% title('Jakobshavn Isbræ','fontsize',12,'fontweight','b');
% 
% figure
% subplot(3,1,1)
% plot(pt_PG1/1000,'color','b','linestyle','none','marker','.','markersize',20);
% set(gca,'XTick',[1:2:24]);grid on;
% subplot(3,1,2)
% plot(pt_PG2/1000,'color','k','linestyle','none','marker','.','markersize',20)
% set(gca,'XTick',[1:2:24]);grid on;
% subplot(3,1,3)
% plot(pt_PG3/1000,'color','r','linestyle','none','marker','.','markersize',20)
% set(gca,'XTick',[1:2:24],'XTickLabel',data_str_PG(1:2:24,:),'XTickLabelRotation',-45,'fontsize',8)
% grid on
% 
%
% figure
% subplot(3,1,1)
% plot(pt_FJ1/1000,'color','b','linestyle','none','marker','.','markersize',20);
% xlim([0 24])
% set(gca,'XTick',[1:2:23]);grid on;
% subplot(3,1,2)
% plot(pt_FJ2/1000,'color','k','linestyle','none','marker','.','markersize',20)
% set(gca,'XTick',[1:2:23]);grid on;xlim([0 24])
% subplot(3,1,3)
% plot(pt_FJ3/1000,'color','r','linestyle','none','marker','.','markersize',20)
% set(gca,'XTick',[1:2:23],'XTickLabel',data_str_FJ(1:2:23,:),'XTickLabelRotation',-45,'fontsize',8)
% xlim([0 24])
% grid on
%
%%%%%%%%%%%%%%
%
% Alternate plot 5Window Mean
%
%figure
% title('Jakobshavn Isbræ','fontsize',12,'fontweight','b');
% subplot(3,1,1)
% plot([1:length(pt_JAK1_5window_mean)],pt_JAK1_5window_mean,'color','b','linestyle','none','marker','.','markersize',20);
% set(gca,'XTick',[1:2:19]); grid on
% subplot(3,1,2)
% plot([1:length(pt_JAK2_5window_mean)],pt_JAK2_5window_mean,'color','k','linestyle','none','marker','.','markersize',20)
% set(gca,'XTick',[1:2:19]); grid on
% subplot(3,1,3)
% plot([1:length(pt_JAK3_5window_mean)],pt_JAK3_5window_mean,'color','r','linestyle','none','marker','.','markersize',20)
% %legend('JAK1', 'JAK2', 'JAK3','location','northwest')
% ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
% %ylim([0 7])
% %dias=['nov/14';'apr/15';'fev/16'];
% set(gca,'XTick',[1:2:19],'XTickLabel',data_str_JAK(1:2:19,:),'XTickLabelRotation',-45,'fontsize',8)
% grid on
% 
% figure
% subplot(3,1,1)
% plot([1:length(pt_PG1_5window_mean)],pt_PG1_5window_mean/1000,'color','b','linestyle','none','marker','.','markersize',20);
% set(gca,'XTick',[1:2:24]);grid on;
% subplot(3,1,2)
% plot([1:length(pt_PG2_5window_mean)],pt_PG2_5window_mean/1000,'color','k','linestyle','none','marker','.','markersize',20)
% set(gca,'XTick',[1:2:24]);grid on;
% subplot(3,1,3)
% plot([1:length(pt_PG3_5window_mean)],pt_PG3_5window_mean/1000,'color','r','linestyle','none','marker','.','markersize',20)
% set(gca,'XTick',[1:2:24],'XTickLabel',data_str_PG(1:2:24,:),'XTickLabelRotation',-45,'fontsize',8)
% grid on
% 
% 
% figure
% subplot(3,1,1)
% plot([1:length(pt_FJ1_5window_mean)],pt_FJ1_5window_mean/1000,'color','b','linestyle','none','marker','.','markersize',20);
% xlim([0 24])
% set(gca,'XTick',[1:2:23]);grid on;
% subplot(3,1,2)
% plot([1:length(pt_FJ2_5window_mean)],pt_FJ2_5window_mean/1000,'color','k','linestyle','none','marker','.','markersize',20)
% set(gca,'XTick',[1:2:23]);grid on;xlim([0 24])
% subplot(3,1,3)
% plot([1:length(pt_FJ3_5window_mean)],pt_FJ3_5window_mean/1000,'color','r','linestyle','none','marker','.','markersize',20)
% set(gca,'XTick',[1:2:23],'XTickLabel',data_str_FJ(1:2:23,:),'XTickLabelRotation',-45,'fontsize',8)
% xlim([0 24])
% grid on
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Plot gradient

%JAK
prof_JAK_5window_mean_monthly=[nanmean(prof_curve_JAK_5window_mean(:,1),2) nanmean(prof_curve_JAK_5window_mean(:,2:3),2) nan(999,1) nanmean(prof_curve_JAK_5window_mean(:,4:5),2) nanmean(prof_curve_JAK_5window_mean(:,6:7),2) nanmean(prof_curve_JAK_5window_mean(:,8:10),2) nanmean(prof_curve_JAK_5window_mean(:,11),2) nanmean(prof_curve_JAK_5window_mean(:,12),2) nanmean(prof_curve_JAK_5window_mean(:,13),2) nanmean(prof_curve_JAK_5window_mean(:,14:15),2) nanmean(prof_curve_JAK_5window_mean(:,16:17),2) nan(999,1) nanmean(prof_curve_JAK_5window_mean(:,18),2) nan(999,1) nan(999,1) nanmean(prof_curve_JAK_5window_mean(:,19),2) nan(999,1) nan(999,1) nan(999,1) nan(999,1) nan(999,1) nan(999,1) nan(999,1)];

%PG
prof_PG_5window_mean_monthly=[nan(1997,1) nan(1997,1) nanmean(prof_curve_PG_5window_mean(:,1),2) nanmean(prof_curve_PG_5window_mean(:,2),2) nan(1997,1) nan(1997,1) nanmean(prof_curve_PG_5window_mean(:,3),2) nanmean(prof_curve_PG_5window_mean(:,4:5),2) nanmean(prof_curve_PG_5window_mean(:,6),2) nanmean(prof_curve_PG_5window_mean(:,7),2) nanmean(prof_curve_PG_5window_mean(:,8:9),2) nanmean(prof_curve_PG_5window_mean(:,10:11),2) nanmean(prof_curve_PG_5window_mean(:,12),2) nanmean(prof_curve_PG_5window_mean(:,13:14),2) nanmean(prof_curve_PG_5window_mean(:,15),2) nanmean(prof_curve_PG_5window_mean(:,16),2) nanmean(prof_curve_PG_5window_mean(:,17:18),2) nanmean(prof_curve_PG_5window_mean(:,19),2) nanmean(prof_curve_PG_5window_mean(:,20),2) nanmean(prof_curve_PG_5window_mean(:,21),2) nanmean(prof_curve_PG_5window_mean(:,22),2) nanmean(prof_curve_PG_5window_mean(:,23),2) nanmean(prof_curve_PG_5window_mean(:,24),2)];

%FJ
prof_FJ_5window_mean_monthly=[nan(1997,1) nan(1997,1) nan(1997,1) nan(1997,1) nan(1997,1) nan(1997,1) nan(1997,1) nan(1997,1) nan(1997,1) prof_curve_FJ_5window_mean(:,1) nanmean(prof_curve_FJ_5window_mean(:,2:4),2) nanmean(prof_curve_FJ_5window_mean(:,5),2) nan(1997,1) nanmean(prof_curve_FJ_5window_mean(:,6:7),2) nanmean(prof_curve_FJ_5window_mean(:,8:10),2) nanmean(prof_curve_FJ_5window_mean(:,11:12),2) nanmean(prof_curve_FJ_5window_mean(:,13),2) nanmean(prof_curve_FJ_5window_mean(:,14:15),2) nanmean(prof_curve_FJ_5window_mean(:,16:17),2) nanmean(prof_curve_FJ_5window_mean(:,18:19),2) nanmean(prof_curve_FJ_5window_mean(:,20:21),2) nanmean(prof_curve_FJ_5window_mean(:,22:23),2) nan(1997,1)];

figure;
plot(dist,prof_JAK_5window_mean_monthly,'.')
legend(monthly(1:23,:))
imagesc((prof_JAK_5window_mean_monthly'))
set(gca,'YTick',[1:23],'YTickLabel',monthly(1:23,:),'fontsize',8)%,'XTickLabelRotation',-45

figure;
imagesc(prof_PG_5window_mean_monthly')
set(gca,'YTick',[1:23],'YTickLabel',monthly(1:23,:),'fontsize',8)%,'XTickLabelRotation',-45

figure;
imagesc((prof_FJ_5window_mean_monthly'))
set(gca,'YTick',[1:23],'YTickLabel',monthly(1:23,:),'fontsize',8)%,'XTickLabelRotation',-45


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Summer and Winter mean with STD shaded

% JAK Summer & Winter

for i=1:4
JAK_summer2_profile(:,i)=profile_ext(X_p_curve_JAK,Y_p_curve_JAK,JAK_summer2(:,:,i),R_stack);
end

for i=1:10
JAK_winter2_profile(:,i)=profile_ext(X_p_curve_JAK,Y_p_curve_JAK,JAK_winter2(:,:,i),R_stack);
end

plot(dist,nanmean(JAK_summer2_profile,2),'.','color','r','markersize',3);
ylim([0 20]);
xlim([0 55])
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
grid on;
title('Mean Summer and Winter - Jakobshavn Isbræ','fontsize',12,'fontweight','b');
xlabel('distance [km]','fontsize',12,'fontweight','b')

hold on

plot(dist,nanmean(JAK_winter2_profile,2),'.','color','b','markersize',3);
% ylim([0 20]);
% xlim([0 55])
% ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
% grid on;
% title('Mean Winter - Petermann Glacier','fontsize',12,'fontweight','b');
% xlabel('distance [km]','fontsize',12,'fontweight','b')

legend('Summer','Winter','location','northeast');

hold on

% Floating area (Just a line for JAK -> Rosenau, R. et al., 2013. Grounding line migration and high-resolution calving dynamics of Jakobshavn Isbræ, West Greenland. Journal of Geophysical Research: Earth Surface, 118(2), pp.382–395.
% the ice front / GL referent to 19/08/2015 (after the calving event)

X_floating_JAK=[dist(137) dist(137)];
Y_floating_JAK=[0 20];

plot(X_floating_JAK,Y_floating_JAK,'color',[0.5 0.5 0.5],'linestyle','--');


X_floating_JAK=[dist(1):((0.048957*999)/(length(prof_curve_JAK)-1)):dist(137)];
Y_floating_JAK=[zeros(1,length(X_floating_JAK)) ones(1,length(X_floating_JAK))*20];
X_floating_JAK=[X_floating_JAK flip(X_floating_JAK)];
fill(X_floating_JAK,Y_floating_JAK,[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');



%%% Plot the STD shaded
hold on
std_velocity_JAK_profile_interp_SUMMER= fillgaps(interp1(dist,nanstd(JAK_summer2_profile,1,2),dist,'PCHIP'));
%F = fillgaps(double(std_velocity_JAK_profile/1000));

JAK_summer2_profile_filled_gaps=fillgaps(nanmean(JAK_summer2_profile,2));
fill_STD_JAK_SUMMER=[JAK_summer2_profile_filled_gaps(205:end)'+std_velocity_JAK_profile_interp_SUMMER(205:end), flip(JAK_summer2_profile_filled_gaps(205:end)'-std_velocity_JAK_profile_interp_SUMMER(205:end))];
dist_JAK_fill=[dist(205:end) , flip(dist(205:end))];
fill(dist_JAK_fill,fill_STD_JAK_SUMMER,'r','FaceAlpha', 0.3,'linestyle','none');


% std_velocity_PG_profile_interp_SUMMER= fillgaps(interp1(dist_PG,nanstd(PG_summer2_profile/1000,1,2),dist_PG,'PCHIP'));
% %F = fillgaps(double(std_velocity_PG_profile/1000));
% PG_summer2_profile_filled_gaps=fillgaps(nanmean(PG_summer2_profile/1000,2));
% fill_STD_PG_SUMMER=[PG_summer2_profile_filled_gaps(250:end)'+std_velocity_PG_profile_interp_SUMMER(250:end), flip(PG_summer2_profile_filled_gaps(250:end)'-std_velocity_PG_profile_interp_SUMMER(250:end))];
% dist_PG_fill=[dist_PG(250:end) , flip(dist_PG(250:end))];
% fill(dist_PG_fill,fill_STD_PG_SUMMER,'r','FaceAlpha', 0.3,'linestyle','none');


%%% Plot the STD shaded
hold on
std_velocity_JAK_profile_interp_WINTER= fillgaps(interp1(dist,nanstd(JAK_winter2_profile,1,2),dist,'PCHIP'));
%F = fillgaps(double(std_velocity_JAK_profile/1000));

fill_STD_JAK_WINTER=[fillgaps(nanmean(JAK_winter2_profile,2)'+std_velocity_JAK_profile_interp_WINTER), flip(fillgaps(nanmean(JAK_winter2_profile,2)'-std_velocity_JAK_profile_interp_WINTER))];
dist_JAK_fill=[dist , flip(dist)];
fill(dist_JAK_fill,fill_STD_JAK_WINTER,'b','FaceAlpha', 0.3,'linestyle','none');



% PG Summer & Winter

for i=1:7
PG_summer2_profile(:,i)=profile_ext(X_p_curve_PG,Y_p_curve_PG,PG_summer2(:,:,i),Rstack_PG);
end


for i=1:8
PG_winter2_profile(:,i)=profile_ext(X_p_curve_PG,Y_p_curve_PG,PG_winter2(:,:,i),Rstack_PG);
end

figure
plot(dist_PG,nanmean(PG_summer2_profile/1000,2),'.','color','r','markersize',3);
ylim([0 1.8]);
xlim([0 200])
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
grid on;
title('Mean Summer and Winter - Petermann Glacier','fontsize',12,'fontweight','b');
xlabel('distance [km]','fontsize',12,'fontweight','b')

hold on

plot(dist_PG,nanmean(PG_winter2_profile/1000,2),'.','color','b','markersize',3);
%ylim([0 1.6]);
%xlim([0 200])
%ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
%grid on;
%title('Mean Winter - Petermann Glacier','fontsize',12,'fontweight','b');
%xlabel('distance [km]','fontsize',12,'fontweight','b')

legend('Summer','Winter','location','northeast');

hold on

% Floating area
% considering the most recent Ice front position (CCI) and the grounding line from

X_floating_PG=[dist_PG(504) dist_PG(504)];
Y_floating_PG=[-0.1 1.8];

plot(X_floating_PG,Y_floating_PG,'color',[0.5 0.5 0.5],'linestyle','--');


X_floating_PG=[dist_PG(1):((0.1916*1997)/(length(prof_curve_PG)-1)):dist_PG(998)];
Y_floating_PG=[ones(1,length(X_floating_PG))*-0.1 ones(1,length(X_floating_PG))*1.8];
X_floating_PG=[X_floating_PG flip(X_floating_PG)];
fill(X_floating_PG,Y_floating_PG,[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');



%%% Plot the STD shaded
std_velocity_PG_profile_interp_SUMMER= fillgaps(interp1(dist_PG,nanstd(PG_summer2_profile/1000,1,2),dist_PG,'PCHIP'));
%F = fillgaps(double(std_velocity_PG_profile/1000));
PG_summer2_profile_filled_gaps=fillgaps(nanmean(PG_summer2_profile/1000,2));
fill_STD_PG_SUMMER=[PG_summer2_profile_filled_gaps(250:end)'+std_velocity_PG_profile_interp_SUMMER(250:end), flip(PG_summer2_profile_filled_gaps(250:end)'-std_velocity_PG_profile_interp_SUMMER(250:end))];
dist_PG_fill=[dist_PG(250:end) , flip(dist_PG(250:end))];
fill(dist_PG_fill,fill_STD_PG_SUMMER,'r','FaceAlpha', 0.3,'linestyle','none');


%%% Plot the STD shaded
hold on
std_velocity_PG_profile_interp_WINTER= fillgaps(interp1(dist_PG,nanstd(PG_winter2_profile/1000,1,2),dist_PG,'PCHIP'));
%F = fillgaps(double(std_velocity_PG_profile/1000));

fill_STD_PG_WINTER=[fillgaps(nanmean(PG_winter2_profile/1000,2)'+std_velocity_PG_profile_interp_WINTER), flip(fillgaps(nanmean(PG_winter2_profile/1000,2)'-std_velocity_PG_profile_interp_WINTER))];
dist_PG_fill=[dist_PG , flip(dist_PG)];
fill(dist_PG_fill,fill_STD_PG_WINTER,'b','FaceAlpha', 0.3,'linestyle','none');



% FJ Summer & Winter

for i=1:7
FJ_summer2_profile(:,i)=profile_ext(X_p_curve_FJ,Y_p_curve_FJ,FJ_summer2(:,:,i),Rstack_FJ);
end

for i=1:8
FJ_winter2_profile(:,i)=profile_ext(X_p_curve_FJ,Y_p_curve_FJ,FJ_winter2(:,:,i),Rstack_FJ);
end

figure
plot(dist_FJ,nanmean(FJ_summer2_profile/1000,2),'.','color','r','markersize',3);
ylim([0 1.6]);
xlim([0 200])
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
grid on;
title('Mean Summer and Winter - 79-Fjord','fontsize',12,'fontweight','b');
xlabel('distance [km]','fontsize',12,'fontweight','b')

hold on

plot(dist_FJ,nanmean(FJ_winter2_profile/1000,2),'.','color','b','markersize',3);
% ylim([0 1.6]);
% xlim([0 200])
% ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
% grid on;
% title('Mean Winter - 79-Fjord','fontsize',12,'fontweight','b');
% xlabel('distance [km]','fontsize',12,'fontweight','b')


legend('Summer','Winter','location','northeast');

% Floating area
% considering the most recent Ice front position (CCI) and the grounding line from 
X_floating_FJ=[dist_FJ(1):((0.1916*999*2)/(length(prof_curve_FJ)-1)):dist_FJ(193*2)];
Y_floating_FJ=[zeros(1,length(X_floating_FJ)) ones(1,length(X_floating_FJ))*1.8];
X_floating_FJ=[X_floating_FJ flip(X_floating_FJ)];
fill(X_floating_FJ,Y_floating_FJ,[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');

%%% Plot the STD shaded
hold on
std_velocity_FJ_profile_interp= fillgaps(interp1(dist_FJ,std_velocity_FJ_profile/1000,dist_FJ,'PCHIP'));
%F = fillgaps(double(std_velocity_FJ_profile/1000));

fill_STD_FJ=[(fillgaps(mean_velocity_FJ_profile)'/1000+std_velocity_FJ_profile_interp), flip((fillgaps(mean_velocity_FJ_profile')/1000-std_velocity_FJ_profile_interp))];
dist_FJ_fill=[dist_FJ , flip(dist_FJ)];
fill(dist_FJ_fill,fill_STD_FJ,[0.5 0.5 0.5],'FaceAlpha', 0.3,'linestyle','none');

%%% Plot the STD shaded
hold on
std_velocity_FJ_profile_interp_SUMMER= fillgaps(interp1(dist_FJ,nanstd(FJ_summer2_profile/1000,1,2),dist_FJ,'PCHIP'));
%F = fillgaps(double(std_velocity_FJ_profile/1000));

fill_STD_FJ_SUMMER=[fillgaps(nanmean(FJ_summer2_profile/1000,2)'+std_velocity_FJ_profile_interp_SUMMER), flip(fillgaps(nanmean(FJ_summer2_profile/1000,2)'-std_velocity_FJ_profile_interp_SUMMER))];
dist_FJ_fill=[dist_FJ , flip(dist_FJ)];
fill(dist_FJ_fill,fill_STD_FJ_SUMMER,'r','FaceAlpha', 0.3,'linestyle','none');


%%% Plot the STD shaded
hold on
std_velocity_FJ_profile_interp_WINTER= fillgaps(interp1(dist_FJ,nanstd(FJ_winter2_profile/1000,1,2),dist_FJ,'PCHIP'));
%F = fillgaps(double(std_velocity_FJ_profile/1000));

fill_STD_FJ_WINTER=[fillgaps(nanmean(FJ_winter2_profile/1000,2)'+std_velocity_FJ_profile_interp_WINTER), flip(fillgaps(nanmean(FJ_winter2_profile/1000,2)'-std_velocity_FJ_profile_interp_WINTER))];
dist_FJ_fill=[dist_FJ , flip(dist_FJ)];
fill(dist_FJ_fill,fill_STD_FJ_WINTER,'b','FaceAlpha', 0.3,'linestyle','none');

%% Create a mask to analyse the slow moving areas:

h=imagesc(PG_summer_mean_minus_winter2);
tt=double(~isnan(PG_summer_mean_minus_winter2)); set(h,'AlphaData', tt);
caxis([0 2]);

% draw masks
poly_PG = imfreehand();
mask_PG = poly_PG.createMask();


% FJ
h=imagesc(FJ_summer_mean_divided_winter2);
tt=double(~isnan(FJ_summer_mean_divided_winter2)); set(h,'AlphaData', tt);
caxis([0 2]);

% draw masks
poly_FJ = imfreehand();
mask_FJ = poly_FJ.createMask();


slow_mov_PG = PG_summer_mean_minus_winter2(mask_PG==1);
hist(slow_mov_PG/1000,[-0.1:0.01:0.1]);
title('summer minus winter - Petermann Glacier')
xlim([-0.1 0.1])
ylim([0 55000]);
xlabel('[km/yr]','fontsize',12,'fontweight','b')

figure
slow_mov_FJ = FJ_summer_mean_minus_winter2(mask_FJ==1);
hist(slow_mov_FJ/1000,[-0.1:0.002:0.1]);
title('summer minus winter - 79-Fjord')
xlim([-0.025 0.025])
xlabel('[km/yr]','fontsize',12,'fontweight','b')

mask_PG_unit=uint8(mask_PG);
mask_FJ_unit=uint8(mask_FJ);

mask_PG_unit(find(mask_PG_unit==0))=250;
mask_FJ_unit(find(mask_FJ_unit==0))=250;

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_stack_DuFil.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_slow_area_mask.tif', mask_PG_unit, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/FJ_stack_DuFil.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/FJ_slow_area_mask.tif', mask_FJ_unit, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


PG_2std_stable_Area=(nanstd(slow_mov_PG)*2/1000);
FJ_2std_stable_Area=(nanstd(slow_mov_FJ)*2/1000);

PG_summer_minus_winter_greaterPG_2std=PG_summer_mean_minus_winter2/1000;
PG_summer_minus_winter_greaterPG_2std(PG_summer_minus_winter_greaterPG_2std<=(nanmean(slow_mov_PG)/1000)+PG_2std_stable_Area & PG_summer_minus_winter_greaterPG_2std>=(nanmean(slow_mov_PG)/1000)-PG_2std_stable_Area)=0;

FJ_summer_minus_winter_greaterFJ_2std=FJ_summer_mean_minus_winter2/1000;
FJ_summer_minus_winter_greaterFJ_2std(FJ_summer_minus_winter_greaterFJ_2std<=(nanmean(slow_mov_FJ)/1000)+FJ_2std_stable_Area & FJ_summer_minus_winter_greaterFJ_2std>=(nanmean(slow_mov_FJ)/1000)-FJ_2std_stable_Area)=0;

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_stack_DuFil.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_summer_minus_winter_greaterPG_2std.tif', PG_summer_minus_winter_greaterPG_2std, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/FJ_stack_DuFil.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/FJ_summer_minus_winter_greaterFJ_2std.tif', FJ_summer_minus_winter_greaterFJ_2std, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

%% Taylor diagram

load('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/IM_paper_Validation.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [hp ht axl] = taylordiag(STDs,RMSs,CORs,['option',value])
% Outputs:
%   	STATM(1,:) => Mean
%   	STATM(2,:) => Standard Deviation (scaled by N)
%   	STATM(3,:) => Centered Root Mean Square Difference (scaled by N)
%   	STATM(4,:) => Correlation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%taylor_Matrix=[fillgaps(prof_Joughin_2015_JAK'/1000),fillgaps(nanmean(prof_curve_JAK,2)'),

STATM_JAK = allstats(fillgaps(prof_Joughin_2015_JAK/1000),fillgaps(nanmean(prof_curve_JAK,2)));
STATM_PG = allstats(fillgaps(prof_Joughin_2015_PG(250:end)/1000),fillgaps(prof_curve_PG_interp(250:end)/1000));
STATM_FJ = allstats(fillgaps(prof_Joughin_2015_FJ/1000),fillgaps(prof_curve_FJ_interp/1000));

S1_Stats=[STATM_JAK(:,2)'; STATM_PG(:,2)'; STATM_FJ(:,2)'];
Joughin_Stats=[STATM_JAK(:,1)'; STATM_PG(:,1)'; STATM_FJ(:,1)'];

S1_Stats(:,2)=S1_Stats(:,2)./Joughin_Stats(:,2);
%Normalizando CRMS do modelo pelo desvio observado
S1_Stats(:,3)=S1_Stats(:,3)./Joughin_Stats(:,2);
%Normalizando desvio do observado pelo desvio observado
Joughin_Stats(:,2)=Joughin_Stats(:,2)./Joughin_Stats(:,2);

figure
set(gcf,'PaperPositionMode','auto','position',[107   300   457   339])
[hp ht axl]=taylordiag([Joughin_Stats(1,2);S1_Stats(:,2)],[Joughin_Stats(1,3);S1_Stats(:,3)],[Joughin_Stats(1,4);S1_Stats(:,4)])%,'tickSTD',[0:0.25:1.5],'tickRMS',[0:0.25:1.5],'titleRMS',0,'tickRMSangle',135,'showlabelsRMS',0,'colCOR','k','colSTD','k','colRMS','k');

name_taylor=cellstr(['InSAR NSIDC';'JAK        ';'PG         ';'FJ         ']);
for i=1:4
set(ht(i),'String',name_taylor(i));
set(ht(i),'fontsize',10)
set(hp(i),'markersize',12)
end


%%
% cd /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/Stack_Data/filtered
% load('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/Velocities_JAK.mat','dist','B_','prof_S1')
% 
% [Vel_Stack,R_stack]=geotiffread('stack_filtered3.tif');
% im2=Vel_Stack;
% im2(im2<=0)=nan;
% 
% Vel_mean=nanmean(im2,3);
% std_stack=nanstd(im2,1,3);
% 
% %%%%%%%%
% % Data stacked and filtered:
% %%%%%%%%
% 
% % extract the profile from the filtered data: 
% 
% for i=1:19
% prof_S1(:,i)=profile_ext(X_p,Y_p,Vel_Stack(:,:,i),R_stack);
% end
% 
% % Winter time
% % 16/nov/2014 -> 28/march/2015  &  11/11/2015 -> 03/02/2016
% % 1:8 && 18:19
% 
% Vel_mean_Winter=nanmean(im2(:,:,[1:8 18:19]),3);
% std_Winter=nanstd(im2(:,:,[1:8 18:19]),1,3);
% 
% figure; imagesc(Vel_mean);caxis([0 14]); title('Mean all data'); colorbar
% figure; imagesc(Vel_mean_Winter);caxis([0 14]); title('Mean Winter'); colorbar
% figure; imagesc(std_stack);caxis([0 5]); colorbar; title('STD all data');
% figure; imagesc(std_Winter);caxis([0 5]); colorbar; title('STD Winter');
% 
% 
% !cp /nfs/a59/eeagdl/Dropbox/Rotinas/UoL/profile_ext.m ./
% jak_STDstack_prof=profile_ext(X_p,Y_p,std_stack,R_stack);
% jak_STDstack_Winter_prof=profile_ext(X_p,Y_p,std_Winter,R_stack);
% 
% figure; plot(dist(1,:),jak_STDstack_prof,'.'); hold on;
% plot(dist(1,:),jak_STDstack_Winter_prof,'.');
% legend('STD all data','STD Winter');
% title('STD profile');
% grid on
% 
% 
% 
% for i=1:length(prof_S1)
% 
% det(i,:)=detrend(prof_S1(i,:));
% 
% end
% 

%% Errors based on the stable areas
%
% RMS measures how far on average the error is from 0.
% The mean of the pairwise differences does not measure the variability of the
% difference, and the variability as indicated by the standard deviation is around
% the mean instead of 0. Therefore, the RMS of the differences is a meaningful
% measure of the error.
%
% Mal's email:
%
% You should use the root mean square of the values rather than the
% standard deviation. This will take into account any bias in the
% displacement over stationary areas. For example, if all your stationary
% pixels had a displacement value of 10 m then it would be reasonable to
% expect your error to be 10 m. However the standard deviation would be
% zero - because all the displacement values are the same - whereas the
% rms would give a more realistic 10 m.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% JAK
h=imagesc(mean_velocity_stack_JAK);
tt=double(~isnan(mean_velocity_stack_JAK)); set(h,'AlphaData', tt);
caxis([0 6]);

% draw masks
poly_JAK = imfreehand();
mask_JAK = poly_JAK.createMask();

slow_mov_JAK_meanMap =mean_velocity_stack_JAK(mask_JAK==1);
RMS_JAK_meanMap=rms(slow_mov_JAK_meanMap(~isnan(slow_mov_JAK_meanMap)))*1000;

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/Stack_Data/filtered/stack_filtered3.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/JAK_slow_area_mask.tif', mask_JAK, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);



% PG
slow_mov_PG_meanMap =mean_velocity_stack_PG(mask_PG==1);
RMS_PG_meanMap=rms(slow_mov_PG_meanMap(~isnan(slow_mov_PG_meanMap)));

% FJ
slow_mov_FJ_meanMap =mean_velocity_stack_FJ(mask_FJ==1);
RMS_FJ_meanMap=rms(slow_mov_FJ_meanMap(~isnan(slow_mov_FJ_meanMap)));


% Appling a Median filter to reduce the noise in JAK:
% 6x6 window == 540mx540m


Median_6x6_JAK = medfilt2(mean_velocity_stack_JAK,[6 6]);

Median_6x6_JAK_profile=profile_ext(X_p_curve_JAK,Y_p_curve_JAK,Median_6x6_JAK,R_stack);


plot(J_test_profile, '.')
hold on;

Compari_test=J_test_profile-nanmean(prof_Joughin_2015_JAK/1000,2);
Compari_test=Compari_test(40:end);
plot(Compari_test,'.')
plot(J_test_profile,nanmean(prof_Joughin_2015_JAK/1000,2),'.');
RMS_Compar_test=rms(Compari_test(~isnan(Compari_test)))

%%%%%
plot(dist,fillgaps(Median_6x6_JAK_profile),'-','color','r','linewidth',2);hold on;
hold on
plot(dist,Median_6x6_JAK_profile,'-','color','k','linewidth',2);hold on;
ylim([0 20]);
xlim([0 55]);
%ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
grid off;
title('Mean velocity profile','fontsize',12,'fontweight','b');
xlabel('distance [km]','fontsize',12,'fontweight','b')
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')

hold on

% Floating area (Just a line for JAK -> Rosenau, R. et al., 2013. Grounding line migration and high-resolution calving dynamics of Jakobshavn Isbræ, West Greenland. Journal of Geophysical Research: Earth Surface, 118(2), pp.382–395.
% the ice front / GL referent to 19/08/2015 (after the calving event)

X_floating_JAK=[dist(137) dist(137)];
Y_floating_JAK=[0 20];

plot(X_floating_JAK,Y_floating_JAK,'color',[0.5 0.5 0.5],'linestyle','--');


X_floating_JAK=[dist(1):((0.048957*999)/(length(prof_curve_JAK)-1)):dist(137)];
Y_floating_JAK=[zeros(1,length(X_floating_JAK)) ones(1,length(X_floating_JAK))*20];
X_floating_JAK=[X_floating_JAK flip(X_floating_JAK)];
fill(X_floating_JAK,Y_floating_JAK,[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');

hold on
std_velocity_JAK_profile_interp= fillgaps(interp1(dist,std_velocity_JAK_profile,dist,'PCHIP'));
%F = fillgaps(double(std_velocity_FJ_profile/1000));

fill_STD_JAK__=[(fillgaps(Median_6x6_JAK_profile')+RMS_JAK_meanMap/1000), flip((fillgaps(Median_6x6_JAK_profile')-RMS_JAK_meanMap/1000))];
dist_JAK_fill=[dist , flip(dist)];
fill(dist_JAK_fill,fill_STD_JAK__,[0.5 0.5 0.5],'FaceAlpha', 0.3,'linestyle','none');


%%%

%figure;
[AX_JAK,H1_JAK,H2_JAK] = plotyy(dist,Median_6x6_JAK_profile,dist,prof_DEM_JAK);

set(H1_JAK,'LineStyle','-','marker','none','color','k','linewidth',2);hold on;
set(H2_JAK,'LineStyle','--','marker','none','color',[0.5 0.5 0.5],'linewidth',2);hold on;
box off
set(AX_JAK(1),'ylim',[0 20],'Ycolor','k');
set(AX_JAK(2),'ylim',[0 1300],'Ycolor',[0.5 0.5 0.5]);
xlim([0 50]);
%ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
grid off;
title('Jakobshavn Isbræ','fontsize',12,'fontweight','b');
xlabel('distance [km]','fontsize',12,'fontweight','b')
ylabel(AX_JAK(1),'velocity [km/yr]','fontsize',12,'fontweight','b','color','k')
ylabel(AX_JAK(2),'elevation [m]','fontsize',12,'fontweight','b','color','k')

set(AX_JAK(1),'YTick',[0:2:20],'YTickLabel',[0:2:20],'fontsize',12)
set(AX_JAK(2),'YTick',[0:200:1300],'YTickLabel',[0:200:1300],'fontsize',12)

hold on

% Floating area (Just a line for JAK -> Rosenau, R. et al., 2013. Grounding line migration and high-resolution calving dynamics of Jakobshavn Isbræ, West Greenland. Journal of Geophysical Research: Earth Surface, 118(2), pp.382–395.
% the ice front / GL referent to 19/08/2015 (after the calving event)

X_floating_JAK=[dist(137) dist(137)];
Y_floating_JAK=[0 20];

plot(X_floating_JAK,Y_floating_JAK,'color',[0.5 0.5 0.5],'linestyle','--');


X_floating_JAK=[dist(1):((0.048957*999)/(length(prof_curve_JAK)-1)):dist(137)];
Y_floating_JAK=[zeros(1,length(X_floating_JAK)) ones(1,length(X_floating_JAK))*20];
X_floating_JAK=[X_floating_JAK flip(X_floating_JAK)];
fill(X_floating_JAK,Y_floating_JAK,[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');


% STD shaded JAK

hold on
std_velocity_JAK_profile_interp= fillgaps(interp1(dist,std_velocity_JAK_profile,dist,'PCHIP'));
%F = fillgaps(double(std_velocity_FJ_profile/1000));

fill_STD_JAK=[(fillgaps(mean_velocity_JAK_profile)'+std_velocity_JAK_profile_interp), flip((fillgaps(mean_velocity_JAK_profile')-std_velocity_JAK_profile_interp))];
dist_JAK_fill=[dist , flip(dist)];
fill(dist_JAK_fill,fill_STD_JAK,[0.5 0.5 0.5],'FaceAlpha', 0.3,'linestyle','none');

%% Slow areas Comparison

% Create a mask of fast flow to compare the slow areas:

info = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/automated/Stack_Data/filtered/stack_filtered3.tif');


% JAK
h=imagesc(mean_velocity_stack_JAK);
tt=double(~isnan(mean_velocity_stack_JAK)); set(h,'AlphaData', tt);
caxis([0 5]);


poly_JAK_fast_areas= imfreehand();
mask_JAK_fast_areas = poly_JAK_fast_areas.createMask();


fast_mov_JAK = mean_velocity_stack_JAK;
fast_mov_JAK(mask_JAK_fast_areas==1) = nan;
fast_mov_JAK=fast_mov_JAK(1:end-1,1:end-2);

geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/JAK_fast_area_mask.tif', mask_JAK_fast_areas, R_stack,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

% Interpolate my velocity to a poor resolution;
% Subset the Joughin velocity map
% Interpolate the Joughin velocity map to my Vel product

[mean_velocity_stack_JAK_interp_250m,Rstack_JAK_interp]=interp_map(mean_velocity_stack_JAK,R_stack, 0.36);
[Vel_Joughin_subset_JAK,R_Joughin_subset_JAK]=subset_map(Vel_Joughin_2015,Rstack_JAK_interp,R_Joughin_2015);
[Vel_Joughin_subset_JAK_90m,R_Joughin_subset_JAK_90m]=interp_map(Vel_Joughin_subset_JAK,R_Joughin_subset_JAK,2.7778);


%PG
h=imagesc(PG_summer_mean_minus_winter2);
tt=double(~isnan(PG_summer_mean_minus_winter2)); set(h,'AlphaData', tt);
caxis([0 1200]);

% draw masks
poly_PG_fast_areas= imfreehand();
mask_PG_fast_areas = poly_PG_fast_areas.createMask();


fast_mov_PG = mean_velocity_stack_PG;
fast_mov_PG(mask_PG_fast_areas==0) = nan;

geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_fast_area_mask.tif', mask_PG_fast_areas, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_fast_area_mask3.tif', mask_PG_fast_areas, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
%geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/PG_fast_area_mask2.tif', mask_PG_fast_areas, Rstack_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

% Interpolate my velocity to a poor resolution;
% Subset the Joughin velocity map
% Interpolate the Joughin velocity map to my Vel product

[mean_velocity_stack_PG_interp_250m,Rstack_PG_interp]=interp_map(mean_velocity_stack_PG,Rstack_PG, 0.4);
[Vel_Joughin_subset_PG,R_Joughin_subset_PG]=subset_map(Vel_Joughin_2015,Rstack_PG_interp,R_Joughin_2015);
[Vel_Joughin_subset_PG_100m,R_Joughin_subset_PG_100m]=interp_map(Vel_Joughin_subset_PG,R_Joughin_subset_PG,2.5);



% FJ
h=imagesc(FJ_summer_mean_divided_winter2);
tt=double(~isnan(FJ_summer_mean_divided_winter2)); set(h,'AlphaData', tt);
caxis([0 2]);

% draw masks
poly_FJ_fast_areas= imfreehand();
mask_FJ_fast_areas = poly_FJ_fast_areas.createMask();


fast_mov_FJ = mean_velocity_stack_FJ;
fast_mov_FJ(mask_FJ_fast_areas==1) = nan;
fast_mov_FJ=fast_mov_FJ(2:end, 3:end);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/FJ_fast_area_mask.tif', mask_FJ_fast_areas, Rstack_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


% Interpolate my velocity to a poor resolution;
% Subset the Joughin velocity map
% Interpolate the Joughin velocity map to my Vel product

[mean_velocity_stack_FJ_interp_250m,Rstack_FJ_interp]=interp_map(mean_velocity_stack_FJ,Rstack_FJ, 0.4);
[Vel_Joughin_subset_FJ,R_Joughin_subset_FJ]=subset_map(Vel_Joughin_2015,Rstack_FJ_interp,R_Joughin_2015);
[Vel_Joughin_subset_FJ_100m,R_Joughin_subset_FJ_100m]=interp_map(Vel_Joughin_subset_FJ,R_Joughin_subset_FJ,2.5);

%%%%
% Mask the fast flow and compare both histograms


fast_mov_JAK_Joughin_subset = Vel_Joughin_subset_JAK_90m;
fast_mov_JAK_Joughin_subset(mask_JAK_fast_areas(1:end-1,1:end-2)==1) = nan;
fast_mov_JAK_Joughin_subset(fast_mov_JAK_Joughin_subset<=0.0001) = nan;

fast_mov_PG_Joughin_subset = Vel_Joughin_subset_PG_100m;
fast_mov_PG_Joughin_subset(mask_PG_fast_areas==0) = nan;
fast_mov_PG_Joughin_subset(fast_mov_PG_Joughin_subset<=0.0001) = nan;

fast_mov_FJ_Joughin_subset = Vel_Joughin_subset_FJ_100m;
mask_FJ_fast_areas_V2=mask_FJ_fast_areas(2:end, 3:end);
fast_mov_FJ_Joughin_subset(mask_FJ_fast_areas_V2==1) = nan;
fast_mov_FJ_Joughin_subset(fast_mov_FJ_Joughin_subset<=0.0001) = nan;

figure;
subplot(1,3,1);
[counts_Joughin_JAK,centers_Joughin_JAK] = hist(fast_mov_JAK_Joughin_subset(:)/1000,[-2:0.25:2]);
bar(centers_Joughin_JAK,counts_Joughin_JAK,'FaceColor','none','EdgeColor','r','LineWidth',1.5);hold on;
[counts_JAK,centers_JAK] = hist(fast_mov_JAK(:),[-2:0.25:2]);
bar(centers_JAK,counts_JAK,'FaceColor','none','EdgeColor','b','LineWidth',1.5);hold on;
xlim([-2 2])
title('Jakobshavn Isbræ','fontsize',12,'fontweight','b');
xlabel('[km/yr]','fontsize',12,'fontweight','b');

legend('NSIDC', 'S1','location','NorthWest')


subplot(1,3,2);
[counts_Joughin_PG,centers_Joughin_PG] = hist(fast_mov_PG_Joughin_subset(:)/1000,[-0.1:0.01:0.1]);
bar(centers_Joughin_PG,counts_Joughin_PG,'FaceColor','none','EdgeColor','r','LineWidth',1.5);hold on;
[counts_PG,centers_PG] = hist(fast_mov_PG(:)/1000,[-0.1:0.01:0.1]);
bar(centers_PG,counts_PG,'FaceColor','none','EdgeColor','b','LineWidth',1.5);hold on;
xlim([-0.16 0.16]);
title('Petermann','fontsize',12,'fontweight','b');
xlabel('[km/yr]','fontsize',12,'fontweight','b');

%legend('NSIDC', 'S1','location','NorthWest')

subplot(1,3,3);
[counts_Joughin_FJ,centers_Joughin_FJ] = hist(fast_mov_FJ_Joughin_subset(:)/1000,[-0.1:0.01:0.1]);
bar(centers_Joughin_FJ,counts_Joughin_FJ,'FaceColor','none','EdgeColor','r','LineWidth',1.5);hold on;
[counts_FJ,centers_FJ] = hist(fast_mov_FJ(:)/1000,[-0.1:0.01:0.1]);
bar(centers_FJ,counts_FJ,'FaceColor','none','EdgeColor','b','LineWidth',1.5);hold on;
xlim([-0.16 0.16]);
title('79-Fjord','fontsize',12,'fontweight','b');
S1_minus_Joughin_PG_slow_areaxlabel('[km/yr]','fontsize',12,'fontweight','b');

%legend('NSIDC', 'S1','location','NorthWest')



% Histogram: S1-InSAR


S1_minus_Joughin_JAK_slow_area=fast_mov_JAK_Joughin_subset/1000-fast_mov_JAK(1:end-1,1:end-2);
figure,hist(S1_minus_Joughin_JAK_slow_area(:),[-0.3:0.02:0.3])
xlim([-0.3 0.3])
title('Jakobshavn Isbræ','fontsize',12,'fontweight','b');
xlabel('[km/yr]','fontsize',12,'fontweight','b');

% Fig: /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Hist_S1_minus_Joughin_JAK.png

S1_minus_Joughin_PG_slow_area=fast_mov_PG_Joughin_subset/1000-fast_mov_PG/1000;
figure,hist(S1_minus_Joughin_PG_slow_area(:),[-0.1:0.01:0.1]) 
title('Petermann','fontsize',12,'fontweight','b');
xlim([-0.1 0.1])
% Fig: /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Hist_S1_minus_Joughin_PG.png


S1_minus_Joughin_FJ_slow_area=fast_mov_FJ_Joughin_subset/1000-fast_mov_FJ/1000;
figure,hist(S1_minus_Joughin_FJ_slow_area(:),[-0.1:0.01:0.1]) 
title('79-Fjord','fontsize',12,'fontweight','b');
xlim([-0.1 0.1])




hist(fast_mov_JAK_Joughin_subset(:)/1000,[-2:0.25:2]);
xlim([-2 2])
