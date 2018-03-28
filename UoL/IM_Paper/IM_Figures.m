%% Main Profiles

%GIMP - DEM

[GIMP_DEM,R_gimp]=geotiffread('/nfs/a59/eeagdl/DATABASE/GREENLAND/GIMP_DEM/gimpdem_90m.tif');

prof_DEM_JAK=profile_ext(X_p_curve_JAK,Y_p_curve_JAK,GIMP_DEM,R_gimp);


% JAK 


figure;
[AX_JAK,H1_JAK,H2_JAK] = plotyy(dist,mean_velocity_JAK_profile/1000,dist,prof_DEM_JAK);

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

set(AX_JAK(1),'Ylim',[0 16],'YTick',[0:2:16],'YTickLabel',[0:2:16],'fontsize',12)
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

shadedErrorBar(dist,mean_velocity_JAK_profile/1000,std_velocity_JAK_profile/1000,{'k','linestyle','none'},1);

set(gcf,'Paperorientation','landscape')
print -dpng -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/JAK_Main_Profile
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/JAK_Main_Profile

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
%plot([dist_PG2(489) dist_PG2(489)], [0 0.1], 'color','k','linestyle','-','linewidth',3);

%PG6:
plot([dist_PG2(527) dist_PG2(527)], [0 0.1], 'color','k','linestyle','-','linewidth',3);

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

shadedErrorBar(dist_PG,mean_velocity_PG_profile/1000,std_velocity_PG_profile/1000,{'k','linestyle','none'},1);

print -dpng -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/PG_Main_Profile
set(gcf,'Paperorientation','landscape')
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/PG_Main_Profile

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

shadedErrorBar(dist_FJ,mean_velocity_FJ_profile/1000,std_velocity_FJ_profile/1000,{'k','linestyle','none'},1);

print -dpng -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/FJ_Main_Profile
set(gcf,'Paperorientation','landscape')
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/FJ_Main_Profile
%% Across Profiles
%%%%%%%%%%%%%%%%%  Across Profiles  %%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%% JAK  %%%%%%%%%%%%%%%%%%%%%

dist_across_JAK1_=(-0.0112*576):((0.0112*999)/(length(prof_across_JAK1)-1)):(0.0112*(999-576));
dist_across_JAK2_=(-0.0165*483):((0.0165*999)/(length(prof_across_JAK2)-1)):(0.0165*(999-483));
dist_across_JAK3_=(-0.0137*432):((0.0137*999)/(length(prof_across_JAK3)-1)):(0.0137*(999-432));


% plot cross profile with the main profile as reference

    % The image product resolution is 90m and the across profiles are in
    % high spatial resolution, so I have to undersample them in order to
    % not get repeatedly values

prof_across_JAK1_mean= nanmean(prof_across_JAK1,2);
prof_across_JAK2_mean= nanmean(prof_across_JAK2,2);  
prof_across_JAK3_mean= nanmean(prof_across_JAK3,2);


% STD shading
% Plotting across profiles with the main profile as reference 

figure;
plot(flip(dist_across_JAK1_(1:8:end))*(-1),flip(prof_across_JAK1_mean(1:8:end)/1000),'color','b', 'LineWidth',2);hold on
plot(flip(dist_across_JAK2_(1:6:end))*(-1),flip(prof_across_JAK2_mean(1:6:end)/1000),'color','k','LineWidth',2);
plot(flip(dist_across_JAK3_(1:6:end))*(-1),flip(prof_across_JAK3_mean(1:6:end)/1000),'color','r','LineWidth',2);
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
xlabel('distance [km]','fontsize',12,'fontweight','b')
%title('Velocity Profile','fontsize',12,'fontweight','b');
legend('JAK1','JAK2','JAK3');
hold on


%JAK1
std_velocity_JAK1_across=nanstd(prof_across_JAK1(1:8:end,:),1,2)/1000;
fill_across_JAK1_STD=[std_velocity_JAK1_across];
shadedErrorBar(flip(dist_across_JAK1_(1:8:end))*(-1),flip(prof_across_JAK1_mean(1:8:end)/1000),fill_across_JAK1_STD,{'b','linestyle','none'},1);

%JAK2
std_velocity_JAK2_across=nanstd(prof_across_JAK2(1:6:end,:),1,2)/1000;
fill_across_JAK2_STD=[std_velocity_JAK2_across];
shadedErrorBar(flip(dist_across_JAK2_(1:6:end))*(-1),flip(prof_across_JAK2_mean(1:6:end)/1000),fill_across_JAK2_STD,{'color',[0.5 0.5 0.5],'linestyle','none'},1);

%JAK3
std_velocity_JAK3_across=nanstd(prof_across_JAK3(1:6:end,:),1,2)/1000;
fill_across_JAK3_STD=[std_velocity_JAK3_across];
shadedErrorBar(flip(dist_across_JAK3_(1:6:end))*(-1),flip(prof_across_JAK3_mean(1:6:end)/1000),fill_across_JAK3_STD,{'r','linestyle','none'},1);


annotation(gcf,'textarrow',[0.226785714285714 0.226785714285714],...
    [0.710904761904762 0.842857142857143],'String',{'Flow'});

plot([0 0],[0 7],'color',[0 0.5 0],'linewidth',2);

plot([0 0],[0 1.6],'color',[0 0.5 0],'linewidth',2);
ylim([0 6])
set(gca,'fontsize',12)

set(gcf,'Paperorientation','portrait')
print -dpng -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/JAK_Across_Profile
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/JAK_Across_Profile



%%%%%%%%%%%%%%%%%%% PG  %%%%%%%%%%%%%%%%%%%%%
% Plotting the cross profs with the main profile as reference:

    % The image product resolution is 90m and the across profiles are in
    % high spatial resolution, so I have to undersample them in order to
    % not get repeatedly values

prof_across_PG1_mean= nanmean(prof_across_PG1/1000,2);
prof_across_PG4_mean= nanmean(prof_across_PG4/1000,2);  
prof_across_PG5_mean= nanmean(prof_across_PG5/1000,2);
prof_across_PG6_mean= nanmean(prof_across_PG6/1000,2);

%%% Plotting the STD shadow across profiles

figure;
plot(dist_across_PG1_(1:4:end),fillgaps(prof_across_PG1_mean(1:4:end)),'color','b','LineWidth',2);hold on
%plot(dist_across_PG4_(1:4:end),fillgaps(prof_across_PG4_mean(1:4:end)),'color','k','LineWidth',2);
plot(dist_across_PG6_(1:4:end),fillgaps(prof_across_PG6_mean(1:4:end)),'color','k','LineWidth',2);
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

