eval(['!create_offset ' data1 '.slc.deramp.par ' data2 '.slc.deramp.par DW6' data1 '_' data2 '.deramp.off 1 10 2 0']);

%eval(['!offset_pwr_tracking ' data1 '.slc.deramp ' data2 '.slc.deramp ' data1 '.slc.deramp.par ' data2 '.slc.deramp.par ' data1 '_' data2 '.deramp.off ' data1 '_' data2 '.deramp.offs ' data1 '_' data2 '.deramp.snr 600 80 ' data1 '_' data2 '.deramp.offsets 2 5.0 50 10 - - - - 4 0'])
eval(['!offset_pwr_tracking ' data1 '.slc.deramp ' data2 '.slc.deramp ' data1 '.slc.deramp.par ' data2 '.slc.deramp.par DW6' data1 '_' data2 '.deramp.off DW6' data1 '_' data2 '.deramp.offs DW6' data1 '_' data2 '.deramp.ccp 300 40 DW6' data1 '_' data2 '.deramp.offsets 1 0.01 50 10 - - - - 4 0 0 DW6' data1 '_' data2 '.deramp.ccs_std' ]) % Window size and steps jakobshavn
%eval(['!offset_pwr_tracking ' data1 '.slc.deramp ' data2 '.slc.deramp ' data1 '.slc.deramp.par ' data2 '.slc.deramp.par ' data1 '_' data2 '.deramp.off ' data1 '_' data2 '.deramp.offs ' data1 '_' data2 '.deramp.snr 350 75 ' data1 '_' data2 '.deramp.offsets 1 3.0 20 4 - - - - 4 0']) % Window size and steps GVI
%eval(['!offset_pwr_tracking ' data1 '.slc.deramp ' data2 '.slc.deramp ' data1 '.slc.deramp.par ' data2 '.slc.deramp.par ' data1 '_' data2 '.deramp.off ' data1 '_' data2 '.deramp.offs ' data1 '_' data2 '.deramp.snr 400 80 ' data1 '_' data2 '.deramp.offsets 2 5.0 50 10 - - - - 4 0'])
%eval(['!offset_pwr_tracking ' data1 '.slc.deramp ' data2 '.slc.deramp ' data1 '.slc.deramp.par ' data2 '.slc.deramp.par ' data1 '_' data2 '.deramp.off ' data1 '_' data2 '.deramp.offs ' data1 '_' data2 '.deramp.snr 144 48 ' data1 '_' data2 '.deramp.offsets 2 5.0 40 20 - - - - 4 0'])

%eval(['!offset_tracking ' data1 '_' data2 '.deramp.offs ' data1 '_' data2 '.deramp.snr ' data1 '.slc.deramp.par ' data1 '_' data2 '.deramp.off ' data1 '_' data2 '.deramp.dis_map ' data1 '_' data2 '.deramp.dis_val 2 5.0 1']);
eval(['!offset_tracking DW6' data1 '_' data2 '.deramp.offs DW6' data1 '_' data2 '.deramp.ccp ' data1 '.slc.deramp.par DW6' data1 '_' data2 '.deramp.off DW6' data1 '_' data2 '.deramp.dis_map DW6' data1 '_' data2 '.deramp.dis_val 2 0.0 1']);

%eval(['!multi_look ' data1 '.slc.deramp ' data1 '.slc.deramp.par master_deramp.mli master_deramp.mli.par 20 4']);
eval(['!multi_look ' data1 '.slc.deramp ' data1 '.slc.deramp.par DW6master_deramp.mli DW6master_deramp.mli.par 50 10']);%Jak

%eval(['!multi_look ' data1 '.slc.deramp ' data1 '.slc.deramp.par master_deramp.mli master_deramp.mli.par 40 20']);

[s,widthMaster]=system(['grep range_samples: DW6master_deramp.mli.par | cut -c33-36']);
widthMaster=num2str(widthMaster(1,1:4));

eval(['!cpx_to_real DW6' data1 '_' data2 '.deramp.dis_map DW6ground_' data1 '_' data2 ' ' widthMaster ' 0']);
eval(['!cpx_to_real DW6' data1 '_' data2 '.deramp.dis_map DW6azimuth_' data1 '_' data2 ' ' widthMaster ' 1']);         
eval(['!cpx_to_real DW6' data1 '_' data2 '.deramp.dis_map DW6velocity_' data1 '_' data2 ' ' widthMaster ' 3']);
eval(['!cpx_to_real DW6' data1 '_' data2 '.deramp.dis_map DW6angle_' data1 '_' data2 ' ' widthMaster ' 4']); 

%$col_ramp==10.0 instead of 30.0 (cycle) and also uses 100.0(col_ramp2)
eval(['!rasdt_pwr24 DW6ground_' data1 '_' data2 ' DW6master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 DW6ground_' data1 '_' data2 '.bmp']);
eval(['!rasdt_pwr24 DW6azimuth_' data1 '_' data2 ' DW6master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 DW6azimuth_' data1 '_' data2 '.bmp']);
eval(['!rasdt_pwr24 DW6velocity_' data1 '_' data2 ' DW6master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 DW6velocity_' data1 '_' data2 '.bmp']);
eval(['!rasdt_pwr24 DW6angle_' data1 '_' data2 ' DW6master_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 DW6angle_' data1 '_' data2 '.bmp']);


