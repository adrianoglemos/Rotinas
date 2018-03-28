#!/bin/csh -x

 echo " "
 echo "**** Script to proces S1 data from SLC2 debursted FT in GAMMA via urs Gamma method, while automatically 'geting' the correct input files from the Leeds archive and flattening post sub topo. plus '- 999' in doppler!!!!!! and 4x default azi autof patch size and range bins and 2011 obdir error fixed****"
 echo " "
 echo " added orbit update with OPOD precise orbits, and initial coregistration offset estimation from orbits, changet offset_tracking from thres2 (4.0) to thres (8.0) "
 echo " removed redownload of corrupt data 24/02/16, added image transparency, partially added gridlines "
 echo " updated for gamma 2015"
 echo " 14 July 2016 - Removed GCP lines where coordinates are outside frame (negative pixel values"
 echo " "
 echo " ------------------ CPOM S1 IV WWW: JAK Version 1 -----------------------------------------------"
 echo " hardwire = polygon locations for extracted geotiff"
 echo " "
 echo "Files required:"
 echo " all files gor from archive apart from frame mask"
 echo " "
 echo "Script witten by Anna Hogg 19.11.2015"
 echo " "
 echo " "

 if ($#argv < 42)then
   echo "*************************************************************************"
   echo " "
   echo "USAGE: procS1_SLC2FTgc_v8_cwT21_wwwJAK.sh <scene1 identifier> <scene2 identifier> <S1_no> <S1_Imode> <S1_Ifmt> <lat> <lon> <lat2> <lon2> <pol> <rng_lks> <azi_lks> <rng_win> <azi_win> <no_ovr> <nr> <naz> <thres> <thres2> <npoly> <ras_rng_mli> <ras_azi_mli> <Trk_no> <col_ramp> <Rstep> <Astep> <off_Rwin2> <off_Awin2> <disp_mode> <poly_flag> <DEM> <temp_B> <max_yr_IV> <DEM_ovr> <AOI> <col_ramp_THUMB> <THUMB_lk> <DEM_ovr_Fi> <Rstep_adap> <Astep_adap> <off_Rwin2_adap> <off_Awin2_adap>"
   echo " "
   echo "*************************************************************************"
   echo " "
   echo "scene identifier   -   filename (without the extension)"
   echo "                             e.g. 20141021"
   echo "scene1             -   master of InSAR pair"
   echo "scene2             -   slave of InSAR pair"
   echo "S1_no              -   number of S1 satellite used. options: S1A"
   echo "S1_Imode           -   S1 Imaging Mode: IW"
   echo "S1_Ifmt            -   S1 Image Format: SLC"
   echo "lat                -   frame center latitude: ****.****"
   echo "lon                -   frame center longitude: ****.****"
   echo "lat2               -   frame center latitude: ****.****"
   echo "lon2               -   frame center longitude: ****.****"
   echo "pol                -   imaging polarisation: hh"
   echo "rng_lks            -   number of range looks used in initial offset determination. set as 10 "
   echo "azi_lks            -   number of azimuth looks used in initial offset determination. set as 2"
   echo "rng_win            -   range search window size"
   echo "azi_win            -   azimuth search window size"
   echo "no_ovr             -   oversampling number"
   echo "nr                 -   number of offset estimates in range direction. 16 = default, 64 or 128 = preferable to reduce error"
   echo "naz                -   number of offset estimates in azimuth direction. 16 = default, 64 or 128 = preferable to reduce error"
   echo "thres              -   offset estimation quality threshold: 7.0"
   echo "thres2             -   offset estimation quality threshold: 4.0"
   echo "npoly              -   number offset polynomial fit" 
   echo "ras_rng_mli        -   range direction multilooking of raster image"
   echo "ras_azi_mli        -   azimuth direction multilooking of raster image"
   echo "Trk_no             -   Track number"
   echo "col_ramp           -   colour ramp for output images"
   echo "Rstep              -   Range offset tracking step"
   echo "Astep              -   Azimuth offset tracking step"
   echo "off_Rwin2          -   range offset tracking window size"
   echo "off_Awin2          -   azimuth offset tracking window size"
   echo "disp_mode          -   displagement image mode"
   echo "poly_flag          -   polynomial flag"
   echo "DEM                -   DEM" 
   echo "temp_B             -   temporal baseline"
   echo "max_yr_IV          -   max IV/yr for area"
   echo "DEM_ovr            -   DEM oversampling factor"
   echo "AOI                -   area of interest"
   echo "col_ramp_THUMB     -   colour ramp for thumbnail images"
   echo "THUMB_lk           -   number of looks of thumbnal images"
   echo "DEM_ovr_Fi         -   DEM over fine"
   echo "Rstep_adap         -   Range offset adaptive tracking step"
   echo "Astep_adap         -   Azimuth offset adaptive tracking step"
   echo "off_Rwin2_adap     -   range offset adaptive tracking window size"
   echo "off_Awin2_adap     -   azimuth offset adaptive tracking window size"
   echo " "
   exit(-1)
 endif

 # defaults for input parameters
  set scene1 = "."
  set scene2 = "."
  set S1_no = "S1"
  set S1_Imode = "IW"
  set S1_Ifmt = "SLC"
  set lat = "." 
  set lon = "."
  set lat2 = "."
  set lon2 = "."
  # removed pol variable - not needed
  set pol = "hh"
  set rng_lks = "10"
  set azi_lks = "2"
  set rng_win = "256"
  set azi_win = "64"
  set no_ovr = "1"
  set nr = "64" 
  set naz = "64"
  set thres = "8.0"
  set thres2 = "0.05"
  set npoly = "1"
  set ras_rng_mli = "4"
  set ras_azi_mli = "4"  
  set Trk_no = "125"   
  set col_ramp = "10."
  set Rstep = "40"
  set Astep = "8"
  set off_Rwin2 = "256"
  set off_Awin2 = "256"
  set disp_mode = "2"
  set poly_flag = "1"
  set DEM = "gimpdem_90m"
  set temp_B = "12"
  set max_yr_IV = "1500.0"
  set DEM_ovr = "4"
  set AOI = "JAK"
  set col_ramp_THUMB = "3000."
  set THUMB_lk = "4"
  set DEM_ovr_Fi = "4"
  set Rstep_adap = "40"
  set Astep_adap = "8"
  set off_Rwin2_adap = "256"
  set off_Awin2_adap = "256"

 # Assign user input (from command line) to parameters
 if ($#argv >= 42)then
   set scene1 = $1
   set scene2 = $2
   set S1_no = $3
   set S1_Imode = $4
   set S1_Ifmt = $5
   set lat = $6
   set lon = $7
   set lat2 = $8
   set lon2 = $9
   # pol variable not in use - ESA changed polarisation setting on some aquisitions and info not actually needed for processing so cut
   set pol = $10
   set rng_lks = $11
   set azi_lks = $12
   set rng_win = $13
   set azi_win = $14
   set no_ovr = $15
   set nr = $16
   set naz = $17
   set thres = $18
   set thres2 = $19
   set npoly = $20
   set ras_rng_mli = $21
   set ras_azi_mli = $22
   set Trk_no = $23  
   set col_ramp = $24
   set Rstep = $25
   set Astep = $26
   set off_Rwin2 = $27
   set off_Awin2 = $28
   set disp_mode = $29
   set poly_flag = $30
   set DEM = $31
   set temp_B = $32
   set max_yr_IV = $33
   set DEM_ovr = $34
   set AOI = $35
   set col_ramp_THUMB = $36
   set THUMB_lk = $37
   set DEM_ovr_Fi = $38
  set Rstep_adap = $39
  set Astep_adap = $40
  set off_Rwin2_adap = $41
  set off_Awin2_adap = $42
endif


if ( $S1_no == 'S1' ) then
    set S1_no = 'S1*'
endif
# ==============================================================================================
# ==============================================================================================
# SLC debursting processing
# ==============================================================================================
# ==============================================================================================

# deburst SLC S1 data 

# ==============================================================================================

# ===========================================
# Get required input files for SLC debursting
# ===========================================

# set output directory for processing
 set out_dir = `pwd`
 echo 'out_dir'
 echo $out_dir

# cd into S1 archive and get image pairs
# IM1
set sc1 = `echo $scene1 | cut -c3-8`
echo 'sc1'
echo $sc1
cd /nfs/a41/L0data/S1/${Trk_no}/${S1_no}_${S1_Imode}_${S1_Ifmt}_${Trk_no}_***_******_${sc1}_******_${lat}.****_${lon}.****
cp *.zip ${out_dir}
cd ${out_dir}
# Now save the platform for orbit checking
set platfa = `ls *.zip | awk -F '_' '{print $1}'`

# ==========================================
# Section inserted to check for zipfile errors.
# Redownloads dodgy files.
# ELH 24/02/2016
# ==========================================

unzip6 -t *.zip
if ( $status != 0 ) then
    # Get just the identifier with no zip or SAFE.zip extension
    set reqFile = `echo *.zip | awk -F "." '{print $1}'`
    # Redownload it to Ndwnld
    cd /nfs/a41/earelh/working/
 	./redownload.sh $reqFile /nfs/a41/L0data/S1/Ndwnld/ `cat user.txt` `cat pwd.txt`
    cd ${out_dir}
    # Copy rather than move it, so that it gets archived again
    cp -f /nfs/a41/L0data/S1/Ndwnld/${reqFile}.* ${out_dir}
    unzip -t *.zip
    if ( $status != 0 ) then
	echo "Redownloaded file was still corrupt"
	echo "Attempting to continue regardless"
    endif
endif

# ==========================================
# End of changes
# ELH 24/02/2016
# ==========================================


# ELH - added forced overwrite option
unzip6 -o *.zip
set reqFile_sc1 = `echo *.zip | awk -F "." '{print $1}'`

cd *.SAFE/measurement
cp s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.tiff ${out_dir}
cp s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.tiff ${out_dir}
cp s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.tiff ${out_dir}
cd ${out_dir}
cd *.SAFE/annotation
cp s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.xml ${out_dir}
cp s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.xml ${out_dir}
cp s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.xml ${out_dir}
cd calibration
cp calibration-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.xml ${out_dir}
cp calibration-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.xml ${out_dir}
cp calibration-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.xml ${out_dir}
cp noise-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.xml ${out_dir}
cp noise-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.xml ${out_dir}
cp noise-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.xml ${out_dir}
cd ${out_dir}
rm -rf *.zip
rm -rf *.SAFE

# IM2
set sc2 = `echo $scene2 | cut -c3-8`
echo 'sc2'
echo $sc2
cd /nfs/a41/L0data/S1/${Trk_no}/${S1_no}_${S1_Imode}_${S1_Ifmt}_${Trk_no}_***_******_${sc2}_******_${lat2}.****_${lon2}.****
cp *.zip ${out_dir}
cd ${out_dir}
set platfb = `ls ${S1_no}_${S1_Imode}_${S1_Ifmt}__****_${scene2}T*.zip | awk -F '_' '{print $1}'`
# ==========================================
# Section inserted to check for zipfile errors.
# Redownloads dodgy files.
# ELH 24/02/2016
# ==========================================

unzip6 -t *.zip
if ( $status != 0 ) then
    # Get just the identifier with no zip or SAFE.zip extension
    set reqFile = `echo *.zip | awk -F "." '{print $1}'`
    # Redownload it to Ndwnld
    cd /nfs/a41/earelh/working/
 	./redownload.sh $reqFile /nfs/a41/L0data/S1/Ndwnld/ `cat user.txt` `cat pwd.txt`
    cd ${out_dir}
    # Copy rather than move it, so that it gets archived again
    cp -f /nfs/a41/L0data/S1/Ndwnld/${reqFile}.* ${out_dir}
    unzip -t *.zip
    if ( $status != 0 ) then
	echo "Redownloaded file was still corrupt"
	echo "Attempting to continue regardless"
    endif
endif

# ==========================================
# End of changes
# ELH 24/02/2016
# ==========================================


# ELH - added forced overwrite option
unzip6 -o *.zip
set reqFile_sc2 = `echo *.zip | awk -F "." '{print $1}'`

cd *.SAFE/measurement
cp s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.tiff ${out_dir}
cp s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.tiff ${out_dir}
cp s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.tiff ${out_dir}
cd ${out_dir}
cd *.SAFE/annotation
cp s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.xml ${out_dir}
cp s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.xml ${out_dir}
cp s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.xml ${out_dir}
cd calibration
cp calibration-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.xml ${out_dir}
cp calibration-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.xml ${out_dir}
cp calibration-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.xml ${out_dir}
cp noise-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.xml ${out_dir}
cp noise-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.xml ${out_dir}
cp noise-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.xml ${out_dir}
cd ${out_dir}
rm -rf *.zip
rm -rf *.SAFE

# ==================================================
# check to see if necessary SLC2DB input files exist
# ==================================================

 echo "test if required input files exist"
 echo " "
 set nonomatch
 #tiff
 if ( ! -e s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.tiff ) then
  echo "ERROR: ${scene2} 001 tiff file(s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.tiff) does not exist"
 endif 
 if ( ! -e s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.tiff ) then
  echo "ERROR: ${scene2} 002 tiff file(s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.tiff) does not exist"
 endif
 if ( ! -e s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.tiff ) then
  echo "ERROR: ${scene2} 003 tiff file(s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.tiff) does not exist"
 endif
  if ( ! -e s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.tiff ) then
  echo "ERROR: ${scene1} 001 tiff file(s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.tiff) does not exist"
 endif 
 if ( ! -e s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.tiff ) then
  echo "ERROR: ${scene1} 002 tiff file(s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.tiff) does not exist"
 endif
 if ( ! -e s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.tiff ) then
  echo "ERROR: ${scene1} 003 tiff file(s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.tiff) does not exist"
 endif
 # xml
 if ( ! -e s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.xml ) then
  echo "ERROR: ${scene2} 001 xml file(s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.xml) does not exist"
 endif 
 if ( ! -e s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.xml ) then
  echo "ERROR: ${scene2} 002 xml file(s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.xml) does not exist"
 endif
 if ( ! -e s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.xml ) then
  echo "ERROR: ${scene2} 003 xml file(s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.xml) does not exist"
 endif
 if ( ! -e s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.xml ) then
  echo "ERROR: ${scene1} 001 xml file(s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.xml) does not exist"
 endif 
 if ( ! -e s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.xml ) then
  echo "ERROR: ${scene1} 002 xml file(s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.xml) does not exist"
 endif
 if ( ! -e s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.xml ) then
  echo "ERROR: ${scene1} 003 xml file(s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.xml) does not exist"
 endif
 # calibration
 if ( ! -e calibration-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.xml ) then
  echo "ERROR: ${scene2} 001 xml file(calibration-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.xml) does not exist"
 endif 
 if ( ! -e calibration-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.xml ) then
  echo "ERROR: ${scene2} 002 xml file(calibration-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.xml) does not exist"
 endif
 if ( ! -e calibration-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.xml ) then
  echo "ERROR: ${scene2} 003 xml file(calibration-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.xml) does not exist"
 endif
 if ( ! -e calibration-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.xml ) then
  echo "ERROR: ${scene1} 001 xml file(calibration-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.xml) does not exist"
 endif 
 if ( ! -e calibration-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.xml ) then
  echo "ERROR: ${scene1} 002 xml file(calibration-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.xml) does not exist"
 endif
 if ( ! -e calibration-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.xml ) then
  echo "ERROR: ${scene1} 003 xml file(calibration-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.xml) does not exist"
 endif
 # noise
 if ( ! -e noise-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.xml ) then
  echo "ERROR: ${scene2} 001 xml file(noise-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.xml) does not exist"
 endif 
 if ( ! -e noise-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.xml ) then
  echo "ERROR: ${scene2} 002 xml file(noise-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.xml) does not exist"
 endif
 if ( ! -e noise-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.xml ) then
  echo "ERROR: ${scene2} 003 xml file(noise-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.xml) does not exist"
 endif
 if ( ! -e noise-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.xml ) then
  echo "ERROR: ${scene1} 001 xml file(noise-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.xml) does not exist"
 endif 
 if ( ! -e noise-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.xml ) then
  echo "ERROR: ${scene1} 002 xml file(noise-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.xml) does not exist"
 endif
 if ( ! -e noise-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.xml ) then
  echo "ERROR: ${scene1} 003 xml file(noise-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.xml) does not exist"
 endif  
 echo "required input/output files and directories exist"
 echo " "
 
 # =================================================================================================
 
 # Enter command line parameters into log
 
 set LOG = $1_$2_SLC2FT.log
 
 date > $LOG ; echo " " >> $LOG
 echo "script version: $0" >> $LOG ; echo " " >> $LOG
 echo "scene1 identifier: $1" >> $LOG
 echo "scene2 identifier: $2" >> $LOG
 echo "S1_no: $3" >> $LOG
 echo "S1_Imode: $4" >> $LOG
 echo "S1_Ifmt: $5" >> $LOG
 echo "lat: $6" >> $LOG
 echo "lon: $7" >> $LOG
 echo "lat2: $8" >> $LOG
 echo "lon2: $9" >> $LOG
 echo "pol: $10" >> $LOG
 echo "rng_lks: $11" >> $LOG
 echo "azi_lks: $12" >> $LOG
 echo "rng_win: $13" >> $LOG
 echo "azi_win: $14" >> $LOG
 echo "no_ovr: $15" >> $LOG
 echo "nr: $16" >> $LOG
 echo "naz: $17" >> $LOG
 echo "thres: $18" >> $LOG
 echo "thres2: $19" >> $LOG
 echo "npoly: $20" >> $LOG
 echo "ras_rng_mli: $21" >> $LOG
 echo "ras_azi_mli: $22" >> $LOG
 echo "Trk_no: $23" >> $LOG
 echo "col_ramp: $24" >> $LOG
 echo "Rstep: $25" >> $LOG
 echo "Astep: $26" >> $LOG
 echo "off_Rwin2: $27" >> $LOG
 echo "off_Awin2: $28" >> $LOG
 echo "disp_mode: $29" >> $LOG
 echo "poly_flag: $30" >> $LOG
   echo "DEM: $31" >> $LOG
   echo "temp_B: $32" >> $LOG
   echo "max_yr_IV: $33" >> $LOG
   echo "DEM_ovr: $34" >> $LOG
   echo "AOI: $35" >> $LOG
   echo "col_ramp_THUMB: $36" >> $LOG
   echo "THUMB_lk: $37" >> $LOG
   echo "DEM_ovr_Fi: $38" >> $LOG
  echo "Rstep_adap: $39" >> $LOG
  echo "Astep_adap: $40" >> $LOG
  echo "off_Rwin2_adap: $41" >> $LOG
  echo "off_Awin2_adap: $42" >> $LOG
 echo " " >> $LOG 

 # ====================================
 # set some DEM / QDInSAR variables
 # ====================================
 
 cd /nfs/a41/DEMs/Greenland/
 yes '' | ln -s ${DEM}.dem ${out_dir}
 yes '' | cp ${DEM}.dem_par ${out_dir}
 cd ${out_dir}
 set DEM_ID = B1km
 set DEM_lks = 4
 set nFFT = 256
 set cc_win = 5
 set wfrac = 0.2
 
 # ================================================================================================
 
 echo " "
 echo " "
 echo "======================================="
 echo " create TOPS processing parameter file "
 echo "======================================="
 echo " "
 echo " "
 
 # IM1
 # *** Generate SLC parameter and image files for Sentinel-1 SLC data  ***
 # N.B should be rng 19897 x azi 17908 per burst 
 par_S1_SLC s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.tiff s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.xml calibration-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.xml noise-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.xml ${scene1}_B1.slc.par ${scene1}_B1.slc ${scene1}_B1.TOPS_par
 par_S1_SLC s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.tiff s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.xml calibration-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.xml noise-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.xml ${scene1}_B2.slc.par ${scene1}_B2.slc ${scene1}_B2.TOPS_par
 par_S1_SLC s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.tiff s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.xml calibration-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.xml noise-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.xml ${scene1}_B3.slc.par ${scene1}_B3.slc ${scene1}_B3.TOPS_par
 

 # *** DISP dismph_fft: display of magnitude/phase and 2D FFT of complex data***
 # *** dismph_fft ***
 
 # make SLC_tab
 echo "${scene1}_B1.slc ${scene1}_B1.slc.par ${scene1}_B1.TOPS_par" > SLC1_tab.txt
 echo "${scene1}_B2.slc ${scene1}_B2.slc.par ${scene1}_B2.TOPS_par" >> SLC1_tab.txt
 echo "${scene1}_B3.slc ${scene1}_B3.slc.par ${scene1}_B3.TOPS_par" >> SLC1_tab.txt

 # *** Calculate SLC mosaic of Sentinel-1 TOPS burst SLC data ***
 # N.B output is rng 68000 x azi 13000 
 SLC_mosaic_S1_TOPS SLC1_tab.txt ${scene1}.slc ${scene1}.slc.par ${rng_lks} ${azi_lks}
 
 # *** Calculate MLI mosaic from Sentinel-1 TOPS SLC burst data (FCOMPLEX and SCOMPLEX) ***
 # N.B output is rng 16220 x azi 16909
 multi_S1_TOPS SLC1_tab.txt ${scene1}.mli ${scene1}.mli.par ${rng_lks} ${azi_lks}
 
 # get image dimensions
 # N.B. should be 6480 x 6658
 set mli1_width = `grep range_samples: ${scene1}.mli.par | cut -c31-36`
 echo $mli1_width
 set mli1_lng = `grep azimuth_lines: ${scene1}.mli.par | cut -c31-36`
 echo $mli1_lng
 
 # *** Generate 8-bit greyscale raster image of intensity data ***
 # N.B. dimensions will be 1620 x 6658
 raspwr ${scene1}.mli ${mli1_width} - - ${ras_rng_mli} ${ras_azi_mli} - - - ${scene1}.mli.bmp
 
 # *** Calculate a multi-look intensity (MLI) image from an SLC image ***
 multi_look ${scene1}.slc ${scene1}.slc.par ${scene1}.Smli ${scene1}.Smli.par ${rng_lks} ${azi_lks}
 
 # get image dimensions
 # N.B. should be 6480 x 6658
 set Smli1_width = `grep range_samples: ${scene1}.Smli.par | cut -c31-36`
 echo $Smli1_width
 set Smli1_lng = `grep azimuth_lines: ${scene1}.Smli.par | cut -c31-36`
 echo $Smli1_lng
 
 # *** Generate 8-bit greyscale raster image of intensity data ***
 # N.B. dimensions will be 1620 x 1664
 raspwr ${scene1}.Smli ${Smli1_width} - - ${ras_rng_mli} ${ras_azi_mli} - - - ${scene1}.Smli.bmp
 
 # *** Copy selected burst from Sentinel-1 TOPS SLC to a file ***
 # SLC_burst_copy 
 
 echo "*** Generate SLC parameter and image files for Sentinel-1 SLC data  ***" >> $LOG
 echo "" >> $LOG
 echo "par_S1_SLC s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.tiff s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.xml calibration-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.xml noise-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-001.xml ${scene1}_B1.slc.par ${scene1}_B1.slc ${scene1}_B1.TOPS_par" >> $LOG
 echo "par_S1_SLC s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.tiff s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.xml calibration-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.xml noise-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-002.xml ${scene1}_B2.slc.par ${scene1}_B2.slc ${scene1}_B2.TOPS_par" >> $LOG
 echo "par_S1_SLC s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.tiff s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.xml calibration-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.xml noise-s1*-***-***-**-${scene1}t******-${scene1}t******-******-******-003.xml ${scene1}_B3.slc.par ${scene1}_B3.slc ${scene1}_B3.TOPS_par" >> $LOG
 echo " " >> $LOG
 echo "SLC1_tab.txt" >> $LOG
 echo " " >> $LOG
 echo "*** Calculate SLC mosaic of Sentinel-1 TOPS burst SLC data ***" >> $LOG
 echo "SLC_mosaic_S1_TOPS SLC1_tab.txt ${scene1}.slc ${scene1}.slc.par ${rng_lks} ${azi_lks}" >> $LOG
 echo " " >> $LOG
 echo "*** Calculate MLI mosaic from Sentinel-1 TOPS SLC burst data (FCOMPLEX and SCOMPLEX) ***" >> $LOG
 echo "multi_S1_TOPS SLC1_tab.txt ${scene1}.mli ${scene1}.mli.par ${rng_lks} ${azi_lks}" >> $LOG
 echo " " >> $LOG
 echo "*** Generate 8-bit greyscale raster image of intensity data ***" >> $LOG
 echo "raspwr ${scene1}.mli ${mli1_width} - - ${ras_rng_mli} ${ras_azi_mli} - - - ${scene1}.mli.bmp" >> $LOG
 echo " " >> $LOG
 echo "*** Calculate a multi-look intensity (MLI) image from an SLC image ***" >> $LOG
 echo "multi_look ${scene1}.slc ${scene1}.slc.par ${scene1}.Smli ${scene1}.Smli.par ${rng_lks} ${azi_lks}" >> $LOG
 echo " " >> $LOG
 echo "*** Generate 8-bit greyscale raster image of intensity data ***" >> $LOG
 echo "raspwr ${scene1}.Smli ${Smli1_width} - - ${ras_rng_mli} ${ras_azi_mli} - - - ${scene1}.Smli.bmp" >> $LOG
 echo " " >> $LOG
 echo "======" >> $LOG
 
 # =================================================================================================
 # IM2
 # *** Generate SLC parameter and image files for Sentinel-1 SLC data  ***
 # N.B should be rng 19897 x azi 17908 per burst 
 par_S1_SLC s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.tiff s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.xml calibration-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.xml noise-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.xml ${scene2}_B1.slc.par ${scene2}_B1.slc ${scene2}_B1.TOPS_par
 par_S1_SLC s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.tiff s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.xml calibration-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.xml noise-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.xml ${scene2}_B2.slc.par ${scene2}_B2.slc ${scene2}_B2.TOPS_par
 par_S1_SLC s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.tiff s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.xml calibration-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.xml noise-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.xml ${scene2}_B3.slc.par ${scene2}_B3.slc ${scene2}_B3.TOPS_par
 
 # *** DISP dismph_fft: display of magnitude/phase and 2D FFT of complex data***
 # *** dismph_fft ***
 
 # make SLC_tab
 echo "${scene2}_B1.slc ${scene2}_B1.slc.par ${scene2}_B1.TOPS_par" > SLC2_tab.txt
 echo "${scene2}_B2.slc ${scene2}_B2.slc.par ${scene2}_B2.TOPS_par" >> SLC2_tab.txt
 echo "${scene2}_B3.slc ${scene2}_B3.slc.par ${scene2}_B3.TOPS_par" >> SLC2_tab.txt

 # *** Calculate a SLC mosiac of S1 TOPS IW SLC data ***
 # N.B output is rng 68000 x azi 13000 
 SLC_mosaic_S1_TOPS SLC2_tab.txt ${scene2}.slc ${scene2}.slc.par ${rng_lks} ${azi_lks}
 
 # *** Calculate MLI mosaic from Sentinel-1 TOPS SLC burst data (FCOMPLEX and SCOMPLEX) ***
 # N.B output is rng 16220 x azi 16909
 multi_S1_TOPS SLC2_tab.txt ${scene2}.mli ${scene2}.mli.par ${rng_lks} ${azi_lks}
 
 # get image dimensions
 # N.B. should be 6480 x 6658
 set mli2_width = `grep range_samples: ${scene2}.mli.par | cut -c31-36`
 echo $mli2_width
 set mli2_lng = `grep azimuth_lines: ${scene2}.mli.par | cut -c31-36`
 echo $mli2_lng
 
 # *** Generate 8-bit greyscale raster image of intensity data ***
 # N.B. dimensions will be 1620 x 6658
 raspwr ${scene2}.mli ${mli2_width} - - ${ras_rng_mli} ${ras_azi_mli} - - - ${scene2}.mli.bmp
 
 # *** Calculate a multi-look intensity (MLI) image from an SLC image ***
 multi_look ${scene2}.slc ${scene2}.slc.par ${scene2}.Smli ${scene2}.Smli.par ${rng_lks} ${azi_lks}
 
 # get image dimensions
 # N.B. should be 6480 x 6658
 set Smli2_width = `grep range_samples: ${scene2}.Smli.par | cut -c31-36`
 echo $Smli2_width
 set Smli2_lng = `grep azimuth_lines: ${scene1}.Smli.par | cut -c31-36`
 echo $Smli2_lng
 
 # *** Generate 8-bit greyscale raster image of intensity data ***
 # N.B. dimensions will be 1620 x 1664
 raspwr ${scene2}.Smli ${Smli2_width} - - ${ras_rng_mli} ${ras_azi_mli} - - - ${scene2}.Smli.bmp
 
 echo "*** Generate SLC parameter and image files for Sentinel-1 SLC data  ***" >> $LOG
 echo "" >> $LOG
 echo "par_S1_SLC s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.tiff s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.xml calibration-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.xml noise-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-001.xml ${scene2}_B1.slc.par ${scene2}_B1.slc ${scene2}_B1.TOPS_par" >> $LOG
 echo "par_S1_SLC s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.tiff s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.xml calibration-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.xml noise-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-002.xml ${scene2}_B2.slc.par ${scene2}_B2.slc ${scene2}_B2.TOPS_par" >> $LOG
 echo "par_S1_SLC s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.tiff s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.xml calibration-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.xml noise-s1*-***-***-**-${scene2}t******-${scene2}t******-******-******-003.xml ${scene2}_B3.slc.par ${scene2}_B3.slc ${scene2}_B3.TOPS_par" >> $LOG
 echo " " >> $LOG
 echo "SLC2_tab.txt" >> $LOG
 echo " " >> $LOG
 echo "*** Calculate a SLC mosiac of S1 TOPS IW SLC data ***" >> $LOG
 echo "SLC_mosaic_S1_TOPS SLC2_tab.txt ${scene2}.slc ${scene2}.slc.par ${rng_lks} ${azi_lks}" >> $LOG
 echo " " >> $LOG
 echo "*** Calculate MLI mosaic from Sentinel-1 TOPS SLC burst data (FCOMPLEX and SCOMPLEX) ***" >> $LOG
 echo "multi_S1_TOPS SLC1_tab.txt ${scene2}.mli ${scene2}.mli.par ${rng_lks} ${azi_lks}" >> $LOG
 echo " " >> $LOG
 echo "*** Generate 8-bit greyscale raster image of intensity data ***" >> $LOG
 echo "raspwr ${scene2}.mli ${mli2_width} - - ${ras_rng_mli} ${ras_azi_mli} - - - ${scene2}.mli.bmp" >> $LOG
 echo " " >> $LOG
 echo "*** Calculate a multi-look intensity (MLI) image from an SLC image ***" >> $LOG
 echo "multi_look ${scene2}.slc ${scene2}.slc.par ${scene2}.Smli ${scene2}.Smli.par ${rng_lks} ${azi_lks}" >> $LOG
 echo " " >> $LOG
 echo "*** Generate 8-bit greyscale raster image of intensity data ***" >> $LOG
 echo "raspwr ${scene2}.Smli ${Smli2_width} - - ${ras_rng_mli} ${ras_azi_mli} - - - ${scene2}.Smli.bmp" >> $LOG
 echo " " >> $LOG
 echo "======" >> $LOG
 
 # delete input files so save space
  rm -f *.tiff
  rm -f *.xml

# ==============================================================================================
# ==============================================================================================
# SLC2CoRegSLC processing - UPGRADE DEM and orbit only coregistration, not old ERS method
# ==============================================================================================
# ==============================================================================================

 echo " "
 echo " "
 echo "============================================="
 echo "Update slc orbits with S1 OPOD precise orbits"
 echo "============================================="
 echo " "
 echo " "
 
 # set orbit directory
 set Orbit_dir_a =  /nfs/a147/raw/orbits/S1A/POEORB/
 set Orbit_dir_b =  /nfs/a147/raw/orbits/S1B/POEORB/

 # set date of OPOD orbit file to use - look for file starting 1 day before image to ensure full period covered
 set sc1_orb_date_temp = `date -d ${scene1} +%s`
 set sc1_orb_date_temp = `echo ${sc1_orb_date_temp}-86400 | bc -l`
 set sc1_orb_date_temp =  `date -d @${sc1_orb_date_temp} +'%F'`
 set sc1_orb_date = `echo ${sc1_orb_date_temp} | tr -d '-'`
 echo ${sc1_orb_date}
 
 set sc2_orb_date_temp = `date -d ${scene2} +%s`
 set sc2_orb_date_temp = `echo ${sc2_orb_date_temp}-86400 | bc -l`
 set sc2_orb_date_temp =  `date -d @${sc2_orb_date_temp} +'%F'`
 set sc2_orb_date = `echo ${sc2_orb_date_temp} | tr -d '-'`
 echo ${sc2_orb_date}
 
 # set variable to say if precise orbits file existed
 set sc1_OrbF = POE
 set sc2_OrbF = POE
 echo ${sc1_OrbF}
 echo ${sc2_OrbF}
 # sc1
 # First select the right orbit dir
 if ( $platfa == 'S1A' ) then
   set Orbit_dir = $Orbit_dir_a
 else if ( $platfa == 'S1B' ) then
   set Orbit_dir = $Orbit_dir_b
 endif
 set nonomatch
 if ( ! -e ${Orbit_dir}S1*_OPER_AUX_POEORB_OPOD_********T******_V${sc1_orb_date}T******_********T******.EOF ) then
   echo "ERROR: ${sc1_orb_date} precise orbit file(${Orbit_dir}S1*_OPER_AUX_POEORB_OPOD_********T******_V${sc1_orb_date}T******_********T******.EOF) does not exist"
   set sc1_OrbF = STD
 endif
 # sc2
 # First select the right orbit dir
 if ( $platfa == 'S1A' ) then
   set Orbit_dir = $Orbit_dir_a
 else if ( $platfa == 'S1B' ) then
   set Orbit_dir = $Orbit_dir_b
 endif
 if ( ! -e ${Orbit_dir}S1*_OPER_AUX_POEORB_OPOD_********T******_V${sc2_orb_date}T******_********T******.EOF ) then
   echo "ERROR: ${sc2_orb_date} precise orbit file(${Orbit_dir}S1*_OPER_AUX_POEORB_OPOD_********T******_V${sc2_orb_date}T******_********T******.EOF) does not exist"
   set sc2_OrbF = STD
 endif
 
 echo "Final sc1 and sc2 orbits"
 echo ${sc1_OrbF}
 echo ${sc2_OrbF}
 
 # *** Extract Sentinel-1 OPOD state vectors and copy into the ISP image parameter file ***
  #S1_OPOD_vec ${scene1}.slc.par S1*_OPER_AUX_POEORB_OPOD_20150121T123255_V20141230T225944_20150101T005944.EOF
  S1_OPOD_vec ${scene1}.slc.par ${Orbit_dir}S1*_OPER_AUX_POEORB_OPOD_********T******_V${sc1_orb_date}T******_********T******.EOF
  S1_OPOD_vec ${scene2}.slc.par ${Orbit_dir}S1*_OPER_AUX_POEORB_OPOD_********T******_V${sc2_orb_date}T******_********T******.EOF
 
 echo " "
 echo " "
 echo "============================================="
 echo " create hgt map of coreg master slc from DEM "
 echo "============================================="
 echo " "
 echo " "
 
 # *** Calculate lookup table and DEM related products for terrain-corrected geocoding ***
 set outres = 100 # Approximate output spatial resolution of your results in m
 set demresN=`awk '$1 == "post_north:" {print $2}' $DEM.dem_par`
 set ovrfactN=`echo $demresN $outres | awk '{print -1*($1/$2)}' `
 echo $ovrfactN
 set demresE=`awk '$1 == "post_east:" {print $2}' $DEM.dem_par`
 set ovrfactE=`echo $demresE $outres | awk '{print $1/$2}'` 
 echo $ovrfactE
 
 # *** Calculate lookup table and DEM related products for terrain-corrected geocoding ***
 # if fail exchange $scene1.slc.par for ${master}.slc.mli.par
 gc_map $scene1.Smli.par - $DEM.dem_par $DEM.dem ${sc1}_slc.dem_par ${sc1}_slc.dem ${sc1}_slc.sim_lut $ovrfactN $ovrfactE ${sc1}_slc.sim_dem ${sc1}_u ${sc1}_v ${sc1}_inc ${sc1}_psi ${sc1}_pix ${sc1}_ls_map 8 2 
 
 # *** Calculate terrain-based sigma0 and gammma0 normalization area in slant-range geometry ***
 pixel_area $scene1.Smli.par ${sc1}_slc.dem_par ${sc1}_slc.dem ${sc1}_slc.sim_lut ${sc1}_ls_map ${sc1}_inc ${sc1}_pix_sigma0 ${sc1}_pix_gamma0 
 
 # *** Generate 8-bit greyscale raster image of intensity data ***
 # N.B. output dimensions will be 1620 x 6658
 raspwr ${sc1}_pix_sigma0 ${mli1_width} - - ${ras_rng_mli} ${ras_azi_mli} - - - ${sc1}_pix_sigma0.bmp
 
 # *** Create DIFF/GEO parameter file for geocoding and differential interferometry ***
 create_diff_par $scene1.Smli.par - $scene1.diff_par 1 0 
 
 # *** Offset tracking between SLC images using intensity cross-correlation ***
 offset_pwrm ${sc1}_pix_sigma0 $scene1.Smli $scene1.diff_par ${scene1}_slc.offs ${scene1}_slc.ccp ${rng_win} ${rng_win} ${sc1}_offsets 2 ${nr} ${nr} 0.2 
 
 # *** Range and azimuth offset polynomial estimation using SVD ***
 offset_fitm ${scene1}_slc.offs ${scene1}_slc.ccp $scene1.diff_par ${sc1}_coffs ${sc1}_coffsets 0.2 1 
 
  # Get DEM_width
  # width_dem=`awk '$1 == "width:" {print $2}' geo/EQA.dem_par`
  # length_dem=`awk '$1 == "nlines:" {print $2}' geo/EQA.dem_par`
 set slc1_DEM_width = `grep width: ${sc1}_slc.dem_par | cut -c22-26`
 echo $slc1_DEM_width
  set slc1_DEM_lng = `grep nlines: ${sc1}_slc.dem_par | cut -c22-26`
 echo $slc1_DEM_lng
 
 # *** Geocoding lookup table refinement using DIFF_par offset polynomials ***
 gc_map_fine ${sc1}_slc.sim_lut $slc1_DEM_width $scene1.diff_par ${sc1}_slc.sim_lut_fine 1
 
  # Get slc1 width and lngth
  #width=`awk '$1 == "range_samples:" {print $2}' ${masterslcdir}/${master}.slc.mli.par`; #echo $width
  #length=`awk '$1 == "azimuth_lines:" {print $2}' ${masterslcdir}/${master}.slc.mli.par`; #echo $length
 set slc1_width = `grep range_samples: ${scene1}.Smli.par | cut -c31-36`
 echo $slc1_width
 set slc1_lng = `grep azimuth_lines: ${scene1}.Smli.par | cut -c31-36`
 echo $slc1_lng
 
 # *** Geocoding of image data using lookup table values  ***
 geocode_back ${scene1}.Smli $slc1_width ${sc1}_slc.sim_lut_fine ${scene1}.Smli.gc $slc1_DEM_width $slc1_DEM_lng 2 0
 
 # *** Generate 8-bit greyscale raster image of intensity data ***
 # N.B. output dimensions will be 772 x 810
 raspwr ${scene1}.Smli.gc $slc1_DEM_width - - ${ras_rng_mli} ${ras_azi_mli} - - - ${scene1}.Smli.gc.bmp
 raspwr ${scene1}.Smli.gc $slc1_DEM_width - - 1 1 - - - ${scene1}.Smli.gc_BIG.bmp
 
 # *** Forward geocoding transformation using a lookup table ***
 geocode ${sc1}_slc.sim_lut_fine ${sc1}_slc.dem $slc1_DEM_width ${scene1}_slc.hgt $slc1_width $slc1_lng 2 0 
 
 # *** Geocoding of image data using lookup table values  ***
 geocode_back ${scene1}_slc.hgt $slc1_width ${sc1}_slc.sim_lut_fine ${scene1}_slc.hgt.gc $slc1_DEM_width $slc1_DEM_lng - 0
 
 # *** Generate 8-bit raster graphics image of height and intensity ***
 rashgt ${scene1}_slc.hgt ${scene1}.Smli $slc1_width - - - ${ras_rng_mli} ${ras_azi_mli} 500 - - - ${scene1}_slc.hgt.bmp
 rashgt ${sc1}_slc.dem ${scene1}.Smli.gc $slc1_DEM_width - - - ${ras_rng_mli} ${ras_azi_mli} 500 - - - ${sc1}_slc.dem.bmp
 rashgt ${sc1}_slc.dem ${scene1}_slc.hgt.gc $slc1_DEM_width - - - ${ras_rng_mli} ${ras_azi_mli} 500 - - - ${scene1}_slc.hgt.gc.bmp
 
 # ======================================================================
 # not currently using water masked hgt in coregistration, but steps work
 # ======================================================================
 # mask out water areas where no inSAR coherence will be obtained
 set height_threshold = -5
 # *** Generate phase unwrapping validity mask using correlation and intensity ***
 rascc_mask ${scene1}_slc.hgt - $slc1_width - - - - - ${height_threshold} - 0 1 - - - ${scene1}_slc.hgt_mask.ras
 
 # *** Mask data using a Sun or BMP format raster image ***
 mask_data ${scene1}_slc.hgt $slc1_width ${scene1}.masked.hgt ${scene1}_slc.hgt_mask.ras 0 
 
 # *** Generate 8-bit raster graphics image of height and intensity ***
 rashgt ${scene1}.masked.hgt ${scene1}.Smli $slc1_width - - - ${ras_rng_mli} ${ras_azi_mli} 500 - - - ${scene1}.masked.hgt.bmp
  
 echo " "
 echo " "
 echo "========================="
 echo "Initial offset estimation"
 echo "========================="
 echo " "
 echo " "
 
 # *** Derive lookup table for SLC/MLI coregistration (considering terrain heights) ***
 rdc_trans ${scene1}.Smli.par ${scene1}_slc.hgt ${scene2}.Smli.par ${sc1}_${sc2}.Smli_LUT
 
 # generate SLC table for output resampled slave burst SLC
 echo "${scene2}_B1.rslc ${scene2}_B1.rslc.par ${scene2}_B1.rslc.TOPS_par" > RSLC2_tab.txt
 echo "${scene2}_B2.rslc ${scene2}_B2.rslc.par ${scene2}_B2.rslc.TOPS_par" >> RSLC2_tab.txt
 echo "${scene2}_B3.rslc ${scene2}_B3.rslc.par ${scene2}_B3.rslc.TOPS_par" >> RSLC2_tab.txt
 
 # *** Resample TOPS (IW mode) SLC using a lookup table and SLC offset polynomials for refinement ***
 SLC_interp_lt_S1_TOPS SLC2_tab.txt ${scene2}.slc.par SLC1_tab.txt ${scene1}.slc.par ${sc1}_${sc2}.Smli_LUT $scene1.Smli.par $scene2.Smli.par - RSLC2_tab.txt ${scene2}.rslc ${scene2}.rslc.par
  
 # *** Calculate a multi-look intensity (MLI) image from an SLC image ***
 multi_look ${scene2}.rslc ${scene2}.rslc.par ${scene2}.rmli ${scene2}.rmli.par ${rng_lks} ${azi_lks}
 
 # *** Generate 8-bit greyscale raster image of intensity data ***
 raspwr ${scene2}.rmli $slc1_width - - ${ras_rng_mli} ${ras_azi_mli} - - - ${scene2}.rmli.bmp
  
# ==============================================================================================
# ==============================================================================================
# CoRegSLC2FT processing
# ==============================================================================================
# ==============================================================================================

 # *** Create and update ISP offset and interferogram parameter files ***
 yes '' | create_offset ${scene1}.slc.par ${scene2}.rslc.par ${sc1}_${sc2}.offT_init 1

# set off thres - old gamma was thres2(4.0), but in Dec 2015 gamma onwards must be number between 0 and 1 
 set off_thres_init = 0.00
 echo $off_thres_init
 set off_thres = 0.05
 echo $off_thres

# *** Offset tracking between SLC images using intensity cross-correlation ***
# N.B. ccpN is new snrN
 offset_pwr_tracking ${scene1}.slc ${scene2}.rslc ${scene1}.slc.par ${scene2}.rslc.par ${sc1}_${sc2}.offT_init ${sc1}_${sc2}.offsN_init ${sc1}_${sc2}.ccpN_init $off_Rwin2 $off_Awin2 ${sc1}_${sc2}.offsetsN_init 1 $off_thres_init $Rstep $Astep - - - - 4 0 - ${sc1}_${sc2}.ccsN_init

 # *** Create and update ISP offset and interferogram parameter files ***
 yes '' | create_offset ${scene1}.slc.par ${scene2}.rslc.par ${sc1}_${sc2}.offT 1

 offset_pwr_tracking2 ${scene1}.slc ${scene2}.rslc ${scene1}.slc.par ${scene2}.rslc.par ${sc1}_${sc2}.offT ${sc1}_${sc2}.offsN ${sc1}_${sc2}.ccpN ${sc1}_${sc2}.offT_init ${sc1}_${sc2}.offsN_init $off_Rwin2_adap $off_Awin2_adap ${sc1}_${sc2}.offsetsN 1 $off_thres $Rstep_adap $Astep_adap - - - - 4 0 - ${sc1}_${sc2}.ccsN
 
 # *** Conversion of range and azimuth offsets files to displacement map ***
 offset_tracking ${sc1}_${sc2}.offsN ${sc1}_${sc2}.ccpN ${scene1}.slc.par ${sc1}_${sc2}.offT ${sc1}_${sc2}.coffsN ${sc1}_${sc2}.coffsetsN $disp_mode $off_thres $poly_flag
 
 set off_width = `grep offset_estimation_range_samples: ${sc1}_${sc2}.offT | cut -c39-42`
 echo $off_width
 set off_lng = `grep offset_estimation_azimuth_samples: ${sc1}_${sc2}.offT | cut -c39-42`
 echo $off_lng
 
 # *** Calculate a multi-look intensity (MLI) image from an SLC image ***
 multi_look ${scene1}.slc ${scene1}.slc.par ${scene1}.mli ${scene1}.mli.par 1 1
 
 #set slc_width = `grep offset_estimation_ending_range: ${sc1}_${sc2}.off | cut -c38-42`
 set slc_width = `grep interferogram_width: ${sc1}_${sc2}.offT | cut -c38-43`
 echo $slc_width
 #set slc_length = `grep offset_estimation_ending_azimuth: ${sc1}_${sc2}.off | cut -c38-42`
 set slc_length = `grep interferogram_azimuth_lines: ${sc1}_${sc2}.offT | cut -c38-43`
 echo $slc_length
 set Rsamp_width = `grep offset_estimation_range_spacing: ${sc1}_${sc2}.offT | cut -c39-42`
 echo $Rsamp_width
 set Asamp_length = `grep offset_estimation_azimuth_spacing: ${sc1}_${sc2}.offT | cut -c40-42`
 echo $Asamp_length
 #multi_real 20140809_B1.mli 0921_B1.off test2.pwr1 test2.offN2 48 32 12 17908 12 19897

 # *** Calculate multi-look averaged or interpolated 2D image (float data) ***
 multi_real ${scene1}.mli ${sc1}_${sc2}.offT ${scene1}.pwr1 ${sc1}_${sc2}.offN2 $Rsamp_width $Asamp_length 0 $slc_length 0 $slc_width
 
 # *** Generate 8-bit greyscale raster image of intensity data ***
 raspwr ${scene1}.pwr1 $off_width 1 0 1 1 1 .35 - ${scene1}.pwr1.bmp
 
 # *** calculate real part, imaginary part, intensity, magnitude, or phase from FCOMPLEX data ***
 cpx_to_real ${sc1}_${sc2}.coffsN ${sc1}_${sc2}.coffsN_real $off_width 0
 cpx_to_real ${sc1}_${sc2}.coffsN ${sc1}_${sc2}.coffsN_im $off_width 1
 cpx_to_real ${sc1}_${sc2}.coffsN ${sc1}_${sc2}.coffsN_mag $off_width 3
 
 # *** Generate 8-bit raster graphics image of height and intensity ***
 #rashgt ${sc1}_${sc2}.coffsN_real ${scene1}.pwr1 $off_width 1 1 0 1 1 $col_ramp
 #rashgt ${sc1}_${sc2}.coffsN_im ${scene1}.pwr1 $off_width 1 1 0 1 1 $col_ramp
 #rashgt ${sc1}_${sc2}.coffsN_mag ${scene1}.pwr1 $off_width 1 1 0 1 1 $col_ramp
 
 # *** Generate 24-bit raster graphics image of deformation or phase + intensity data ***
 rasdt_pwr24 ${sc1}_${sc2}.coffsN_real ${scene1}.pwr1 $off_width 1 1 0 1 1 $col_ramp 1. .35 1 ${sc1}_${sc2}.coffsN_real.bmp
 rasdt_pwr24 ${sc1}_${sc2}.coffsN_im ${scene1}.pwr1 $off_width 1 1 0 1 1 $col_ramp 1. .35 1 ${sc1}_${sc2}.coffsN_im.bmp
 rasdt_pwr24 ${sc1}_${sc2}.coffsN_mag ${scene1}.pwr1 $off_width 1 1 0 1 1 $col_ramp 1. .35 1 ${sc1}_${sc2}.coffsN_mag.bmp
 
  set col_ramp2 = 100.
 
 rasdt_pwr24 ${sc1}_${sc2}.coffsN_real ${scene1}.pwr1 $off_width 1 1 0 1 1 $col_ramp2 1. .35 1 ${sc1}_${sc2}.coffsN_c100real.bmp
 rasdt_pwr24 ${sc1}_${sc2}.coffsN_im ${scene1}.pwr1 $off_width 1 1 0 1 1 $col_ramp2 1. .35 1 ${sc1}_${sc2}.coffsN_c100im.bmp
 rasdt_pwr24 ${sc1}_${sc2}.coffsN_mag ${scene1}.pwr1 $off_width 1 1 0 1 1 $col_ramp2 1. .35 1 ${sc1}_${sc2}.coffsN_c100mag.bmp
 
 # make raster of SNR
 # *** Generate 24-bit raster graphics image of deformation or phase + intensity data ***
 rasdt_pwr24 ${sc1}_${sc2}.ccpN ${scene1}.pwr1 $off_width 1 1 0 1 1 1. 1. .35 - ${sc1}_${sc2}.1mccp.bmp
 
 # -----------------------------
 # filter and dust the IV result
 # -----------------------------
 # set var's
 set fmax = 0.3
 echo "fmax"
 echo $fmax
 
 set win = 10
 echo "win"
 echo $win
 
 # set up python libs
 app setup canopy python-libs
 
 # filter
 /nfs/a41/S1_CPOM_www/post_proc_scr/gaussian_filter.py ${sc1}_${sc2}.coffsN_mag float32 $off_width $off_lng ${sc1}_${sc2}.coffsN_mag_Fil -w $win -fmax $fmax
 
 # *** Generate 24-bit raster graphics image of deformation or phase + intensity data ***
 rasdt_pwr24 ${sc1}_${sc2}.coffsN_mag_Fil ${scene1}.pwr1 $off_width 1 1 0 $ras_rng_mli $ras_azi_mli $col_ramp2 1. .35 1 ${sc1}_${sc2}.coffsN_mag_Fil.bmp
 
 # dust
 /nfs/a41/S1_CPOM_www/post_proc_scr/dust_filter.py ${sc1}_${sc2}.coffsN_mag_Fil float32 $off_width $off_lng ${sc1}_${sc2}.coffsN_mag_DuFil

 # *** Generate 24-bit raster graphics image of deformation or phase + intensity data ***
 rasdt_pwr24 ${sc1}_${sc2}.coffsN_mag_DuFil ${scene1}.pwr1 $off_width 1 1 0 $ras_rng_mli $ras_azi_mli $col_ramp2 1. .35 1 ${sc1}_${sc2}.coffsN_mag_DuFil.bmp
 
 # ========================================================
 # delete preprocessing files nolonger needed - save space!
 # ========================================================
 #sc1
 rm -rf ${scene1}_B1.slc.par
 rm -rf ${scene1}_B1.slc
 rm -rf ${scene1}_B1.TOPS_par
 rm -rf ${scene1}_B2.slc.par
 rm -rf ${scene1}_B2.slc
 rm -rf ${scene1}_B2.TOPS_par
 rm -rf ${scene1}_B3.slc.par
 rm -rf ${scene1}_B3.slc
 rm -rf ${scene1}_B3.TOPS_par
 rm -rf ${scene1}_B1_deramp.slc
 rm -rf ${scene1}_B1_deramp.slc.par
 rm -rf ${scene1}_B1_deramp.TOPS_par
 rm -rf ${scene1}_B1_deramp.slc.dph
 rm -rf ${scene1}_B2_deramp.slc
 rm -rf ${scene1}_B2_deramp.slc.par
 rm -rf ${scene1}_B2_deramp.TOPS_par
 rm -rf ${scene1}_B2_deramp.slc.dph
 rm -rf ${scene1}_B3_deramp.slc
 rm -rf ${scene1}_B3_deramp.slc.par
 rm -rf ${scene1}_B3_deramp.TOPS_par
 rm -rf ${scene1}_B3_deramp.slc.dph
 #sc2
 rm -rf ${scene2}_B1.rslc.TOPS_par
 rm -rf ${scene2}_B1.rslc
 rm -rf ${scene2}_B1_deramp.rslc
 rm -rf ${scene2}_B1.rslc.par
 rm -rf ${scene2}_B1.slc.par
 rm -rf ${scene2}_B1.slc
 rm -rf ${scene2}_B1.TOPS_par
 rm -rf ${scene2}_B2.rslc.TOPS_par
 rm -rf ${scene2}_B2.rslc
 rm -rf ${scene2}_B2_deramp.rslc
 rm -rf ${scene2}_B2.rslc.par
 rm -rf ${scene2}_B2.slc.par
 rm -rf ${scene2}_B2.slc
 rm -rf ${scene2}_B2.TOPS_par
 rm -rf ${scene2}_B3.rslc.TOPS_par
 rm -rf ${scene2}_B3.rslc
 rm -rf ${scene2}_B3_deramp.rslc
 rm -rf ${scene2}_B3.rslc.par
 rm -rf ${scene2}_B3.slc.par
 rm -rf ${scene2}_B3.slc
 rm -rf ${scene2}_B3.TOPS_par
 rm -rf ${sc1}_offsets 
 rm -rf ${sc1}_coffs 
 rm -rf ${sc1}_coffsets 
 rm -rf ${scene1}.diff_par 
 rm -rf ${scene1}_slc.offs 
 rm -rf ${scene1}_slc.ccp
 rm -rf ${sc1}_u
 rm -rf ${sc1}_v 
 rm -rf ${sc1}_inc 
 rm -rf ${sc1}_psi 
 rm -rf ${sc1}_pix 
 rm -rf ${sc1}_ls_map 
 rm -rf ${sc1}_inc 
 rm -rf ${sc1}_pix_sigma0 
 rm -rf ${sc1}_pix_gamma0 
 
 # ====================================
 # scale to m/yr and geocoding with DEM
 # ====================================
 
	#gc_map ${scene1}.mli.par - ${DEM}.dem_par ${DEM}.dem B1km_${sc1}.dem_seg_par B1km_${sc1}.dem_seg B1km_${sc1}.dem_LUT ${DEM_ovr_Fi} ${DEM_ovr_Fi}
	#set DEMwidth = `grep width: B1km_${sc1}.dem_seg_par | cut -c22-26`
	#echo $DEMwidth
	#set DEMlength = `grep nlines: B1km_${sc1}.dem_seg_par | cut -c22-26`
	#echo $DEMlength
	#geocode_back ${scene1}.mli $mli1_width B1km_${sc1}.dem_LUT ${scene1}.mli.gc $DEMwidth $DEMlength - 0
	#raspwr ${scene1}.mli.gc $DEMwidth
	
	# scale IV to m/yr
	#-----------------
	set lincb_fctr = `echo 365/${temp_B} | bc -l`
	echo $lincb_fctr
	lin_comb 1 ${sc1}_${sc2}.coffsN_mag 0.0 $lincb_fctr ${sc1}_${sc2}.coffsN_mag_yr $off_width
	lin_comb 1 ${sc1}_${sc2}.coffsN_mag_DuFil 0.0 $lincb_fctr ${sc1}_${sc2}.coffsN_mag_DuFil_yr $off_width
	lin_comb 1 ${sc1}_${sc2}.coffsN_mag_Fil 0.0 $lincb_fctr ${sc1}_${sc2}.coffsN_mag_Fil_yr $off_width
	replace_values ${sc1}_${sc2}.coffsN_mag_yr $max_yr_IV 0.000 ${sc1}_${sc2}.coffsN_mag_yrF $off_width 1 2
	replace_values ${sc1}_${sc2}.coffsN_mag_DuFil_yr $max_yr_IV 0.000 ${sc1}_${sc2}.coffsN_mag_DuFil_yrF $off_width 1 2
	replace_values ${sc1}_${sc2}.coffsN_mag_Fil_yr $max_yr_IV 0.000 ${sc1}_${sc2}.coffsN_mag_Fil_yrF $off_width 1 2
	set col_ramp_YR = 1000.
	rasdt_pwr24 ${sc1}_${sc2}.coffsN_mag_yrF ${scene1}.pwr1 $off_width 1 1 0 1 1 $col_ramp_YR 1. .35 1 ${sc1}_${sc2}.coffsN_mag_yrF.bmp
	rasdt_pwr24 ${sc1}_${sc2}.coffsN_mag_yrF - $off_width 1 1 0 1 1 $col_ramp_YR 1. .35 1 ${sc1}_${sc2}.coffsN_mag_yrF_blk.bmp
	rasdt_pwr24 ${sc1}_${sc2}.coffsN_mag_DuFil_yrF ${scene1}.pwr1 $off_width 1 1 0 1 1 $col_ramp_YR 1. .35 1 ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.bmp
	convert -transparent black ${sc1}_${sc2}.coffsN_mag_yrF_blk.bmp ${sc1}_${sc2}.coffsN_mag_yrF_transp.bmp
	
	#  make mli image the same size as the geocoded offset image
	# ----------------------------------------------------------
	
	set real_rlk = `grep offset_estimation_range_spacing: ${sc1}_${sc2}.offT | cut -c41-42`
	echo $real_rlk
	set real_azlk = `grep offset_estimation_azimuth_spacing: ${sc1}_${sc2}.offT | cut -c41-42`
	echo $real_azlk
	set loff = `grep offset_estimation_starting_azimuth: ${sc1}_${sc2}.offT | cut -c41-42`
	echo $loff
	set nlines = `grep offset_estimation_ending_azimuth: ${sc1}_${sc2}.offT | cut -c38-42`
	echo $nlines
	multi_look ${scene1}.slc ${scene1}.slc.par ${scene1}.mligc ${scene1}.mligc.par $real_rlk $real_azlk $loff $nlines
	
	# geocode - 100 m
	#----------------
	
	# *** Calculate lookup table and DEM related products for terrain-corrected geocoding ***
	#gc_map ${scene1}.mligc.par - ${DEM}.dem_par ${DEM}.dem B1km_${sc1}_${sc2}.dem_seg_par B1km_${sc1}_${sc2}.dem_seg B1km_${sc1}_${sc2}.dem_LUT ${DEM_ovr} ${DEM_ovr}
	gc_map ${scene1}.mligc.par - ${DEM}.dem_par ${DEM}.dem B1km_${sc1}_${sc2}.dem_seg_par B1km_${sc1}_${sc2}.dem_seg B1km_${sc1}_${sc2}.dem_LUT $ovrfactN $ovrfactE
	set FT_DEMwidth = `grep width: B1km_${sc1}_${sc2}.dem_seg_par | cut -c22-26`
	echo $FT_DEMwidth
	set FT_DEMlength = `grep nlines: B1km_${sc1}_${sc2}.dem_seg_par | cut -c22-26`
	echo $FT_DEMlength
	# *** Geocoding of image data using lookup table values  ***
	geocode_back ${sc1}_${sc2}.coffsN_mag_yrF $off_width B1km_${sc1}_${sc2}.dem_LUT ${sc1}_${sc2}.coffsN_mag_yrF.gc $FT_DEMwidth -
	geocode_back ${scene1}.mligc $off_width B1km_${sc1}_${sc2}.dem_LUT ${scene1}.mligc.gc $FT_DEMwidth $FT_DEMlength - 0
	geocode_back ${sc1}_${sc2}.ccpN $off_width B1km_${sc1}_${sc2}.dem_LUT ${sc1}_${sc2}.ccpN.gc $FT_DEMwidth 
	geocode_back ${sc1}_${sc2}.coffsN_mag_DuFil_yrF $off_width B1km_${sc1}_${sc2}.dem_LUT ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc $FT_DEMwidth -
	geocode_back ${sc1}_${sc2}.coffsN_mag_Fil_yrF $off_width B1km_${sc1}_${sc2}.dem_LUT ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc $FT_DEMwidth -
	
	# *** Generate 24-bit raster graphics image of deformation or phase + intensity data ***
	rasdt_pwr24 ${sc1}_${sc2}.ccpN.gc ${scene1}.mligc.gc $FT_DEMwidth 1 1 0 1 1 1. 1. .35 - ${sc1}_${sc2}.ccpN.gc.bmp
	raspwr ${scene1}.mligc.gc $FT_DEMwidth - - 1 1 - - - ${scene1}.mligc.gc.bmp
	rasdt_pwr24 ${sc1}_${sc2}.coffsN_mag_yrF.gc - $FT_DEMwidth 1 1 0 1 1 $col_ramp_YR 1. .35 1 ${sc1}_${sc2}.coffsN_mag_yrF_blk.gc.bmp
	rasdt_pwr24 ${sc1}_${sc2}.coffsN_mag_yrF.gc ${scene1}.mligc.gc $FT_DEMwidth 1 1 0 1 1 $col_ramp_YR 1. .35 1 ${sc1}_${sc2}.coffsN_mag_yrF.gc.bmp
	convert -transparent black ${sc1}_${sc2}.coffsN_mag_yrF_blk.gc.bmp ${sc1}_${sc2}.coffsN_mag_yrF_transp.gc.bmp
	rasdt_pwr24 ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc ${scene1}.mligc.gc $FT_DEMwidth 1 1 0 1 1 $col_ramp_YR 1. .35 1 ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc.bmp
	
	# geocode - 500 m
	#----------------
	
	set outres = 500 # Approximate output spatial resolution of your results in m
	set demresN=`awk '$1 == "post_north:" {print $2}' $DEM.dem_par`
	set ovrfactN=`echo $demresN $outres | awk '{print -1*($1/$2)}' `
	echo $ovrfactN
	set demresE=`awk '$1 == "post_east:" {print $2}' $DEM.dem_par`
	set ovrfactE=`echo $demresE $outres | awk '{print $1/$2}'` 
	echo $ovrfactE
 
	# *** Calculate lookup table and DEM related products for terrain-corrected geocoding ***
	# if fail exchange $scene1.slc.par for ${master}.slc.mli.par
	gc_map ${scene1}.mligc.par - ${DEM}.dem_par ${DEM}.dem B5km_${sc1}_${sc2}.dem_seg_par B5km_${sc1}_${sc2}.dem_seg B5km_${sc1}_${sc2}.dem_LUT $ovrfactN $ovrfactE
	set FT5_DEMwidth = `grep width: B5km_${sc1}_${sc2}.dem_seg_par | cut -c22-26`
	echo $FT5_DEMwidth
	set FT5_DEMlength = `grep nlines: B5km_${sc1}_${sc2}.dem_seg_par | cut -c22-26`
	echo $FT5_DEMlength
	# *** Geocoding of image data using lookup table values  ***
	geocode_back ${sc1}_${sc2}.coffsN_mag_yrF $off_width B5km_${sc1}_${sc2}.dem_LUT ${sc1}_${sc2}.coffsN_mag_yrF.5gc $FT5_DEMwidth -
	geocode_back ${scene1}.mligc $off_width B5km_${sc1}_${sc2}.dem_LUT ${scene1}.mligc.5gc $FT5_DEMwidth $FT5_DEMlength - 0
	geocode_back ${sc1}_${sc2}.ccpN $off_width B5km_${sc1}_${sc2}.dem_LUT ${sc1}_${sc2}.ccpN.5gc $FT5_DEMwidth 
	geocode_back ${sc1}_${sc2}.coffsN_mag_DuFil_yrF $off_width B5km_${sc1}_${sc2}.dem_LUT ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.5gc $FT5_DEMwidth -
	geocode_back ${sc1}_${sc2}.coffsN_mag_Fil_yrF $off_width B5km_${sc1}_${sc2}.dem_LUT ${sc1}_${sc2}.coffsN_mag_Fil_yrF.5gc $FT5_DEMwidth -
	
	# *** Generate 24-bit raster graphics image of deformation or phase + intensity data ***
	rasdt_pwr24 ${sc1}_${sc2}.ccpN.5gc ${scene1}.mligc.5gc $FT5_DEMwidth 1 1 0 1 1 1. 1. .35 - ${sc1}_${sc2}.ccpN.5gc.bmp
	raspwr ${scene1}.mligc.5gc $FT5_DEMwidth - - 1 1 - - - ${scene1}.mligc.5gc.bmp
	rasdt_pwr24 ${sc1}_${sc2}.coffsN_mag_yrF.5gc - $FT5_DEMwidth 1 1 0 1 1 $col_ramp_YR 1. .35 1 ${sc1}_${sc2}.coffsN_mag_yrF_blk.5gc.bmp
	rasdt_pwr24 ${sc1}_${sc2}.coffsN_mag_yrF.5gc ${scene1}.mligc.5gc $FT5_DEMwidth 1 1 0 1 1 $col_ramp_YR 1. .35 1 ${sc1}_${sc2}.coffsN_mag_yrF.5gc.bmp
	convert -transparent black ${sc1}_${sc2}.coffsN_mag_yrF_blk.5gc.bmp ${sc1}_${sc2}.coffsN_mag_yrF_transp.5gc.bmp
	rasdt_pwr24 ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.5gc ${scene1}.mligc.5gc $FT5_DEMwidth 1 1 0 1 1 $col_ramp_YR 1. .35 1 ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.5gc.bmp
	
	# make tiffs
	#-----------
	
	# *** DISP data2geotiff: convert geocoded data with DEM parameter file to GeoTIFF format ***
	data2geotiff B1km_${sc1}_${sc2}.dem_seg_par ${scene1}.mligc.gc 2 ${scene1}.mligc.gc.tiff
	data2geotiff B1km_${sc1}_${sc2}.dem_seg_par ${scene1}.mligc.gc.bmp 0 ${scene1}.mligc.gc.bmp.tiff
	data2geotiff B1km_${sc1}_${sc2}.dem_seg_par ${sc1}_${sc2}.coffsN_mag_yrF.gc 2 ${sc1}_${sc2}.coffsN_mag_yrF.gc.tiff
	data2geotiff B1km_${sc1}_${sc2}.dem_seg_par ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc 2 ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc.tiff
	#data2geotiff B1km_${sc1}_${sc2}.dem_seg_par ${sc1}_${sc2}.coffsN_mag_yrF_blk.gc.bmp 0 ${sc1}_${sc2}.coffsN_mag_yrF_blk.gc.bmp.tiff
	data2geotiff B1km_${sc1}_${sc2}.dem_seg_par ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc.bmp 0 ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc.bmp.tiff
	data2geotiff B1km_${sc1}_${sc2}.dem_seg_par ${sc1}_${sc2}.coffsN_mag_yrF.gc.bmp 0 ${sc1}_${sc2}.coffsN_mag_yrF.gc.bmp.tiff
	data2geotiff B1km_${sc1}_${sc2}.dem_seg_par ${sc1}_${sc2}.ccpN.gc 2 ${sc1}_${sc2}.ccpN.gc.tiff
	data2geotiff B1km_${sc1}_${sc2}.dem_seg_par ${sc1}_${sc2}.ccpN.gc.bmp 0 ${sc1}_${sc2}.ccpN.gc.bmp.tiff
	
	data2geotiff B5km_${sc1}_${sc2}.dem_seg_par ${sc1}_${sc2}.coffsN_mag_yrF.5gc 2 ${sc1}_${sc2}.coffsN_mag_yrF.5gc.tiff
	data2geotiff B5km_${sc1}_${sc2}.dem_seg_par ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.5gc 2 ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.5gc.tiff
	data2geotiff B5km_${sc1}_${sc2}.dem_seg_par ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.5gc.bmp 0 ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.5gc.bmp.tiff
	data2geotiff B5km_${sc1}_${sc2}.dem_seg_par ${sc1}_${sc2}.coffsN_mag_yrF.5gc.bmp 0 ${sc1}_${sc2}.coffsN_mag_yrF.5gc.bmp.tiff
	data2geotiff B5km_${sc1}_${sc2}.dem_seg_par ${sc1}_${sc2}.ccpN.5gc 2 ${sc1}_${sc2}.ccpN.5gc.tiff
	data2geotiff B5km_${sc1}_${sc2}.dem_seg_par ${sc1}_${sc2}.ccpN.5gc.bmp 0 ${sc1}_${sc2}.ccpN.5gc.bmp.tiff
	
	data2geotiff B1km_${sc1}_${sc2}.dem_seg_par ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc 2 ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc.tiff
	data2geotiff B5km_${sc1}_${sc2}.dem_seg_par ${sc1}_${sc2}.coffsN_mag_Fil_yrF.5gc 2 ${sc1}_${sc2}.coffsN_mag_Fil_yrF.5gc.tiff
	
	# make fine geocoded mli
	# ----------------------
	
	set real_rlk = 10
	echo $real_rlk
	set real_azlk = 2
	echo $real_azlk
	set loff = 0
	echo $loff
	set nlines = `grep offset_estimation_ending_azimuth: ${sc1}_${sc2}.offT | cut -c38-42`
	echo $nlines
	multi_look ${scene1}.slc ${scene1}.slc.par ${scene1}.mliFgc ${scene1}.mliFgc.par $real_rlk $real_azlk $loff $nlines
	
	
	# *** Calculate lookup table and DEM related products for terrain-corrected geocoding ***
	gc_map ${scene1}.mliFgc.par - ${DEM}.dem_par ${DEM}.dem B1km_${sc1}.dem_seg_par B1km_${sc1}.dem_seg B1km_${sc1}.dem_LUT ${DEM_ovr_Fi} ${DEM_ovr_Fi}
	set DEMwidth = `grep width: B1km_${sc1}.dem_seg_par | cut -c22-26`
	echo $DEMwidth
	set DEMlength = `grep nlines: B1km_${sc1}.dem_seg_par | cut -c22-26`
	echo $DEMlength
	
	set Fmli1_width = `grep range_samples: ${scene1}.mliFgc.par | cut -c31-36`
    echo $Fmli1_width
	# *** Geocoding of image data using lookup table values  ***
	geocode_back ${scene1}.mliFgc $Fmli1_width B1km_${sc1}.dem_LUT ${scene1}.mliFgc.gc $DEMwidth $DEMlength - 0
	# *** Generate 8-bit greyscale raster image of intensity data ***
	raspwr ${scene1}.mliFgc.gc $DEMwidth - - 1 1 - - - ${scene1}.mliFgc.gc.bmp
	
	# *** DISP data2geotiff: convert geocoded data with DEM parameter file to GeoTIFF format ***
	data2geotiff B1km_${sc1}.dem_seg_par ${scene1}.mliFgc.gc 2 ${scene1}.mliFgc.gc.tiff
	data2geotiff B1km_${sc1}.dem_seg_par ${scene1}.mliFgc.gc.bmp 0 ${scene1}.mliFgc.gc.bmp.tiff

 # ====================================
 # extract IV data alongtransect
 # ====================================
 
 # get transect for AOI
 cd /nfs/a41/S1_CPOM_www/transects/WWW/
 cp ${AOI}_transect_pnts_v1.txt ${out_dir}
 cp ${AOI}_gate_pnts_v1.txt ${out_dir}
 
 cp ${AOI}_gate_dist_v1.txt ${out_dir}
 cp ${AOI}_transect_dist_v1.txt ${out_dir}
 cd ${out_dir}
 
 dos2unix ${AOI}_transect_pnts_v1.txt
 dos2unix ${AOI}_gate_pnts_v1.txt
 dos2unix ${AOI}_gate_dist_v1.txt
 dos2unix ${AOI}_transect_dist_v1.txt

 #------------------
 # TRANSECT retrieve
 #------------------
 # *** make output *.*.mli.CFLgcp.Co.txt
 set Co_FN = gcp
 echo '' > ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN}.temp
 
 # *** determine no of gcp's in text file ***
 set rows = `wc -l ${AOI}_transect_pnts_v1.txt | awk '{print $1}'`
 echo $rows
 
 # *** remove commas ***
 sed -e "s/,/ /g" < ${AOI}_transect_pnts_v1.txt > Cfree.txt

 # loop start!:
 foreach i ( `seq 1 ${rows}` )

 # *** ectract row and col no ***
 # N.B. idl row 1 goes into: matlab col 1, goes into: gamma col 2, goes into: Qgis col 1(var X). idl row 2 goes into: matlab col 2, goes into: gamma col 1, goes into: Qgis col 4 (varY)
 #set azlin = `cat Cfree.txt | awk "FNR == $i {print $1}"`
 set azlin = `awk "FNR == $i" Cfree.txt | awk '{print $1}'`
 # col 1
 echo ${azlin}
 #set rpix = `cat Cfree.txt | awk "FNR == $i {print $2}"`
 set rpix = `awk "FNR == $i" Cfree.txt | awk '{print $2}'`
 # col 2
 echo ${rpix}
 
	 ## *** convert row and col no's to ccordinates ***
	 ## *** Transform SAR image coordinates to map projection or geographic (lat/lon) coordinates ***
	 #sarpix_coord ${scene1}.mli.par - $DEM.dem_par $azlin $rpix > coord.txtl
 
 # convert PS coordinate points to pixels
 # *** Calculate SAR pixel coordinates (iazpix,jrpix) of geographic coordinate ***
 coord_to_sarpix ${scene1}.mligc.par - B1km_${sc1}_${sc2}.dem_seg_par $rpix $azlin 0 > coord.txt

 # *** extract geographic ccordinates ***
 set azcoord = `cat coord.txt | awk 'FNR == 18 {print $6}'`
 echo $azcoord
 set rcoord = `cat coord.txt | awk 'FNR == 18 {print $7}'`
 echo $rcoord
 
 # remove pix location file for a specific set of coordinates
 rm -rf coord.txt
 
 # *** write extracted coordinates to text file ***
 echo $i $azcoord $rcoord 0 >> ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN}.temp

 # loop end!:
 end
 
 # remove blank line at start
 grep '[^[:blank:]]' < ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN}.temp > ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN}
 
 # remove PS coordinate file for transect without comma separation
  rm -rf Cfree.txt
  rm -rf ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN}.temp
 
 # extract IV from non-geocoded image
 # *** Extract unwrapped phase at GCP locations ***
 set Co_FNex = ${Co_FN}ex
 gcp_phase ${sc1}_${sc2}.coffsN_mag_yrF ${sc1}_${sc2}.offN2 ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN} ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FNex}
 gcp_phase ${sc1}_${sc2}.coffsN_mag_DuFil_yrF ${sc1}_${sc2}.offN2 ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN} ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.${Co_FNex}
 gcp_phase ${sc1}_${sc2}.coffsN_mag_Fil_yrF ${sc1}_${sc2}.offN2 ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN} ${sc1}_${sc2}.coffsN_mag_Fil_yrF.${Co_FNex}
 gcp_phase ${sc1}_${sc2}.ccpN ${sc1}_${sc2}.offN2 ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN} ${sc1}_${sc2}.ccpN.${Co_FNex}
 gcp_phase ${scene1}_slc.hgt ${sc1}_${sc2}.offN2 ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN} ${scene1}_slc.hgt.${Co_FNex}
 #gcp_phase ${sc1}_${sc2}.coffsN_mag_yrF ${sc1}_${sc2}.offT test.txt test.txt.gcpex
 
 # FIX GCP data in rows where nothing extracted