fill_across_PG1_STD=[std_velocity_PG1_across/1000];
shadedErrorBar(dist_across_PG1_(1:4:end),prof_across_PG1_mean(1:4:end),fill_across_PG1_STD,{'b','linestyle','none'},1);


%PG6

std_velocity_PG6_across=nanstd(prof_across_PG6(1:4:end,:),1,2);

fill_across_PG6_STD=[std_velocity_PG6_across/1000];
shadedErrorBar(dist_across_PG6_(1:4:end),prof_across_PG6_mean(1:4:end),fill_across_PG6_STD,{'k','linestyle','none'},1);

%PG5

std_velocity_PG5_across=nanstd(prof_across_PG5(1:2:end,:),1,2);

fill_across_PG5_STD=[std_velocity_PG5_across/1000];
shadedErrorBar(dist_across_PG5_(1:2:end),prof_across_PG5_mean(1:2:end),fill_across_PG5_STD,{'r','linestyle','none'},1);


ylim([0 1.6])
set(gca,'fontsize',12)

set(gcf,'Paperorientation','portrait')
print -dpng -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/PG_Across_Profile
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/PG_Across_Profile

%%%%%%%%%%%%%%%%%%% FJ  %%%%%%%%%%%%%%%%%%% 

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

annotation(gcf,'textarrow',[0.2 0.2],...
    [0.737012987012987 0.826190476190476],'String',{'Flow'});

plot([0 0],[-0.05 2],'color',[0 0.5 0],'linewidth',2);

hold on

%FJ1

std_velocity_FJ1_across=nanstd(prof_across_FJ1(1:4:end,:),1,2);

fill_across_FJ1_STD=[std_velocity_FJ1_across/1000];
shadedErrorBar(dist_across_FJ1_(1:4:end),prof_across_FJ1_mean(1:4:end),fill_across_FJ1_STD,{'b','linestyle','none'},1);

%FJ2

std_velocity_FJ2_across=nanstd(prof_across_FJ2(1:3:end,:),1,2);

fill_across_FJ2_STD=[std_velocity_FJ2_across/1000];
shadedErrorBar(dist_across_FJ2_(1:3:end),prof_across_FJ2_mean(1:3:end),fill_across_FJ2_STD,{'k','linestyle','none'},1);


%FJ3

std_velocity_FJ3_across=nanstd(prof_across_FJ3(1:4:end,:),1,2);

fill_across_FJ3_STD=[std_velocity_FJ3_across/1000];
shadedErrorBar(dist_across_FJ3_(1:4:end),prof_across_FJ3_mean(1:4:end),fill_across_FJ3_STD,{'r','linestyle','none'},1);


ylim([-0.05 1.6])
set(gca,'fontsize',12)

set(gcf,'Paperorientation','portrait')
print -dpng -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/FJ_Across_Profile
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/FJ_Across_Profile

%% Plot Summer and Winter

%%%%%%%%%%%%%%%%%%% JAK  %%%%%%%%%%%%%%%%%%% 

plot(dist,nanmean(JAK_summer2_profile,2),'.','color','r','markersize',3);
ylim([0 14]);
xlim([0 55])
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
grid off;
title('Mean Summer and Winter - Jakobshavn Isbræ','fontsize',12,'fontweight','b');
xlabel('distance [km]','fontsize',12,'fontweight','b')

hold on

plot(dist,nanmean(JAK_winter2_profile,2),'.','color','b','markersize',3);
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
shadedErrorBar(dist,nanmean(JAK_summer2_profile,2),std_velocity_JAK_profile_interp_SUMMER,{'color','r','linestyle','none'},1);


std_velocity_JAK_profile_interp_WINTER= nanstd(JAK_winter2_profile,1,2);
shadedErrorBar(dist,nanmean(JAK_winter2_profile,2),std_velocity_JAK_profile_interp_WINTER,{'color','b','linestyle','none'},1);

% Across profiles locations:
%JAK1:
plot([dist(365) dist(365)], [0 1], 'color','b','linestyle','-','linewidth',3);
%JAK2:
plot([dist(516) dist(516)], [0 1], 'color','k','linestyle','-','linewidth',3);
%JAK3:
plot([dist(801) dist(801)], [0 1], 'color','r','linestyle','-','linewidth',3);

set(gcf,'Paperorientation','landscape')
print -dpng -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/JAK_Summer_Winter_Profile
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/JAK_Summer_Winter_Profile


%%%%%%%%%%%%%%%%%%% PG  %%%%%%%%%%%%%%%%%%% 

figure
plot(dist_PG,nanmean(PG_summer2_profile/1000,2),'.','color','r','markersize',3);
ylim([0 1.8]);
xlim([0 200])
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
%grid on;
title('Mean Summer and Winter - Petermann Glacier','fontsize',12,'fontweight','b');
xlabel('distance [km]','fontsize',12,'fontweight','b')

hold on

plot(dist_PG,nanmean(PG_winter2_profile/1000,2),'.','color','b','markersize',3);

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

std_velocity_PG_profile_interp_SUMMER= nanstd(PG_summer2_profile/1000,1,2);
fill_STD_PG_SUMMER=[std_velocity_PG_profile_interp_SUMMER];
shadedErrorBar(dist_PG,nanmean(PG_summer2_profile/1000,2),fill_STD_PG_SUMMER,{'r','linestyle','none'},1);


%%% Plot the STD shaded
hold on

std_velocity_PG_profile_interp_WINTER= nanstd(PG_winter2_profile/1000,1,2);
fill_STD_PG_WINTER=[std_velocity_PG_profile_interp_WINTER];
shadedErrorBar(dist_PG,nanmean(PG_winter2_profile/1000,2),fill_STD_PG_WINTER,{'b','linestyle','none'},1);


%PG1:
plot([dist_PG2(268) dist_PG2(268)], [0 0.1], 'color','b','linestyle','-','linewidth',3);

%PG4:
%plot([dist_PG2(489) dist_PG2(489)], [0 0.1], 'color','k','linestyle','-','linewidth',3);

%PG6:
plot([dist_PG2(527) dist_PG2(527)], [0 0.1], 'color','k','linestyle','-','linewidth',3);

%PG5:
plot([dist_PG2(771) dist_PG2(771)], [0 0.1], 'color','r','linestyle','-','linewidth',3);

print -dpng -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/PG_Summer_Winter_Profile
set(gcf,'Paperorientation','landscape')
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/PG_Summer_Winter_Profile

%%%%%%%%%%%%%%%%%%% FJ  %%%%%%%%%%%%%%%%%%% 

