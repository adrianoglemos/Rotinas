cd /nfs/a41/Ocean_Model_ECCO2/THETA/
% load grid
lon=(1/8):(1/4):360; lat=(-90+1/8):(1/4):90;
nx=length(lon); ny=length(lat);
dpt=[0,10,10,10,10,10,10,10,10.01,10.03,10.11,10.32,10.80,    ...
     11.76,13.42,16.04,19.82,24.85,31.10,38.42,46.50,55,      ...
     63.50,71.58,78.90,85.15,90.18,93.96,96.58,98.25,99.25,   ...
     100.01,101.33,104.56,111.33,122.83,139.09,158.94,180.83, ...
     203.55,226.50,249.50,272.50,295.50,318.50,341.50,364.50, ...
     387.50,410.50,433.50,456.50];
dpt=cumsum(dpt); dpt=(dpt(1:50)+dpt(2:51))/2;

load('/nfs/a59/eeagdl/DATABASE/ECCO2/Depth.mat')
load('/nfs/a59/eeagdl/DATABASE/ECCO2/depths.mat')



pathsate_opt=['/nfs/a41/Ocean_Model_ECCO2/THETA/'];
destination=['/nfs/a59/eeagdl/DATABASE/ECCO2/'];
d_opt=dir(pathsate_opt);
j=1;
for i=3:length(d_opt);
    name=d_opt(i,1).name;
    data_ECCO2{j,1}=cellstr(name);
    date_ECCO2(j,:)=cellstr(name(19:26));
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data_ECCO2{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name

date_ECCO2_num=datenum(date_ECCO2,'yyyymmdd');

j=1;
for i=1:size(list_opt,1);
   read_temp =ncread([pathsate_opt list_opt{i,1}],'THETA');
   read_temp(read_temp<-100)=nan;
   temp_ECCO2(:,:,:,j)=read_temp(1228:1236,636:639,:);
   j=j+1;
end


% monthly mean: each 10, starting in Jan/2008 until 27/03/2017 (PS: last month 9 dates)
j=1;
for i=1:10:size(temp_ECCO2,4)-8
temp_month=nanmean(temp_ECCO2(:,:,:,i:i+9),4);
temp_ECCO2_monthly_mean(:,:,:,j)=temp_month;

Tprof_ECCO2_monthly(:,j)=nanmean(reshape(temp_month,[9*4 50]),1);

j=j+1;
end

j=1;
for i=1:size(temp_ECCO2,4)
temp_dayly_100m=nanmean(temp_ECCO2(:,:,1:11,i),3);
temp_dayly_100_200m=nanmean(temp_ECCO2(:,:,12:17,i),3);
temp_dayly_200_350m=nanmean(temp_ECCO2(:,:,18:end,i),3);

temp_ECCO2_dayly_mean_100m(:,:,j)=temp_dayly_100m;
temp_ECCO2_dayly_mean_100_200m(:,:,j)=temp_dayly_100_200m;
temp_ECCO2_dayly_mean_200_350m(:,:,j)=temp_dayly_200_350m;

T_mean_prof_ECCO2_dayly_100m(:,j)=nanmean(temp_dayly_100m(:));
T_mean_prof_ECCO2_dayly_100_200m(:,j)=nanmean(temp_dayly_100_200m(:));
T_mean_prof_ECCO2_dayly_200_350m(:,j)=nanmean(temp_dayly_200_350m(:));

j=j+1;
end


load('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/ECCO2_JAK.mat')

figure
j=1; year=2008;
for i=1:12:size(Tprof_ECCO2_monthly,2)

    subplot(2,5,j)

   plot(Tprof_ECCO2_monthly(:,i:i+11),-depths,'linewidth',2) 
   xlim([-3 6])
   grid on
   xlabel('T [celsius]')
   ylabel('Depth [m]')
   title(num2str(year))
   j=j+1; year=year+1;
    
end
  legend('J','F','M','A','M','J','J','A','S','O','N','D')
  print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/T_Profile_Fjord_JAK
  
  
  %%%%% mean Temperature in each of the coluns
  figure('PaperOrientation','landscape','position',[1 1 820 425]);
  plot(date_ECCO2_num,T_mean_prof_ECCO2_dayly_100m, 'color', 'r','LineStyle','-','Linewidth',3);hold on;
  plot(date_ECCO2_num,T_mean_prof_ECCO2_dayly_100_200m, 'color','k','LineStyle','-','Linewidth',3)
  plot(date_ECCO2_num,T_mean_prof_ECCO2_dayly_200_350m, 'color', 'b','LineStyle','-','Linewidth',3)
  ylabel('Potential Temperature [°C]','fontsize',12,'fontweight','b')
  xlim([datenum('122008','mmyyyy')  datenum('042017','mmyyyy')])
  set(gca,'XGrid','on','YAxisLocation','left')
  datetick('x','yyyy','keeplimits');

  legend('0-100m', '100-200m','200-350m','location','northwest','fontsize',12);
  
  print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/T_mean_Fjord_JAK_diff_Depths
  
figure
T2=reshape(feb_2008,[9*4 50]);
% S2=reshape(S,[2*2 50]);
subplot(121)
plot(nanmean(T2,1),-depths,'linewidth',2)
grid on
xlabel('T [celsius]')
ylabel('Depth [m]')




transec_lon=307.5; % lon=[0 360]
ind_transec_lon=find(lon<=(transec_lon+0.125) & lon>=(transec_lon-0.125))
ind_transec_lon=ind_transec_lon(1);

% transec_lat=69.6; % lat=[-90 90]
% ind_transec_lat=find(lat<=(transec_lat+0.125) & lat>=(transec_lat-0.125))
% ind_transec_lat=ind_transec_lon(1);

j=1;
for i=1:size(list_opt,1);

transecto(:,:,j)=squeeze(read_temp(ind_transec_lon,:,:));
dest=[destination list_opt{i,1} '/'];    

end


for i=2008:2017
   
    dte=datestr(datenum(1992,1,0)+double(day),'yyyymmdd');
    day=double(ncread('THETA.1440x720x50.20080401.nc','TIME'))
    
end

dte=datestr(datenum(1992,1,0)+double(day),'yyyymmdd');

day1=datestr(datenum(1992,1,0)+double(day1),'yyyymmdd');
day2=datestr(datenum(1992,1,0)+double(day1),'yyyymmdd');
day=double(ncread('THETA.1440x720x50.20080401.nc','TIME'))
dte=datestr(datenum(1992,1,0)+double(day),'yyyymmdd');


ncdisp('THETA.1440x720x50.20080401.nc');

transecto=squeeze(data(1230,:,:))
pcolor(lat,-depths,transecto')
shading flat,colorbar

%%%%%% Ice Front Location:
if_JAK = shaperead('/nfs/a59/eeagdl/DATABASE/GREENLAND/CCI_products/greenland_calving_front_locations/v2.0/Products/v2.0/Jakobshavn_Isbræ_G310846E69083N/cfl_Jakobshavn_Isbræ_G310846E69083N_20150819.shp','UseGeoCoords',true);
lon_if_JAK=extractfield(if_JAK,'Lon');
lat_if_JAK=extractfield(if_JAK,'Lat');
%%%%%%%%%%%


figure;
pcolor(lon(1232-40:1232+15),lat(637-20:637+20),nanmean(data((1232-40):(1232+15),(637-20):(637+20),1),3)')
shading interp,colorbar
caxis([-2 2]);

figure;
pcolor(lon,lat,data(:,:,1)')
shading interp,c=colorbar
caxis([-4 10]);
hold on;
ylabel(c,'T [celsius]','fontsize',12,'fontweight','b')
xlabel('longitude','fontsize',12,'fontweight','b')
ylabel('latitude [N]','fontsize',12,'fontweight','b')

plot([lon(1228) lon(1236) lon(1236) lon(1228) lon(1228)], [lat(636) lat(636) lat(639) lat(639) lat(636)] , 'r'); 
print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Greenland_region_Tprofile_JAK

%plot the transect on the map: 
hold on; plot(ones(size(lat(637-5:637+5)))*lon(1232),lat(637-5:637+5),'color','r','LineStyle','-','Linewidth',3)
%plot the ice front:
plot(lon_if_JAK+360,lat_if_JAK,'color','k','LineStyle','--','Linewidth',3)

depth=double(ncread(url_S,'DEPTH_T',1,50));
data=ncread(url_S,'SALT',[808 451 1 1],[2 2 50 1]);
data=double(data);
data(data<-100)=nan;
S=data;
data=ncread('THETA.1440x720x50.20080730.nc','THETA',[1232 637 1 1],[24 10 50 1]);%,[1221:1244 633:641 : 1]);
data=double(data);
data(data<-100)=nan;
T=data;

figure
T2=reshape(feb_2008,[9*4 50]);
% S2=reshape(S,[2*2 50]);
subplot(121)
plot(nanmean(T2,1),-depths,'linewidth',2)
grid on
xlabel('T')
ylabel('Depth')