# identify missing rows and fill with 'dummy data': 1251     000.00000     000.00000       0.00000       0.00000

#- input / output files:
set inFile="${sc1}_${sc2}.coffsN_mag_yrF.${Co_FNex}"
set outFile="${sc1}_${sc2}.coffsN_mag_yrF.${Co_FNex}_fix"
	#- expected last line:
	set lastLine=`tail -1 ${inFile} | awk '{print $1}'`
	#- init output file:
	cat >! ${outFile} < /dev/null
	#- read through the file:
	foreach line ( `seq 1 ${lastLine}` )
	   #- search for line, or make it up:
	   #egrep "^\s+?${line} " ${inFile} >> ${outFile} || \
	   #echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	    egrep "^\s+?${line} " ${inFile} | awk -v fnm=$outFile '{if (($2<0) || ($3<0)) {printf "%6s     000.00000     000.00000       0.00000       0.00000\n", $1 >> fnm} else { printf "%6s %13s %13s %13s %13s\n", $1, $2, $3, $4, $5 >> fnm}}' || echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	end
#- input / output files:
set inFile="${sc1}_${sc2}.ccpN.${Co_FNex}"
set outFile="${sc1}_${sc2}.ccpN.${Co_FNex}_fix"
	#- expected last line:
	set lastLine=`tail -1 ${inFile} | awk '{print $1}'`
	#- init output file:
	cat >! ${outFile} < /dev/null
	#- read through the file:
	foreach line ( `seq 1 ${lastLine}` )
	   #- search for line, or make it up:
	   #egrep "^\s+?${line} " ${inFile} >> ${outFile} || \
	   #echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	    egrep "^\s+?${line} " ${inFile} | awk -v fnm=$outFile '{if (($2<0) || ($3<0)) {printf "%6s     000.00000     000.00000       0.00000       0.00000\n", $1 >> fnm} else { printf "%6s %13s %13s %13s %13s\n", $1, $2, $3, $4, $5 >> fnm}}' || echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	end