figure
plot(dist_FJ,nanmean(FJ_summer2_profile/1000,2),'.','color','r','markersize',3);
ylim([0 1.6]);
xlim([0 200])
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
%grid on;
title('Mean Summer and Winter - 79-Fjord','fontsize',12,'fontweight','b');
xlabel('distance [km]','fontsize',12,'fontweight','b')

hold on

plot(dist_FJ,nanmean(FJ_winter2_profile/1000,2),'.','color','b','markersize',3);

legend('Summer','Winter','location','northeast');

% Floating area
% considering the most recent Ice front position (CCI) and the grounding line from 
X_floating_FJ=[dist_FJ(1):((0.1916*999*2)/(length(prof_curve_FJ)-1)):dist_FJ(193*2)];
Y_floating_FJ=[zeros(1,length(X_floating_FJ)) ones(1,length(X_floating_FJ))*1.8];
X_floating_FJ=[X_floating_FJ flip(X_floating_FJ)];
fill(X_floating_FJ,Y_floating_FJ,[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');

hold on

std_velocity_FJ_profile_interp_SUMMER= nanstd(FJ_summer2_profile/1000,1,2);
fill_STD_FJ_SUMMER=[std_velocity_FJ_profile_interp_SUMMER];
shadedErrorBar(dist_FJ,nanmean(FJ_summer2_profile/1000,2),fill_STD_FJ_SUMMER,{'r','linestyle','none'},1);

hold on

std_velocity_FJ_profile_interp_WINTER= nanstd(FJ_winter2_profile/1000,1,2);
fill_STD_FJ_WINTER=[std_velocity_FJ_profile_interp_WINTER];
shadedErrorBar(dist_FJ,nanmean(FJ_winter2_profile/1000,2),fill_STD_FJ_WINTER,{'b','linestyle','none'},1);

% Across profiles:
%FJ1:
plot([dist_FJ2(48) dist_FJ2(48)], [0 0.1], 'color','b','linestyle','-','linewidth',3);
%FJ2:
plot([dist_FJ2(171) dist_FJ2(171)], [0 0.1], 'color','k','linestyle','-','linewidth',3);
%FJ3:
plot([dist_FJ2(479) dist_FJ2(479)], [0 0.1], 'color','r','linestyle','-','linewidth',3);

print -dpng -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/FJ_Summer_Winter_Profile
set(gcf,'Paperorientation','landscape')
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/FJ_Summer_Winter_Profile


%% Points

% Extract points JAK1,2&3 ; PG1,2(4)&3(5) ; FJ1,2&3
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
% (PG6)PG6_main:577
% (PG6)PG3_cross:444 (0.026)

% FJ1_main:48 (0.1952)
% FJ1_cross:595 (0.02470)
% 
% FJ2_main:171
% FJ2_cross:599 (0.03160)
% 
% FJ3_main:479
% FJ3_cross:629 (0.02670)

%Defining the seasons:
%summer: JJA
summer_2002=([datenum('01062002','ddmmyyyy')  datenum('30082002','ddmmyyyy') datenum('30082002','ddmmyyyy') datenum('01062002','ddmmyyyy')]);
summer_2003=([datenum('01062003','ddmmyyyy')  datenum('30082003','ddmmyyyy') datenum('30082003','ddmmyyyy') datenum('01062003','ddmmyyyy')]);
summer_2004=([datenum('01062004','ddmmyyyy')  datenum('30082004','ddmmyyyy') datenum('30082004','ddmmyyyy') datenum('01062004','ddmmyyyy')]);
summer_2005=([datenum('01062005','ddmmyyyy')  datenum('30082005','ddmmyyyy') datenum('30082005','ddmmyyyy') datenum('01062005','ddmmyyyy')]);
summer_2006=([datenum('01062006','ddmmyyyy')  datenum('30082006','ddmmyyyy') datenum('30082006','ddmmyyyy') datenum('01062006','ddmmyyyy')]);
summer_2007=([datenum('01062007','ddmmyyyy')  datenum('30082007','ddmmyyyy') datenum('30082007','ddmmyyyy') datenum('01062007','ddmmyyyy')]);
summer_2008=([datenum('01062008','ddmmyyyy')  datenum('30082008','ddmmyyyy') datenum('30082008','ddmmyyyy') datenum('01062008','ddmmyyyy')]);
summer_2009=([datenum('01062009','ddmmyyyy')  datenum('30082009','ddmmyyyy') datenum('30082009','ddmmyyyy') datenum('01062009','ddmmyyyy')]);
summer_2010=([datenum('01062010','ddmmyyyy')  datenum('30082010','ddmmyyyy') datenum('30082010','ddmmyyyy') datenum('01062010','ddmmyyyy')]);
summer_2011=([datenum('01062011','ddmmyyyy')  datenum('30082011','ddmmyyyy') datenum('30082011','ddmmyyyy') datenum('01062011','ddmmyyyy')]);
summer_2012=([datenum('01062012','ddmmyyyy')  datenum('30082012','ddmmyyyy') datenum('30082012','ddmmyyyy') datenum('01062012','ddmmyyyy')]);
summer_2013=([datenum('01062013','ddmmyyyy')  datenum('30082013','ddmmyyyy') datenum('30082013','ddmmyyyy') datenum('01062013','ddmmyyyy')]);
summer_2014=([datenum('01062014','ddmmyyyy')  datenum('30082014','ddmmyyyy') datenum('30082014','ddmmyyyy') datenum('01062014','ddmmyyyy')]);
summer_2015=([datenum('01062015','ddmmyyyy')  datenum('30082015','ddmmyyyy') datenum('30082015','ddmmyyyy') datenum('01062015','ddmmyyyy')]);
summer_2016=([datenum('01062016','ddmmyyyy')  datenum('30082016','ddmmyyyy') datenum('30082016','ddmmyyyy') datenum('01062016','ddmmyyyy')]);

%winter: DJF
winter_2002=([datenum('01122002','ddmmyyyy')  datenum('28022003','ddmmyyyy') datenum('28022003','ddmmyyyy') datenum('01122002','ddmmyyyy')]);
winter_2003=([datenum('01122003','ddmmyyyy')  datenum('28022004','ddmmyyyy') datenum('28022004','ddmmyyyy') datenum('01122003','ddmmyyyy')]);
winter_2004=([datenum('01122004','ddmmyyyy')  datenum('28022005','ddmmyyyy') datenum('28022005','ddmmyyyy') datenum('01122004','ddmmyyyy')]);
winter_2005=([datenum('01122005','ddmmyyyy')  datenum('28022006','ddmmyyyy') datenum('28022006','ddmmyyyy') datenum('01122005','ddmmyyyy')]);
winter_2006=([datenum('01122006','ddmmyyyy')  datenum('28022007','ddmmyyyy') datenum('28022007','ddmmyyyy') datenum('01122006','ddmmyyyy')]);
winter_2007=([datenum('01122007','ddmmyyyy')  datenum('28022008','ddmmyyyy') datenum('28022008','ddmmyyyy') datenum('01122007','ddmmyyyy')]);
winter_2008=([datenum('01122008','ddmmyyyy')  datenum('28022009','ddmmyyyy') datenum('28022009','ddmmyyyy') datenum('01122008','ddmmyyyy')]);
winter_2009=([datenum('01122009','ddmmyyyy')  datenum('28022010','ddmmyyyy') datenum('28022010','ddmmyyyy') datenum('01122009','ddmmyyyy')]);
winter_2010=([datenum('01122010','ddmmyyyy')  datenum('28022011','ddmmyyyy') datenum('28022011','ddmmyyyy') datenum('01122010','ddmmyyyy')]);
winter_2011=([datenum('01122011','ddmmyyyy')  datenum('28022012','ddmmyyyy') datenum('28022012','ddmmyyyy') datenum('01122011','ddmmyyyy')]);
winter_2012=([datenum('01122012','ddmmyyyy')  datenum('28022013','ddmmyyyy') datenum('28022013','ddmmyyyy') datenum('01122012','ddmmyyyy')]);
winter_2013=([datenum('01122013','ddmmyyyy')  datenum('28022014','ddmmyyyy') datenum('28022014','ddmmyyyy') datenum('01122013','ddmmyyyy')]);
winter_2014=([datenum('01122014','ddmmyyyy')  datenum('28022015','ddmmyyyy') datenum('28022015','ddmmyyyy') datenum('01122014','ddmmyyyy')]);
winter_2015=([datenum('01122015','ddmmyyyy')  datenum('28022016','ddmmyyyy') datenum('28022016','ddmmyyyy') datenum('01122015','ddmmyyyy')]);
winter_2016=([datenum('01122016','ddmmyyyy')  datenum('28022017','ddmmyyyy') datenum('28022017','ddmmyyyy') datenum('01122016','ddmmyyyy')]);

Y_seasons=[-60 -60 20 20];


summer_2014_PG_FJ=([datenum('15062014','ddmmyyyy')  datenum('15082014','ddmmyyyy') datenum('15082014','ddmmyyyy') datenum('15062014','ddmmyyyy')]);
summer_2015_PG_FJ=([datenum('15062015','ddmmyyyy')  datenum('15082015','ddmmyyyy') datenum('15082015','ddmmyyyy') datenum('15062015','ddmmyyyy')]);
summer_2016_PG_FJ=([datenum('15062016','ddmmyyyy')  datenum('15082016','ddmmyyyy') datenum('15082016','ddmmyyyy') datenum('15062016','ddmmyyyy')]);



%%%%%%%%%%%%%%%%%%%%%%%%%%  JAK  %%%%%%%%%%%%%%%%%%%%
figure(2)
subplot(2,2,1)
plot(data_str_JAK_num,pt_JAK1_5window_mean/1000,'color','b','linestyle','none','marker','.','markersize',20);hold on
plot(data_str_JAK_num,pt_JAK2_5window_mean/1000,'color','k','linestyle','none','marker','.','markersize',20)
plot(data_str_JAK_num,pt_JAK3_5window_mean/1000,'color','r','linestyle','none','marker','.','markersize',20)
legend('JAK1', 'JAK2', 'JAK3','location','northwest')
plot(data_str_JAK_num,mdl_pt_JAK1_5window_mean.Fitted,'b');
plot(data_str_JAK_num,mdl_pt_JAK2_5window_mean.Fitted,'k');
plot(data_str_JAK_num,mdl_pt_JAK3_5window_mean.Fitted,'r');
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
ylim([0 7])
set(gca,'XTickLabelRotation',-45,'fontsize',10)
%grid on
title('Jakobshavn Isbræ','fontsize',12,'fontweight','b');
xlim([datenum('112014','mmyyyy')  datenum('022017','mmyyyy')])
NumTicks = 10;
L = get(gca,'XLim');
set(gca,'XTick',linspace(L(1),L(2),NumTicks))
% Add the summer and winter shadow
fill(summer_2015,Y_seasons,'r','FaceAlpha', 0.1,'linestyle','none');
fill(summer_2016,Y_seasons,'r','FaceAlpha', 0.1,'linestyle','none');
fill(winter_2014,Y_seasons,'b','FaceAlpha', 0.1,'linestyle','none');
fill(winter_2015,Y_seasons,'b','FaceAlpha', 0.1,'linestyle','none');
fill(winter_2016,Y_seasons,'b','FaceAlpha', 0.1,'linestyle','none');

datetick('x','mm/yyyy','keeplimits','keepticks');


%%%%%%%%%%%%%%%%%%%%%%%%%%  PG  %%%%%%%%%%%%%%%%%%%%

figure(2)
subplot(2,2,2)
plot(data_str_PG_num,pt_PG1_5window_mean/1000,'color','b','linestyle','none','marker','.','markersize',20);hold on
plot(data_str_PG_num,pt_PG2_5window_mean/1000,'color','k','linestyle','none','marker','.','markersize',20)
plot(data_str_PG_num,pt_PG3_5window_mean/1000,'color','r','linestyle','none','marker','.','markersize',20)
legend('PG1', 'PG2', 'PG3','location','northwest')
plot(data_str_PG_num,mdl_pt_PG1_5window_mean.Fitted,'b');
plot(data_str_PG_num,mdl_pt_PG2_5window_mean.Fitted,'k');
plot(data_str_PG_num,mdl_pt_PG3_5window_mean.Fitted,'r');
ylabel('Velocity [km/yr]','fontsize',12,'fontweight','b')
ylim([0 1.6])
%dias=['Jan/15';'apr/15';'Sep/16'];
set(gca,'XTickLabelRotation',-45,'fontsize',10)
%grid on
title('Petermann Glacier','fontsize',12,'fontweight','b');
xlim([datenum('122014','mmyyyy')  datenum('082016','mmyyyy')])
NumTicks = 7;
L = get(gca,'XLim');
set(gca,'XTick',linspace(L(1),L(2),NumTicks))
% Add the summer and winter shadow
fill(summer_2015_PG_FJ,Y_seasons,'r','FaceAlpha', 0.1,'linestyle','none');
fill(summer_2016_PG_FJ,Y_seasons,'r','FaceAlpha', 0.1,'linestyle','none');
fill(winter_2014,Y_seasons,'b','FaceAlpha', 0.1,'linestyle','none');
fill(winter_2015,Y_seasons,'b','FaceAlpha', 0.1,'linestyle','none');
datetick('x','mm/yyyy','keeplimits','keepticks');

%%%%%%%%%%%%%%%%%%%%%%%%%%  FJ  %%%%%%%%%%%%%%%%%%%%

figure(2)
subplot(2,2,3.5)
plot(data_str_FJ_num,pt_FJ1_5window_mean/1000,'color','b','linestyle','none','marker','.','markersize',20);hold on
plot(data_str_FJ_num,pt_FJ2_5window_mean/1000,'color','k','linestyle','none','marker','.','markersize',20)
plot(data_str_FJ_num,pt_FJ3_5window_mean/1000,'color','r','linestyle','none','marker','.','markersize',20)
legend('FJ1', 'FJ2', 'FJ3','location','northwest')
plot(data_str_FJ_num,mdl_pt_FJ1_5window_mean.Fitted,'b');
plot(data_str_FJ_num,mdl_pt_FJ2_5window_mean.Fitted,'k');
plot(data_str_FJ_num,mdl_pt_FJ3_5window_mean.Fitted,'r');
ylabel('velocity [km/yr]','fontsize',12,'fontweight','b')
ylim([0 1.65])
%dias=['Jan/15';'apr/15';'Sep/16'];
set(gca,'XTickLabelRotation',-45,'fontsize',10)
%grid on
title('79-Fjord','fontsize',12,'fontweight','b');
xlim([datenum('072015','mmyyyy')  datenum('102016','mmyyyy')])
NumTicks = 8;
L = get(gca,'XLim');
set(gca,'XTick',linspace(L(1),L(2),NumTicks))
% Add the summer and winter shadow
fill(summer_2015_PG_FJ,Y_seasons,'r','FaceAlpha', 0.1,'linestyle','none');
fill(summer_2016_PG_FJ,Y_seasons,'r','FaceAlpha', 0.1,'linestyle','none');
fill(winter_2014,Y_seasons,'b','FaceAlpha', 0.1,'linestyle','none');
fill(winter_2015,Y_seasons,'b','FaceAlpha', 0.1,'linestyle','none');
datetick('x','mm/yyyy','keeplimits','keepticks');


print -dpng -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pt_JAK_PG_FJ_linearTrend_5window_mean_PG6included
set(gcf,'Paperorientation','landscape')
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pt_JAK_PG_FJ_linearTrend_5window_mean_PG6included

%%%%%%%%%%%%%%%%%%%%%%%%%%  NSIDC DATA  %%%%%%%%%%%%%%%%%%%%


figure(4);
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,1),'.','color','r');
   hold on;
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,2),'.','color','y');
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,3),'.','color','m');
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,4),'.','color','g');
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,5),'.','color','c');
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,6),'.','color','b');

    legend('M6','M9','M13','M17','M20','M26');
   
