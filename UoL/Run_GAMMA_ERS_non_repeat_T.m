%% Co-register the images using the GIMP DEM:

data1= num2str(19920926); data2= num2str(19921116);
path1=['/nfs/a59/eeagdl/Data/Tests/NTrack/Images/112/ERS1_112_06269_1948_920926_170310/'];
path2=['/nfs/a59/eeagdl/Data/Tests/NTrack/Images/341/ERS1_341_06999_1949_921116_170011/'];

cd /nfs/a59/eeagdl/Data/Tests/NTrack/Images/112/ERS1_112_06269_1948_920926_170310/
% multi_look 19950613.slc 19950613.slc.par 19950613.mli 19950613.mli.par 1 5
% multi_look 19950624.slc 19950624.slc.par 19950624.mli 19950624.mli.par 1 5

% Using GIMP:
%!gc_map 19950613.mli.par - /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem.par /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem 19950613.dem.par 19950613.dem 19950613.lt 1 1 19950613.sim_sar u_19950613 v_19950613 inc_19950613 psi_19950613 pix_19950613 ls_map_19950613 8 2
eval(['!gc_map ' path1 data1 '.mli.par - /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem.par /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem ' data1 '.dem.par ' data1 '.dem ' data1 '.lt 9 9 ' data1 '.sim_sar u_' data1 ' v_' data1 ' inc_' data1 ' psi_' data1 ' pix_' data1 ' ls_map_' data1 ' 8 1']);

[s,widthSLC]=system(['grep range_samples: ' path1 data1 '.slc.par | cut -c33-36']);
widthSLC=widthSLC(1:4);

y=['grep azimuth_lines: ' path1 data1 '.mli.par | cut -c33-36']
[s,lines]=system(y);
lines=num2str(lines(1,1:4));

y=['grep azimuth_lines: ' path2 data2 '.mli.par | cut -c33-36']
[s,lines2]=system(y);
lines2=num2str(lines2(1,1:4));

y2=['grep width: ' path1 data1 '.dem.par | cut -c22-26']
[s2,widthDEM]=system(y2);
widthDEM=num2str(widthDEM(1,1:5));

y3=['grep lines: ' path1 data1 '.dem.par | cut -c22-27']
[s3,linesDEM]=system(y3);
linesDEM=num2str(linesDEM(1,1:5));


eval(['!geocode ' data1 '.lt ' data1 '.dem ' widthDEM ' ' data1 '.sim_sar2  ' widthSLC ' ' lines ' 1 0']);

% create_diff_par 19950613.mli.par - 19950613.diff_par 1
% 
% init_offsetm 19950613.mli 19950613.sim_sar2 19950613.diff_par - - - - - - 3.0
% offset_pwrm 19950613.mli 19950613.sim_sar2 19950613.diff_par 19950613_offs 19950613_snr 256 256 19950613_offsets 1 8 8 3.0
% offset_fitm 19950613_offs 19950613_snr 19950613.diff_par 19950613_coffs 19950613_coffsets 3.0 3
% 
% offset_pwrm 19950613.mli 19950613.sim_sar2 19950613.diff_par 19950613_offs 19950613_snr 128 128 19950613_offsets 1 24 24 3.0
% offset_fitm 19950613_offs 19950613_snr 19950613.diff_par 19950613_coffs 19950613_coffsets 3.0 3
% gc_map_fine 19950613.lt 1356 19950613.diff_par 19950613.lt.fine 0
% 
% geocode_back 19950613.mli 5616 19950613.lt.fine 19950613_geoc.mli 1356 1080 2 0
% 
% geocode 19950613.lt.fine 19950613.dem 1356 19950613.dem.Final 5616 5608 1 0
  %dishgt 19950613.dem.Final 19950613.mli 5616

%%%% Ex. I - Corregister using a lookup table:


eval(['!rdc_trans ' path1 data1 '.mli.par ' path1 data1 '.sim_sar2 ' path2 data2 '.mli.par lt0']);
eval(['!geocode lt0 ' path1 data1 '.mli ' widthSLC ' mli0 ' widthSLC ' ' lines2 ' 2 0']);

