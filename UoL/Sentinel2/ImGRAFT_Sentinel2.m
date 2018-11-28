datafolder=downloadDemoData('cias');


[A,x,y,Ia]=geoimread(fullfile(datafolder,'batura_2001.tif'));
[B,xb,yb,Ib]=geoimread(fullfile(datafolder,'batura_2002.tif'));

deltax=x(2)-x(1);%m/pixel
deltay=y(2)-y(1);%m/pixel

[pu,pv]=meshgrid(10:20:size(A,2),10:20:size(A,1)); %pixel coordinated

%obtain corresponding map coordinates of pixel coordinates
px=interp1(x,pu); py=interp1(y,pv);

%... but restricted to points inside this region of interest polygon
roi=[387 452;831 543;1126 899;1343 1006;1657 1022;2188 1330;...
     2437 1220;2564 1359;2483 1473;2188 1489;1693 1320;1563 1181; ...
     1061 1168;663 718;456 686;25 877;28 627;407 465];

mask=inpolygon(pu,pv,roi(:,1),roi(:,2));
pu(~mask)=nan; %inserting nans at some locations will tell template match to skip these locations

[du,dv,C,Cnoise,pu,pv]=templatematch(A,B,pu,pv,'showprogress',true,'method','oc');
close all

%visualize the results
%turn the intensity image into an RGB image
%so that it does not interfere with colorbar:

showimg(x,y,A)
hold on
signal2noise=C./Cnoise;
keep=(signal2noise>2)&(C>.6);
V=(du*deltax)+(dv*1i)*deltay; %m/yr
Vn=abs(V);
alphawarp(px,py,Vn,.2+keep*.5)
quiver(px(keep),py(keep),real(V(keep))./Vn(keep),imag(V(keep))./Vn(keep),0.2,'k') %arrows show direction.
caxis([0 200])
colorbar('southoutside');


%% Test S2

cd /nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing_150_150/Diff_TimeSteps

datafolder='/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing_150_150/Diff_TimeSteps/';

[A,x,y,Ia]=geoimread(fullfile(datafolder,'S2A_tile_20160708_22WEB_0.jp2'));
[B,xb,yb,Ib]=geoimread(fullfile(datafolder,'S2A_tile_20160714_22WEB_0.jp2'));

deltax=x(2)-x(1);%m/pixel
deltay=y(2)-y(1);%m/pixel

%dt=date2-date1;
dt=6;% days

[pu,pv]=meshgrid(10:21:size(A,2),10:21:size(A,1)); %pixel coordinated

%obtain corresponding map coordinates of pixel coordinates
px=interp1(x,pu); py=interp1(y,pv);

%... but restricted to points inside this region of interest polygon
roi=[387 452;831 543;1126 899;1343 1006;1657 1022;2188 1330;...
     2437 1220;2564 1359;2483 1473;2188 1489;1693 1320;1563 1181; ...
     1061 1168;663 718;456 686;25 877;28 627;407 465];

mask=inpolygon(pu,pv,roi(:,1),roi(:,2));
pu(~mask)=nan; %inserting nans at some locations will tell template match to skip these locations

[du,dv,C,Cnoise,pu,pv]=templatematch(A,B,pu,pv,'showprogress',true,'method','oc');
close all

%visualize the results
%turn the intensity image into an RGB image
%so that it does not interfere with colorbar:

showimg(x,y,A)
hold on
signal2noise=C./Cnoise;
keep=(signal2noise>2)&(C>.6);
%V=(du*deltax)+(dv*1i)*deltay; %m/yr
V=((du*deltax)+(dv*1i)*deltay).*365/dt; %m/yr
Vn=abs(V);
alphawarp(px,py,Vn,.2+keep*1.0)
quiver(px(keep),py(keep),real(V(keep))./Vn(keep),imag(V(keep))./Vn(keep),0.2,'k') %arrows show direction.
caxis([0 20000])
colorbar('southoutside');


%% Comparison

[Vga,xga,yga,Iga]=geoimread(fullfile(datafolder,'VEL_m_y_20160708_20160714.tif'));
Vga(Vga<=0)=nan;


figure;
subplot(131)
pcolor(xga,yga,Vga)
shading interp
colormap jet
caxis([0 18000])
colorbar
title('GAMMA','fontsize',14)

subplot(132)
pcolor(px,py,Vn)
shading interp
colormap jet
caxis([0 18000])
colorbar
title('ImGRAFT','fontsize',14)




Vga(Vga<=0)=nan;
s1_int= interp2(xga,yga,Vga,px,py);

subplot(133)
pcolor(px,py,s1_int-Vn)
shading interp
colorbar
colormap(gca,redbluecmap)
caxis([-500 500])
title('GAMMA-ImGRAFT','fontsize',14)

print -dpng -r300 /nfs/a59/eeagdl/Figures_temp/S2_JAK/GAMMA_minus_ImGRAFT

