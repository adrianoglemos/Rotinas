pathsate=['/nfs/a59/eeagdl/Data/Available_Images/S1/Images/A4/162/la_68/'];
d=dir(pathsate);
j=1;
for i=4:length(d);
name=d(i,1).name;
data{j,1}=cellstr(name);
date{j,1}=cellstr(name(18:25));
list(j,1)=cellstr(data{j,1});
j=j+1;
%folder=char(folder, data);
end
clear d i j name

d=char([date{:}]);
date2=datenum(str2num(d(:,1:4)),str2num(d(:,5:6)),str2num(d(:,7:8)));



for i=1:length(list);
    temp=[pathsate list{i,1}];
    %d=dir(temp);
    cd(temp)
    data1=d(i,:);
    
%%%Geocoding the image Petermann_gcorrNew.dem  Petermann_gcorrNew.dem_par
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eval(['!multi_look ' data1 '.slc ' data1 '.slc.par ' data1 '.slc.presentation.mli ' data1 '.slc.presentation.mli.par 50 10']);
%eval(['!multi_look ' data1 '.slc.deramp ' data1 '.slc.deramp.par ' data1 '.slc.deramp.mli ' data1 '.slc.deramp.mli.par 50 10']);

%eval(['!gc_map ' data1 '.slc.deramp.presentation.mli.par - /nfs/a59/eeagdl/Data/Available_Images/S1/Antarctic/DEM/Bamber_1km/nsidc0422_antarctic_1km_dem/krigged_dem_nsidc.bin.par /nfs/a59/eeagdl/Data/Available_Images/S1/Antarctic/DEM/Bamber_1km/nsidc0422_antarctic_1km_dem/krigged_dem_nsidc.bin.swap ' data1 '.presentation.dem.par ' data1 '.presentation.dem ' data1 '.presentation.lt 10 10 ' data1 '.presentation.sim_par ' data1 '.presentation_u ' data1 '.presentation_v ' data1 '.presentation_inc ' data1 '.presentation_psi ' data1 '.presentation_pix ' data1 '.presentation_ls_map 8 2']);
eval(['!gc_map ' data1 '.slc.presentation.mli.par - /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem.par /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem ' data1 '.presentation.dem.par ' data1 '.presentation.dem ' data1 '.presentation.lt 1 1 ' data1 '.presentation.sim_par ' data1 '.presentation_u ' data1 '.presentation_v ' data1 '.presentation_inc ' data1 '.presentation_psi ' data1 '.presentation_pix ' data1 '.presentation_ls_map 8 2']);

%%%Refinement of geocoding lookup table
eval(['!pixel_area ' data1 '.slc.presentation.mli.par ' data1 '.presentation.dem.par ' data1 '.presentation.dem ' data1 '.presentation.lt ' data1 '.presentation_ls_map ' data1 '.presentation_inc ' data1 '.presentation_pix_sigma0 ' data1 '.presentation_pix_gamma0']);

%%%Correction to the lookup table is determined and applied
eval(['!create_diff_par ' data1 '.slc.presentation.mli.par - ' data1 '.presentation.diff_par 1 0']);
eval(['!offset_pwrm ' data1 '.presentation_pix_sigma0 ' data1 '.slc.presentation.mli ' data1 '.presentation.diff_par ' data1 '.presentation.offs ' data1 '.presentation.snr 256 256 ' data1 '.presentation_offsets 2 64 64 4.0']);
eval(['!offset_fitm ' data1 '.presentation.offs ' data1 '.presentation.snr ' data1 '.presentation.diff_par ' data1 '.presentation_coffs ' data1 '.presentation_coffsets 4.0 1']);

y1=['grep range_samples: ' data1 '.slc.presentation.mli.par | cut -c33-36']
[s,widthGeo]=system(y1);
widthGeo=num2str(widthGeo(1,1:4));

y2=['grep width: ' data1 '.presentation.dem.par | cut -c23-26']
[s2,widthDEM]=system(y2);
widthDEM=num2str(widthDEM(1,1:4));

y3=['grep lines: ' data1 '.presentation.dem.par | cut -c23-26']
[s3,linesDEM]=system(y3);
linesDEM=num2str(linesDEM(1,1:4));

eval(['!gc_map_fine ' data1 '.presentation.lt ' widthDEM ' ' data1 '.presentation.diff_par ' data1 '.presentation.lt_fine 1']);

eval(['!geocode_back ' data1 '.slc.presentation.mli ' widthGeo ' ' data1 '.presentation.lt_fine ' data1 '.presentation_geoc.slc.mli ' widthDEM ' ' linesDEM ' 2 0']);
eval(['!data2geotiff ' data1 '.presentation.dem.par ' data1 '.presentation_geoc.slc.mli 2 ' data1 '.presentation.tif']);
eval(['!raspwr ' data1 '.presentation_geoc.slc.mli ' widthDEM]);
%!raspwr 20150125_geoc.slc.mli 3048
eval(['!cp ' data1 '.presentation_geoc.slc.mli.bmp ../']);
eval(['!cp ' data1 '.presentation.tif ../tif/']);

%eval(['!rm *.presentation*'])
end