#- input / output files:
set inFile="${scene1}_slc.hgt.${Co_FNex}"
set outFile="${scene1}_slc.hgt.${Co_FNex}_fix"
	#- expected last line:
	set lastLine=`tail -1 ${inFile} | awk '{print $1}'`
	#- init output file:
	cat >! ${outFile} < /dev/null
	#- read through the file:
	foreach line ( `seq 1 ${lastLine}` )
	   #- search for line, or make it up:
	   #egrep "^\s+?${line} " ${inFile} >> ${outFile} || \
	   #echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	    egrep "^\s+?${line} " ${inFile} | awk -v fnm=$outFile '{if (($2<0) || ($3<0)) {printf "%6s     000.00000     000.00000       0.00000       0.00000\n", $1 >> fnm} else { printf "%6s %13s %13s %13s %13s\n", $1, $2, $3, $4, $5 >> fnm}}' || echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	end
#- input / output files:
set inFile="${sc1}_${sc2}.coffsN_mag_DuFil_yrF.${Co_FNex}"
set outFile="${sc1}_${sc2}.coffsN_mag_DuFil_yrF.${Co_FNex}_fix"
	#- expected last line:
	set lastLine=`tail -1 ${inFile} | awk '{print $1}'`
	#- init output file:
	cat >! ${outFile} < /dev/null
	#- read through the file:
	foreach line ( `seq 1 ${lastLine}` )
	   #- search for line, or make it up:
	   #egrep "^\s+?${line} " ${inFile} >> ${outFile} || \
	   #echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	    egrep "^\s+?${line} " ${inFile} | awk -v fnm=$outFile '{if (($2<0) || ($3<0)) {printf "%6s     000.00000     000.00000       0.00000       0.00000\n", $1 >> fnm} else { printf "%6s %13s %13s %13s %13s\n", $1, $2, $3, $4, $5 >> fnm}}' || echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	end
