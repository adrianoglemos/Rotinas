data1= num2str(20150127); 

cd /nfs/a59/eeagdl/Data/Available_Images/S1/Images/A4/162/la_68/n/S1A_IW_SLC__1SSH_20150127T204700_20150127T204729_004362_005525_7ECC.SAFE

%%% Creating a SLC image and .par file

% par_S1_SLC measurement/s1a-iw1-slc-hh-20150208t204955-20150208t205021-004537-005928-001.tiff annotation/s1a-iw1-slc-hh-20150208t204955-20150208t205021-004537-005928-001.xml annotation/calibration/calibration-s1a-iw1-slc-hh-20150208t204955-20150208t205021-004537-005928-001.xml annotation/calibration/noise-s1a-iw1-slc-hh-20150208t204955-20150208t205021-004537-005928-001.xml 20150208_iw1_hh.slc.par 20150208_iw1_hh.slc 20150208_iw1_hh.tops_par
% par_S1_SLC measurement/s1a-iw2-slc-hh-20150208t204956-20150208t205022-004537-005928-002.tiff annotation/s1a-iw2-slc-hh-20150208t204956-20150208t205022-004537-005928-002.xml annotation/calibration/calibration-s1a-iw2-slc-hh-20150208t204956-20150208t205022-004537-005928-002.xml annotation/calibration/noise-s1a-iw2-slc-hh-20150208t204956-20150208t205022-004537-005928-002.xml 20150208_iw2_hh.slc.par 20150208_iw2_hh.slc 20150208_iw2_hh.tops_par
% par_S1_SLC measurement/s1a-iw3-slc-hh-20150208t204957-20150208t205023-004537-005928-003.tiff annotation/s1a-iw3-slc-hh-20150208t204957-20150208t205023-004537-005928-003.xml annotation/calibration/calibration-s1a-iw3-slc-hh-20150208t204957-20150208t205023-004537-005928-003.xml annotation/calibration/noise-s1a-iw3-slc-hh-20150208t204957-20150208t205023-004537-005928-003.xml 20150208_iw3_hh.slc.par 20150208_iw3_hh.slc 20150208_iw3_hh.tops_par

eval(['!par_S1_SLC measurement/s1a-iw1* annotation/s1a-iw1* annotation/calibration/calibration-s1a-iw1* annotation/calibration/noise-s1a-iw1* ' data1 '_iw1_hh.slc.par ' data1 '_iw1_hh.slc ' data1 '_iw1_hh.tops_par']);
eval(['!par_S1_SLC measurement/s1a-iw2* annotation/s1a-iw2* annotation/calibration/calibration-s1a-iw2* annotation/calibration/noise-s1a-iw2* ' data1 '_iw2_hh.slc.par ' data1 '_iw2_hh.slc ' data1 '_iw2_hh.tops_par']);
eval(['!par_S1_SLC measurement/s1a-iw3* annotation/s1a-iw3* annotation/calibration/calibration-s1a-iw3* annotation/calibration/noise-s1a-iw3* ' data1 '_iw3_hh.slc.par ' data1 '_iw3_hh.slc ' data1 '_iw3_hh.tops_par']);


%%%Creating table:

eval(['!echo ' data1 '_iw1_hh.slc ' data1 '_iw1_hh.slc.par ' data1 '_iw1_hh.tops_par > tab1_S1_' data1 ]);
eval(['!echo ' data1 '_iw2_hh.slc ' data1 '_iw2_hh.slc.par ' data1 '_iw2_hh.tops_par >> tab1_S1_' data1 ]);
eval(['!echo ' data1 '_iw3_hh.slc ' data1 '_iw3_hh.slc.par ' data1 '_iw3_hh.tops_par >> tab1_S1_' data1 ]);

% echo 20150220_iw1_hh.slc 20150220_iw1_hh.slc.par 20150220_iw1_hh.tops_par > tab2_PG
% echo 20150220_iw2_hh.slc 20150220_iw2_hh.slc.par 20150220_iw2_hh.tops_par >> tab2_PG
% echo 20150220_iw3_hh.slc 20150220_iw3_hh.slc.par 20150220_iw3_hh.tops_par >> tab2_PG

%%%Mosaic the swaths:
eval(['!SLC_mosaic_S1_TOPS tab1_S1_' data1 ' ' data1 '.slc ' data1 '.slc.par 10 2'])
% SLC_mosaic_S1_TOPS tab2_PG 20150220.slc 20150220.slc.par 10 2

