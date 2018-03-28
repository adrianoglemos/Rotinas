cd /nfs/a59/eeagdl/Data/offset_track

ras_02947=imread('02947.slc.ras');
ras_02990=imread('02990.slc.ras');

cd /nfs/a59/eeagdl/Data/Tests/Masked
%import coffsets and offsets
import_coffsets
import_offsets

%sub_02947=ras_02947(1:28036,:);

figure %,subplot(1,2,1);
imagesc(ras_02947);
colormap(gray);
hold on;
plot(coffsets(:,1),coffsets(:,2),'LineStyle','none','marker','.','markersize',6,'Color', 'g');

figure %,subplot(1,2,2);
imagesc(ras_02990);
colormap(gray);
hold on;
plot(coffsets(:,1),coffsets(:,2),'LineStyle','none','marker','.','markersize',6,'Color', 'g');

% draw masks
poly1 = imfreehand();
mask1 = poly1.createMask();

ras1 = ras_02947;
ras1(mask1==1) = 0;


poly2 = imfreehand();
mask2 = poly2.createMask();

ras2 = ras_02990;
ras2(mask2==1) = 0;


figure,imagesc(ras1);
colormap(gray);
hold on;
plot(coffsets(:,1),coffsets(:,2),'LineStyle','none','marker','.','markersize',20,'Color', 'g');
plot(offsets(:,1),offsets(:,2),'LineStyle','none','marker','.','markersize',8,'Color', 'm');

figure,imagesc(ras2);
colormap(gray);
hold on;
plot(coffsets(:,1),coffsets(:,2),'LineStyle','none','marker','.','markersize',20,'Color', 'g');
plot(offsets(:,1),offsets(:,2),'LineStyle','none','marker','.','markersize',8,'Color', 'm');


imwrite(ras1,'02947_Mask.ras','ras');
imwrite(ras2,'02990_Mask.ras','ras');


mask1=uint8(mask1);
mask2=double(mask2);

%To apply the mask on GAMMA (mask_data). mask==1 -> data not masked .
%mask==0 -> data masked
i=find(mask2==0);j=find(mask2==1);
mask2(i)=999;mask2(j)=0;mask2(i)=1;

%Create the .ras image
imwrite(mask1,'Mask1.ras','ras');
imwrite(mask2,'Mask2_nan.ras','ras');


%%%% Gamma

mask_data 02947.slc 4912 02947M_nan.slc Mask1_nan.ras 1
mask_data 02990.slc 4912 02990M_nan.slc Mask2_nan.ras 1

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

dispM(:,1)=coffsetsM(:,3)-coffsetsM(:,5); 
dispM(:,2)=coffsetsM(:,4)-coffsetsM(:,6);
dispM(:,3)=sqrt((dispM(:,1)).^2+(dispM(:,2)).^2);

%dots in different sizes
figure,imagesc(ras1);
colormap(gray);
hold on;
scatter(coffsetsM(:,1),coffsetsM(:,2),dispM(:,3)*200,'g','filled');




figure,imagesc(ras1);
colormap(gray);
hold on;
%plot(coffsetsM(:,1),coffsetsM(:,2),'LineStyle','none','marker','.','markersize',20,'Color', 'g');
plot(offsetsN(:,1),offsetsN(:,2),'LineStyle','none','marker','.','markersize',4,'Color', 'g');


figure,imagesc(ras1);
colormap(gray);
hold on;
%plot(coffsetsM(:,1),coffsetsM(:,2),'LineStyle','none','marker','.','markersize',20,'Color', 'g');
plot(offsetsNN(:,1),offsetsNN(:,2),'LineStyle','none','marker','.','markersize',4,'Color', 'g');



figure,imagesc(ras1);
colormap(gray);
hold on;
%plot(coffsetsM(:,1),coffsetsM(:,2),'LineStyle','none','marker','.','markersize',20,'Color', 'g');
plot(M(:,1),M(:,2),'LineStyle','none','marker','.','markersize',4,'Color', 'g');


movM=sqrt((M(:,8)).^2+(M(:,9)).^2);

scatter(flipud(M(:,1)),M(:,2),8,flipud(movM/3),'filled');
colormap(jet)
caxis([0 10]);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% corregistration (256X1024_24X24) %%%% offser (128X512_36X108)

dispM2(:,1)=coffsetsM100300(:,3)-coffsetsM100300(:,5); 
dispM2(:,2)=coffsetsM100300(:,4)-coffsetsM100300(:,6);
dispM2(:,3)=sqrt((dispM2(:,1)).^2+(dispM2(:,2)).^2);

%dots in different sizes
figure,imagesc(ras1);
colormap(gray);
hold on;
scatter(coffsetsM100300(:,1),coffsetsM100300(:,2),dispM2(:,3)*200,'g','filled');


%%%% import MN1=02947_02990M_N1.disp_val;

movMN1=sqrt((MN1(:,8)).^2+(MN1(:,9)).^2);

scatter(flipud(MN1(:,1)),MN1(:,2),8,flipud(movMN1/3),'filled');
colormap(jet)
caxis([0 6]);
colorbar
print -dpng -r300 mov_N1



%%%% import MN2=02947_02990M_N2.disp_val;

movMN2=sqrt((MN2(:,8)).^2+(MN2(:,9)).^2);

scatter(flipud(MN2(:,1)),MN2(:,2),15,flipud(movMN2/3),'filled');
colormap(jet)
caxis([0 10]);
scatter(MN2(:,1),MN2(:,2),15,movMN2/3,'filled');

colorbar
print -dpng -r300 mov_N2

%%%% import MN3=02947_02990M_N3.disp_val;

movMN3=sqrt((MN3(:,8)).^2+(MN3(:,9)).^2);

scatter(flipud(MN3(:,1)),MN3(:,2),8,flipud(movMN3/3),'filled');
colormap(jet)
caxis([0 6]);
colorbar
print -dpng -r300 mov_N3


%%%% import MN4=02947_02990M_N4.disp_val;

movMN4=sqrt((MN4(:,8)).^2+(MN4(:,9)).^2);

scatter(flipud(MN4(:,1)),MN4(:,2),8,flipud(movMN4/3),'filled');
colormap(jet)
caxis([0 6]);
colorbar
print -dpng -r300 mov_N4







%range:
range=-3.39895 + ((2.7617e-04).*coffsets(:,3)) + (2.5512e-05.*coffsets(:,4)) - (8.9121e-09.*coffsets(:,3).*coffsets(:,4));


%azimuth:
azim=(-1715.94780)+2.4080e-02.*coffsets(:,3)-4.5636e-05.*coffsets(:,4)+3.2740e-08.*coffsets(:,3).*coffsets(:,4);



%range_offset_polynomial:
r=-3.38780+2.2053e-04   2.9241e-05  -5.8358e-09
%azimuth_offset_polynomial: 
a=-1716.08972   2.4208e-02  -5.4700e-05   3.2118e-08