ground_cor= ['DW6ground_' data1 '_' data2]; 
azimuth_cor= ['DW6azimuth_' data1 '_' data2]; 

eval(['!float_math ' ground_cor ' ' ground_cor ' DW6Multi_gro ' widthMaster ' 2']);
eval(['!float_math ' azimuth_cor ' ' azimuth_cor ' DW6Multi_az ' widthMaster ' 2']);
eval(['!float_math DW6Multi_gro DW6Multi_az DW6Sum ' widthMaster ' 0']);
eval(['!float_math DW6Sum - DW6squRo ' widthMaster ' 6']);
%eval(['!float_math squRo - VELOCITY ' widthMaster ' 3 - - - - 36'])% 36 days
eval(['!float_math DW6squRo - DW6VELOCITY ' widthMaster ' 3 - - - - 12'])%12days [m/dia]
eval(['!float_math DW6VELOCITY - DW6VEL_km_y_' data1 '_' data2 ' ' widthMaster ' 2 - - - - 0.365']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Geocoding %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

eval(['!gc_map DW6master_deramp.mli.par - /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem.par /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem DW6' data1 '.dem.par DW6' data1 '.dem DW6' data1 '.lt']);

y2=['grep width: DW6' data1 '.dem.par | cut -c23-26']
[s2,widthDEM]=system(y2);
widthDEM=num2str(widthDEM(1,1:4));

y3=['grep lines: DW6' data1 '.dem.par | cut -c23-26']
[s3,linesDEM]=system(y3);
linesDEM=num2str(linesDEM(1,1:4));

eval(['!geocode_back DW6VEL_km_y_' data1 '_' data2 ' ' widthMaster ' DW6' data1 '.lt DW6vel_geoc_' data1 '_' data2 ' ' widthDEM ' ' linesDEM ' 2 0'])

eval(['!data2geotiff DW6' data1 '.dem.par DW6vel_geoc_' data1 '_' data2 ' 2 DW6VEL_km_y_' data1 '_' data2 '.tif']);


[Vel_dw,R_dw]=geotiffread('DW6VEL_km_y_20141116_20141128.tif');
%imagesc(Vel_dw*1000);

 Vel_dw(Vel_dw<=0)=nan;

 [row_S1,col_S1] = map2pix(R_dw,X_p,Y_p);

 prof_S1_dw=improfile(Vel_dw,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));
           
 clear row* col* ccp_map Rs1 Rs1_ccp Vel_map

 
figure('units', 'centimeters','position', [0 0 30 40] , 'paperpositionmode', 'auto');        
subplot(2,1,1)        
plot(dist(1,:),1000*prof_S1(:,1),'color',[0 0.45 0.74], 'Linestyle', 'none','marker','.');hold on;
        plot(dist(1,:),1000*prof_S1_dw,'.'); hold on;
        B_=nan(2,3);
        B_(:,1)=[-2000;20000];
        B_(:,2)=889*0.047949;
        ylabel('velocity [m.yr^{-1}]','fontsize',10,'fontweight','b')
        xlabel('distance [km]','fontsize',10,'fontweight','b')
        hold on;
        plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
        xlim([0 (0.047949*999)+1]);
        ylim(gca,[0 12000]);
        set(gca,'XTick',[0:5:45])
        set(gca,'YTick',[0:2000:12000])
        grid on;
        title('different window size', 'FontWeight','bold','FontSize',10)        

subplot(2,1,2)        
plot(dist(1,:),1000*(prof_S1(:,1)-prof_S1_dw),'color',[0 0.45 0.74], 'Linestyle', 'none','marker','.');hold on;

        B_=nan(2,3);
        B_(:,1)=[-20000;20000];
        B_(:,2)=889*0.047949;
        ylabel('velocity [m.yr^{-1}]','fontsize',10,'fontweight','b')
        xlabel('distance [km]','fontsize',10,'fontweight','b')
        hold on;
        plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
        xlim([0 (0.047949*999)+1]);
        ylim(gca,[-400 400]);
        set(gca,'XTick',[0:5:45])
        %set(gca,'YTick',[0:2000:12000])
        grid on;
        title('different window size difference', 'FontWeight','bold','FontSize',10)        

        
        figure
        plot(dist(1,:),1000*(prof_S1(:,1)-prof_S1_dw),'color',[0 0.45 0.74], 'Linestyle', 'none','marker','.');hold on;
        B_=nan(2,3);
        B_(:,1)=[-20000;20000];
        B_(:,2)=889*0.047949;
        ylabel('velocity [m.yr^{-1}]','fontsize',10,'fontweight','b')
        xlabel('distance [km]','fontsize',10,'fontweight','b')
        hold on;
        plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
        xlim([0 (0.047949*999)+1]);
        ylim(gca,[-10000 10000]);
        set(gca,'XTick',[0:5:45])
        %set(gca,'YTick',[0:2000:12000])
        grid on;
        title('different window size difference', 'FontWeight','bold','FontSize',10)        

