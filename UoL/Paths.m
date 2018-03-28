cd /nfs/a59/eeagdl/Dropbox/Rotinas


imread('02990.cslc.ras');
info=imfinfo('02990.cslc.ras');
%info2=geotiffinfo('02990.cslc.ras');
R = worldfileread('concord_ortho_w.tfw','planar', [info.Height info.Width]);
worldfilewrite(R, 'teste.tfw');


 mapshow(ans,R);
 axis image off
 
 %Reading th s1
 [A, R] = geotiffread('s1a-iw-grd-hh-20141113t080048-20141113t080113-003260-003c52-001.tiff');
 
a=fread(fileID,'double');
fclose(fileID);
 
cd /nfs/a59/eeagdl/Data/offset_track
 file = fopen('velocity','rb');
  map1 = fread(file,'float');  % esse deve ser lido de 1 em 1
                                             % bytes
  fclose(file);
