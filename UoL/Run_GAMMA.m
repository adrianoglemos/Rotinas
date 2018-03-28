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

eval(['!mkdir /nfs/a59/eeagdl/Data/Tests/NTrack/Processing/' data1 '_' data2]);
cd(['/nfs/a59/eeagdl/Data/Tests/NTrack/Processing/' data1 '_' data2]);
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



eval(['!offset_pwr_tracking ' path1 data1 '.slc ' path2 data2 '.slc ' path1 data1 '.slc.par ' path2 data2 '.slc.par ' data1 '_' data2 '.off ' data1 '_' data2 '_offsNN ' data1 '_' data2 '_snrNN 64 256 ' data1 '_' data2 '_offsetsNN 2 4.0 12 48']);

eval(['!offset_tracking ' data1 '_' data2 '_offsNN ' data1 '_' data2 '_snrNN ' path1 data1 '.slc.par ' data1 '_' data2 '.off ' data1 '_' data2 '.disp_map ' data1 '_' data2 '.disp_val 2 4. 1']);

eval(['!multi_look ' path1 data1 '.slc ' path1 data1 '.slc.par master_' data1 '_' data2 '.mli master_' data1 '_' data2 '.mli.par 12 48']);

eval(['!cpx_to_real ' data1 '_' data2 '.disp_map ' data1 '_' data2 '_ground_range 468 0']);
eval(['!cpx_to_real ' data1 '_' data2 '.disp_map ' data1 '_' data2 '_azimuth 468 1']);
eval(['!cpx_to_real ' data1 '_' data2 '.disp_map ' data1 '_' data2 '_velocity 468 3']);
eval(['!cpx_to_real ' data1 '_' data2 '.disp_map ' data1 '_' data2 '_angle 468 4']);


eval(['!rasdt_pwr24 ' data1 '_' data2 '_ground_range master_' data1 '_' data2 '.mli 468 1 1 0 1 1 55. 1. .35 1 ' data1 '_' data2 '_ground_range.bmp']);
eval(['!rasdt_pwr24 ' data1 '_' data2 '_azimuth master_' data1 '_' data2 '.mli 468 1 1 0 1 1 55. 1. .35 1 ' data1 '_' data2 '_azimuth.bmp']);
eval(['!rasdt_pwr24 ' data1 '_' data2 '_velocity master_' data1 '_' data2 '.mli 468 1 1 0 1 1 55. 1. .35 1 ' data1 '_' data2 '_velocity.bmp']);
eval(['!rasdt_pwr24 ' data1 '_' data2 '_angle master_' data1 '_' data2 '.mli 468 1 1 0 1 1 55. 1. .35 1 ' data1 '_' data2 '_angle.bmp']);


ground_cor= [data1 '_' data2 '_ground_range']; 
azimuth_cor= [data1 '_' data2 '_azimuth']; 

eval(['!float_math ' ground_cor ' ' ground_cor ' Multi_gro 468 2']);
eval(['!float_math ' azimuth_cor ' ' azimuth_cor ' Multi_az 468 2']);
eval(['!float_math Multi_gro Multi_az Sum 468 0']);
eval(['!float_math Sum - squRo 468 6']);
eval(['!float_math squRo - VELOCITY 468 3 - - - - 35'])
eval(['!float_math VELOCITY - VEL_km_y_' data1 '_' data2 ' 468 2 - - - - 0.365']);

eval(['!data2tiff VEL_km_y_' data1 '_' data2 ' 468 2 VEL_km_y_' data1 '_' data2 '.tif']);