ylim([0 18000])

fill([date_pt_S1_Joughin_JAK(1) date_pt_S1_Joughin_JAK(1) n_sorted(end,1) n_sorted(end,1)],[0 20000 20000 0],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');

   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,1),'.','color','r');
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,2),'LineStyle','--','MarkerSize',2,'MarkerFaceColor','y','Marker','^','color','y');
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,3),'LineStyle','--','MarkerSize',2,'MarkerFaceColor','m','Marker','^','color','m');
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,4),'LineStyle','--','MarkerSize',2,'MarkerFaceColor','g','Marker','^','color','g');
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,5),'LineStyle','--','MarkerSize',2,'MarkerFaceColor','c','Marker','^','color','c');
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,6),'LineStyle','--','MarkerSize',2,'MarkerFaceColor','b','Marker','^','color','b');
xlim([datenum('122008','mmyyyy')  datenum('042017','mmyyyy')])

date_pt_S1_TSX_Joughin_JAK_combined=datestr([min(n_sorted(:,1)):max(date_pt_S1_Joughin_JAK)],'mmmyy');
datetick('x','yyyy','keeplimits');
set(gca,'XGrid','on','YAxisLocation','left')
ylabel('velocity [m/yr]','fontsize',12,'fontweight','b')

fill(summer_2009,Y_seasons,'r','FaceAlpha', 0.1,'linestyle','none');
fill(summer_2010,Y_seasons,'r','FaceAlpha', 0.1,'linestyle','none');
fill(summer_2011,Y_seasons,'r','FaceAlpha', 0.1,'linestyle','none');
fill(summer_2012,Y_seasons,'r','FaceAlpha', 0.1,'linestyle','none');
fill(summer_2013,Y_seasons,'r','FaceAlpha', 0.1,'linestyle','none');
fill(summer_2014,Y_seasons,'r','FaceAlpha', 0.1,'linestyle','none');
fill(summer_2015,Y_seasons,'r','FaceAlpha', 0.1,'linestyle','none');
fill(summer_2016,Y_seasons,'r','FaceAlpha', 0.1,'linestyle','none');