#- input / output files:
set inFile="${sc1}_${sc2}.coffsN_mag_Fil_yrF.${Co_FNex}"
set outFile="${sc1}_${sc2}.coffsN_mag_Fil_yrF.${Co_FNex}_fix"
	#- expected last line:
	set lastLine=`tail -1 ${inFile} | awk '{print $1}'`
	#- init output file:
	cat >! ${outFile} < /dev/null
	#- read through the file:
	foreach line ( `seq 1 ${lastLine}` )
	   #- search for line, or make it up:
	   #egrep "^\s+?${line} " ${inFile} >> ${outFile} || \
	   #echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	    egrep "^\s+?${line} " ${inFile} | awk -v fnm=$outFile '{if (($2<0) || ($3<0)) {printf "%6s     000.00000     000.00000       0.00000       0.00000\n", $1 >> fnm} else { printf "%6s %13s %13s %13s %13s\n", $1, $2, $3, $4, $5 >> fnm}}' || echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	end
 
 #------------------
 # GATE retrieve
 #------------------
 # *** make output *.*.mli.CFLgcp.Co.txt
 set Co_FN_gate = gcp_gate
 echo '' > ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN_gate}.temp
 
 # *** determine no of gcp's in text file ***
 set rows = `wc -l ${AOI}_gate_pnts_v1.txt | awk '{print $1}'`
 echo $rows
 
 # *** remove commas ***
 sed -e "s/,/ /g" < ${AOI}_gate_pnts_v1.txt > Cfree.txt

 # loop start!:
 foreach i ( `seq 1 ${rows}` )

 # *** ectract row and col no ***
 # N.B. idl row 1 goes into: matlab col 1, goes into: gamma col 2, goes into: Qgis col 1(var X). idl row 2 goes into: matlab col 2, goes into: gamma col 1, goes into: Qgis col 4 (varY)
 #set azlin = `cat Cfree.txt | awk "FNR == $i {print $1}"`
 set azlin = `awk "FNR == $i" Cfree.txt | awk '{print $1}'`
 # col 1
 echo ${azlin}
 #set rpix = `cat Cfree.txt | awk "FNR == $i {print $2}"`
 set rpix = `awk "FNR == $i" Cfree.txt | awk '{print $2}'`
 # col 2
 echo ${rpix}
 
	 ## *** convert row and col no's to ccordinates ***
	 ## *** Transform SAR image coordinates to map projection or geographic (lat/lon) coordinates ***
	 #sarpix_coord ${scene1}.mli.par - $DEM.dem_par $azlin $rpix > coord.txtl
 
 # convert PS coordinate points to pixels
 # *** Calculate SAR pixel coordinates (iazpix,jrpix) of geographic coordinate ***
 coord_to_sarpix ${scene1}.mligc.par - B1km_${sc1}_${sc2}.dem_seg_par $rpix $azlin 0 > coord.txt

 # *** extract geographic ccordinates ***
 set azcoord = `cat coord.txt | awk 'FNR == 18 {print $6}'`
 echo $azcoord
 set rcoord = `cat coord.txt | awk 'FNR == 18 {print $7}'`
 echo $rcoord
 
 # remove pix location file for a specific set of coordinates
 rm -rf coord.txt
 
 # *** write extracted coordinates to text file ***
 echo $i $azcoord $rcoord 0 >> ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN_gate}.temp

 # loop end!:
 end
 
 # remove blank line at start
 grep '[^[:blank:]]' < ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN_gate}.temp > ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN_gate}
 
 # remove PS coordinate file for transect without comma separation
  rm -rf Cfree.txt
  rm -rf ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN_gate}.temp
 
 # extract IV from non-geocoded image
 # *** Extract unwrapped phase at GCP locations ***
 set Co_FNex_gate = ${Co_FN_gate}ex
 gcp_phase ${sc1}_${sc2}.coffsN_mag_yrF ${sc1}_${sc2}.offN2 ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN_gate} ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FNex_gate}
 gcp_phase ${sc1}_${sc2}.coffsN_mag_DuFil_yrF ${sc1}_${sc2}.offN2 ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN_gate} ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.${Co_FNex_gate}
 gcp_phase ${sc1}_${sc2}.coffsN_mag_Fil_yrF ${sc1}_${sc2}.offN2 ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN_gate} ${sc1}_${sc2}.coffsN_mag_Fil_yrF.${Co_FNex_gate}
 gcp_phase ${sc1}_${sc2}.ccpN ${sc1}_${sc2}.offN2 ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN_gate} ${sc1}_${sc2}.ccpN.${Co_FNex_gate}
 gcp_phase ${scene1}_slc.hgt ${sc1}_${sc2}.offN2 ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FN_gate} ${scene1}_slc.hgt.${Co_FNex_gate}
 #gcp_phase ${sc1}_${sc2}.coffsN_mag_yrF ${sc1}_${sc2}.offT test.txt test.txt.gcpex
 
