%Offset tracking:

%%% Co-registration

%create_offset 20150208.slc.par 20150220.slc.par 20150208_20150220.off 1 10 2 0
%offset_pwr 20150208.slc 20150220.slc 20150208.slc.par 20150220.slc.par 20150208_20150220.off 20150208_20150220.offs 20150208_20150220.snr 256 64 20150208_20150220.offsets 2 64 64 7.0 4 0 0
%offset_fit 20150208_20150220.offs 20150208_20150220.snr 20150208_20150220.off 20150208_20150220.coffs 20150208_20150220.coffsets 7.0 4 0
clear all
data1= num2str(20150127); data2= num2str(20150217);

%eval(['!mkdir /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/' data1 '_' data2 '_la_68']);
cd(['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A1/non_repeat_track/' data1 '_' data2 ]);
% path1=['/nfs/a59/eeagdl/Data/Available_Images/S1/Images/A1/162/S1A_IW_SLC__1SSH_20150127T204956_20150127T205023_004362_005525_1995.SAFE/'];
% path2=['/nfs/a59/eeagdl/Data/Available_Images/S1/Images/A1/118/S1A_IW_SLC__1SSH_20150217T202518_20150217T202546_004668_005C33_861E.SAFE/'];

eval(['!create_offset ' data1 '.slc.par ' data2 '.slc.par ' data1 '_' data2 '.off 1 10 2 0'])

eval(['!offset_pwr ' data1 '.slc ' data2 '.slc ' data1 '.slc.par ' data2 '.slc.par ' data1 '_' data2 '.off ' data1 '_' data2 '.offs ' data1 '_' data2 '.snr 256 64 ' data1 '_' data2 '.offsets 1 64 64 7.0 4 0 0']);

eval(['!offset_fit ' data1 '_' data2 '.offs ' data1 '_' data2 '.snr ' data1 '_' data2 '.off - - 10.0 3 0']);

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

eval(['!offset_pwr ' data1 '.slc ' data2 '.rslc ' data1 '.slc.par ' data2 '.rslc.par ' data1 '_' data2 '.off1 ' data1 '_' data2 '.offs ' data1 '_' data2 '.snr 256 64 ' data1 '_' data2 '.offsets1 1 64 64 7.0 4 0 0']);
%offset_pwr 20150208M.slc 20150220M.rslc 20150208.slc.par 20150220.rslc.par 20150208_20150220M.off1 20150208_20150220M.offs 20150208_20150220M.snr 256 64 - 1 64 64 7.0 4 0 0

eval(['!offset_fit ' data1 '_' data2 '.offs ' data1 '_' data2 '.snr ' data1 '_' data2 '.off1 - - 10.0 3 0']);
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


%% Co-registering the deramp images using the Geocode methody.

eval(['!multi_look ' data1 '.slc.deramp ' data1 '.slc.deramp.par ' data1 '.mli.deramp ' data1 '.mli.deramp.par 10 2']);
eval(['!multi_look ' data2 '.slc.deramp ' data2 '.slc.deramp.par ' data2 '.mli.deramp ' data2 '.mli.deramp.par 10 2']);

eval(['!gc_map ' data1 '.mli.deramp.par - /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem.par /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem ' data1 '.dem.par ' data1 '.dem ' data1 '.lt 1 1 ' data1 '.sim_sar u_' data1 ' v_' data1 ' inc_' data1 ' psi_' data1 ' pix_' data1 ' ls_map_' data1 ' 8 2']);

eval(['!geocode ' data1 '.lt ' data1 '.sim_sar 3154 ' data1 '.sim_sar2 67771 13342 1 0']);

eval(['!create_diff_par ' data1 '.mli.deramp.par - ' data1 '.diff_par 1']);

eval(['!init_offsetm ' data1 '.mli.deramp.par ' data1 '.sim_sar2 ' data1 '.diff_par - - - - - - 5.0']);
eval(['!offset_pwrm ' data1 '.mli.deramp ' data1 '.sim_sar2 ' data1 '.diff_par ' data1 '_offs ' data1 '_snr 256 256 ' data1 '_offsets 1 8 8 1.0']);
offset_fitm 19950613_offs 19950613_snr 19950613.diff_par 19950613_coffs 19950613_coffsets 3.0 3

offset_pwrm 19950613.mli 19950613.sim_sar2 19950613.diff_par 19950613_offs 19950613_snr 128 128 19950613_offsets 1 24 24 3.0
offset_fitm 19950613_offs 19950613_snr 19950613.diff_par 19950613_coffs 19950613_coffsets 3.0 3
gc_map_fine 19950613.lt 1356 19950613.diff_par 19950613.lt.fine 0

geocode_back 19950613.mli 5616 19950613.lt.fine 19950613_geoc.mli 1356 1080 2 0

geocode 19950613.lt.fine 19950613.dem 1356 19950613.dem.Final 5616 5608 1 0
  %dishgt 19950613.dem.Final 19950613.mli 5616

%%%% Ex. I - Corregister using a lookup table:

rdc_trans 19950613.mli.par 19950613.dem.Final 19950624.mli.par lt0
geocode lt0 data1.mli 67771 mli0 67771 13342 2 0

create_diff_par data2.mli.deramp.par - diff0 1
init_offsetm mli0 data2.mli.deramp diff0 1 1 - - - - 2.5
offset_pwrm mli0 data2.mli.deramp diff0 offs0 snr0 256 64 offsets0 2 64 64
offset_fitm offs0 snr0 diff0 coffs0 coffsets0 7.0 4
gc_map_fine lt0  67771 diff0 lt1