%%%Multi-look them:
eval(['!multi_look ' data1 '.slc ' data1 '.slc.par ' data1 '.slc.mli ' data1 '.slc.mli.par 10 2']);
% multi_look 20150220.slc 20150220.slc.par 20150220.slc.mli 20150220.slc.mli.par 10 2

[s,width]=system(['grep range_samples: ' data1 '.slc.mli.par | cut -c33-36']);
width=num2str(width(1,1:4));

eval(['!raspwr ' data1 '.slc.mli ' width]);

[s,widthSLC]=system(['grep range_samples: ' data1 '.slc.par | cut -c32-36']);
widthSLC=widthSLC(1:5);

eval(['!rasSLC ' data1 '.slc ' widthSLC ' - - - - - - - - - ' data1 '.slc.ras']);

%%% Masking the main flow:
% 
% im=imread([data1 '.slc.ras']);
% figure
% imagesc(im);
% colormap(gray);
% poly1 = imfreehand();
% 
% mask1 = poly1.createMask();
% ras1 = im;
% ras1(mask1==1) = 0;
% mask1=uint8(mask1);
% imwrite(mask1,['Mask_' data1 '.ras'],'ras');
% 
% close all
% clear im poly1 mask1 ras1
% 
% eval(['!mask_class Mask_' data1 '.ras ' data1 '.slc ' data1 'M.slc 1 1 -1 1 0']);
% eval(['!rasSLC ' data1 'M.slc ' widthSLC ' - - - - - - - - - ' data1 'M.slc.ras']);

%t=imread([data1 'M.slc.ras']);imagesc(t);
%close all; clear t;
clear all
data1= num2str(20150208);

cd /nfs/a59/eeagdl/Data/Available_Images/S1/Images/A4/162/la_68/n/S1A_IW_SLC__1SSH_20150208T204700_20150208T204728_004537_005928_DCC6.SAFE

%%% Creating a SLC image and .par file

% par_S1_SLC measurement/s1a-iw1-slc-hh-20150208t204955-20150208t205021-004537-005928-001.tiff annotation/s1a-iw1-slc-hh-20150208t204955-20150208t205021-004537-005928-001.xml annotation/calibration/calibration-s1a-iw1-slc-hh-20150208t204955-20150208t205021-004537-005928-001.xml annotation/calibration/noise-s1a-iw1-slc-hh-20150208t204955-20150208t205021-004537-005928-001.xml 20150208_iw1_hh.slc.par 20150208_iw1_hh.slc 20150208_iw1_hh.tops_par
% par_S1_SLC measurement/s1a-iw2-slc-hh-20150208t204956-20150208t205022-004537-005928-002.tiff annotation/s1a-iw2-slc-hh-20150208t204956-20150208t205022-004537-005928-002.xml annotation/calibration/calibration-s1a-iw2-slc-hh-20150208t204956-20150208t205022-004537-005928-002.xml annotation/calibration/noise-s1a-iw2-slc-hh-20150208t204956-20150208t205022-004537-005928-002.xml 20150208_iw2_hh.slc.par 20150208_iw2_hh.slc 20150208_iw2_hh.tops_par
% par_S1_SLC measurement/s1a-iw3-slc-hh-20150208t204957-20150208t205023-004537-005928-003.tiff annotation/s1a-iw3-slc-hh-20150208t204957-20150208t205023-004537-005928-003.xml annotation/calibration/calibration-s1a-iw3-slc-hh-20150208t204957-20150208t205023-004537-005928-003.xml annotation/calibration/noise-s1a-iw3-slc-hh-20150208t204957-20150208t205023-004537-005928-003.xml 20150208_iw3_hh.slc.par 20150208_iw3_hh.slc 20150208_iw3_hh.tops_par

eval(['!par_S1_SLC measurement/s1a-iw1* annotation/s1a-iw1* annotation/calibration/calibration-s1a-iw1* annotation/calibration/noise-s1a-iw1* ' data1 '_iw1_hh.slc.par ' data1 '_iw1_hh.slc ' data1 '_iw1_hh.tops_par']);
eval(['!par_S1_SLC measurement/s1a-iw2* annotation/s1a-iw2* annotation/calibration/calibration-s1a-iw2* annotation/calibration/noise-s1a-iw2* ' data1 '_iw2_hh.slc.par ' data1 '_iw2_hh.slc ' data1 '_iw2_hh.tops_par']);
eval(['!par_S1_SLC measurement/s1a-iw3* annotation/s1a-iw3* annotation/calibration/calibration-s1a-iw3* annotation/calibration/noise-s1a-iw3* ' data1 '_iw3_hh.slc.par ' data1 '_iw3_hh.slc ' data1 '_iw3_hh.tops_par']);