# FIX GCP data in rows where nothing extracted
# identify missing rows and fill with 'dummy data': 1251     000.00000     000.00000       0.00000       0.00000

#- input / output files:
set inFile="${sc1}_${sc2}.coffsN_mag_yrF.${Co_FNex_gate}"
set outFile="${sc1}_${sc2}.coffsN_mag_yrF.${Co_FNex_gate}_fix"
	#- expected last line:
	set lastLine=`tail -1 ${inFile} | awk '{print $1}'`
	#- init output file:
	cat >! ${outFile} < /dev/null
	#- read through the file:
	foreach line ( `seq 1 ${lastLine}` )
	   #- search for line, or make it up:
	   #egrep "^\s+?${line} " ${inFile} >> ${outFile} || \
	   #echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	    egrep "^\s+?${line} " ${inFile} | awk -v fnm=$outFile '{if (($2<0) || ($3<0)) {printf "%6s     000.00000     000.00000       0.00000       0.00000\n", $1 >> fnm} else { printf "%6s %13s %13s %13s %13s\n", $1, $2, $3, $4, $5 >> fnm}}' || echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	end
#- input / output files:
set inFile="${sc1}_${sc2}.ccpN.${Co_FNex_gate}"
set outFile="${sc1}_${sc2}.ccpN.${Co_FNex_gate}_fix"
	#- expected last line:
	set lastLine=`tail -1 ${inFile} | awk '{print $1}'`
	#- init output file:
	cat >! ${outFile} < /dev/null
	#- read through the file:
	foreach line ( `seq 1 ${lastLine}` )
	   #- search for line, or make it up:
	   #egrep "^\s+?${line} " ${inFile} >> ${outFile} || \
	   #echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	    egrep "^\s+?${line} " ${inFile} | awk -v fnm=$outFile '{if (($2<0) || ($3<0)) {printf "%6s     000.00000     000.00000       0.00000       0.00000\n", $1 >> fnm} else { printf "%6s %13s %13s %13s %13s\n", $1, $2, $3, $4, $5 >> fnm}}' || echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	end
