
load('/nfs/a59/eeagdl/Petterman_S1/SNRs.mat');

%cd /nfs/a59/eeagdl/Petterman_S1/v1/offset_geocoded
cd /nfs/a59/eeagdl/Data/Tests/N7
im_ers=imread('19920207_geoc.slc.mli.ras');
%imagesc(im_s1);colormap gray
imagesc(im_ers);colormap gray

% Creating the mask to extract the error area:

poly1 = imfreehand();
mask1 = poly1.createMask();
[pos_ers_row,pos_ers_col]=find(mask1==1);

% ras1 = vel_ers;
% ras1(mask1==1) = 0;


%pos_ers = getPosition(poly1); ppos_ers=round(pos_ers);
%pos_ers_row=ppos_ers(:,2);
%pos_ers_col=ppos_ers(:,1);

[row_error_ERS,col_error_ERS] = pix2map(Rers,pos_ers_row,pos_ers_col);
[row_error_S1,col_error_S1] = map2pix(Rs1,row_error_ERS,col_error_ERS);row_error_S1=round(row_error_S1);col_error_S1=round(col_error_S1); 

%%%%%%%% Testing the grabbed area %%%%%%%%%%%%%%%%%%%%%%%%

a=vel_ers; a(pos_ers_row,pos_ers_col)=nan;
b=vel_s1; b(row_error_S1,col_error_S1)=nan;

figure;h1=imagesc(a);t1=double(~isnan(a));
set(h1,'AlphaData', t1); clear h1 t1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for i=1:length(pos_ers_row)
   
    error_S1(i,1)=Vel_S1(row_error_S1(i),col_error_S1(i));
    error_ERS(i,1)=Vel_ERS(pos_ers_row(i),pos_ers_col(i));
    error_S1_7(i,1)=vel_s1_7(row_error_S1(i),col_error_S1(i));
    error_ERS_7(i,1)=vel_ers_7(pos_ers_row(i),pos_ers_col(i));
end


mean_S1=nanmean(error_S1);
mean_S1_7=nanmean(error_S1_7);
mean_ERS=nanmean(error_ERS);
mean_ERS_7=nanmean(error_ERS_7);

std_S1=nanstd(error_S1);
std_S1_7=nanstd(error_S1_7);
std_ERS=nanstd(error_ERS);
std_ERS_7=nanstd(error_ERS_7);

rms_S1=rms(error_S1(~isnan(error_S1)));
rms_S1_7=rms(error_S1_7(~isnan(error_S1_7)));
rms_ERS=rms(error_ERS(~isnan(error_ERS)));
rms_ERS_7=rms(error_ERS_7(~isnan(error_ERS_7)));



%%%%%%%%%%%%%%%%%%% Ex. fill plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(med_mensal, 'k', 'MarkerSize',15,'Marker','.','LineWidth',1.5);hold on
mes={ 'J' 'F' 'M' 'A' 'M' 'J' 'J' 'A' 'S' 'O' 'N' 'D'};
acolor= 'k';
alpha= 0.15;
F= 1:12;
amean= med_mensal';
astd= std_mensal';
fill([F fliplr(F)],[amean+astd fliplr(amean-astd)],acolor,'FaceAlpha', alpha,'linestyle','none');
title('(b)',  'fontsize',10,'fontname','arial')
%ylabel('[%]','fontsize',8,'fontname','arial')
set(gca,'XLim',[0 13],'XTick',[1:12],'XTickLabel',mes(1:end), 'fontsize',8, 'fontname','arial')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

alpha= 0.15;

% Interpolating to create the fill error:
%pinterp_S1= interp1(dist,prof_S1_snr7_1km,dist,'spline');
pinterp_S1= interp1(dist(~isnan(prof_S1_snr7_1km)),prof_S1_snr7_1km(~isnan(prof_S1_snr7_1km)),dist,'cubic');
pinterp_ERS = interp1(dist(824:3997),prof_ERS_snr7_1km(824:3997),dist(824:3997),'cubic');

%prof_S1_snr7_1km_copy=prof_S1_snr7_1km;

%%%%%%%%%%%%%%%% Plot ERRORS %%%%%%%%%%%%%%%%%%%%%%%%%%%
load /nfs/a59/eeagdl/Petterman_S1/Plot_errors_FRINGE_paper.mat

% Plot of the time series with the error fill errorbar ** No SNR Filter **:

figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
plot(dist,prof_ERS_snr7_1km); hold on;
plot(dist,prof_S1_snr7_1km,'r');
plot(dist_nsidc,prof_NSIDC/1000,'k');

fill([dist(824:3997) fliplr(dist(824:3997))],[pinterp_ERS+(rms_ERS*1) fliplr(pinterp_ERS-(rms_ERS*1))],'b','FaceAlpha', alpha,'linestyle','none');
fill([dist fliplr(dist)],[pinterp_S1+(rms_S1*1) fliplr(pinterp_S1-(rms_S1*1))],'r','FaceAlpha', alpha,'linestyle','none');

%errorbar(20,1.4,(rms_S1*5),'xr');
%errorbar(30,1.4,(rms_ERS*5),'xb');

