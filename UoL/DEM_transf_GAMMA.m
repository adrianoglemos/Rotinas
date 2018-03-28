
%%% DEM in INTEGER*2

cd /nfs/a59/eeagdl/DATABASE/GREENLAND/GIMP_DEM
[gimp,Rgimp]=geotiffread('gimpdem_90m.tif');
Y = swapbytes(gimp);

fileID = fopen('gimp21.dem','w');
fwrite(fileID,Y','integer*2');
fclose(fileID);



%%% DEM in Real*4

Y2=single(z_cs2);
%Y2(isnan(Y2))=0.01;
Y = swapbytes(Y2);



fileID = fopen('Slater.dem','w');
fwrite(fileID,Y','real*4');
fclose(fileID);
