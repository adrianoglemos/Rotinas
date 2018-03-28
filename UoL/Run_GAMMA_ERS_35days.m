% ISP same track to ERS

data1=num2str(19950509);
data2=num2str(19950613);

[s,widthSLC]=system(['grep range_samples: ' data1 '.slc.par | cut -c32-36']);
widthSLC=widthSLC(1:5);

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
eval(['!rasSLC ' data1 'M.slc ' widthSLC ' - - - - - - - - - ' data1 'M.slc.ras']);

% Data 2

[s,widthSLC]=system(['grep range_samples: ' data2 '.slc.par | cut -c32-36']);
widthSLC=widthSLC(1:5);

eval(['!rasSLC ' data2 '.slc ' widthSLC ' - - - - - - - - - ' data2 '.slc.ras']);

%%% Masking the main flow:

im=imread([data2 '.slc.ras']);
figure
imagesc(im);
colormap(gray);
poly1 = imfreehand();

mask1 = poly1.createMask();
ras1 = im;
ras1(mask1==1) = 0;
mask1=uint8(mask1);
imwrite(mask1,['Mask_' data2 '.ras'],'ras');

close all
clear im poly1 mask1 ras1

eval(['!mask_class Mask_' data2 '.ras ' data2 '.slc ' data2 'M.slc 1 1 -1 1 0']);
eval(['!rasSLC ' data2 'M.slc ' widthSLC ' - - - - - - - - - ' data2 'M.slc.ras']);


% eval(['!mask_class Mask_' data1 '.ras ' data1 '.slc ' data1 'M.slc 1 1 -1 1 0']);
% eval(['!mask_class Mask_' data2 '.ras ' data2 '.slc ' data2 'M.slc 1 1 -1 1 0']);
% 
% eval(['!rasSLC ' data1 'M.slc 5616 - - - - - - - - - ' data1 'M.slc.ras']);
% eval(['!rasSLC ' data2 'M.slc 5616 - - - - - - - - - ' data2 'M.slc.ras']);


% Testing the masked data

% im1=imread([data1 'M.slc.ras']);
% imagesc(im1);
% im2=imread([data2 'M.slc.ras']);
% imagesc(im2);

% 

eval(['!mkdir /nfs/a59/eeagdl/Data/Tests/NTrack/Processing/Repeat_Track/' data1 '_' data2]);
cd(['/nfs/a59/eeagdl/Data/Tests/NTrack/Processing/Repeat_Track/' data1 '_' data2]);
path1=['/nfs/a59/eeagdl/Data/Tests/NTrack/Images/427/ERS1_427_19954_1938_950509_171134/'];
path2=['/nfs/a59/eeagdl/Data/Tests/NTrack/Images/427/ERS1_427_20455_1938_950613_171140/'];


eval(['!create_offset ' path1 data1 '.slc.par ' path2 data2 '.slc.par ' data1 '_' data2 '.off 1 - - 0']);

eval(['!init_offset_orbit ' path1 data1 '.slc.par ' path2 data2 '.slc.par ' data1 '_' data2 '.off - - 0']);

eval(['!init_offset ' path1 data1 '.slc ' path2 data2 '.slc ' path1 data1 '.slc.par ' path2 data2 '.slc.par ' data1 '_' data2 '.off 2 10 - - - - 4.0 128 128']);

eval(['!offset_pwr ' path1 data1 'M.slc ' path2 data2 'M.slc ' path1 data1 '.slc.par ' path2 data2 '.slc.par ' data1 '_' data2 '.off ' data1 '_' data2 '_offsM ' data1 '_' data2 '_snrM 128 128 ' data1 '_' data2 '_offsetsM 2 128 128 5']);

eval(['!offset_fit ' data1 '_' data2 '_offsM ' data1 '_' data2 '_snrM ' data1 '_' data2 '.off ' data1 '_' data2 '_coffsM ' data1 '_' data2 '_coffsetsM 5 1']);

eval(['!offset_pwr ' path1 data1 'M.slc ' path2 data2 'M.slc ' path1 data1 '.slc.par ' path2 data2 '.slc.par ' data1 '_' data2 '.off ' data1 '_' data2 '_offsM ' data1 '_' data2 '_snrM 128 128 ' data1 '_' data2 '_offsetsM 2 128 128 5']);

eval(['!offset_fit ' data1 '_' data2 '_offsM ' data1 '_' data2 '_snrM ' data1 '_' data2 '.off ' data1 '_' data2 '_coffsM ' data1 '_' data2 '_coffsetsM 5 1']);

%SLC_interp 19950624.slc 19950613.slc.par 19950624.slc.par 19950613_19950624.off 19950624.rslc 19950624.rslc.par
% multi_look 19950624.rslc 19950624.rslc.par 19950624.rmli 19950624.rmli.par 1 5
% dis2pwr 19950613.mli 19950624.rmli 5616 5616



eval(['!offset_pwr_tracking ' path1 data1 '.slc ' path2 data2 '.slc ' path1 data1 '.slc.par ' path2 data2 '.slc.par ' data1 '_' data2 '.off ' data1 '_' data2 '_offsNN ' data1 '_' data2 '_snrNN 256 256 ' data1 '_' data2 '_offsetsNN 2 4.0 6 24']);

eval(['!offset_tracking ' data1 '_' data2 '_offsNN ' data1 '_' data2 '_snrNN ' path1 data1 '.slc.par ' data1 '_' data2 '.off ' data1 '_' data2 '.disp_map ' data1 '_' data2 '.disp_val 2 4. 1']);

eval(['!multi_look ' path1 data1 '.slc ' path1 data1 '.slc.par master_' data1 '_' data2 '.mli master_' data1 '_' data2 '.mli.par 6 24']);

