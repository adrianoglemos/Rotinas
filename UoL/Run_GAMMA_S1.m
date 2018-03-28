data1= num2str(20150204);

cd /nfs/a59/eeagdl/Data/Available_Images/S1/Images/A2/098/S1A_IW_SLC__1SSH_20150204T113548_20150204T113615_004473_0057C0_BE1D.SAFE

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

%t=imread([data1 'M.slc.ras']);imagesc(t);
%close all; clear t;

%% Offset tracking:

%%% Co-registration

%create_offset 20150208.slc.par 20150220.slc.par 20150208_20150220.off 1 10 2 0
%offset_pwr 20150208.slc 20150220.slc 20150208.slc.par 20150220.slc.par 20150208_20150220.off 20150208_20150220.offs 20150208_20150220.snr 256 64 20150208_20150220.offsets 2 64 64 7.0 4 0 0
%offset_fit 20150208_20150220.offs 20150208_20150220.snr 20150208_20150220.off 20150208_20150220.coffs 20150208_20150220.coffsets 7.0 4 0

data1= num2str(20150123); data2= num2str(20150216);

eval(['!mkdir /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/098/' data1 '_' data2]);
cd(['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/098/' data1 '_' data2]);
path1=['/nfs/a59/eeagdl/Data/Available_Images/S1/Images/098/20150123/S1A_IW_SLC__1SSH_20150123T113523_20150123T113551_004298_0053BB_B7F4.SAFE/'];
path2=['/nfs/a59/eeagdl/Data/Available_Images/S1/Images/098/20150216/S1A_IW_SLC__1SSH_20150216T113523_20150216T113550_004648_005BBF_B83D.SAFE/'];

eval(['!create_offset ' path1 data1 '.slc.par ' path2 data2 '.slc.par ' data1 '_' data2 'M.off 1 10 2 0'])

eval(['!offset_pwr ' path1 data1 'M.slc ' path2 data2 'M.slc ' path1 data1 '.slc.par ' path2 data2 '.slc.par ' data1 '_' data2 'M.off ' data1 '_' data2 'M.offs ' data1 '_' data2 'M.snr 256 64 - 1 64 64 7.0 4 0 0']);

eval(['!offset_fit ' data1 '_' data2 'M.offs ' data1 '_' data2 'M.snr ' data1 '_' data2 'M.off - - 10.0 1 0']);

      eval(['!echo ' data2 '_iw1_hh.rslc ' data2 '_iw1_hh.rslc.par ' data2 '_iw1_hh.rslc.tops_par > RSLC_tab']);
      eval(['!echo ' data2 '_iw2_hh.rslc ' data2 '_iw2_hh.rslc.par ' data2 '_iw2_hh.rslc.tops_par >> RSLC_tab']);
      eval(['!echo ' data2 '_iw3_hh.rslc ' data2 '_iw3_hh.rslc.par ' data2 '_iw3_hh.rslc.tops_par >> RSLC_tab']);

eval(['!cp ' path1 '*tops* ./']);
eval(['!cp ' path2 '*.tops* ./']);
eval(['!cp ' path1 '*.slc* ./']);
eval(['!cp ' path2 '*.slc* ./']);         
eval(['!SLC_interp_S1_TOPS ' path2 'tab1_S1_' data2 ' ' data2 '.slc.par ' path1 'tab1_S1_' data1 ' ' data1 '.slc.par ' data1 '_' data2 'M.off RSLC_tab ' data2 '.rslc ' data2 '.rslc.par']);


eval(['!create_offset ' data1 '.slc.par ' data2 '.slc.par ' data1 '_' data2 'M.off1 1 10 2 0']);
%create_offset 20150208.slc.par 20150220.slc.par 20150208_20150220M.off1 1 10 2 0

%Masking the derramped slave image
eval(['!mask_class ' path1 'Mask_' data1 '.ras ' data2 '.rslc ' data2 'M.rslc 1 1 -1 1 0']);

eval(['!offset_pwr ' data1 'M.slc ' data2 'M.rslc ' data1 '.slc.par ' data2 '.rslc.par ' data1 '_' data2 'M.off1 ' data1 '_' data2 'M.offs ' data1 '_' data2 'M.snr 256 64 - 1 64 64 7.0 4 0 0']);
%offset_pwr 20150208M.slc 20150220M.rslc 20150208.slc.par 20150220.rslc.par 20150208_20150220M.off1 20150208_20150220M.offs 20150208_20150220M.snr 256 64 - 1 64 64 7.0 4 0 0

eval(['!offset_fit ' data1 '_' data2 'M.offs ' data1 '_' data2 'M.snr ' data1 '_' data2 'M.off1 - - 10.0 1 0']);
%offset_fit 20150208_20150220M.offs 20150208_20150220M.snr 20150208_20150220M.off1 - - 10.0 1 0

eval(['!offset_add ' data1 '_' data2 'M.off ' data1 '_' data2 'M.off1 ' data1 '_' data2 'M.off.total']);
%offset_add 20150208_20150220M.off 20150208_20150220M.off1 20150208_20150220M.off.total

eval(['!SLC_interp_S1_TOPS ' path2 'tab1_S1_' data2 ' ' data2 '.slc.par ' path1 'tab1_S1_' data1 ' ' data1 '.slc.par ' data1 '_' data2 'M.off.total RSLC_tab ' data2 '.rslc ' data2 '.rslc.par']);
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

eval(['!offset_pwr_tracking ' data1 '.slc.deramp ' data2 '.slc.deramp ' data1 '.slc.deramp.par ' data2 '.slc.deramp.par ' data1 '_' data2 '.deramp.off ' data1 '_' data2 '.deramp.offs ' data1 '_' data2 '.deramp.snr 200 40 ' data1 '_' data2 '.deramp.offsets 2 5.0 50 10 - - - - 4 0'])

eval(['!offset_tracking ' data1 '_' data2 '.deramp.offs ' data1 '_' data2 '.deramp.snr ' data1 '.slc.deramp.par ' data1 '_' data2 '.deramp.off ' data1 '_' data2 '.deramp.dis_map ' data1 '_' data2 '.deramp.dis_val 2 5.0 1']);

eval(['!multi_look ' data1 '.slc.deramp ' data1 '.slc.deramp.par master_deramp.mli master_deramp.mli.par 50 10']);

[s,widthMaster]=system(['grep range_samples: master_deramp.mli.par | cut -c33-36']);
widthMaster=num2str(widthMaster(1,1:4));

eval(['!cpx_to_real ' data1 '_' data2 '.deramp.dis_map ground_PG ' widthMaster ' 0']);
eval(['!cpx_to_real ' data1 '_' data2 '.deramp.dis_map azimuth_PG ' widthMaster ' 1']);         
eval(['!cpx_to_real ' data1 '_' data2 '.deramp.dis_map velocity_PG ' widthMaster ' 3']);
eval(['!cpx_to_real ' data1 '_' data2 '.deramp.dis_map angle_PG ' widthMaster ' 4']); 


eval(['!rasdt_pwr24 ground_PG master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 ground_PG.bmp']);
eval(['!rasdt_pwr24 azimuth_PG master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 azimuth_PG.bmp']);
eval(['!rasdt_pwr24 velocity_PG master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 velocity_PG.bmp']);
eval(['!rasdt_pwr24 angle_PG master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 angle_PG.bmp']);