fill(winter_2009,Y_seasons,'b','FaceAlpha', 0.1,'linestyle','none');
fill(winter_2010,Y_seasons,'b','FaceAlpha', 0.1,'linestyle','none');
fill(winter_2011,Y_seasons,'b','FaceAlpha', 0.1,'linestyle','none');
fill(winter_2012,Y_seasons,'b','FaceAlpha', 0.1,'linestyle','none');
fill(winter_2013,Y_seasons,'b','FaceAlpha', 0.1,'linestyle','none');

fill(winter_2014,Y_seasons,'b','FaceAlpha', 0.1,'linestyle','none');
fill(winter_2015,Y_seasons,'b','FaceAlpha', 0.1,'linestyle','none');
fill(winter_2016,Y_seasons,'b','FaceAlpha', 0.1,'linestyle','none');

print -dpng -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pt_JAK_Mpts
set(gcf,'Paperorientation','landscape')
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pt_JAK_Mpts


% Plotting the N points
   % tributary locations: N6, N8, N11, N15, pad1, pad2, pad3, pad10
   figure(1)
   %subplot(3,1,1)
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,2),'.','MarkerFaceColor','y','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k'); hold on;%N6
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,3),'.','MarkerFaceColor','m','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');hold on;%N8
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,4),'.','MarkerFaceColor','g','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%N11
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,5),'.','MarkerFaceColor','c','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%N15
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,6),'.','MarkerFaceColor','r','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%pad1
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,7),'.','MarkerFaceColor','b','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%pad2
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,8),'.','MarkerFaceColor','k','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%pad3
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,15),'.','MarkerFaceColor',[1 0.2 0.5],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%pad10
   legend([name_pts(2:8) name_pts(15)],'location','northwest');
 
   %legend('N6','N8','N11','N15','Pad1','Pad2','Pad3','Pad10')%,'Pad16','Pad17','Pad18','Pad19','Pad20');

   ylim([0 4000])
