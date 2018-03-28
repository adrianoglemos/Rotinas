cd /nfs/a59/eeagdl/Petterman_S1/v1/Offset_Track

% Importing data:

im1=imread('20150208.slc.ras');
im2=imread('20150220.slc.ras');
im3=imread('20150220.rslc.ras');

dis_val

figure %,subplot(1,2,1);
imagesc(im1);
colormap(gray);
% hold on;
% plot(coffsets(:,1),coffsets(:,2),'LineStyle','none','marker','.','markersize',6,'Color', 'g');

figure %,subplot(1,2,2);
imagesc(im3);
colormap(gray);
% hold on;
% plot(coffsets(:,1),coffsets(:,2),'LineStyle','none','marker','.','markersize',6,'Color', 'g');

% draw masks
poly1 = imfreehand();
mask1 = poly1.createMask();

ras1 = im1;
ras1(mask1==1) = 0;


poly2 = imfreehand();
mask2 = poly2.createMask();

ras2 = im2;
ras2(mask2==1) = 0;

ras3=z;
teste=nan(13341,67772);
teste(Vel_zero==1)= ras3(Vel_zero==1);

section=nan(13341,67772);
section(trans==1)= ras3(trans==1);


figure,imagesc(ras1);
colormap(gray);
hold on;
%plot(coffsets(:,1),coffsets(:,2),'LineStyle','none','marker','.','markersize',20,'Color', 'g');
plot(offsets(:,1),offsets(:,2),'LineStyle','none','marker','.','markersize',8,'Color', 'm');

figure,imagesc(ras2);
colormap(gray);
hold on;
%plot(coffsets(:,1),coffsets(:,2),'LineStyle','none','marker','.','markersize',20,'Color', 'g');
plot(offsets(:,1),offsets(:,2),'LineStyle','none','marker','.','markersize',8,'Color', 'm');


imwrite(ras1,'02947_Mask.ras','ras');
imwrite(ras2,'02990_Mask.ras','ras');


mask1=uint8(mask1);
mask2=uint8(mask2);

%To apply the mask on GAMMA (mask_data). mask==1 -> data not masked .
%mask==0 -> data masked

i=find(mask1==0);j=find(mask1==1);
mask1(i)=999;mask1(j)=0;mask1(i)=1;
clear i j

i=find(mask2==0);j=find(mask2==1);
mask2(i)=999;mask2(j)=0;mask2(i)=1;
clear i j

%Create the .ras image
imwrite(mask1,'Mask1.ras','ras');
imwrite(mask2,'Mask2.ras','ras');


%%%% Gamma

mask_data 02947.slc 5616 02947M_5616.slc Mask1_5616.ras 1
mask_data 02990.slc 5616 02990M_5616.slc Mask2_5616.ras 1

rasSLC 19920207M_5616.slc 5616 - - - - - - - - - 19920207M.slc.ras
rasSLC 19920210M_5616.slc 5616 - - - - - - - - - 19920210M.slc.ras

%%%%% Displacement

disp(:,1)=coffsets(:,3)-coffsets(:,5); 
disp(:,2)=coffsets(:,4)-coffsets(:,6);
disp(:,3)=sqrt((disp(:,1)).^2+(disp(:,2)).^2);

%dots in different sizes
figure,imagesc(ras1);
colormap(gray);
hold on;
%plot(coffsets(:,1),coffsets(:,2),'LineStyle','none','marker','.','markersize',6,'Color', 'g');
scatter(coffsets(:,1),coffsets(:,2),disp(:,3)*200,'g','filled');

%vectors
figure,imagesc(ras1);
colormap(gray);
hold on;
quiver(coffsets(:,1),coffsets(:,2),disp(:,1),disp(:,2),'g','filled');



%%%%Data masked

figure,imagesc(ras1);
colormap(gray);
hold on;
plot(coffsetsM(:,1),coffsetsM(:,2),'LineStyle','none','marker','.','markersize',20,'Color', 'g');
plot(offsetsM(:,1),offsetsM(:,2),'LineStyle','none','marker','.','markersize',8,'Color', 'm');

figure,imagesc(ras2);
colormap(gray);
hold on;
plot(coffsetsM(:,1),coffsetsM(:,2),'LineStyle','none','marker','.','markersize',20,'Color', 'g');
plot(offsetsM(:,1),offsetsM(:,2),'LineStyle','none','marker','.','markersize',8,'Color', 'm');


%%%% import MN1=02947_02990M_N1.disp_val;

movMN1=sqrt((MN1(:,8)).^2+(MN1(:,9)).^2);
mov=movMN1/12;
mov2=mov;
mov2(mov2>5)=5;
table=[MN1(:,1) MN1(:,2) mov2];
%%% Saving
cd /nfs/a59/eeagdl/Petterman_S1/S1_arcgis
xlswrite('S1_talbe_up_5ms.xls',table)

scatter(flipud(MN1(:,1)),MN1(:,2),8,flipud(mov),'filled');

scatter(MN1(:,1),MN1(:,2),8,(movMN1/12),'filled');
colormap(jet)
caxis([0 5]);
colorbar
print -dpng -r300 mov_N1