%%%Creating table:

eval(['!echo ' data1 '_iw1_hh.slc ' data1 '_iw1_hh.slc.par ' data1 '_iw1_hh.tops_par > tab1_S1_' data1 ]);
eval(['!echo ' data1 '_iw2_hh.slc ' data1 '_iw2_hh.slc.par ' data1 '_iw2_hh.tops_par >> tab1_S1_' data1 ]);
eval(['!echo ' data1 '_iw3_hh.slc ' data1 '_iw3_hh.slc.par ' data1 '_iw3_hh.tops_par >> tab1_S1_' data1 ]);

% echo 20150220_iw1_hh.slc 20150220_iw1_hh.slc.par 20150220_iw1_hh.tops_par > tab2_PG
% echo 20150220_iw2_hh.slc 20150220_iw2_hh.slc.par 20150220_iw2_hh.tops_par >> tab2_PG
% echo 20150220_iw3_hh.slc 20150220_iw3_hh.slc.par 20150220_iw3_hh.tops_par >> tab2_PG

%%%Mosaic the swaths:
eval(['!SLC_mosaic_S1_TOPS tab1_S1_' data1 ' ' data1 '.slc ' data1 '.slc.par 10 2'])
% SLC_mosaic_S1_TOPS tab2_PG 20150220.slc 20150220.slc.par 10 2

%%%Multi-look them:
eval(['!multi_look ' data1 '.slc ' data1 '.slc.par ' data1 '.slc.mli ' data1 '.slc.mli.par 10 2']);
% multi_look 20150220.slc 20150220.slc.par 20150220.slc.mli 20150220.slc.mli.par 10 2

[s,width]=system(['grep range_samples: ' data1 '.slc.mli.par | cut -c33-36']);
width=num2str(width(1,1:4));

eval(['!raspwr ' data1 '.slc.mli ' width]);

[s,widthSLC]=system(['grep range_samples: ' data1 '.slc.par | cut -c32-36']);
widthSLC=widthSLC(1:5);

eval(['!rasSLC ' data1 '.slc ' widthSLC ' - - - - - - - - - ' data1 '.slc.ras']);



%% Offset tracking:

%%% Co-registration

%create_offset 20150208.slc.par 20150220.slc.par 20150208_20150220.off 1 10 2 0
%offset_pwr 20150208.slc 20150220.slc 20150208.slc.par 20150220.slc.par 20150208_20150220.off 20150208_20150220.offs 20150208_20150220.snr 256 64 20150208_20150220.offsets 2 64 64 7.0 4 0 0
%offset_fit 20150208_20150220.offs 20150208_20150220.snr 20150208_20150220.off 20150208_20150220.coffs 20150208_20150220.coffsets 7.0 4 0
pause(2); clear all
data1= num2str(20150816); data2= num2str(20150921);

eval(['!mkdir /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Antarctic/GeorgeVI/066/' data1 '_' data2 '_la_73']);
cd(['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Antarctic/GeorgeVI/066/' data1 '_' data2 '_la_73']);
path1=['/nfs/a59/eeagdl/Data/Available_Images/S1/Antarctic/GeorgeVI/066/73S/S1A_IW_SLC__1SSH_20150825T073929_20150825T073956_007416_00A358_9888.SAFE/'];
path2=['/nfs/a59/eeagdl/Data/Available_Images/S1/Antarctic/GeorgeVI/066/73S/S1A_IW_SLC__1SSH_20150906T073929_20150906T073956_007591_00A825_D8A6.SAFE/'];

eval(['!create_offset ' path1 data1 '.slc.par ' path2 data2 '.slc.par ' data1 '_' data2 '.off 1 10 2 0'])

eval(['!offset_pwr ' path1 data1 '.slc ' path2 data2 '.slc ' path1 data1 '.slc.par ' path2 data2 '.slc.par ' data1 '_' data2 '.off ' data1 '_' data2 '.offs ' data1 '_' data2 '.snr 256 64 - 1 64 64 7.0 4 0 0']);