y1=['grep range_samples: master_' data1 '_' data2 '.mli.par | cut -c34-36']
[s,width]=system(y1);
width=num2str(width(1,1:3));



eval(['!cpx_to_real ' data1 '_' data2 '.disp_map ' data1 '_' data2 '_ground_range ' width ' 0']);
eval(['!cpx_to_real ' data1 '_' data2 '.disp_map ' data1 '_' data2 '_azimuth ' width ' 1']);
eval(['!cpx_to_real ' data1 '_' data2 '.disp_map ' data1 '_' data2 '_velocity ' width ' 3']);
eval(['!cpx_to_real ' data1 '_' data2 '.disp_map ' data1 '_' data2 '_angle ' width ' 4']);


eval(['!rasdt_pwr24 ' data1 '_' data2 '_ground_range master_' data1 '_' data2 '.mli ' width ' 1 1 0 1 1 55. 1. .35 1 ' data1 '_' data2 '_ground_range.bmp']);
eval(['!rasdt_pwr24 ' data1 '_' data2 '_azimuth master_' data1 '_' data2 '.mli ' width ' 1 1 0 1 1 55. 1. .35 1 ' data1 '_' data2 '_azimuth.bmp']);
eval(['!rasdt_pwr24 ' data1 '_' data2 '_velocity master_' data1 '_' data2 '.mli ' width ' 1 1 0 1 1 55. 1. .35 1 ' data1 '_' data2 '_velocity.bmp']);
eval(['!rasdt_pwr24 ' data1 '_' data2 '_angle master_' data1 '_' data2 '.mli ' width ' 1 1 0 1 1 55. 1. .35 1 ' data1 '_' data2 '_angle.bmp']);


ground_cor= [data1 '_' data2 '_ground_range']; 
azimuth_cor= [data1 '_' data2 '_azimuth']; 

eval(['!float_math ' ground_cor ' ' ground_cor ' Multi_gro 936 2']);
eval(['!float_math ' azimuth_cor ' ' azimuth_cor ' Multi_az 936 2']);
eval(['!float_math Multi_gro Multi_az Sum 936 0']);
eval(['!float_math Sum - squRo 936 6']);
eval(['!float_math squRo - VELOCITY 936 3 - - - - 35'])
eval(['!float_math VELOCITY - VEL_km_y_' data1 '_' data2 ' 936 2 - - - - 0.365']);

%eval(['!data2tiff VEL_km_y_' data1 '_' data2 ' 936 2 VEL_km_y_' data1 '_' data2 '.tif']);

%% Geocoding the result
%%%Geocoding the image Petermann_gcorrNew.dem  Petermann_gcorrNew.dem_par
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

eval(['!gc_map ' path1 data1 '.mli.par - /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem.par /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem ' data1 '.dem.par ' data1 '.dem ' data1 '.lt 1 1 ' data1 '.sim_par ' data1 '_u ' data1 '_v ' data1 '_inc ' data1 '_psi ' data1 '_pix ' data1 '_ls_map 8 2']);

%%%Refinement of geocoding lookup table
eval(['!pixel_area ' path1 data1 '.mli.par ' data1 '.dem.par ' data1 '.dem ' data1 '.lt ' data1 '_ls_map ' data1 '_inc ' data1 '_pix_sigma0 ' data1 '_pix_gamma0']);

%%%Correction to the lookup table is determined and applied
eval(['!create_diff_par ' path1 data1 '.mli.par - ' data1 '.diff_par 1 0']);
eval(['!offset_pwrm ' data1 '_pix_sigma0 ' path1 data1 '.mli ' data1 '.diff_par ' data1 '.offs ' data1 '.snr 256 256 ' data1 '_offsets 2 64 64 4.0']);
eval(['!offset_fitm ' data1 '.offs ' data1 '.snr ' data1 '.diff_par ' data1 '_coffs ' data1 '_coffsets 4.0 1']);

y1=['grep range_samples: ' path1 data1 '.mli.par | cut -c33-36']
[s,widthGeo]=system(y1);
widthGeo=num2str(widthGeo(1,1:4));

y2=['grep width: ' data1 '.dem.par | cut -c23-26']
[s2,widthDEM]=system(y2);
widthDEM=num2str(widthDEM(1,1:4));

y3=['grep lines: ' data1 '.dem.par | cut -c23-26']
[s3,linesDEM]=system(y3);
linesDEM=num2str(linesDEM(1,1:4));

eval(['!gc_map_fine ' data1 '.lt ' widthDEM ' ' data1 '.diff_par ' data1 '.lt_fine 1']);

eval(['!geocode_back ' path1 data1 '.mli ' widthGeo ' ' data1 '.lt_fine ' data1 '_geoc.slc.mli ' widthDEM ' ' linesDEM ' 2 0']);
%!raspwr 20150125_geoc.slc.mli 3048

eval(['!geocode_back VEL_km_y_' data1 '_' data2 ' ' width ' ' data1 '.lt_fine vel_geoc_' data1 '_' data2 ' ' widthDEM ' ' linesDEM ' 2 0'])
%eval(['!geocode_back ' data1 '_' data2 '.deramp.snr ' widthGeo ' ' data1 '.lt_fine SNR_' data1 '_' data2 ' ' widthDEM ' ' linesDEM ' 2 0'])



eval(['!geocode ' data1 '.lt_fine VEL_km_y_' data1 '_' data2 ' ' width ' vel_teste ' widthDEM ' ' linesDEM ' 1 0']);
eval(['!data2geotiff ' data1 '.dem.par vel_geoc_' data1 '_' data2 ' 2 VEL_km_y_' data1 '_' data2 '.tif']);
%eval(['!data2geotiff ' data1 '.dem.par SNR_' data1 '_' data2 ' 2 SNR_' data1 '_' data2 '.tif']);