eval(['!create_diff_par ' path2 data2 '.mli.par - diff0 1']);
eval(['!init_offsetm mli0 ' path2 data2 '.mli diff0 1 1 - - - - 2.5']);
eval(['!offset_pwrm mli0 ' path2 data2 '.mli diff0 offs0 snr0 256 256 offsets0 2 16 16 7']);
eval(['!offset_fitm offs0 snr0 diff0 coffs0 coffsets0 2.5 4']);
eval(['!gc_map_fine lt0 ' widthSLC ' diff0 lt1']);

eval(['!SLC_interp_lt ' path2 data2 '.slc ' data1 '.slc.par ' path2 data2 '.slc.par lt1 ' data1 '.mli.par ' path2 data2 '.mli.par - ' path2 data2 '.rslc ' path2 data2 '.rslc.par']);

%eval(['!multi_look ' path2 data2 '.rslc ' path2 data2 '.rslc.par ' path2 data2 '.rmli ' path2 data2 '.rmli.par 1 5']);
%eval(['!dis2pwr ' data1 '.mli ' path2 data2 '.rmli 5616 5616']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Masking the data
data1= num2str(19950607); data2= num2str(19950627);

% Masking the image
[s,widthSLC]=system(['grep range_samples: ' data1 '.slc.par | cut -c33-36']);
widthSLC=widthSLC(1:4);

eval(['!rasSLC ' data1 '.slc ' widthSLC ' - - - - - - - - - ' data1 '.slc.ras']);

%%% Masking the main flow:

im=imread([data1 '.slc.ras']);
figure
imagesc(im);
colormap(gray);
poly1 = imfreehand();

mask1 = poly1.createMask();
ras1 = im;
ras1(mask1==1) = 0;
mask1=uint8(mask1);
imwrite(mask1,['Mask_' data1 '.ras'],'ras');

close all
clear im poly1 mask1 ras1

eval(['!mask_class Mask_' data1 '.ras ' data1 '.slc ' data1 'M.slc 1 1 -1 1 0']);
%eval(['!rasSLC ' data1 'M.slc ' widthSLC ' - - - - - - - - - ' data1 'M.slc.ras']);



% Masking the image
[s,widthSLC2]=system(['grep range_samples: ' path2 data2 '.rslc.par | cut -c33-36']);
widthSLC2=widthSLC2(1:4);

eval(['!rasSLC ' path2 data2 '.rslc ' widthSLC2 ' - - - - - - - - - ' path2 data2 '.rslc.ras']);

%%% Masking the main flow:

im=imread([path2 data2 '.rslc.ras']);
figure
imagesc(im);
colormap(gray);
poly1 = imfreehand();

mask1 = poly1.createMask();
ras1 = im;
ras1(mask1==1) = 0;
mask1=uint8(mask1);
imwrite(mask1,[path2 'Mask_' data2 '.ras'],'ras');

close all
clear im poly1 mask1 ras1

eval(['!mask_class ' path2 'Mask_' data2 '.ras ' path2 data2 '.rslc ' path2 data2 'M.rslc 1 1 -1 1 0']);
%eval(['!rasSLC ' data1 'M.slc ' widthSLC ' - - - - - - - - - ' data1 'M.slc.ras']);


%% Offset Tracking traditional processing
eval(['mkdir /nfs/a59/eeagdl/Data/Tests/NTrack/Processing/DEM_10m/' data1 '_' data2 '/']);
cd(['/nfs/a59/eeagdl/Data/Tests/NTrack/Processing/DEM_10m/' data1 '_' data2 '/'])

eval(['!create_offset ' path1 data1 '.slc.par ' path2 data2 '.rslc.par ' data1 '_' data2 '.off 1 - - 0']);
eval(['!offset_pwr ' path1 data1 'M.slc ' path2 data2 'M.rslc ' path1 data1 '.slc.par ' path2 data2 '.rslc.par ' data1 '_' data2 '.off ' data1 '_' data2 '_offsM ' data1 '_' data2 '_snrM 256 256 ' data1 '_' data2 '_offsetsM 2 128 128 4'])
eval(['!offset_fit ' data1 '_' data2 '_offsM ' data1 '_' data2 '_snrM ' data1 '_' data2 '.off ' data1 '_' data2 '_coffsM ' data1 '_' data2 '_coffsetsM 5 1']);

eval(['!offset_pwr ' path1 data1 'M.slc ' path2 data2 'M.rslc ' path1 data1 '.slc.par ' path2 data2 '.rslc.par ' data1 '_' data2 '.off ' data1 '_' data2 '_offsM ' data1 '_' data2 '_snrM 256 256 ' data1 '_' data2 '_offsetsM 2 128 128 4'])
eval(['!offset_fit ' data1 '_' data2 '_offsM ' data1 '_' data2 '_snrM ' data1 '_' data2 '.off ' data1 '_' data2 '_coffsM ' data1 '_' data2 '_coffsetsM 5 1']);

%eval(['!offset_pwr_tracking ' data1 '.slc ' data2 '.rslc ' data1 '.slc.par ' data2 '.rslc.par ' data1 '_' data2 '.off ' data1 '_' data2 '_offsNN ' data1 '_' data2 '_snrNN 64 256 ' data1 '_' data2 '_offsetsNN 2 4.0 12 48']);
%eval(['!offset_pwr_tracking ' data1 '.slc ' data2 '.rslc ' data1 '.slc.par ' data2 '.rslc.par ' data1 '_' data2 '.off ' data1 '_' data2 '_offsNN ' data1 '_' data2 '_snrNN 256 512 ' data1 '_' data2 '_offsetsNN 2 4.0 12 48']);
eval(['!offset_pwr_tracking ' path1 data1 '.slc ' path2 data2 '.rslc ' path1 data1 '.slc.par ' path2 data2 '.rslc.par ' data1 '_' data2 '.off ' data1 '_' data2 '_offsNN ' data1 '_' data2 '_snrNN 256 512 ' data1 '_' data2 '_offsetsNN 1 4.0 12 48']);

eval(['!offset_tracking ' data1 '_' data2 '_offsNN ' data1 '_' data2 '_snrNN ' path1 data1 '.slc.par ' data1 '_' data2 '.off ' data1 '_' data2 '.disp_map ' data1 '_' data2 '.disp_val 2 4. 1']);

%eval(['!multi_look ' data1 '.slc ' data1 '.slc.par master_' data1 '_' data2 '.mli master_' data1 '_' data2 '.mli.par 12 48']);
eval(['!multi_look ' path1 data1 '.slc ' path1 data1 '.slc.par master_' data1 '_' data2 '.mli master_' data1 '_' data2 '.mli.par 12 48']);

y1=['grep range_samples: master_' data1 '_' data2 '.mli.par | cut -c34-36']
[s,width]=system(y1);
width=num2str(width(1,1:3));

% y2=['grep width: ' data1 '.dem.par | cut -c23-26']
% [s2,widthDEM]=system(y2);
% widthDEM=num2str(widthDEM(1,1:4));
% 
% y3=['grep lines: ' data1 '.dem.par | cut -c23-26']
% [s3,linesDEM]=system(y3);
% linesDEM=num2str(linesDEM(1,1:4));


eval(['!cpx_to_real ' data1 '_' data2 '.disp_map ' data1 '_' data2 '_ground_range ' width ' 0']);
eval(['!cpx_to_real ' data1 '_' data2 '.disp_map ' data1 '_' data2 '_azimuth ' width ' 1']);
eval(['!cpx_to_real ' data1 '_' data2 '.disp_map ' data1 '_' data2 '_velocity ' width ' 3']);
eval(['!cpx_to_real ' data1 '_' data2 '.disp_map ' data1 '_' data2 '_angle ' width ' 4']);


eval(['!rasdt_pwr24 ' data1 '_' data2 '_ground_range master_' data1 '_' data2 '.mli ' width ' 1 1 0 1 1 55. 1. .35 1 ' data1 '_' data2 '_ground_range.bmp']);
eval(['!rasdt_pwr24 ' data1 '_' data2 '_azimuth master_' data1 '_' data2 '.mli ' width ' 1 1 0 1 1 55. 1. .35 1 ' data1 '_' data2 '_azimuth.bmp']);
eval(['!rasdt_pwr24 ' data1 '_' data2 '_velocity master_' data1 '_' data2 '.mli ' width ' 1 1 0 1 1 55. 1. .35 1 ' data1 '_' data2 '_velocity.bmp']);
eval(['!rasdt_pwr24 ' data1 '_' data2 '_angle master_' data1 '_' data2 '.mli ' width ' 1 1 0 1 1 55. 1. .35 1 ' data1 '_' data2 '_angle.bmp']);

% eval(['!geocode_back ' data1 '_' data2 '_azimuth 468 ' data1 '.lt ' data1 '_' data2 '_azimuthGeo 1686 - 2 0']);
% eval(['!geocode_back ' data1 '_' data2 '_ground_range 468 ' data1 '.lt ' data1 '_' data2 '_ground_rangeGeo 1686 - 2 0']);

ground_cor= [data1 '_' data2 '_ground_range']; 
azimuth_cor= [data1 '_' data2 '_azimuth']; 

eval(['!float_math ' ground_cor ' ' ground_cor ' Multi_gro ' width ' 2']);
eval(['!float_math ' azimuth_cor ' ' azimuth_cor ' Multi_az ' width ' 2']);
eval(['!float_math Multi_gro Multi_az Sum ' width ' 0']);
eval(['!float_math Sum - squRo ' width ' 6']);
eval(['!float_math squRo - VELOCITY ' width ' 3 - - - - 51'])
eval(['!float_math VELOCITY - VEL_km_y_' data1 '_' data2 ' ' width ' 2 - - - - 0.365']);


eval(['!geocode_back master_' data1 '_' data2 '.mli ' width ' ' path1 data1 '.lt master_geoc_' data1 '_' data2 '.mli ' widthDEM ' ' linesDEM ' 2 0'])
% eval(['!geocode_back VEL_km_y_' data1 '_' data2 ' ' width ' ' path1 data1 '.lt vel_geoc_' data1 '_' data2 ' ' widthDEM ' ' linesDEM ' 1 0'])
% eval(['!data2geotiff ' path1 data1 '.dem.par vel_geoc_' data1 '_' data2 ' 2 VEL_km_y_' data1 '_' data2 '.tif']);


eval(['!gc_map master_' data1 '_' data2 '.mli.par - /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem.par /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem ' data1 '.demMaster.par ' data1 '.demMaster ' data1 '.ltMaster 1 1 ' data1 '.sim_sarMaster uMaster_' data1 ' vMaster_' data1 ' incMaster_' data1 ' psiMaster_' data1 ' pixMaster_' data1 ' lsMaster_map_' data1 ' 8 1']);

y2=['grep width: ' data1 '.demMaster.par | cut -c23-26']
[s2,width_lk]=system(y2);
width_lk=num2str(width_lk(1,1:4));


eval(['!geocode_back VEL_km_y_' data1 '_' data2 ' ' width ' ' data1 '.ltMaster vel_geoc_' data1 '_' data2 ' ' width_lk ' - 2 0'])
eval(['!data2geotiff ' data1 '.demMaster.par vel_geoc_' data1 '_' data2 ' 2 VEL_km_y_' data1 '_' data2 '.tif']);


%eval(['!data2tiff VEL_km_y_' data1 '_' data2 ' 468 2 VEL_km_y_' data1 '_' data2 '.tif']);

y=['VEL_km_y_' data1 '_' data2 '.tif'];
eval(['[im92,R92]=geotiffread(''' y ''');']);

imagesc(im);
caxis([0 2]);
colormap jet;
colorbar