eval(['!offset_fit ' data1 '_' data2 '.offs ' data1 '_' data2 '.snr ' data1 '_' data2 '.off - - 10.0 3 0']);
%eval(['!offset_fit ' data1 '_' data2 '.offs ' data1 '_' data2 '.snr ' data1 '_' data2 '.off - - 4.0 1 0']);% Anna's script

      eval(['!echo ' data2 '_iw1_hh.rslc ' data2 '_iw1_hh.rslc.par ' data2 '_iw1_hh.rslc.tops_par > RSLC_tab']);
      eval(['!echo ' data2 '_iw2_hh.rslc ' data2 '_iw2_hh.rslc.par ' data2 '_iw2_hh.rslc.tops_par >> RSLC_tab']);
      eval(['!echo ' data2 '_iw3_hh.rslc ' data2 '_iw3_hh.rslc.par ' data2 '_iw3_hh.rslc.tops_par >> RSLC_tab']);

eval(['!cp ' path1 '*tops* ./']);
eval(['!cp ' path2 '*.tops* ./']);
eval(['!cp ' path1 '*.slc* ./']);
eval(['!cp ' path2 '*.slc* ./']);         
eval(['!SLC_interp_S1_TOPS ' path2 'tab1_S1_' data2 ' ' data2 '.slc.par ' path1 'tab1_S1_' data1 ' ' data1 '.slc.par ' data1 '_' data2 '.off RSLC_tab ' data2 '.rslc ' data2 '.rslc.par']);


eval(['!create_offset ' data1 '.slc.par ' data2 '.slc.par ' data1 '_' data2 '.off1 1 10 2 0']);
%create_offset 20150208.slc.par 20150220.slc.par 20150208_20150220M.off1 1 10 2 0

%Masking the derramped slave image
%eval(['!mask_class ' path1 'Mask_' data1 '.ras ' data2 '.rslc ' data2 '.rslc 1 1 -1 1 0']);

eval(['!offset_pwr ' data1 '.slc ' data2 '.rslc ' data1 '.slc.par ' data2 '.rslc.par ' data1 '_' data2 '.off1 ' data1 '_' data2 '.offs ' data1 '_' data2 '.snr 256 64 - 1 64 64 7.0 4 0 0']);
%offset_pwr 20150208M.slc 20150220M.rslc 20150208.slc.par 20150220.rslc.par 20150208_20150220M.off1 20150208_20150220M.offs 20150208_20150220M.snr 256 64 - 1 64 64 7.0 4 0 0

eval(['!offset_fit ' data1 '_' data2 '.offs ' data1 '_' data2 '.snr ' data1 '_' data2 '.off1 - - 10.0 3 0']);
%eval(['!offset_fit ' data1 '_' data2 '.offs ' data1 '_' data2 '.snr ' data1 '_' data2 '.off1 - - 4.0 1 0']);% Anna's script
%offset_fit 20150208_20150220M.offs 20150208_20150220M.snr 20150208_20150220M.off1 - - 10.0 1 0

eval(['!offset_add ' data1 '_' data2 '.off ' data1 '_' data2 '.off1 ' data1 '_' data2 '.off.total']);
%offset_add 20150208_20150220M.off 20150208_20150220M.off1 20150208_20150220M.off.total

eval(['!SLC_interp_S1_TOPS ' path2 'tab1_S1_' data2 ' ' data2 '.slc.par ' path1 'tab1_S1_' data1 ' ' data1 '.slc.par ' data1 '_' data2 '.off.total RSLC_tab ' data2 '.rslc ' data2 '.rslc.par']);
%SLC_interp_S1_TOPS tab2_PG 20150220.slc.par tab1_SLC1 20150208.slc.par 20150208_20150220M.off.total RSLC_tab 20150220.rslc 20150220.rslc.par      
      
	eval(['!multi_look ' data2 '.rslc ' data2 '.rslc.par ' data2 '.rslc.mli ' data2 '.rslc.mli.par 10 2']);
	%multi_look 20150220.rslc 20150220.rslc.par 20150220.rslc.mli 20150220.rslc.mli.par 10 2
	
[s,widthRmli2]=system(['grep range_samples: ' data2 '.rslc.mli.par | cut -c33-36']);
widthRmli2=num2str(widthRmli2(1,1:4));

	eval(['!raspwr ' data2 '.rslc.mli ' widthRmli2]);
	%dis2pwr 20150208.slc.mli 20150220.rslc.mli 6777 6777
      

