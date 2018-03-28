
%%%% Interpolating the GIMP DEM from 90m to 10m:

%Importing the GIMP DEM 
cd /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP
[im,R]=geotiffread('gimpdem_90m.tif');
im2=imread('gimpdem_90m.tif');
geoshow(im,R,'DisplayType','surface')




  file = fopen('S0_DTM20.tif','r','ieee-le.l64','UTF-8');
  map1 = fread(file,'int16','ieee-le.l64');  % esse deve ser lido de 1 em 1
  %map1 = fscanf(file,'%ld');  % esse deve ser lido de 1 em 1
a=swapbytes(im);
  fclose(file);
  
  dem2=reshape(map1,23402,37637);
%  st=native2unicode(map1,'UTF-8');
%   st=double(st);
 dem2=reshape(map1,16620,30000);
 
dem=reshape(a,16620,30000);
%   
  imagesc(dem); colorbar; colormap gray
  demcmap(dem);
  
  
 
  im2=double(im);
  
  g=im2(:,1:4000);
  g1=im2(:,4001:8000);
  g2=im2(:,8001:8310);
  
  %g4=im2(:,12001:end);
  
  
  a=0:90:(90*29999);
  b=0:90:(3999*90);
  b1=(4000*90):90:(7999*90);
  b2=(8000*90):90:(90*8309);

  [B,A]=meshgrid(b,a);
  [B1,A1]=meshgrid(b1,a);
  [B2,A2]=meshgrid(b2,a);
  
  X=0:10:(90*29999);
  Y=0:10:(3999*90);
  Y1=(4000*90):10:(7999*90);
  Y2=(8000*90):10:(90*8309);

%   X=1:90000;
%   Y=1:(4000*9);
%   Y2=1:(310*9);
   
  [y,x]=meshgrid(Y,X);
  [y1,x1]=meshgrid(Y1,X);
  [y2,x2]=meshgrid(Y2,X);  
  
  
  d=interp2(B,A,g,y,x);
  d1=interp2(B1,A1,g1,y1,x1);
%   d3=interp2(B,A,g3,y,x);
  d2=interp2(B2,A2,g2,y2,x2);

  a1=nan(5,2);
  a2=a1;
  a3=[a1 a2];
  imagesc(d1);
  
  
%   d1=griddata(B,A,g1,y,x);
  
  
info = geotiffinfo('gimpdem_90m.tif');
geotiffwrite('DEM_gimp_10m.tif', z, R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

  
  Vq = interpn(DEM,9);
  
  for i=1:length(f)
      d(f(i))=d(f(i))*-1;
  end
  