xlim([datenum('122008','mmyyyy')  datenum('042017','mmyyyy')])

fill([date_pt_S1_Joughin_JAK(1) date_pt_S1_Joughin_JAK(1) n_sorted(end,1) n_sorted(end,1)],[0 7000 7000 0],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');
    
   % extra locations: pad4 and pad5
   figure(2)
   %subplot(3,1,2)
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,9),'.','MarkerFaceColor',[0.5 0.5 0.5],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');hold on;%pad4
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,10),'.','MarkerFaceColor',[0.68 0.92 1],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%pad5
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,21),'.','MarkerFaceColor','r','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%pad16
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,22),'.','MarkerFaceColor','g','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%pad17
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,23),'.','MarkerFaceColor','y','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%pad18
   legend([name_pts(9:10) name_pts(21:23)],'location','northwest');

   %legend('Pad4','Pad5','Pad16','Pad17','Pad18')%,'Pad16','Pad17','Pad18','Pad19','Pad20');
xlim([datenum('122008','mmyyyy')  datenum('042017','mmyyyy')])

ylim([400 4000])

fill([date_pt_S1_Joughin_JAK(1) date_pt_S1_Joughin_JAK(1) n_sorted(end,1) n_sorted(end,1)],[0 7000 7000 0],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');
plot([datenum('15082015','ddmmyyyy') datenum('15082015','ddmmyyyy')],[0 7000],'linestyle','--','color','r');

    
    %main stream:
    % pad6, pad7, pad8, pad9, pad11, pad12, pad13, pad14, pad15
figure(3)
    %subplot(3,1,3)
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,11),'.','MarkerFaceColor',[0.3 0.2 0.5],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor',[0.3 0.2 0.5]); hold on;%pad6
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,12),'.','MarkerFaceColor',[0.3 0.2 0.0],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor',[0.3 0.2 0.0]);%pad7
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,13),'.','MarkerFaceColor',[0.8 0.2 0.0],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor',[0.8 0.2 0.0]);%pad8
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,14),'.','MarkerFaceColor',[0.0 0.2 0.5],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor',[0.0 0.2 0.5]);%pad9
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,16),'.','MarkerFaceColor',[0.1 0.2 0.3],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor',[0.1 0.2 0.3]);%pad11
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,17),'.','MarkerFaceColor',[0.0 0.2 0.8],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor',[0.0 0.2 0.8]);%pad12
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,18),'.','MarkerFaceColor',[0.0 0.8 0.5],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor',[0.0 0.8 0.5]);%pad13
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,19),'.','MarkerFaceColor',[0.25 0.25 0.25],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor',[0.25 0.25 0.25]);%pad14
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,20),'.','MarkerFaceColor',[0.333 0.333 0.333],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor',[0.333 0.333 0.333]);%pad15
   
   legend([name_pts(11:14) name_pts(16:20)],'location','northwest');
%    legend('Pad6','Pad7','Pad8','Pad9','Pad11','Pad12','Pad13','Pad14','Pad15')%,'Pad16','Pad17','Pad18','Pad19','Pad20');
xlim([datenum('122008','mmyyyy')  datenum('042017','mmyyyy')])
 %   legend('N6','N8','N11','N15','Pad1','Pad2','Pad3','Pad4','Pad5','Pad6','Pad7','Pad8','Pad9','Pad10','Pad11','Pad12','Pad13','Pad14','Pad15')%,'Pad16','Pad17','Pad18','Pad19','Pad20');
   
ylim([1500 6500])

fill([date_pt_S1_Joughin_JAK(1) date_pt_S1_Joughin_JAK(1) n_sorted(end,1) n_sorted(end,1)],[0 7000 7000 0],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');

   figure(1)
    %subplot(3,1,1)

   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,2),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','y','Marker','^','MarkerEdgeColor','k','color','y');%N6
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,3),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','m','Marker','^','MarkerEdgeColor','k','color','m');%N8
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,4),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','g','Marker','^','MarkerEdgeColor','k','color','g');%N11
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,5),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','c','Marker','^','MarkerEdgeColor','k','color','c');%N15
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,6),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','r','Marker','^','MarkerEdgeColor','k','color','r');%pad1
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,7),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','b','Marker','^','MarkerEdgeColor','k','color','b');%pad2
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,8),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','k','Marker','^','MarkerEdgeColor','k','color','k');%pad3
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,15),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[1 0.2 0.5],'Marker','^','MarkerEdgeColor','k','color',[1 0.2 0.5]);%pad10
   set(gca,'XGrid','on','XAxisLocation','top')
   %legend('N6','N8','N11','N15','Pad1','Pad2','Pad3','Pad10')%,'Pad16','Pad17','Pad18','Pad19','Pad20');
date_pt_S1_TSX_Joughin_JAK_combined=datestr([min(n_sorted(:,1)):max(date_pt_S1_Joughin_JAK)],'mmmyy');
datetick('x','yyyy','keeplimits');
ylabel('velocity [m/yr]','fontsize',12,'fontweight','b')

print -dpng -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pt_JAK_N_and_Pads1_pts
set(gcf,'Paperorientation','landscape')
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pt_JAK_N_and_Pads1_pts

figure(2)
   %subplot(3,1,2)
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,9),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.5 0.5 0.5],'Marker','^','MarkerEdgeColor','k','color',[0.5 0.5 0.5]);hold on %pad4 
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,10),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.68 0.92 1],'Marker','^','MarkerEdgeColor','k','color',[0.68 0.92 1]);%pad5
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,21),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','r','Marker','^','MarkerEdgeColor','k','color','r');%pad16
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,22),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','g','Marker','^','MarkerEdgeColor','k','color','g');%pad17
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,23),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','y','Marker','^','MarkerEdgeColor','k','color','y');%pad18
   
   %legend('Pad4','Pad5')%,'Pad16','Pad17','Pad18','Pad19','Pad20');
date_pt_S1_TSX_Joughin_JAK_combined=datestr([min(n_sorted(:,1)):max(date_pt_S1_Joughin_JAK)],'mmmyy');
datetick('x','yyyy','keeplimits');
set(gca,'XGrid','on','xticklabel',[])

ylabel('velocity [m/yr]','fontsize',12,'fontweight','b')

