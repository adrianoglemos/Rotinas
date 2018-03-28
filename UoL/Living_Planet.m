

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

    for w=[5];
        
        for f=[0.1];
            for af=[50];
            %eval(['!app setup canopy python-libs && ../gaussian_filter.py vel_geoc_dust float32 ' widthDEM ' ' linesDEM ' vel_geoc_dust_gauss_' num2str(w) '_' num2str(f) '_' num2str(af) ' -w ' num2str(w) ' -fmax ' num2str(f) ' -af ' num2str(af)]);
            eval(['!data2geotiff ' date(1:8) '.dem.par vel_geoc_dust_gauss_' num2str(w) '_' num2str(f) '_' num2str(af) ' 2 VEL_km_y_' date(1:17) '_filter2_' num2str(w) '_' num2str(f) '_' num2str(af) '.tif']);
            end
        end
    end

clear widthDEM linesDEM y2 y3

end

for i=[1:11 13:length(list)];
    path1=[pathsate list{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    
    date=list{i,1};
    
cd(path1);

eval(['[Vel_map_gauss'  num2str(j) ',Rs1_gauss_'  num2str(j) ']=geotiffread(''VEL_km_y_' date(1:17) '_filter2_5_0.1_50.tif'');']);
%eval(['[ccp_map_'  num2str(j) ',Rs1_ccp_'  num2str(j) ']=geotiffread(''CCP_' date(1:17) '.tif'');']);

eval(['Vel_map=Vel_map_gauss'  num2str(j) '; Rs1=Rs1_gauss_'  num2str(j) ';']);


Vel_map(Vel_map<=0)=nan;

[row_S1,col_S1] = map2pix(Rs1,X_p,Y_p);
%[row_S1_ccp,col_S1_ccp] = map2pix(Rs1_ccp,X_p,Y_p);

prof_S1_gauss(:,j)=improfile(Vel_map,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));



clear row* col* ccp_map Rs1 Rs1_ccp Vel_map

j=j+1;

end




figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
for i=1:19;
plot(dist(i,1:650),prof_S1_gauss(1:650,i),'.');hold on;
end

figure('units', 'centimeters','position', [0 0 20 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
for i=1:19;
plot(dist(i,1:650),prof_S1_mov_med(1:650,i),'.');hold on;
end

%title('JAK Profile mMedian filter','fontsize',12,'fontweight','b');
ylabel('velocity [km.yr^{-1}]','fontsize',14,'fontweight','b')

xlabel('distance [km]','fontsize',14,'fontweight','b')
%plot(dist(1,1:631),prof_NSIDC_2009(1:631),'.')
hold on;
%plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
%plot(B_(:,3),B_(:,1),'color','k', 'Linestyle', '--','LineWidth',2);

xlim([0 35]);%[0 (0.047949*999)+1]);
%xlim([0 (29.9439*999)+1]);

ylim(gca,[0 12]);

set(gca,'XTick',[0:5:35])
set(gca,'YTick',[0:2:12])
grid on;


legend('20141116-20141128','20141128-20141210','20141222-20150103','20150127-20150208','20150208-20150220','20150304-20150316','20150316-20150328','20150328-20150409','20150409-20150421','20150421-20150503','20150503-20150515','20150527-20150608','20150726-20150807','20150807-20150819','20150819-20150831','20150831-20150912','20150912-20150924','20151111-20151123','20160203-20160215');