SLC_interp_lt 19950624.slc 19950613.slc.par 19950624.slc.par lt1 19950613.mli.par 19950624.mli.par - 19950624.rslc 19950624.rslc.par





%%
eval(['!create_offset ' data1 '.slc.deramp.par ' data2 '.slc.deramp.par ' data1 '_' data2 '.deramp.off 1 10 2 0']);

eval(['!offset_pwr_tracking ' data1 '.slc.deramp ' data2 '.slc.deramp ' data1 '.slc.deramp.par ' data2 '.slc.deramp.par ' data1 '_' data2 '.deramp.off ' data1 '_' data2 '.deramp.offs ' data1 '_' data2 '.deramp.snr 400 80 ' data1 '_' data2 '.deramp.offsets 2 5.0 50 10 - - - - 4 0'])

eval(['!offset_tracking ' data1 '_' data2 '.deramp.offs ' data1 '_' data2 '.deramp.snr ' data1 '.slc.deramp.par ' data1 '_' data2 '.deramp.off ' data1 '_' data2 '.deramp.dis_map ' data1 '_' data2 '.deramp.dis_val 2 5.0 1']);

eval(['!multi_look ' data1 '.slc.deramp ' data1 '.slc.deramp.par master_deramp.mli master_deramp.mli.par 50 10']);

[s,widthMaster]=system(['grep range_samples: master_deramp.mli.par | cut -c33-36']);
widthMaster=num2str(widthMaster(1,1:4));

eval(['!cpx_to_real ' data1 '_' data2 '.deramp.dis_map ground_' data1 '_' data2 ' ' widthMaster ' 0']);
eval(['!cpx_to_real ' data1 '_' data2 '.deramp.dis_map azimuth_' data1 '_' data2 ' ' widthMaster ' 1']);         
eval(['!cpx_to_real ' data1 '_' data2 '.deramp.dis_map velocity_' data1 '_' data2 ' ' widthMaster ' 3']);
eval(['!cpx_to_real ' data1 '_' data2 '.deramp.dis_map angle_' data1 '_' data2 ' ' widthMaster ' 4']); 


eval(['!rasdt_pwr24 ground_' data1 '_' data2 ' master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 ground_' data1 '_' data2 '.bmp']);
eval(['!rasdt_pwr24 azimuth_' data1 '_' data2 ' master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 azimuth_' data1 '_' data2 '.bmp']);
eval(['!rasdt_pwr24 velocity_' data1 '_' data2 ' master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 velocity_' data1 '_' data2 '.bmp']);
eval(['!rasdt_pwr24 angle_' data1 '_' data2 ' master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 angle_' data1 '_' data2 '.bmp']);


ground_cor= ['ground_' data1 '_' data2]; 
azimuth_cor= ['azimuth_' data1 '_' data2]; 

eval(['!float_math ' ground_cor ' ' ground_cor ' Multi_gro ' widthMaster ' 2']);
eval(['!float_math ' azimuth_cor ' ' azimuth_cor ' Multi_az ' widthMaster ' 2']);
eval(['!float_math Multi_gro Multi_az Sum ' widthMaster ' 0']);
eval(['!float_math Sum - squRo ' widthMaster ' 6']);
eval(['!float_math squRo - VELOCITY ' widthMaster ' 3 - - - - 12'])
eval(['!float_math VELOCITY - VEL_km_y_' data1 '_' data2 ' ' widthMaster ' 2 - - - - 0.365']);

eval(['!data2tiff VEL_km_y_' data1 '_' data2 ' ' widthMaster ' 2 VEL_km_y_' data1 '_' data2 '.tif']);

%% Geocoding the data

eval(['!gc_map ' data1 '.slc.mli.par - /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem.par /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem ' data1 '.dem.par ' data1 '.dem ' data1 '.lt 1 1 ' data1 '.sim_par ' data1 '_u ' data1 '_v ' data1 '_inc ' data1 '_psi ' data1 '_pix ' data1 '_ls_map 8 2']);
eval(['!pixel_area ' data1 '.slc.deramp.mli.par ' data1 '.dem.par ' data1 '.dem ' data1 '.lt ' data1 '_ls_map ' data1 '_inc ' data1 '_pix_sigma0 ' data1 '_pix_gamma0']);
eval(['!create_diff_par ' data1 '.slc.deramp.mli.par - ' data1 '.diff_par 1 0']);
eval(['!offset_pwrm ' data1 '_pix_sigma0 ' data1 '.slc.deramp.mli ' data1 '.diff_par ' data1 '.offs ' data1 '.snr 256 256 ' data1 '_offsets 2 64 64 7.0']);
eval(['!offset_fitm ' data1 '.offs ' data1 '.snr ' data1 '.diff_par ' data1 '_coffs ' data1 '_coffsets 7.0 1']);

y1=['grep range_samples: ' data1 '.slc.derramp.mli.par | cut -c33-36']
[s,widthGeo]=system(y1);
widthMaster=num2str(widthMaster(1,1:4));

y2=['grep range_samples: ' data1 '.dem.par | cut -c33-36']
[s2,widthDEM]=system(y2);
widthMaster=num2str(widthMaster(1,1:4));

eval(['!gc_map_fine ' data1 '.lt ' widthDEM ' ' data1 '.diff_par ' data1 '.lt_fine 1']);

eval(['!geocode_back ' data1 '.slc.mli ' widthGeo ' ' data1 '.lt_fine ' data1 '_geoc.slc.mli ' widthDEM ' - 2 0']);

%eval(['!data2geotiff ' data1 '.dem.par VELOCITY 2 VELOCITY_tiff.tif']);