print -dpng -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pt_JAK_N_and_Pads2_pts
set(gcf,'Paperorientation','landscape')
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pt_JAK_N_and_Pads2_pts

   %subplot(3,1,3)
   figure(3)
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,11),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.3 0.2 0.5],'Marker','^','MarkerEdgeColor','k','color',[0.3 0.2 0.5]);%pad6
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,12),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.3 0.2 0.0],'Marker','^','MarkerEdgeColor','k','color',[0.3 0.2 0.0]);%pad7
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,13),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.8 0.2 0.0],'Marker','^','MarkerEdgeColor','k','color',[0.8 0.2 0.0]);%pad8
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,14),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.0 0.2 0.5],'Marker','^','MarkerEdgeColor','k','color',[0.0 0.2 0.5]);%pad9
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,16),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.1 0.2 0.3],'Marker','^','MarkerEdgeColor','k','color',[0.1 0.2 0.3]);%pad11
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,17),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.0 0.2 0.8],'Marker','^','MarkerEdgeColor','k','color',[0.0 0.2 0.8]);%pad12
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,18),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.0 0.8 0.5],'Marker','^','MarkerEdgeColor','k','color',[0.0 0.8 0.5]);%pad13
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,19),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.25 0.25 0.25],'Marker','^','MarkerEdgeColor','k','color',[0.25 0.25 0.25]);%pad14
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK_Npts(:,20),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.333 0.333 0.333],'Marker','^','MarkerEdgeColor','k','color',[0.333 0.333 0.333]);%pad15
    %legend('Pad6','Pad7','Pad8','Pad9','Pad11','Pad12','Pad13','Pad14','Pad15')%,'Pad16','Pad17','Pad18','Pad19','Pad20');


date_pt_S1_TSX_Joughin_JAK_combined=datestr([min(n_sorted(:,1)):max(date_pt_S1_Joughin_JAK)],'mmmyy');
datetick('x','yyyy','keeplimits');
ylabel('velocity [m/yr]','fontsize',12,'fontweight','b')
set(gca,'XGrid','on','YAxisLocation','left')
%box off

print -dpng -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pt_JAK_N_and_Pads3_pts
set(gcf,'Paperorientation','landscape')
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pt_JAK_N_and_Pads3_pts

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  JAK

 CM_PGs=[0 0 1; 0 0 0; 1 0 0; 0.333 0.333 0.333;1 1 0; 0 1 0; 1 0 1;0.68 0.92 1; 0 1 1; 1 1 1; 0.5 0.5 0.5;0.0 0.2 0.5]
figure(1)
j=1;
for i=[11 17 18 20]
  plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,i),'MarkerFaceColor',CM_PGs(j,:),'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');hold on;%pad15
 j=j+1;
end
   legend('J1','J2','J3','J4','location','northwest');
%    legend('Pad6','Pad7','Pad8','Pad9','Pad11','Pad12','Pad13','Pad14','Pad15')%,'Pad16','Pad17','Pad18','Pad19','Pad20');
xlim([datenum('122008','mmyyyy')  datenum('042017','mmyyyy')])

ylim([1500 7000])

fill([date_pt_S1_Joughin_JAK(1) date_pt_S1_Joughin_JAK(1) n_sorted(end,1) n_sorted(end,1)],[0 7000 7000 0],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');
%plot([datenum('15082015','ddmmyyyy') datenum('15082015','ddmmyyyy')],[0 7000],'linestyle','--','color','r');

figure(1)
    %subplot(3,1,1)
    j=1;
for(i=[11 17 18 20])
   plot(date_pt_S1_Joughin_JAK(1,:),pt_S1_Joughin_JAK_Npts(:,i),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',CM_PGs(j,:),'Marker','^','MarkerEdgeColor','k','color',CM_PGs(j,:));hold on; %N6
j=j+1;
end


date_pt_S1_TSX_Joughin_JAK_combined=datestr([min(n_sorted(:,1)):max(date_pt_S1_Joughin_JAK)],'mmmyy');
datetick('x','yyyy','keeplimits');
ylabel('velocity [m/yr]','fontsize',12,'fontweight','b')
set(gca,'XGrid','on','YAxisLocation','left')
%box off


print -dpng -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pts_JAK_Js
set(gcf,'Paperorientation','landscape')
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pts_JAK_Js

% Tributary 

figure(2)
j=1;
for i=[7 3 4]
  plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,i),'MarkerFaceColor',CM_PGs(j,:),'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');hold on;%pad15
 j=j+1;
end
   legend('Jt1','Jt2','Jt3','location','northwest');
%    legend('Pad6','Pad7','Pad8','Pad9','Pad11','Pad12','Pad13','Pad14','Pad15')%,'Pad16','Pad17','Pad18','Pad19','Pad20');
xlim([datenum('122008','mmyyyy')  datenum('042017','mmyyyy')])

ylim([0 2500])

