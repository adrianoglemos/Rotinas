%%%%%%%%%%%%%%% IMAGEM Modis %%%%%%%%%%%%%
[img,Rimg]=geotiffread('/nfs/a59/eeagdl/tempp/map_clip.tif');
%Rimg=worldfileread('/media/alemos_serv/Backup_Lab/Dissert/Resultados/IMAGENS_WILKINS/WilkinsModis/WilkinsModisResamp04.tfw');
%s2=shaperead('/media/alemos_serv/Backup_Lab/Dissert/Resultados/IMAGENS_WILKINS/CoastLine/coastline_island_modis/acap1336510284101079_data.shp','UseGeoCoords',true);
% s3=shaperead('/media/alemos_serv/Backup_Lab/Dissert/Resultados/IMAGENS_WILKINS/CoastLine/coasstline_modis/acap1336510284101074_data.shp','UseGeoCoords',true);
%s3=shaperead('/media/alemos_serv/Backup_Lab/Dissert/Resultados/ADD/LatLonMatlab/Atual.shp','UseGeoCoords',true);
[vel,Rvel]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Antarctic/Mosaic_GVI/VEL_mosaic_GVI.tif');


img=double(img); img=img/255;img(img<=0)=nan;


figure('units', 'centimeters','position', [0 0 15 15] , 'paperpositionmode', 'auto'); %,'papertype','A4'  maximize;
axesm('MapProjection','mercator', 'MapLatLimit',[-73 -65],'MapLonLimit',[272 294.5]);

%h=geoshow(img, Rimg); hold on;
h1=mapshow(img, Rimg,'DisplayType','surface'); hold on;
colormap gray
%freezeColors(h)
m=

h1=imshow(im3)
colormap(gray)
freezeColors
hold on

h=mapshow(vel,Rvel,'DisplayType','surface');
colormap default
caxis([0 2]);
colorbar
hold off
alpha(h,0.5);

set(h, 'FaceAlpha', 0.85);





%geoshow(s3,'Color','k', 'LineWidth',1);
%[j,k] =contourm(bat, Rbat,[-1000 -1000],'Color','r', 'LineWidth',1); hold on;
%linem(j(2,185:1760), j(1,185:1760),'LineStyle','-','Color','k','LineWidth',1);

X = get(h,'XData'); 
Y = get(h,'YData');
f=isnan(img);
f(end+1,:)=true;
f(:,end+1)=true;
X(f)=nan;
Y(f)=nan;
set(h,'XData',X,'YData',Y);
gridm('Grid','on','GLineWidth',1,'GLineStyle',':','PLineLocation', 1,'MLineLocation',4, 'fontsize',10);
framem;
mlabel('MeridianLabel','on','MLabelParallel', 'south','ParallelLabel','on','PLabelLocation',1,'MLabelLocation',4)
axis off; 
linem([-69 -69 -72.98 -72.98 -69], [-78 -67.1 -67.1 -78 -78],'LineStyle','--','Color',[0.5 0.5 0.5],'LineWidth',2);
% hold on;
linem([-65.5 -65.5 -72.98 -72.98 -65.5], [272.5-360 294-360 294-360 272.5-360 272.5-360],'LineStyle','--','Color','k','LineWidth',2);
plotm(CTDlalo(:,1),CTDlalo(:,2),'LineStyle','none','marker','.','Color','k'); %Dados CTD
plotm([-67.566], [-68.1333],'LineStyle','none','marker','*','markersize',10,'Color','r'); %Estacao Rothera Point
scaleruler on;
setm(handlem('scaleruler1'),'rulerstyle', 'patches','lat',-61,'LineWidth',1,'Xloc',0.12,'Yloc',-1.897,'MajorTick', 0:100:100,'MajorTickLength',15,'MinorTick', 0:25:50,'MinorTickLength',15,'Units','km')

%plotm(WOAlalo(:,2),WOAlalo(:,1),'LineStyle','none','marker','square','Color','k'); %Dados CTD

pause(1);
print -dpng -r300 /media/alemos_serv/Backup_Lab/Dissert/Resultados/GraficosPNG/RegiaoBase
%saveas (gcf,'/media/alemos_serv/Backup_Lab/Dissert/Resultados/GraficosFIG/RegiaoBase.fig','fig');    