%title('SNR >= 7', 'fontsize',12,'fontweight','b')
ylabel('Velocity (km/yr)','fontsize',14,'fontweight','b')
xlabel('Distance (km)','fontsize',14,'fontweight','b')

hold on;
plot(B_(:,2),B_(:,1),'color','g', 'Linestyle', '--','LineWidth',2);
plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 165]);
ylim([0 2]);
set(gca,'XTick',[0:10:165],'fontsize',15)
set(gca,'YTick',[0:0.2:2],'fontsize',15)

grid on;
legend('ERS','Sentinel-1a','NSIDC vel.');

% annotation(gcf,'textbox',...
%     [0.177795320028028 0.749237820578844 0.0571212396638846 0.0821917808219178],...
%     'String',{[num2str(std_S1*1000) 'm']},...
%     'FitBoxToText','on',...
%     'LineStyle','none',...
%     'BackgroundColor',[1 1 1]);
% 
% annotation(gcf,'textbox',...
%     [0.277605427014852 0.770210114326911 0.10012836970475 0.0821917808219178],...
%     'String',{[num2str(std_ERS*1000) 'm']},...
%     'FitBoxToText','on',...
%     'LineStyle','none',...
%     'BackgroundColor',[1 1 1]);

% Plot of the time series with the error fill errorbar ** SNR Filtered **:

figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
plot(dist,prof_ERS_snr7_1km); hold on;
plot(dist,prof_S1_snr7_1km,'r');
plot(dist_nsidc,prof_NSIDC/1000,'k');

fill([dist(824:3997) fliplr(dist(824:3997))],[pinterp_ERS+(rms_ERS_7*1) fliplr(pinterp_ERS-(rms_ERS_7*1))],'b','FaceAlpha', alpha,'linestyle','none');
fill([dist fliplr(dist)],[pinterp_S1+(rms_S1_7*1) fliplr(pinterp_S1-(rms_S1_7*1))],'r','FaceAlpha', alpha,'linestyle','none');

% errorbar(20,1.4,(std_S1_7*2),'xr');
% errorbar(30,1.4,(std_ERS_7*2),'xb');

%title('SNR >= 7', 'fontsize',12,'fontweight','b')
ylabel('Velocity (km/yr)','fontsize',14,'fontweight','b')
xlabel('Distance (km)','fontsize',14,'fontweight','b')

hold on;
plot(B_(:,2),B_(:,1),'color','g', 'Linestyle', '--','LineWidth',2);
plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);
xlim([0 165]);
ylim([0 2]);
set(gca,'XTick',[0:10:165],'fontsize',15)
set(gca,'YTick',[0:0.2:2],'fontsize',15)

grid on;
legend('ERS','Sentinel-1a','NSIDC vel.');

% annotation(gcf,'textbox',...
%     [0.177795320028028 0.749237820578844 0.0571212396638846 0.0821917808219178],...
%     'String',{[num2str(std_S1_7*1000) 'm']},...
%     'FitBoxToText','on',...
%     'LineStyle','none',...
%     'BackgroundColor',[1 1 1]);
% 
% annotation(gcf,'textbox',...
%     [0.277605427014852 0.770210114326911 0.10012836970475 0.0821917808219178],...
%     'String',{[num2str(std_ERS_7*1000) 'm']},...
%     'FitBoxToText','on',...
%     'LineStyle','none',...
%     'BackgroundColor',[1 1 1]);


%%%%%%% Estimate the percentual of data inside the error shadow:  %%%%%%%%%

nsidc_int=interp1(dist_nsidc,prof_NSIDC/1000,dist,'spline');
interpS1_7=[(pinterp_S1+(rms_S1_7*1)) ; pinterp_S1-(rms_S1_7*1)]';
interpERS_7=[(pinterp_ERS+(rms_ERS_7*1));pinterp_ERS-(rms_ERS_7*1)]';


for i=1:length(dist(1:3776))
    if nsidc_int(i)>=interpS1_7(i,2) & nsidc_int(i)<=interpS1_7(i,1) 
        nsidc_inside_S1(i)=nsidc_int(i);
    else
        nsidc_inside_S1(i)=nan;
    end
        
end

% dist(3776) --> ice front position in the dist() vector

i=1;
for j=824:3776
    if nsidc_int(j)>=interpERS_7(i,2) && nsidc_int(j)<=interpERS_7(i,1) 
        nsidc_inside_ERS(i)=nsidc_int(j);
    else
        nsidc_inside_ERS(i)=nan;
    end
        
    i=i+1;
end


perc_S1=length(nsidc_inside_S1(~isnan(nsidc_inside_S1)))/length(nsidc_inside_S1)
perc_ERS=length(nsidc_inside_ERS(~isnan(nsidc_inside_ERS)))/length(nsidc_inside_ERS)



% No filter Sentinel-1a
% 
% figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto');
% h1=imagesc(vel_s1); t1=double(~isnan(vel_s1));
% caxis([0 2]);
% set(h1,'AlphaData', t1); clear h1 t1;
% 
% % No filter ERS-1
% 
% figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto');
% h1=imagesc(vel_ers); t1=double(~isnan(vel_ers));
% caxis([0 2]);
% set(h1,'AlphaData', t1);clear h1 t1;