%%%%%%%%% Basic offset tracking strategy %%%%%%%%%%%%%%%

%%% 1- Deramp the master:

!mkdir slc_TOPS_deramp													

eval(['!echo slc_TOPS_deramp/' data1 '_iw1_hh.slc slc_TOPS_deramp/' data1 '_iw1_hh.slc.par slc_TOPS_deramp/' data1 '_iw1_hh.tops_par > tab1_deramp']);
eval(['!echo slc_TOPS_deramp/' data1 '_iw2_hh.slc slc_TOPS_deramp/' data1 '_iw2_hh.slc.par slc_TOPS_deramp/' data1 '_iw2_hh.tops_par >> tab1_deramp']);
eval(['!echo slc_TOPS_deramp/' data1 '_iw3_hh.slc slc_TOPS_deramp/' data1 '_iw3_hh.slc.par slc_TOPS_deramp/' data1 '_iw3_hh.tops_par >> tab1_deramp']);
															
%echo slc_TOPS_deramp/20150208_iw1_hh.slc slc_TOPS_deramp/20150208_iw1_hh.slc.par slc_TOPS_deramp/20150208_iw1_hh.tops_par > tab1_deramp
%echo slc_TOPS_deramp/20150208_iw2_hh.slc slc_TOPS_deramp/20150208_iw2_hh.slc.par slc_TOPS_deramp/20150208_iw2_hh.tops_par >> tab1_deramp
%echo slc_TOPS_deramp/20150208_iw3_hh.slc slc_TOPS_deramp/20150208_iw3_hh.slc.par slc_TOPS_deramp/20150208_iw3_hh.tops_par >> tab1_deramp

eval(['!SLC_deramp_S1_TOPS ' path1 'tab1_S1_' data1 ' tab1_deramp 0 1']);
%SLC_deramp_S1_TOPS tab1_SLC1 tab1_deramp 0 1

%%% 2 - Apply the identical phase ramp (of the master) to the co-registered slave.

eval(['!create_diff_par ' data1 '_iw1_hh.slc.par - ' data1 '_iw1_hh.slc.diff_par 1 0']);
eval(['!create_diff_par ' data1 '_iw2_hh.slc.par - ' data1 '_iw2_hh.slc.diff_par 1 0']);
eval(['!create_diff_par ' data1 '_iw3_hh.slc.par - ' data1 '_iw3_hh.slc.diff_par 1 0']);

%create_diff_par 20150208_iw1_hh.slc.par - 20150208_iw1_hh.slc.diff_par 1 0
%create_diff_par 20150208_iw2_hh.slc.par - 20150208_iw2_hh.slc.diff_par 1 0
%create_diff_par 20150208_iw3_hh.slc.par - 20150208_iw3_hh.slc.diff_par 1 0


eval(['!sub_phase ' data2 '_iw1_hh.rslc ./slc_TOPS_deramp/' data1 '_iw1_hh.slc.dph ' data1 '_iw1_hh.slc.diff_par ' data2 '_iw1_hh.rslc.deramp 1 0']);
eval(['!sub_phase ' data2 '_iw2_hh.rslc ./slc_TOPS_deramp/' data1 '_iw2_hh.slc.dph ' data1 '_iw2_hh.slc.diff_par ' data2 '_iw2_hh.rslc.deramp 1 0']);
eval(['!sub_phase ' data2 '_iw3_hh.rslc ./slc_TOPS_deramp/' data1 '_iw3_hh.slc.dph ' data1 '_iw3_hh.slc.diff_par ' data2 '_iw3_hh.rslc.deramp 1 0']);

%sub_phase 20150220_iw1_hh.rslc ./slc_TOPS_deramp/20150208_iw1_hh.slc.dph 20150208_iw1_hh.slc.diff_par 20150220_iw1_hh.rslc.deramp 1 0
%sub_phase 20150220_iw2_hh.rslc ./slc_TOPS_deramp/20150208_iw2_hh.slc.dph 20150208_iw2_hh.slc.diff_par 20150220_iw2_hh.rslc.deramp 1 0
%sub_phase 20150220_iw3_hh.rslc ./slc_TOPS_deramp/20150208_iw3_hh.slc.dph 20150208_iw3_hh.slc.diff_par 20150220_iw3_hh.rslc.deramp 1 0