#- input / output files:
set inFile="${scene1}_slc.hgt.${Co_FNex_gate}"
set outFile="${scene1}_slc.hgt.${Co_FNex_gate}_fix"
	#- expected last line:
	set lastLine=`tail -1 ${inFile} | awk '{print $1}'`
	#- init output file:
	cat >! ${outFile} < /dev/null
	#- read through the file:
	foreach line ( `seq 1 ${lastLine}` )
	   #- search for line, or make it up:
	   #egrep "^\s+?${line} " ${inFile} >> ${outFile} || \
	   #echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	    egrep "^\s+?${line} " ${inFile} | awk -v fnm=$outFile '{if (($2<0) || ($3<0)) {printf "%6s     000.00000     000.00000       0.00000       0.00000\n", $1 >> fnm} else { printf "%6s %13s %13s %13s %13s\n", $1, $2, $3, $4, $5 >> fnm}}' || echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	end
#- input / output files:
set inFile="${sc1}_${sc2}.coffsN_mag_DuFil_yrF.${Co_FNex_gate}"
set outFile="${sc1}_${sc2}.coffsN_mag_DuFil_yrF.${Co_FNex_gate}_fix"
	#- expected last line:
	set lastLine=`tail -1 ${inFile} | awk '{print $1}'`
	#- init output file:
	cat >! ${outFile} < /dev/null
	#- read through the file:
	foreach line ( `seq 1 ${lastLine}` )
	   #- search for line, or make it up:
	   #egrep "^\s+?${line} " ${inFile} >> ${outFile} || \
	   #echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	    egrep "^\s+?${line} " ${inFile} | awk -v fnm=$outFile '{if (($2<0) || ($3<0)) {printf "%6s     000.00000     000.00000       0.00000       0.00000\n", $1 >> fnm} else { printf "%6s %13s %13s %13s %13s\n", $1, $2, $3, $4, $5 >> fnm}}' || echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	end
#- input / output files:
set inFile="${sc1}_${sc2}.coffsN_mag_Fil_yrF.${Co_FNex_gate}"
set outFile="${sc1}_${sc2}.coffsN_mag_Fil_yrF.${Co_FNex_gate}_fix"
	#- expected last line:
	set lastLine=`tail -1 ${inFile} | awk '{print $1}'`
	#- init output file:
	cat >! ${outFile} < /dev/null
	#- read through the file:
	foreach line ( `seq 1 ${lastLine}` )
	   #- search for line, or make it up:
	   #egrep "^\s+?${line} " ${inFile} >> ${outFile} || \
	   #echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	    egrep "^\s+?${line} " ${inFile} | awk -v fnm=$outFile '{if (($2<0) || ($3<0)) {printf "%6s     000.00000     000.00000       0.00000       0.00000\n", $1 >> fnm} else { printf "%6s %13s %13s %13s %13s\n", $1, $2, $3, $4, $5 >> fnm}}' || echo "`printf '%6s' ${line}`     000.00000     000.00000       0.00000       0.00000" >> ${outFile}
	end
 
 # ====================================
 # extract geotiff from central areaa
 # ====================================
 # lauch gdal
 app setup gdal
 
 # get polygon coordinates
 cd  /nfs/a41/S1_CPOM_www/Polygon/WWW/
 cp ${AOI}_poly_PS_v1.txt ${out_dir}
 cd ${out_dir}
 dos2unix ${AOI}_poly_PS_v1.txt
 
 # extract area of IV from tiff
 # gdalwarp [-te xmin ymin xmax ymax] [-tr xres yres] [-tap] [-ts width height]
 #gdalwarp -te -166112.05560498268 -2293985.0987544563 -138086.58407473392 -2259820.7144128182 ${sc1}_${sc2}.coffsN_mag_yrF.gc.tiff ${sc1}_${sc2}.coffsN_mag_yrF.gc_extract.tiff 
 #gdalwarp -te -166112.05560498268 -2293985.0987544563 -138086.58407473392 -2259820.7144128182 ${sc1}_${sc2}.ccpN.gc.tiff ${sc1}_${sc2}.ccpN.gc_extract.tiff 
 #gdalwarp -te -166112.05560498268 -2293985.0987544563 -138086.58407473392 -2259820.7144128182 ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc.tiff ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_extract.tiff 

# ELH - Add section to read the coordinates from file:
set fnm_ex = '/nfs/a41/S1_CPOM_www/www_extract/JAK_extract.txt'
set xmin_ex = `sort -nk 1 $fnm_ex | head -n 1 | awk -F ',' '{print $1}'`
set xmax_ex = `sort -nk 1 $fnm_ex | tail -n 1 | awk -F ',' '{print $1}'`
set ymin_ex = `sort -nk 2 $fnm_ex | head -n 1 | awk -F ',' '{print $2}'`
set ymax_ex = `sort -nk 2 $fnm_ex | tail -n 1 | awk -F ',' '{print $2}'`
 
 # gdalwarp [-te xmin ymin xmax ymax] [-tr xres yres] [-tap] [-ts width height]
 gdalwarp -te $xmin_ex $ymin_ex $xmax_ex $ymax_ex ${sc1}_${sc2}.coffsN_mag_yrF.gc.tiff ${sc1}_${sc2}.coffsN_mag_yrF.gc_extract.tiff 
 gdalwarp -te $xmin_ex $ymin_ex $xmax_ex $ymax_ex ${sc1}_${sc2}.ccpN.gc.tiff  ${sc1}_${sc2}.ccpN.gc_extract.tiff 
 gdalwarp -te $xmin_ex $ymin_ex $xmax_ex $ymax_ex ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc.tiff ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_extract.tiff 
 #gdalwarp -te $xmin_ex $ymin_ex $xmax_ex $ymax_ex ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc.tiff ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_extract.tiff

 # extract BIGGER area of IV from 100 and 500 m tiffs
 # 100 m
# gdalwarp -te -206432.51432970705 -2322277.2986104027 -103858.37188612147 -2242616.6329028155 ${sc1}_${sc2}.coffsN_mag_yrF.gc.tiff ${sc1}_${sc2}.coffsN_mag_yrF.gc_Bextract.tiff 
 #gdalwarp -te -206432.51432970705 -2322277.2986104027 -103858.37188612147 -2242616.6329028155 ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc.tiff ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_Bextract.tiff 
 #gdalwarp -te -206432.51432970705 -2322277.2986104027 -103858.37188612147 -2242616.6329028155 ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc.tiff ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_Bextract.tiff 
 # 500 m
 #gdalwarp -te -1608600.978647687 -529892.79359430599 -1443440.8362989326 -382193.75349687511 ${sc1}_${sc2}.coffsN_mag_yrF.5gc.tiff ${sc1}_${sc2}.coffsN_mag_yrF.5gc_Bextract.tiff 
 #gdalwarp -te -1608600.978647687 -529892.79359430599 -1443440.8362989326 -382193.75349687511 ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.5gc.tiff ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.5gc_Bextract.tiff 
 #gdalwarp -te -1608600.978647687 -529892.79359430599 -1443440.8362989326 -382193.75349687511 ${sc1}_${sc2}.coffsN_mag_Fil_yrF.5gc.tiff ${sc1}_${sc2}.coffsN_mag_Fil_yrF.5gc_Bextract.tiff 

 # ELH - Add section to read the coordinates from file:
set fnm_cr = '/nfs/a41/S1_CPOM_www/www_extract/JAK_crBextract_Zm.txt'
set xmin_cr = `sort -nk 1 $fnm_cr | head -n 1 | awk -F ',' '{print $1}'`
set xmax_cr = `sort -nk 1 $fnm_cr | tail -n 1 | awk -F ',' '{print $1}'`
set ymin_cr = `sort -nk 2 $fnm_cr | head -n 1 | awk -F ',' '{print $2}'`
set ymax_cr = `sort -nk 2 $fnm_cr | tail -n 1 | awk -F ',' '{print $2}'`

# extract zoom area for crevasse gif
gdalwarp -te $xmin_cr $ymin_cr $xmax_cr $ymax_cr ${sc1}_${sc2}.coffsN_mag_yrF.gc.tiff ${sc1}_${sc2}.coffsN_mag_yrF.gc_crBextract.tiff 
gdalwarp -te $xmin_cr $ymin_cr $xmax_cr $ymax_cr ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc.tiff ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_crBextract.tiff 
gdalwarp -te $xmin_cr $ymin_cr $xmax_cr $ymax_cr ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc.tiff ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_crBextract.tiff 
 
 # make picture of extracted tiff area

# Moved the plot routines to later as they use the line
 
 #/nfs/a41/S1_CPOM_www/post_proc_scr/plot_vi.py ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.5gc.tiff ${scene1}.mligc.gc.tiff 0 ${max_TcmG_IV} ${out_dir}/${sc1}_${sc2}.coffsN_mag_DuFil_yrF.5gc_TcmG.png
 
 # plot big extract area with 100m and 500m IV
 # 100m BIG extract