fill([date_pt_S1_Joughin_JAK(1) date_pt_S1_Joughin_JAK(1) n_sorted(end,1) n_sorted(end,1)],[0 7000 7000 0],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');
%plot([datenum('15082015','ddmmyyyy') datenum('15082015','ddmmyyyy')],[0 7000],'linestyle','--','color','r');

figure(2)
    %subplot(3,1,1)
    j=1;
for(i=[7 3 4])
   plot(date_pt_S1_Joughin_JAK(1,:),pt_S1_Joughin_JAK_Npts(:,i),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',CM_PGs(j,:),'Marker','^','MarkerEdgeColor','k','color',CM_PGs(j,:));hold on; %N6
j=j+1;
end

date_pt_S1_TSX_Joughin_JAK_combined_num=[n_sorted(:,1);date_pt_S1_Joughin_JAK'];

date_pt_S1_TSX_Joughin_JAK_combined=datestr([min(n_sorted(:,1)):max(date_pt_S1_Joughin_JAK)],'mmmyy');
datetick('x','yyyy','keeplimits');
ylabel('velocity [m/yr]','fontsize',12,'fontweight','b')
set(gca,'XGrid','on','YAxisLocation','left')
%box off


print -dpng -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pts_JAK_Jts
set(gcf,'Paperorientation','landscape')
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pts_JAK_Jts

datestr([735916 735933 735943 736201 736280 736520 736530 736550 0 736110 736445 736705 736715 736726 736735] ,'dd-mm-yy')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  PG

 CM_PGs=[0 0 1; 0 0 0; 1 0 0; 0.333 0.333 0.333;1 1 0; 0 1 0; 1 0 1;0.68 0.92 1; 0 1 1; 1 1 1; 0.5 0.5 0.5;0.0 0.2 0.5]
figure(1)

for i=[1:size(pt_TSX_Joughin_PG,2)]
  plot(n_sorted_PG(:,1),pt_TSX_Joughin_PG(:,i),'MarkerFaceColor',CM_PGs(i,:),'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');hold on;%pad15
 
end
   legend([name_PG_pts],'location','northwest');
%    legend('Pad6','Pad7','Pad8','Pad9','Pad11','Pad12','Pad13','Pad14','Pad15')%,'Pad16','Pad17','Pad18','Pad19','Pad20');
 %   legend('N6','N8','N11','N15','Pad1','Pad2','Pad3','Pad4','Pad5','Pad6','Pad7','Pad8','Pad9','Pad10','Pad11','Pad12','Pad13','Pad14','Pad15')%,'Pad16','Pad17','Pad18','Pad19','Pad20');
ylim([0 1600])
xlim([datenum('122008','mmyyyy')  datenum('042017','mmyyyy')])

fill([date_pt_S1_PG(1) date_pt_S1_PG(1) n_sorted_PG(end,1) n_sorted_PG(end,1)],[0 7000 7000 0],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');

figure(1)
    %subplot(3,1,1)
    j=1;
for(i=[1:size(pt_S1_PG,2)])
   plot(date_pt_S1_PG,pt_S1_PG(:,i),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',CM_PGs(i,:),'Marker','^','MarkerEdgeColor','k','color',CM_PGs(i,:));hold on; %N6
j=j+5;
end

date_pt_S1_PG_combined=datestr([min(n_sorted_PG(:,1)):max(date_pt_S1_PG)],'mmmyy');


datetick('x','yyyy','keeplimits');
xlim([datenum('092010','mmyyyy')  datenum('042017','mmyyyy')])

ylabel('velocity [m/yr]','fontsize',12,'fontweight','b')
set(gca,'XGrid','on','YAxisLocation','left')
%box off


print -dpng -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pts_PG
set(gcf,'Paperorientation','landscape')
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pts_PG


%     %subplot(3,1,1)
%     figure(2)
% for(i=1:3)
%    plot(date_pt_S1_PG,pt_S1_PG(:,i),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',CM_PGs(i,:),'Marker','^','MarkerEdgeColor','k','color',CM_PGs(i,:));hold on; %N6
% end
% %date_pt_S1_PG_combined=datestr([min(n_sorted_PG(:,1)):max(date_pt_S1_PG)],'mmmyy');
% legend(name_PG_pts(1:3),'location','northwest');
% datetick('x','yyyy','keeplimits');
% ylabel('velocity [m/yr]','fontsize',12,'fontweight','b')
% set(gca,'XGrid','on','YAxisLocation','left')
% %box off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  FJ

 CM_PGs=[0 0 1; 0 0 0; 1 0 0; 0.333 0.333 0.333;1 1 0; 0 1 0; 1 0 1;0.68 0.92 1; 0 1 1; 1 1 1; 0.5 0.5 0.5;0.0 0.2 0.5]
figure(1)

for i=[1:size(pt_TSX_Joughin_FJ,2)-1]
  plot(n_sorted_FJ(:,1),pt_TSX_Joughin_FJ(:,i),'MarkerFaceColor',CM_PGs(i,:),'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');hold on;%pad15
 
end
   legend([name_FJ_pts],'location','northwest');
%    legend('Pad6','Pad7','Pad8','Pad9','Pad11','Pad12','Pad13','Pad14','Pad15')%,'Pad16','Pad17','Pad18','Pad19','Pad20');
xlim([datenum('122008','mmyyyy')  datenum('042017','mmyyyy')])
 %   legend('N6','N8','N11','N15','Pad1','Pad2','Pad3','Pad4','Pad5','Pad6','Pad7','Pad8','Pad9','Pad10','Pad11','Pad12','Pad13','Pad14','Pad15')%,'Pad16','Pad17','Pad18','Pad19','Pad20');
ylim([500 1600])

fill([date_pt_S1_FJ(1) date_pt_S1_FJ(1) n_sorted_FJ(end,1) n_sorted_FJ(end,1)],[0 7000 7000 0],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');

figure(1)
    %subplot(3,1,1)
    j=1;
for(i=[1:size(pt_S1_FJ,2)-1])
   plot(date_pt_S1_FJ,pt_S1_FJ(:,i),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',CM_PGs(i,:),'Marker','^','MarkerEdgeColor','k','color',CM_PGs(i,:));hold on; %N6
j=j+1;
end

date_pt_S1_FJ_combined=datestr([min(n_sorted_FJ(:,1)):max(date_pt_S1_FJ)],'mmmyy');

% NumTicks = 11;
% L = [datenum('01012011','ddmmyyyy')  datenum('01042017','ddmmyyyy')];
% set(gca,'XTick',linspace(L(1),L(2),NumTicks))

datetick('x','yyyy','keeplimits');
xlim([datenum('01122010','ddmmyyyy')  datenum('01042017','ddmmyyyy')])

ylabel('velocity [m/yr]','fontsize',12,'fontweight','b')
set(gca,'XGrid','on','YAxisLocation','left')
%box off


print -dpng -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pts_FJ
set(gcf,'Paperorientation','landscape')
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pts_FJ





%% Intercomparison

subplot(1,3,1);
hist(S1_minus_Joughin_JAK_slow_area(:),[0:5:150])
xlim([0 160])
title('Jakobshavn Isbræ','fontsize',12,'fontweight','b');
xlabel('[m/yr]','fontsize',12,'fontweight','b');
set(gca,'fontsize',12)
%print -dpng -r300 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Hist_S1_minus_Joughin_slow_Areas_JAK.png

subplot(1,3,2);
hist(S1_minus_Joughin_PG_slow_area(:),[0:5:150]) 
title('Petermann','fontsize',12,'fontweight','b');
xlim([0 160])
xlabel('[m/yr]','fontsize',12,'fontweight','b');
set(gca,'fontsize',12)
%print -dpng -r300 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Hist_S1_minus_Joughin_slow_Areas_PG.png

subplot(1,3,3);
hist(S1_minus_Joughin_FJ_slow_area(:),[0:5:150]) 
title('79-Fjord','fontsize',12,'fontweight','b');
xlim([0 160])
xlabel('[m/yr]','fontsize',12,'fontweight','b');
set(gca,'fontsize',12)

set(gcf,'Paperorientation','landscape')
print -dpng -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Hist_S1_minus_Joughin_slow_Areas_FJ
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Hist_S1_minus_Joughin_slow_Areas_FJ