%%% 3 - Mosaic the deramped images

eval(['!echo ' data2 '_iw1_hh.rslc.deramp slc_TOPS_deramp/' data1 '_iw1_hh.slc.par slc_TOPS_deramp/' data1 '_iw1_hh.tops_par > tab2_deramp']);
eval(['!echo ' data2 '_iw2_hh.rslc.deramp slc_TOPS_deramp/' data1 '_iw2_hh.slc.par slc_TOPS_deramp/' data1 '_iw2_hh.tops_par >> tab2_deramp']);
eval(['!echo ' data2 '_iw3_hh.rslc.deramp slc_TOPS_deramp/' data1 '_iw3_hh.slc.par slc_TOPS_deramp/' data1 '_iw3_hh.tops_par >> tab2_deramp']);

%echo 20150220_iw1_hh.rslc.deramp slc_TOPS_deramp/20150208_iw1_hh.slc.par slc_TOPS_deramp/20150208_iw1_hh.tops_par > tab2_deramp
%echo 20150220_iw2_hh.rslc.deramp slc_TOPS_deramp/20150208_iw2_hh.slc.par slc_TOPS_deramp/20150208_iw2_hh.tops_par >> tab2_deramp
%echo 20150220_iw3_hh.rslc.deramp slc_TOPS_deramp/20150208_iw3_hh.slc.par slc_TOPS_deramp/20150208_iw3_hh.tops_par >> tab2_deramp

eval(['!SLC_mosaic_S1_TOPS tab1_deramp ' data1 '.slc.deramp ' data1 '.slc.deramp.par 10 2']);
eval(['!SLC_mosaic_S1_TOPS tab2_deramp ' data2 '.slc.deramp ' data2 '.slc.deramp.par 10 2']);


eval(['!create_offset ' data1 '.slc.deramp.par ' data2 '.slc.deramp.par ' data1 '_' data2 '.deramp.off 1 10 2 0']);

%eval(['!offset_pwr_tracking ' data1 '.slc.deramp ' data2 '.slc.deramp ' data1 '.slc.deramp.par ' data2 '.slc.deramp.par ' data1 '_' data2 '.deramp.off ' data1 '_' data2 '.deramp.offs ' data1 '_' data2 '.deramp.snr 600 80 ' data1 '_' data2 '.deramp.offsets 2 5.0 50 10 - - - - 4 0'])
%eval(['!offset_pwr_tracking ' data1 '.slc.deramp ' data2 '.slc.deramp ' data1 '.slc.deramp.par ' data2 '.slc.deramp.par ' data1 '_' data2 '.deramp.off ' data1 '_' data2 '.deramp.offs ' data1 '_' data2 '.deramp.snr 600 80 ' data1 '_' data2 '.deramp.offsets 1 3.0 50 10 - - - - 4 0']) % Window size and steps jakobshavn
eval(['!offset_pwr_tracking ' data1 '.slc.deramp ' data2 '.slc.deramp ' data1 '.slc.deramp.par ' data2 '.slc.deramp.par ' data1 '_' data2 '.deramp.off ' data1 '_' data2 '.deramp.offs ' data1 '_' data2 '.deramp.snr 350 75 ' data1 '_' data2 '.deramp.offsets 1 3.0 20 4 - - - - 4 0']) % Window size and steps GVI
%eval(['!offset_pwr_tracking ' data1 '.slc.deramp ' data2 '.slc.deramp ' data1 '.slc.deramp.par ' data2 '.slc.deramp.par ' data1 '_' data2 '.deramp.off ' data1 '_' data2 '.deramp.offs ' data1 '_' data2 '.deramp.snr 400 80 ' data1 '_' data2 '.deramp.offsets 2 5.0 50 10 - - - - 4 0'])
%eval(['!offset_pwr_tracking ' data1 '.slc.deramp ' data2 '.slc.deramp ' data1 '.slc.deramp.par ' data2 '.slc.deramp.par ' data1 '_' data2 '.deramp.off ' data1 '_' data2 '.deramp.offs ' data1 '_' data2 '.deramp.snr 144 48 ' data1 '_' data2 '.deramp.offsets 2 5.0 40 20 - - - - 4 0'])