# /nfs/a41/S1_CPOM_www/post_proc_scr/plot_vi.py ${sc1}_${sc2}.coffsN_mag_yrF.gc_Bextract.tiff ${scene1}.mligc.gc.tiff 0 ${max_TcmG_IV} ${out_dir}/${sc1}_${sc2}.coffsN_mag_yrF.gc_Bextract_TcmG.png
# /nfs/a41/S1_CPOM_www/post_proc_scr/plot_vi.py ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_Bextract.tiff ${scene1}.mligc.gc.tiff 0 ${max_TcmG_IV} ${out_dir}/${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_Bextract_TcmG.png
 # 500m BIG extract
 #/nfs/a41/S1_CPOM_www/post_proc_scr/plot_vi.py ${sc1}_${sc2}.coffsN_mag_yrF.5gc_Bextract.tiff ${scene1}.mligc.gc.tiff 0 ${max_TcmG_IV} ${out_dir}/${sc1}_${sc2}.coffsN_mag_yrF.5gc_Bextract_TcmG.png
 #/nfs/a41/S1_CPOM_www/post_proc_scr/plot_vi.py ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.5gc_Bextract.tiff ${scene1}.mligc.gc.tiff 0 ${max_TcmG_IV} ${out_dir}/${sc1}_${sc2}.coffsN_mag_DuFil_yrF.5gc_Bextract_TcmG.png

 # ====================================
 # make CPOM website products
 # ====================================
 
 # make transext text file for the pair with columns: PSx, PSy, IV (km/yr), distance (km) 
 #awk 'NR==FNR{a[NR]=$1" "$2; next} {print a[FNR], $5}' ${AOI}_transect_pnts_v1.txt ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FNex}_fix > ${sc1}_${sc2}.mag_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}_temp
 #awk 'NR==FNR{a[NR]=$1" "$2" "$3; next} {print a[FNR], $1}' ${sc1}_${sc2}.mag_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}_temp ${AOI}_transect_dist_v1.txt > ${sc1}_${sc2}.mag_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}
 #rm -rf ${sc1}_${sc2}.mag_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}_temp
 
 #awk 'NR==FNR{a[NR]=$1" "$2; next} {print a[FNR], $5}' ${AOI}_transect_pnts_v1.txt ${sc1}_${sc2}.ccpN.${Co_FNex}_fix > ${sc1}_${sc2}.ccpN.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}_temp
 #awk 'NR==FNR{a[NR]=$1" "$2" "$3; next} {print a[FNR], $1}' ${sc1}_${sc2}.ccpN.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}_temp ${AOI}_transect_dist_v1.txt > ${sc1}_${sc2}.ccpN.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}
 #rm -rf ${sc1}_${sc2}.ccpN.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}_temp
 
 #awk 'NR==FNR{a[NR]=$1" "$2; next} {print a[FNR], $5}' ${AOI}_transect_pnts_v1.txt ${scene1}_slc.hgt.${Co_FNex}_fix > ${scene1}.hgt.${sc1_OrbF}${sc2_OrbF}_${Co_FNex}_temp
 #awk 'NR==FNR{a[NR]=$1" "$2" "$3; next} {print a[FNR], $1}' ${scene1}.hgt.${sc1_OrbF}${sc2_OrbF}_${Co_FNex}_temp ${AOI}_transect_dist_v1.txt > ${scene1}.hgt.${sc1_OrbF}${sc2_OrbF}_${Co_FNex}
 #rm -rf ${scene1}.hgt.${sc1_OrbF}${sc2_OrbF}_${Co_FNex}_temp
 
 awk 'NR==FNR{a[NR]=$1" "$2; next} {print a[FNR], $5}' ${AOI}_transect_pnts_v1.txt ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.${Co_FNex}_fix > ${sc1}_${sc2}.mag_DuFil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}_temp
 awk 'NR==FNR{a[NR]=$1" "$2" "$3; next} {print a[FNR], $1}' ${sc1}_${sc2}.mag_DuFil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}_temp ${AOI}_transect_dist_v1.txt > ${sc1}_${sc2}.mag_DuFil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}
 rm -rf ${sc1}_${sc2}.mag_DuFil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}_temp
 
 #awk 'NR==FNR{a[NR]=$1" "$2; next} {print a[FNR], $5}' ${AOI}_transect_pnts_v1.txt ${sc1}_${sc2}.coffsN_mag_Fil_yrF.${Co_FNex}_fix > ${sc1}_${sc2}.mag_Fil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}_temp
 #awk 'NR==FNR{a[NR]=$1" "$2" "$3; next} {print a[FNR], $1}' ${sc1}_${sc2}.mag_Fil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}_temp ${AOI}_transect_dist_v1.txt > ${sc1}_${sc2}.mag_Fil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}
 #rm -rf ${sc1}_${sc2}.mag_Fil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}_temp
 
 # gate
 #awk 'NR==FNR{a[NR]=$1" "$2; next} {print a[FNR], $5}' ${AOI}_gate_pnts_v1.txt ${sc1}_${sc2}.coffsN_mag_yrF.${Co_FNex_gate}_fix > ${sc1}_${sc2}.mag_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}_temp
 #awk 'NR==FNR{a[NR]=$1" "$2" "$3; next} {print a[FNR], $1}' ${sc1}_${sc2}.mag_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}_temp ${AOI}_gate_dist_v1.txt > ${sc1}_${sc2}.mag_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}
 #rm -rf ${sc1}_${sc2}.mag_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}_temp
 
 #awk 'NR==FNR{a[NR]=$1" "$2; next} {print a[FNR], $5}' ${AOI}_gate_pnts_v1.txt ${sc1}_${sc2}.ccpN.${Co_FNex_gate}_fix > ${sc1}_${sc2}.ccpN.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}_temp
 #awk 'NR==FNR{a[NR]=$1" "$2" "$3; next} {print a[FNR], $1}' ${sc1}_${sc2}.ccpN.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}_temp ${AOI}_gate_dist_v1.txt > ${sc1}_${sc2}.ccpN.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}
 #rm -rf ${sc1}_${sc2}.ccpN.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}_temp
 
 #awk 'NR==FNR{a[NR]=$1" "$2; next} {print a[FNR], $5}' ${AOI}_gate_pnts_v1.txt  ${scene1}_slc.hgt.${Co_FNex_gate}_fix > ${scene1}.hgt.${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}_temp
 #awk 'NR==FNR{a[NR]=$1" "$2" "$3; next} {print a[FNR], $1}' ${scene1}.hgt.${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}_temp ${AOI}_gate_dist_v1.txt > ${scene1}.hgt.${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}
 #rm -rf ${scene1}.hgt.${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}_temp
 
 awk 'NR==FNR{a[NR]=$1" "$2; next} {print a[FNR], $5}' ${AOI}_gate_pnts_v1.txt ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.${Co_FNex_gate}_fix > ${sc1}_${sc2}.mag_DuFil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}_temp
 awk 'NR==FNR{a[NR]=$1" "$2" "$3; next} {print a[FNR], $1}' ${sc1}_${sc2}.mag_DuFil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}_temp ${AOI}_gate_dist_v1.txt > ${sc1}_${sc2}.mag_DuFil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}
 rm -rf ${sc1}_${sc2}.mag_DuFil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}_temp
 
 #awk 'NR==FNR{a[NR]=$1" "$2; next} {print a[FNR], $5}' ${AOI}_gate_pnts_v1.txt ${sc1}_${sc2}.coffsN_mag_Fil_yrF.${Co_FNex_gate}_fix > ${sc1}_${sc2}.mag_Fil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}_temp
 #awk 'NR==FNR{a[NR]=$1" "$2" "$3; next} {print a[FNR], $1}' ${sc1}_${sc2}.mag_Fil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}_temp ${AOI}_gate_dist_v1.txt > ${sc1}_${sc2}.mag_Fil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}
 #rm -rf ${sc1}_${sc2}.mag_Fil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}_temp

 # ******* NEW plot routines - full and extracted area ********
 app setup canopy python-libs
 # set hatton plot variables
 set max_TcmG_IV = 4500
 echo ${max_TcmG_IV}
 set max_TcmG_SNR = 1
 # set min IV colour scale, note for rig_rev.py version absolute 0 must NOT be used
 set min_TcmG_IV = 0
 set min_TcmG_SNR = 0
 echo ${min_TcmG_IV}
 set mli_alpha = 0.8
 echo ${mli_alpha}
 set CB_transp = 1
 set IV_alpha = 0.4
 set PL_scl = 0.35

 set ORB = ${sc1_OrbF}${sc2_OrbF} 

  # for full area
 # with box and transect overlaid and labelled 
  /nfs/a41/S1_CPOM_www/post_proc_scr/plot_geotiff.py --vtif ${out_dir}/${sc1}_${sc2}.coffsN_mag_yrF.gc.tiff --min_cm ${min_TcmG_IV} --max_cm ${max_TcmG_IV} --alpha_over ${IV_alpha} --alpha_cbar ${IV_alpha} --cmap /nfs/a41/S1_CPOM_www/post_proc_scr/lincode.txt --box /nfs/a41/S1_CPOM_www/Big_pnts/${AOI}_big_pnt_RR_PS.csv --line ${out_dir}/${sc1}_${sc2}.mag_DuFil_yrF.IV_${ORB}_gcpex beglab=A endlab=a --line ${out_dir}/${sc1}_${sc2}.mag_DuFil_yrF.IV_${ORB}_gcp_gateex beglab=B endlab=b --mtif ${out_dir}/${scene1}.mligc.gc.tiff --pow_bk ${PL_scl} --alpha_bk ${mli_alpha} ${out_dir}/${sc1}_${sc2}.coffsN_mag_yrF.gc_TcmGn.png
  #/nfs/a41/S1_CPOM_www/post_proc_scr/plot_geotiff.py --vtif ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc.tiff --min_cm ${min_TcmG_IV} --max_cm ${max_TcmG_IV} --alpha_over ${IV_alpha} --alpha_cbar ${IV_alpha} --cmap /nfs/a41/S1_CPOM_www/post_proc_scr/lincode.txt --box /nfs/a41/S1_CPOM_www/Big_pnts/${AOI}_big_pnt_RR_PS.csv --line ${sc1}_${sc2}.mag_yrF.IV_${ORB}_gcpex beglab=A endlab=a --line ${sc1}_${sc2}.mag_yrF.IV_${ORB}_gcp_gateex beglab=B endlab=b --mtif ${scene1}.mligc.gc.tiff --pow_bk ${PL_scl} --alpha_bk ${mli_alpha} ${out_dir}/${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_TcmGn.png
  #/nfs/a41/S1_CPOM_www/post_proc_scr/plot_geotiff.py --vtif ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc.tiff --min_cm ${min_TcmG_IV} --max_cm ${max_TcmG_IV} --alpha_over ${IV_alpha} --alpha_cbar ${IV_alpha} --cmap /nfs/a41/S1_CPOM_www/post_proc_scr/lincode.txt --box /nfs/a41/S1_CPOM_www/Big_pnts/${AOI}_big_pnt_RR_PS.csv --line ${sc1}_${sc2}.mag_yrF.IV_${ORB}_gcpex beglab=A endlab=a --line ${sc1}_${sc2}.mag_yrF.IV_${ORB}_gcp_gateex beglab=B endlab=b --mtif ${scene1}.mligc.gc.tiff --pow_bk ${PL_scl} --alpha_bk ${mli_alpha} ${out_dir}/${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_TcmGn.png
 
 # withOUT box and transect overlaid and labelled 	
  #/nfs/a41/S1_CPOM_www/post_proc_scr/plot_geotiff.py --vtif ${sc1}_${sc2}.coffsN_mag_yrF.gc.tiff --min_cm ${min_TcmG_IV} --max_cm ${max_TcmG_IV} --alpha_over ${IV_alpha} --alpha_cbar ${IV_alpha} --cmap /nfs/a41/S1_CPOM_www/post_proc_scr/lincode.txt --mtif ${scene1}.mligc.gc.tiff --pow_bk ${PL_scl} --alpha_bk ${mli_alpha} ${out_dir}/${sc1}_${sc2}.coffsN_mag_yrF.gc_TcmG.png
  #/nfs/a41/S1_CPOM_www/post_proc_scr/plot_geotiff.py --vtif ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc.tiff --min_cm ${min_TcmG_IV} --max_cm ${max_TcmG_IV} --alpha_over ${IV_alpha} --alpha_cbar ${IV_alpha} --cmap /nfs/a41/S1_CPOM_www/post_proc_scr/lincode.txt --mtif ${scene1}.mligc.gc.tiff --pow_bk ${PL_scl} --alpha_bk ${mli_alpha} ${out_dir}/${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_TcmG.png
  #/nfs/a41/S1_CPOM_www/post_proc_scr/plot_geotiff.py --vtif ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc.tiff --min_cm ${min_TcmG_IV} --max_cm ${max_TcmG_IV} --alpha_over ${IV_alpha} --alpha_cbar ${IV_alpha} --cmap /nfs/a41/S1_CPOM_www/post_proc_scr/lincode.txt --mtif ${scene1}.mligc.gc.tiff --pow_bk ${PL_scl} --alpha_bk ${mli_alpha} ${out_dir}/${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_TcmG.png

 # for crevasse area
 /nfs/a41/S1_CPOM_www/post_proc_scr/plot_geotiff.py --vtif ${out_dir}/${sc1}_${sc2}.coffsN_mag_yrF.gc_crBextract.tiff --min_cm ${min_TcmG_IV} --max_cm ${max_TcmG_IV} --alpha_over ${IV_alpha} --alpha_cbar ${IV_alpha} --cmap /nfs/a41/S1_CPOM_www/post_proc_scr/lincode.txt --mtif ${out_dir}/${scene1}.mligc.gc.tiff --pow_bk ${PL_scl} --alpha_bk ${mli_alpha} ${out_dir}/${sc1}_${sc2}.coffsN_mag_yrF.gc_crBextract_TcmG.png
 #/nfs/a41/S1_CPOM_www/post_proc_scr/plot_geotiff.py --vtif ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_crBextract.tiff --min_cm ${min_TcmG_IV} --max_cm ${max_TcmG_IV} --alpha_over ${IV_alpha} --alpha_cbar ${IV_alpha} --cmap /nfs/a41/S1_CPOM_www/post_proc_scr/lincode.txt --mtif ${scene1}.mligc.gc.tiff --pow_bk ${PL_scl} --alpha_bk ${mli_alpha} ${out_dir}/${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_crBextract_TcmG.png
 #/nfs/a41/S1_CPOM_www/post_proc_scr/plot_geotiff.py --vtif ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_crBextract.tiff --min_cm ${min_TcmG_IV} --max_cm ${max_TcmG_IV} --alpha_over ${IV_alpha} --alpha_cbar ${IV_alpha} --cmap /nfs/a41/S1_CPOM_www/post_proc_scr/lincode.txt --mtif ${scene1}.mligc.gc.tiff --pow_bk ${PL_scl} --alpha_bk ${mli_alpha} ${out_dir}/${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_crBextract_TcmG.png
  
 # for extracted tiff deliver area
  #/nfs/a41/S1_CPOM_www/post_proc_scr/plot_geotiff.py --vtif ${sc1}_${sc2}.coffsN_mag_yrF.gc_extract.tiff --min_cm ${min_TcmG_IV} --max_cm ${max_TcmG_IV} --alpha_over ${IV_alpha} --alpha_cbar ${IV_alpha} --cmap /nfs/a41/S1_CPOM_www/post_proc_scr/lincode.txt --mtif ${scene1}.mligc.gc.tiff --pow_bk ${PL_scl} --alpha_bk ${mli_alpha} ${out_dir}/${sc1}_${sc2}.coffsN_mag_yrF.gc_extract_TcmG.png
  #/nfs/a41/S1_CPOM_www/post_proc_scr/plot_geotiff.py --vtif ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_extract.tiff --min_cm ${min_TcmG_IV} --max_cm ${max_TcmG_IV} --alpha_over ${IV_alpha} --alpha_cbar ${IV_alpha} --cmap /nfs/a41/S1_CPOM_www/post_proc_scr/lincode.txt --mtif ${scene1}.mligc.gc.tiff --pow_bk ${PL_scl} --alpha_bk ${mli_alpha} ${out_dir}/${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_extract_TcmG.png
  #/nfs/a41/S1_CPOM_www/post_proc_scr/plot_geotiff.py --vtif ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_extract.tiff --min_cm ${min_TcmG_IV} --max_cm ${max_TcmG_IV} --alpha_over ${IV_alpha} --alpha_cbar ${IV_alpha} --cmap /nfs/a41/S1_CPOM_www/post_proc_scr/lincode.txt --mtif ${scene1}.mligc.gc.tiff --pow_bk ${PL_scl} --alpha_bk ${mli_alpha} ${out_dir}/${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_extract_TcmG.png

 # for SNR tiff
 #/nfs/a41/S1_CPOM_www/post_proc_scr/plot_geotiff.py --vtif ${sc1}_${sc2}.ccpN.gc.tiff --min_cm ${min_TcmG_SNR} --max_cm ${max_TcmG_SNR} --alpha_over ${IV_alpha} --alpha_cbar ${IV_alpha} --cmap /nfs/a41/S1_CPOM_www/post_proc_scr/snrcode.txt --mtif ${scene1}.mligc.gc.tiff --pow_bk ${PL_scl} --alpha_bk ${mli_alpha} ${out_dir}/${sc1}_${sc2}.ccpN.gc_TcmG.png
 #/nfs/a41/S1_CPOM_www/post_proc_scr/plot_geotiff.py --vtif ${sc1}_${sc2}.ccpN.gc_extract.tiff --min_cm ${min_TcmG_SNR} --max_cm ${max_TcmG_SNR} --alpha_over ${IV_alpha} --alpha_cbar ${IV_alpha} --cmap /nfs/a41/S1_CPOM_www/post_proc_scr/snrcode.txt --mtif ${scene1}.mligc.gc.tiff --pow_bk ${PL_scl} --alpha_bk ${mli_alpha} ${out_dir}/${sc1}_${sc2}.ccpN.gc_extract_TcmG.png
 
 # ---------------------------------------------
 # add title and crop area to WWW visible images
 # ---------------------------------------------
 # make title text - date in readable format
  set yr1 = `echo $sc1 | cut -c1-2`
  set mo1 = `echo $sc1 | cut -c3-4`
  set da1 = `echo $sc1 | cut -c5-7`
  set dt1 = ${yr1}.${mo1}.${da1}
  echo $dt1
  set yr2 = `echo $sc2 | cut -c1-2`
  set mo2 = `echo $sc2 | cut -c3-4`
  set da2 = `echo $sc2 | cut -c5-7`
  set dt2 = ${yr2}.${mo2}.${da2}
  echo $dt2
  set tit = "20$dt1 to 20$dt2"
  echo $tit
  # add title and crop white area for full frame area - unfiltered data only
  convert -trim +repage -border 30x30 -bordercolor White ${sc1}_${sc2}.coffsN_mag_yrF.gc_TcmGn.png \
    -font Helvetica -pointsize 85 -background White -splice 0x115 +swap -gravity North \
    -annotate +0+30 "$tit" ${sc1}_${sc2}.coffsN_mag_yrF.gc_TcmGn_t.png
  # add title and crop white area for crevasse extracted area - unfiltered data only
  convert -trim +repage -border 30x30 -bordercolor White ${sc1}_${sc2}.coffsN_mag_yrF.gc_crBextract_TcmG.png \
    -font Helvetica -pointsize 85 -background White -splice 0x115 +swap -gravity North \
    -annotate +0+30 "$tit" ${sc1}_${sc2}.coffsN_mag_yrF.gc_crBextract_TcmG_t.png

 
 # make plots of gate data
 # set date DD/MM/YYYY
 set sc1_dd = `echo $scene1 | cut -c7-8`
 set sc1_mm = `echo $scene1 | cut -c5-6`
 set sc1_yy = `echo $scene1 | cut -c1-4`
 set sc1_TD = `echo ${sc1_dd}.${sc1_mm}.${sc1_yy}`
 echo ${sc1_TD}
 
 set sc2_dd = `echo $scene2 | cut -c7-8`
 set sc2_mm = `echo $scene2 | cut -c5-6`
 set sc2_yy = `echo $scene2 | cut -c1-4`
 set sc2_TD = `echo ${sc2_dd}.${sc2_mm}.${sc2_yy}`
 echo ${sc2_TD}

 # use gnuplot
 set yax_max = 17000
 echo ${yax_max}
 setenv GDFONTPATH /usr/share/fonts/dejavu
 #gnuplot -e "set term png font 'DejaVuLGCSans, 14'; set output '${sc1}_${sc2}_mag_yrF.IV_transect.png' ; set ylabel 'Ice velocity (m/yr)'; set xlabel 'Distance (km)'; set title 'Along-Flow Ice Velocity: ${sc1_TD} to ${sc2_TD}' ; set yrange [0:${max_yr_IV}]; set datafile missing '0.00000'; input='${sc1}_${sc2}.mag_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}'; plot input using 4:3 lt rgb 'black' pt 7 ps 0.3 title ''"
 #gnuplot -e "set term png font 'DejaVuLGCSans, 14'; set output '${sc1}_${sc2}_mag_yrF.IV_gate.png' ; set ylabel 'Ice velocity (m/yr)'; set xlabel 'Distance (km)'; set title 'Accross-Flow Ice Velocity: ${sc1_TD} to ${sc2_TD}' ; set yrange [0:${max_yr_IV}]; set datafile missing '0.00000'; input='${sc1}_${sc2}.mag_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}'; plot input using 4:3 lt rgb 'black' pt 7 ps 0.3 title ''"
 #gnuplot -e "set term png font 'DejaVuLGCSans, 14'; set output '${sc1}_${sc2}.ccpN_transect.png' ; set ylabel 'SNR'; set xlabel 'Distance (km)'; set title 'Along-Flow SNR: ${sc1_TD} to ${sc2_TD}' ; set yrange [0:1]; set datafile missing '0.00000'; input='${sc1}_${sc2}.ccpN.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}'; plot input using 4:3 lt rgb 'black' pt 7 ps 0.3 title ''"
 #gnuplot -e "set term png font 'DejaVuLGCSans, 14'; set output '${sc1}_${sc2}.hgt_transect.png' ; set ylabel 'Surface Elevation (m)'; set xlabel 'Distance (km)'; set title 'Along-Flow Surface Elevation: ${sc1_TD} to ${sc2_TD}' ; set datafile missing '0.00000'; input='${scene1}.hgt.${sc1_OrbF}${sc2_OrbF}_${Co_FNex}'; plot input using 4:3 lt rgb 'black' pt 7 ps 0.3 title ''"
 #gnuplot -e "set term png font 'DejaVuLGCSans, 14'; set output '${sc1}_${sc2}.ccpN_gate.png' ; set ylabel 'SNR'; set xlabel 'Distance (km)'; set title 'Accross-Flow SNR: ${sc1_TD} to ${sc2_TD}' ; set yrange [0:1]; set datafile missing '0.00000'; input='${sc1}_${sc2}.ccpN.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}'; plot input using 4:3 lt rgb 'black' pt 7 ps 0.3 title ''"
 #gnuplot -e "set term png font 'DejaVuLGCSans, 14'; set output '${sc1}_${sc2}.hgt_gate.png' ; set ylabel 'Surface Elevation (m)'; set xlabel 'Distance (km)'; set title 'Accross-Flow Surface Elevation: ${sc1_TD} to ${sc2_TD}' ; set datafile missing '0.00000'; input='${scene1}.hgt.${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}'; plot input using 4:3 lt rgb 'black' pt 7 ps 0.3 title ''"
 #gnuplot -e "set term png font 'DejaVuLGCSans, 14'; set output '${sc1}_${sc2}_mag_DuFil_yrF.IV_transect.png' ; set ylabel 'Ice velocity (m/yr)'; set xlabel 'Distance (km)'; set title 'Along-Flow Ice Velocity: ${sc1_TD} to ${sc2_TD}' ; set yrange [0:${max_yr_IV}]; set datafile missing '0.00000'; input='${sc1}_${sc2}.mag_DuFil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}'; plot input using 4:3 lt rgb 'black' pt 7 ps 0.3 title ''"
 #gnuplot -e "set term png font 'DejaVuLGCSans, 14'; set output '${sc1}_${sc2}_mag_DuFil_yrF.IV_gate.png' ; set ylabel 'Ice velocity (m/yr)'; set xlabel 'Distance (km)'; set title 'Accross-Flow Ice Velocity: ${sc1_TD} to ${sc2_TD}' ; set yrange [0:${max_yr_IV}]; set datafile missing '0.00000'; input='${sc1}_${sc2}.mag_DuFil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}'; plot input using 4:3 lt rgb 'black' pt 7 ps 0.3 title ''"
 #gnuplot -e "set term png font 'DejaVuLGCSans, 14'; set output '${sc1}_${sc2}_mag_Fil_yrF.IV_transect.png' ; set ylabel 'Ice velocity (m/yr)'; set xlabel 'Distance (km)'; set title 'Along-Flow Ice Velocity: ${sc1_TD} to ${sc2_TD}' ; set yrange [0:${max_yr_IV}]; set datafile missing '0.00000'; input='${sc1}_${sc2}.mag_Fil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}'; plot input using 4:3 lt rgb 'black' pt 7 ps 0.3 title ''"
 #gnuplot -e "set term png font 'DejaVuLGCSans, 14'; set output '${sc1}_${sc2}_mag_Fil_yrF.IV_gate.png' ; set ylabel 'Ice velocity (m/yr)'; set xlabel 'Distance (km)'; set title 'Accross-Flow Ice Velocity: ${sc1_TD} to ${sc2_TD}' ; set yrange [0:${max_yr_IV}]; set datafile missing '0.00000'; input='${sc1}_${sc2}.mag_Fil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}'; plot input using 4:3 lt rgb 'black' pt 7 ps 0.3 title ''"
 
 # set thumbnail parameters
 set col_ramp_THUMB = 10000.
 set THUMB_lk = 4
 
 #  make thumbnail gc raster: ~ 50 x 50 pix
 #rasdt_pwr24 ${sc1}_${sc2}.coffsN_mag_yrF.gc - $FT_DEMwidth 1 1 0 $THUMB_lk $THUMB_lk $col_ramp_THUMB 1. .35 1 ${sc1}_${sc2}.coffsN_mag_yrF.gc_THUMB.bmp
 #rasdt_pwr24 ${sc1}_${sc2}.ccpN.gc - $FT_DEMwidth 1 1 0 $THUMB_lk $THUMB_lk 1. 1. .35 1 ${sc1}_${sc2}.ccpN.gc_THUMB.bmp
 
 # make thumbnail raster: ~ 200x 200 pix
 #rasdt_pwr24 ${sc1}_${sc2}.coffsN_mag_yrF ${scene1}.pwr1 $off_width 1 1 0 $THUMB_lk $THUMB_lk $col_ramp_THUMB 1. .35 1 ${sc1}_${sc2}.coffsN_mag_yrF.THUMB.bmp
 #rasdt_pwr24 ${sc1}_${sc2}.ccpN ${scene1}.pwr1 $off_width 1 1 0 $THUMB_lk $THUMB_lk 1. 1. .35 1 ${sc1}_${sc2}.ccpN.THUMB.bmp
 
 
 # ---------------------------
 # copy WWW data to WWW folder
 # ---------------------------
 
  set vers = `echo *.sh | awk -F "_" '{print $3}'`
  echo $vers
  set run_vers = `echo $out_dir | awk -F '/' '{print $9}' | cut -c5- `
  set WWWpath = /nfs/a41/S1_CPOM_www/IV_out/${AOI}/WWW/online_v${run_vers}/ 
  set frontEND = `echo ${AOI}_${Trk_no}_${lat}_${lon}_${vers}_`
  
  # tiffs 
  # SNR
  #cp ${sc1}_${sc2}.ccpN.gc_TcmG.tiff ${WWWpath}${frontEND}${sc1}_${sc2}.ccpN.gc_TcmG.tiff
  cp ${sc1}_${sc2}.ccpN.gc_extract.tiff ${WWWpath}${frontEND}${sc1}_${sc2}.ccpN.gc_extract.tiff 
  # IV full area
  #cp ${sc1}_${sc2}.coffsN_mag_yrF.gc.tiff ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_yrF.gc.tiff 
  #cp ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc.tiff ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc.tiff
  #cp ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc.tiff ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc.tiff
  # IV crevassed area
  #cp ${sc1}_${sc2}.coffsN_mag_yrF.gc_crBextract.tiff ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_yrF.gc_crBextract.tiff
  #cp ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_crBextract.tiff ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_crBextract.tiff
  #cp ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_crBextract.tiff ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_crBextract.tiff
  # IV delivered area
  #cp ${sc1}_${sc2}.coffsN_mag_yrF.gc_extract.tiff ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_yrF.gc_extract.tiff
  cp ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_extract.tiff ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_extract.tiff
  #cp ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_extract.tiff ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_extract.tiff
  
  # not used any more
  #cp ${sc1}_${sc2}.coffsN_mag_yrF.gc_extract.tiff ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_yrF.gc_extract.tiff 
  #cp ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_extract.tiff ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_extract.tiff
  #cp ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_extract.tiff ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_extract.tiff
  #cp ${sc1}_${sc2}.coffsN_mag_yrF.5gc_Bextract.tiff ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_yrF.5gc_Bextract.tiff
  #cp ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.5gc_Bextract.tiff ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_DuFil_yrF.5gc_Bextract.tiff
 #cp ${sc1}_${sc2}.coffsN_mag_yrF.gc_Bextract.tiff ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_yrF.gc_Bextract.tiff
  #cp ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_Bextract.tiff ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_Bextract.tiff
  
  # transects
  #cp ${sc1}_${sc2}.mag_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex} ${WWWpath}${frontEND}${sc1}_${sc2}.mag_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}
  #cp ${sc1}_${sc2}.ccpN.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex} ${WWWpath}${frontEND}${sc1}_${sc2}.ccpN.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}
  #cp ${scene1}.hgt.${sc1_OrbF}${sc2_OrbF}_${Co_FNex} ${WWWpath}${frontEND}${scene1}.hgt.${sc1_OrbF}${sc2_OrbF}_${Co_FNex}
  #cp ${sc1}_${sc2}_mag_yrF.IV_transect.png ${WWWpath}${frontEND}${sc1}_${sc2}_mag_yrF.IV_transect.png
  cp ${sc1}_${sc2}.mag_DuFil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex} ${WWWpath}${frontEND}${sc1}_${sc2}.mag_DuFil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}
  #cp ${sc1}_${sc2}_mag_DuFil_yrF.IV_transect.png ${WWWpath}${frontEND}${sc1}_${sc2}_mag_DuFil_yrF.IV_transect.png
  #cp ${sc1}_${sc2}.mag_Fil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex} ${WWWpath}${frontEND}${sc1}_${sc2}.mag_Fil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}
  #cp ${sc1}_${sc2}_mag_Fil_yrF.IV_transect.png ${WWWpath}${frontEND}${sc1}_${sc2}_mag_Fil_yrF.IV_transect.png
  
  # gates
  #cp ${sc1}_${sc2}.mag_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate} ${WWWpath}${frontEND}${sc1}_${sc2}.mag_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}
  #cp ${sc1}_${sc2}.ccpN.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate} ${WWWpath}${frontEND}${sc1}_${sc2}.ccpN.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}
  #cp ${scene1}.hgt.${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate} ${WWWpath}${frontEND}${scene1}.hgt.${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}
  #cp ${sc1}_${sc2}_mag_yrF.IV_gate.png ${WWWpath}${frontEND}${sc1}_${sc2}_mag_yrF.IV_gate.png
  cp ${sc1}_${sc2}.mag_DuFil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate} ${WWWpath}${frontEND}${sc1}_${sc2}.mag_DuFil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}
  #cp ${sc1}_${sc2}_mag_DuFil_yrF.IV_gate.png ${WWWpath}${frontEND}${sc1}_${sc2}_mag_DuFil_yrF.IV_gate.png
  #cp ${sc1}_${sc2}.mag_Fil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate} ${WWWpath}${frontEND}${sc1}_${sc2}.mag_Fil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}
  #cp ${sc1}_${sc2}_mag_Fil_yrF.IV_gate.png ${WWWpath}${frontEND}${sc1}_${sc2}_mag_Fil_yrF.IV_gate.png
  
  # bmp's