As=im2single(A);
hpass=@(As,sigma)As-imfilter(As,fspecial('gaussian',sigma*3,sigma)); %define a filter function
Ass=hpass(As,3); %apply the filter
figure; imagesc(Ass)


%% Bad Pair


%/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing/20160624_20160628

datafolder='/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/processing/20160624_20160628/';

[A,x,y,Ia]=geoimread(fullfile(datafolder,'S2A_tile_20160624_22WEB_0.jp2'));
[B,xb,yb,Ib]=geoimread(fullfile(datafolder,'S2A_tile_20160628_22WEB_0.jp2'));

deltax=x(2)-x(1);%m/pixel
deltay=y(2)-y(1);%m/pixel

%dt=date2-date1;
dt=4;% days

[pu,pv]=meshgrid(1:10:size(A,2),1:10:size(A,1)); %pixel coordinated

%obtain corresponding map coordinates of pixel coordinates
px=interp1(x,pu); py=interp1(y,pv);

%... but restricted to points inside this region of interest polygon

%roi=[387 452;831 543;1126 899;1343 1006;1657 1022;2188 1330;...
%      2437 1220;2564 1359;2483 1473;2188 1489;1693 1320;1563 1181; ...
%      1061 1168;663 718;456 686;25 877;28 627;407 465];

% mask=inpolygon(pu,pv,roi(:,1),roi(:,2));
% pu(~mask)=nan; %inserting nans at some locations will tell template match to skip these locations

% Orientation Correlation ('oc')
[du,dv,C,Cnoise,pu,pv]=templatematch(A,B,pu,pv,'showprogress',true,'method','oc','TemplateWidth',10,'TemplateHeight',10,'SearchWidth',75,'SearchHeight',75);

% Cross-correlation Correlation ('NCC')
[du,dv,C,Cnoise,pu,pv]=templatematch(A,B,pu,pv,'showprogress',true,'method','NCC','TemplateWidth',10,'TemplateHeight',10,'SearchWidth',75,'SearchHeight',75);
close all

%visualize the results
%turn the intensity image into an RGB image
%so that it does not interfere with colorbar:

% showimg(x,y,A)
% hold on
signal2noise=C./Cnoise;
keep=(signal2noise>2)&(C>.6);
%V=(du*deltax)+(dv*1i)*deltay; %m/yr
V=((du*deltax)+(dv*1i)*deltay).*365/dt; %m/yr
Vn=abs(V);
alphawarp(px,py,Vn,.2+keep*1.0)
% quiver(px(keep),py(keep),real(V(keep))./Vn(keep),imag(V(keep))./Vn(keep),0.2,'k') %arrows show direction.
caxis([0 20000])
colorbar('southoutside');

%%%%%%%%%%%%%%%%%%%%
!gdalwarp -ot Float32 -s_srs EPSG:3413 -t_srs EPSG:32622 -r near -of GTiff -co COMPRESS=DEFLATE -co PREDICTOR=1 -co ZLEVEL=6 -wo OPTIMIZE_SIZE=TRUE /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/12days_processing/20170814_20170826/170814_170826.coffsN_mag_DuFil_yrF.gc.tiff 170814_170826_reproj2.tif

[Vga,xga,yga,Ia]=geoimread('/nfs/a59/eeagdl/Data/Available_Images/S2/Russell/S1_reprojected/170814_170826_reproj.tif');
[Vga,Rga]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S2/Russell/S1_reprojected/170814_170826_reproj.tif');

% [Vga,xga,yga,Ia]=geoimread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/12days_processing/20170814_20170826/170814_170826.coffsN_mag_DuFil_yrF.gc.tiff');
% [Vga,Rga]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/12days_processing/20170814_20170826/170814_170826.coffsN_mag_DuFil_yrF.gc.tiff');
Vga(Vga<=0)=nan;
s1_int= interp2(xga,yga,Vga,px,py);
%%%%%%%%%%%%%%%%%%%%%%%%%


[Vga,xga,yga,Iga]=geoimread(fullfile(datafolder,'VEL_m_y_20160624_20160628.tif'));
Vga(Vga<=0)=nan;
s1_int= interp2(xga,yga,Vga,px,py);

figure;
subplot(131)
pcolor(xga,yga,Vga)
shading interp
colormap jet
caxis([0 18000])
colorbar
title('GAMMA','fontsize',14)

subplot(132)
pcolor(px,py,Vn)
shading interp
colormap jet
caxis([0 18000])
colorbar
title('ImGRAFT','fontsize',14)





subplot(133)
pcolor(px,py,s1_int-Vn)
shading interp
colorbar
colormap(gca,redbluecmap)
caxis([-500 500])
title('GAMMA-ImGRAFT','fontsize',14)

print -dpng -r300 /nfs/a59/eeagdl/Figures_temp/S2_JAK/GAMMA_minus_ImGRAFT_badGAMMA