%eval(['!offset_tracking ' data1 '_' data2 '.deramp.offs ' data1 '_' data2 '.deramp.snr ' data1 '.slc.deramp.par ' data1 '_' data2 '.deramp.off ' data1 '_' data2 '.deramp.dis_map ' data1 '_' data2 '.deramp.dis_val 2 5.0 1']);
eval(['!offset_tracking ' data1 '_' data2 '.deramp.offs ' data1 '_' data2 '.deramp.snr ' data1 '.slc.deramp.par ' data1 '_' data2 '.deramp.off ' data1 '_' data2 '.deramp.dis_map ' data1 '_' data2 '.deramp.dis_val 2 4.0 1']);

eval(['!multi_look ' data1 '.slc.deramp ' data1 '.slc.deramp.par master_deramp.mli master_deramp.mli.par 20 4']);
%eval(['!multi_look ' data1 '.slc.deramp ' data1 '.slc.deramp.par master_deramp.mli master_deramp.mli.par 40 20']);

[s,widthMaster]=system(['grep range_samples: master_deramp.mli.par | cut -c33-36']);
widthMaster=num2str(widthMaster(1,1:4));

eval(['!cpx_to_real ' data1 '_' data2 '.deramp.dis_map ground_' data1 '_' data2 ' ' widthMaster ' 0']);
eval(['!cpx_to_real ' data1 '_' data2 '.deramp.dis_map azimuth_' data1 '_' data2 ' ' widthMaster ' 1']);         
eval(['!cpx_to_real ' data1 '_' data2 '.deramp.dis_map velocity_' data1 '_' data2 ' ' widthMaster ' 3']);
eval(['!cpx_to_real ' data1 '_' data2 '.deramp.dis_map angle_' data1 '_' data2 ' ' widthMaster ' 4']); 

%$col_ramp==10.0 instead of 30.0 (cycle) and also uses 100.0(col_ramp2)
eval(['!rasdt_pwr24 ground_' data1 '_' data2 ' master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 ground_' data1 '_' data2 '.bmp']);
eval(['!rasdt_pwr24 azimuth_' data1 '_' data2 ' master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 azimuth_' data1 '_' data2 '.bmp']);
eval(['!rasdt_pwr24 velocity_' data1 '_' data2 ' master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 velocity_' data1 '_' data2 '.bmp']);
eval(['!rasdt_pwr24 angle_' data1 '_' data2 ' master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 angle_' data1 '_' data2 '.bmp']);



%%

ground_cor= ['ground_' data1 '_' data2]; 
azimuth_cor= ['azimuth_' data1 '_' data2]; 

eval(['!float_math ' ground_cor ' ' ground_cor ' Multi_gro ' widthMaster ' 2']);
eval(['!float_math ' azimuth_cor ' ' azimuth_cor ' Multi_az ' widthMaster ' 2']);
eval(['!float_math Multi_gro Multi_az Sum ' widthMaster ' 0']);
eval(['!float_math Sum - squRo ' widthMaster ' 6']);
%eval(['!float_math squRo - VELOCITY ' widthMaster ' 3 - - - - 36'])% 36 days
eval(['!float_math squRo - VELOCITY ' widthMaster ' 3 - - - - 12'])%12days
eval(['!float_math VELOCITY - VEL_km_y_' data1 '_' data2 ' ' widthMaster ' 2 - - - - 365']);

%eval(['!data2geotiff 20150909.dem.par VEL_km_y_' data1 '_' data2 ' 2 VEL_km_y_' data1 '_' data2 '.tif']);
% eval(['!data2tiff VEL_km_y_' data1 '_' data2 ' ' widthMaster ' 2 VEL_km_y_' data1 '_' data2 '.tif']);
% 
% im=imread('VEL_km_y_20150918_20150930.tif');
% 
% im(im==0)=nan;
% h3=imagesc(im); t3=double(~isnan(im));
% caxis([0 1.5]);
% set(h3,'AlphaData', t3);
% axis off

%% Geocoding the data

%%%Geocoding the image Petermann_gcorrNew.dem  Petermann_gcorrNew.dem_par
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eval(['!multi_look ' data1 '.slc.deramp ' data1 '.slc.deramp.par ' data1 '.slc.deramp.mli ' data1 '.slc.deramp.mli.par 20 4']);
%eval(['!multi_look ' data1 '.slc.deramp ' data1 '.slc.deramp.par ' data1 '.slc.deramp.mli ' data1 '.slc.deramp.mli.par 50 10']);