# with box and transect overlaid and labelled 
 #cp ${sc1}_${sc2}.coffsN_mag_yrF.gc_TcmGn.png ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_yrF.gc_TcmGn.png
 #cp ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_TcmGn.png ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_TcmGn.png
 #cp ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_TcmGn.png ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_TcmGn.png
 # withOUT box and transect overlaid and labelled 	
 #cp ${sc1}_${sc2}.coffsN_mag_yrF.gc_TcmG.png ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_yrF.gc_TcmG.png
 #cp ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_TcmG.png ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_TcmG.png
 #cp ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_TcmG.png ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_TcmG.png
 # for crevasse area
 #cp ${sc1}_${sc2}.coffsN_mag_yrF.gc_crBextract_TcmG.png ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_yrF.gc_crBextract_TcmG.png
 #cp ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_crBextract_TcmG.png ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_crBextract_TcmG.png
 #cp ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_crBextract_TcmG.png ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_crBextract_TcmG.png
 # for extracted tiff deliver area
 #cp ${sc1}_${sc2}.coffsN_mag_yrF.gc_Bextract_TcmG.png ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_yrF.gc_Bextract_TcmG.png
 #cp ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_Bextract_TcmG.png ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_Bextract_TcmG.png
 # for SNR tiff
 #cp ${sc1}_${sc2}.ccpN.gc_TcmG.png ${WWWpath}${frontEND}${sc1}_${sc2}.ccpN.gc_TcmG.png
 #cp ${sc1}_${sc2}.ccpN.gc_extract_TcmG.png ${WWWpath}${frontEND}${sc1}_${sc2}.ccpN.gc_extract_TcmG.png
 # for titled and white area cropped images - unfiltered data only
 cp ${sc1}_${sc2}.coffsN_mag_yrF.gc_crBextract_TcmG_t.png ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_yrF.gc_crBextract_TcmG_t.png
 cp ${sc1}_${sc2}.coffsN_mag_yrF.gc_TcmGn_t.png ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_yrF.gc_TcmGn_t.png
  
# 100 and 500m BIG extract
#cp ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_Bextract_TcmG.png ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_Bextract_TcmG.png
#cp ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.5gc_Bextract_TcmG.png ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_DuFil_yrF.5gc_Bextract_TcmG.png
#cp ${sc1}_${sc2}.coffsN_mag_yrF.gc_Bextract_TcmG.png ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_yrF.gc_Bextract_TcmG.png
#cp ${sc1}_${sc2}.coffsN_mag_yrF.5gc_Bextract_TcmG.png ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_yrF.5gc_Bextract_TcmG.png
#cp ${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_Bextract_TcmG.png ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_Fil_yrF.gc_Bextract_TcmG.png
#cp ${sc1}_${sc2}.coffsN_mag_Fil_yrF.5gc_Bextract_TcmG.png ${WWWpath}${frontEND}${sc1}_${sc2}.coffsN_mag_Fil_yrF.5gc_Bextract_TcmG.png

  # -------------------------------------------------
  # Copy outputs to new output folder for delivery
  # -------------------------------------------------
  set vers = `echo *.sh | awk -F "_" '{print $3}'`
  echo $vers
 
  set datapath = ${out_dir}/output/
  mkdir $datapath

  set frontEND = `echo ${AOI}_${Trk_no}_${lat}_${lon}_${vers}_`

  cp ${sc1}_${sc2}.ccpN.gc_extract.tiff ${datapath}${frontEND}${sc1}_${sc2}.ccpN.gc_extract.tiff 
  cp ${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_extract.tiff ${datapath}${frontEND}${sc1}_${sc2}.coffsN_mag_DuFil_yrF.gc_extract.tiff  
  cp ${sc1}_${sc2}.coffsN_mag_yrF.gc_TcmGn_t.png ${datapath}${frontEND}${sc1}_${sc2}.coffsN_mag_yrF.gc_TcmGn_t.png
  cp ${sc1}_${sc2}.coffsN_mag_yrF.gc_crBextract_TcmG_t.png ${datapath}${frontEND}${sc1}_${sc2}.coffsN_mag_yrF.gc_crBextract_TcmG_t.png
  cp ${sc1}_${sc2}.mag_DuFil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex} ${datapath}${frontEND}${sc1}_${sc2}.mag_DuFil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex}
  cp ${sc1}_${sc2}.mag_DuFil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate} ${datapath}${frontEND}${sc1}_${sc2}.mag_DuFil_yrF.IV_${sc1_OrbF}${sc2_OrbF}_${Co_FNex_gate}
    
  # transects are copied in after their creation at the end of the SHED script
  
  # -------------------------------------------------
  # copy output FT offsets to coffsets archive folder
  # -------------------------------------------------
 
  set OFFpath = /nfs/a41/S1_CPOM_www/IV_out/${AOI}/WWW/OFFarch/
  set frontEND = `echo ${AOI}_${Trk_no}_${lat}_${lon}_${vers}_`
  
  # copy SO log 
  cp ${sc1}_${sc2}.offT ${OFFpath}${frontEND}${sc1}_${sc2}.offT 
  cp ${sc1}_${sc2}.coffsN ${OFFpath}${frontEND}${sc1}_${sc2}.coffsN
  
  # --------------------------------
  # copy output SO.txt to log folder
  # --------------------------------
 
  set logpath = /nfs/a41/S1_CPOM_www/IV_out/${AOI}/WWW/SOlog/
  set frontEND = `echo ${AOI}_${Trk_no}_${lat}_${lon}_${vers}_`
  
  # copy SO log 
  cp ${sc1}_${sc2}_SO.txt ${logpath}${frontEND}${sc1}_${sc2}_SO.txt 
 
# ----------------------------------------
# remove uneeded output files
# ----------------------------------------
 rm -rf *.slc
 rm -rf *.rslc
 rm -rf *.mli
 rm -rf *.sim_lut
 rm -rf *.sim_lut_fine
 rm -rf *.dem_LUT
 #rm -rf ${DEM}.dem
 rm -rf *.dem_LUT
 rm -rf *.slc.dem
 rm -rf *.Smli.gc
 rm -rf *.sim_dem
 rm -rf *.hgt.gc
 rm -rf *.mliFgc.gc
 rm -rf *.rmli
 rm -rf *.Smli
 rm -rf *.hgt
 rm -rf *.Smli_LUT
 rm -rf *.dem_seg
 rm -rf *.hgt_mask.ras
 rm -rf *.coffsN
 rm -rf *.coffsetsN
 rm -rf *.mliFgc
 rm -rf *.offsetsN
 rm -rf *.mligc
 rm -rf *.pwr1
 rm -rf *.coffsN_im
 rm -rf *.coffsN_real
 rm -rf *.coffsN_mag
 rm -rf *.coffsN_mag_yr
 rm -rf *.coffsN_mag_yrF
 rm -rf *.ccpN
 rm -rf ${AOI}_transect_pnts_v1.txt
 rm -rf ${AOI}_transect_dist_v1.txt
 rm -rf ${AOI}_gate_pnts_v1.txt
 rm -rf ${AOI}_gate_dist_v1.txt
 rm -rf *.offN2
 #rm -rf *.par
 rm -rf *_tab.txt
 rm -rf SNR.cpt
 rm -rf ${AOI}.cpt

# ==================================================================================================

 echo "=====" >> $LOG
 echo " END " >> $LOG
 echo "=====" >> $LOG