%eval(['!gc_map ' data1 '.slc.deramp.mli.par - /nfs/a59/eeagdl/Data/Available_Images/S1/Antarctic/DEM/Bamber_1km/nsidc0422_antarctic_1km_dem/krigged_dem_nsidc.bin.par /nfs/a59/eeagdl/Data/Available_Images/S1/Antarctic/DEM/Bamber_1km/nsidc0422_antarctic_1km_dem/krigged_dem_nsidc.bin.swap ' data1 '.dem.par ' data1 '.dem ' data1 '.lt 10 10 ' data1 '.sim_par ' data1 '_u ' data1 '_v ' data1 '_inc ' data1 '_psi ' data1 '_pix ' data1 '_ls_map 8 2']);
eval(['!gc_map ' data1 '.slc.deramp.mli.par - /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem.par /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem ' data1 '.dem.par ' data1 '.dem ' data1 '.lt 10 10 ' data1 '.sim_par ' data1 '_u ' data1 '_v ' data1 '_inc ' data1 '_psi ' data1 '_pix ' data1 '_ls_map 8 2']);
%%%Refinement of geocoding lookup table
eval(['!pixel_area ' data1 '.slc.deramp.mli.par ' data1 '.dem.par ' data1 '.dem ' data1 '.lt ' data1 '_ls_map ' data1 '_inc ' data1 '_pix_sigma0 ' data1 '_pix_gamma0']);

%%%Correction to the lookup table is determined and applied
eval(['!create_diff_par ' data1 '.slc.deramp.mli.par - ' data1 '.diff_par 1 0']);
eval(['!offset_pwrm ' data1 '_pix_sigma0 ' data1 '.slc.deramp.mli ' data1 '.diff_par ' data1 '.offs ' data1 '.snr 256 256 ' data1 '_offsets 2 64 64 4.0']);
eval(['!offset_fitm ' data1 '.offs ' data1 '.snr ' data1 '.diff_par ' data1 '_coffs ' data1 '_coffsets 4.0 1']);

y1=['grep range_samples: ' data1 '.slc.deramp.mli.par | cut -c33-36']
[s,widthGeo]=system(y1);
widthGeo=num2str(widthGeo(1,1:4));

y2=['grep width: ' data1 '.dem.par | cut -c22-26']
[s2,widthDEM]=system(y2);
widthDEM=num2str(widthDEM(1,1:5));

y3=['grep lines: ' data1 '.dem.par | cut -c22-26']
[s3,linesDEM]=system(y3);
linesDEM=num2str(linesDEM(1,1:5));

eval(['!gc_map_fine ' data1 '.lt ' widthDEM ' ' data1 '.diff_par ' data1 '.lt_fine 1']);

eval(['!geocode_back ' data1 '.slc.deramp.mli ' widthGeo ' ' data1 '.lt_fine ' data1 '_geoc.slc.mli ' widthDEM ' ' linesDEM ' 2 0']);
%!raspwr 20150125_geoc.slc.mli 3048

eval(['!geocode_back VEL_km_y_' data1 '_' data2 ' ' widthGeo ' ' data1 '.lt_fine vel_geoc_' data1 '_' data2 ' ' widthDEM ' ' linesDEM ' 2 0'])
eval(['!geocode_back ' data1 '_' data2 '.deramp.snr ' widthGeo ' ' data1 '.lt_fine SNR_' data1 '_' data2 ' ' widthDEM ' ' linesDEM ' 2 0'])

eval(['!data2geotiff ' data1 '.dem.par vel_geoc_' data1 '_' data2 ' 2 VEL_km_y_' data1 '_' data2 '.tif']);
eval(['!data2geotiff ' data1 '.dem.par SNR_' data1 '_' data2 ' 2 SNR_' data1 '_' data2 '.tif']);
eval(['!data2geotiff ' data1 '.dem.par ' data1 '_geoc.slc.mli 2 ' data1 '_geoc.slc.mli.tif']);

im=imread('VEL_km_y_20150816_20150921.tif');
im=imread('VEL_km_y_20150825_20150930.tif');
im=imread('VEL_km_y_20150918_20150930.tif');
im=imread('VEL_km_y_20150909_20150921.tif');
im=imread('VEL_km_y_20150825_20150906.tif');

%snr2=imread('SNR_20150918.tif');

imagesc(im);
caxis([0 1500])
