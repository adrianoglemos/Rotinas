eval(['!cpx_to_real c' data1 '_' data2 '.deramp.dis_map cground_' data1 '_' data2 ' ' widthMaster ' 0']);
eval(['!cpx_to_real c' data1 '_' data2 '.deramp.dis_map cazimuth_' data1 '_' data2 ' ' widthMaster ' 1']);         
eval(['!cpx_to_real c' data1 '_' data2 '.deramp.dis_map cvelocity_' data1 '_' data2 ' ' widthMaster ' 3']);
eval(['!cpx_to_real c' data1 '_' data2 '.deramp.dis_map cangle_' data1 '_' data2 ' ' widthMaster ' 4']); 

%$col_ramp==10.0 instead of 30.0 (cycle) and also uses 100.0(col_ramp2)
eval(['!rasdt_pwr24 cground_' data1 '_' data2 ' cmaster_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 cground_' data1 '_' data2 '.bmp']);
eval(['!rasdt_pwr24 cazimuth_' data1 '_' data2 ' cmaster_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 cazimuth_' data1 '_' data2 '.bmp']);
eval(['!rasdt_pwr24 cvelocity_' data1 '_' data2 ' cmaster_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 cvelocity_' data1 '_' data2 '.bmp']);
eval(['!rasdt_pwr24 cangle_' data1 '_' data2 ' cmaster_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 cangle_' data1 '_' data2 '.bmp']);
eval(['!rasdt_pwr24 c' data1 '_' data2 '.deramp.ccs_std cmaster_deramp.mli ' widthMaster ' 1 1 0 1 1 30. 1. .35 1 cccs_std_' data1 '_' data2 '.bmp']);


ground_cor= ['cground_' data1 '_' data2]; 
azimuth_cor= ['cazimuth_' data1 '_' data2]; 

eval(['!float_math ' ground_cor ' ' ground_cor ' cMulti_gro ' widthMaster ' 2']);
eval(['!float_math ' azimuth_cor ' ' azimuth_cor ' cMulti_az ' widthMaster ' 2']);
eval(['!float_math cMulti_gro cMulti_az cSum ' widthMaster ' 0']);
eval(['!float_math cSum - csquRo ' widthMaster ' 6']);
%eval(['!float_math squRo - VELOCITY ' widthMaster ' 3 - - - - 36'])% 36 days
eval(['!float_math csquRo - cVELOCITY ' widthMaster ' 3 - - - - 12'])%12days [m/dia]
eval(['!float_math cVELOCITY - cVEL_km_y_' data1 '_' data2 ' ' widthMaster ' 2 - - - - 0.365']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Geocoding %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

eval(['!gc_map cmaster_deramp.mli.par - /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem.par /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem c' data1 '.dem.par c' data1 '.dem c' data1 '.lt']);

%eval(['!gc_map ' data1 '.slc.deramp.mli.par - /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem.par /nfs/a59/eeagdl/Petterman_S1/DEM/GIMP/gimpdem_90m.dem ' data1 '.dem.par ' data1 '.dem ' data1 '.lt 1 1']);

%%%Refinement of geocoding lookup table
%eval(['!pixel_area ' data1 '.slc.deramp.mli.par ' data1 '.dem.par ' data1 '.dem ' data1 '.lt ' data1 '_ls_map ' data1 '_inc ' data1 '_pix_sigma0 ' data1 '_pix_gamma0']);

%%%Correction to the lookup table is determined and applied
% eval(['!create_diff_par ' data1 '.slc.deramp.mli.par - ' data1 '.diff_par 1 0']);
% eval(['!offset_pwrm ' data1 '_pix_sigma0 ' data1 '.slc.deramp.mli ' data1 '.diff_par ' data1 '.offs ' data1 '.snr 256 256 ' data1 '_offsets 2 64 64 4.0']);
% eval(['!offset_fitm ' data1 '.offs ' data1 '.snr ' data1 '.diff_par ' data1 '_coffs ' data1 '_coffsets 5.0 1']);

% y1=['grep range_samples: ' data1 '.slc.deramp.mli.par | cut -c33-36']
% [s,widthGeo]=system(y1);
% widthGeo=num2str(widthGeo(1,1:4));

y2=['grep width: ' data1 '.dem.par | cut -c23-26']
[s2,widthDEM]=system(y2);
widthDEM=num2str(widthDEM(1,1:4));

y3=['grep lines: ' data1 '.dem.par | cut -c23-26']
[s3,linesDEM]=system(y3);
linesDEM=num2str(linesDEM(1,1:4));

%eval(['!gc_map_fine ' data1 '.lt ' widthDEM ' ' data1 '.diff_par ' data1 '.lt_fine 1']);

%eval(['!geocode_back ' data1 '.slc.deramp.mli ' widthGeo ' ' data1 '.lt_fine ' data1 '_geoc.slc.mli ' widthDEM ' ' linesDEM ' 2 0']);
%eval(['!geocode_back ' data1 '.slc.deramp.mli ' widthGeo ' ' data1 '.lt ' data1 '_geoc.slc.mli ' widthDEM ' ' linesDEM ' 2 0']);
%!raspwr 20150125_geoc.slc.mli 3048

eval(['!geocode_back cVEL_km_y_' data1 '_' data2 ' ' widthMaster ' c' data1 '.lt cvel_geoc_' data1 '_' data2 ' ' widthDEM ' ' linesDEM ' 2 0'])

eval(['!data2geotiff c' data1 '.dem.par cvel_geoc_' data1 '_' data2 ' 2 cVEL_km_y_' data1 '_' data2 '.tif']);


eval(['!app setup canopy python-libs && ../dust_filter.py cvel_geoc_* float32 ' widthDEM ' ' linesDEM ' ./calibrated/cvel_geoc_dust']);

    for w=[5 10 20 40 80 100];
        
        for f=[0.1:0.1:0.9];
            
            %eval(['!app setup canopy python-libs && ../gaussian_filter.py ./calibrated/cvel_geoc_dust float32 ' widthDEM ' ' linesDEM ' ./calibrated/cvel_geoc_dust_gauss2_' num2str(w) '_' num2str(f) ' -w ' num2str(w) ' -fmax ' num2str(f)]);
            eval(['!data2geotiff ' data1 '.dem.par ./calibrated/cvel_geoc_dust_gauss2_' num2str(w) '_' num2str(f) ' 2 ./calibrated/cVEL_km_y_' data1 '_' data2 '_filter2_' num2str(w) '_' num2str(f) '.tif']);
        end
    end

clear widthDEM linesDEM y2 y3

for w=[5 10 20 40 80 100];
        n=1;
        for f=[0.1:0.1:0.9];
           eval(['[Vel_map_gauss_' num2str(w) '_' num2str(ff(n,:)) ',Rs1_gauss_' num2str(w) '_' num2str(ff(n,:)) ']=geotiffread(''cVEL_km_y_' date(1:17) '_filter2_' num2str(w) '_' num2str(f) '.tif'');']);
        
           eval(['Vel_map=Vel_map_gauss_' num2str(w) '_' num2str(ff(n,:)) '; Rs1=Rs1_gauss_' num2str(w) '_' num2str(ff(n,:)) ';']);
           
           Vel_map(Vel_map<=0)=nan;

           [row_S1,col_S1] = map2pix(Rs1,X_p,Y_p);

           eval(['prof_cS1_gauss_' num2str(w) '_' num2str(ff(n,:)) '=improfile(Vel_map,col_S1(~isnan(col_S1)),row_S1(~isnan(row_S1)));']);
           
           clear row* col* ccp_map Rs1 Rs1_ccp Vel_map
           
           n=n+1;
        end
end


for w=[5 10 20 40 80 100];
        n=1;
                
figure('units', 'centimeters','position', [0 0 30 40] , 'paperpositionmode', 'auto');        
        for f=[0.1:0.1:0.9];

        subplot(3,3,n)
        eval(['plot(dist(1,:),1000*prof_S1_gauss_' num2str(w) '_' num2str(ff(n,:)) ',''.'');']);hold on;
        eval(['plot(dist(1,:),1000*prof_cS1_gauss_' num2str(w) '_' num2str(ff(n,:)) ',''.'');']);hold on;
        B_=nan(2,3);
        B_(:,1)=[-2;20000];
        B_(:,2)=889*0.047949;
        ylabel('velocity [m.yr^{-1}]','fontsize',8,'fontweight','b')
        xlabel('distance [km]','fontsize',8,'fontweight','b')
        hold on;
        plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
        xlim([0 (0.047949*999)+1]);
        ylim(gca,[0 12000]);
        set(gca,'XTick',[0:5:45])
        set(gca,'YTick',[0:2000:12000])
        grid on;
        ttt=['w=' num2str(w) ' f=' num2str(f) ];
        title(ttt, 'FontWeight','bold','FontSize',8)
%         legend('0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','location','northwest');
        
        n=n+1;
        end
        
%         B_=nan(2,3);
%         B_(:,1)=[-2;20000];
%         B_(:,2)=889*0.047949;
%         ylabel('velocity [m.yr^{-1}]','fontsize',12,'fontweight','b')
%         xlabel('distance [km]','fontsize',12,'fontweight','b')
%         hold on;
%         plot(B_(:,2),B_(:,1),'color','r', 'Linestyle', '--','LineWidth',2);
%         xlim([0 (0.047949*999)+1]);
%         ylim(gca,[0 12000]);
%         set(gca,'XTick',[0:5:45])
%         set(gca,'YTick',[0:2000:12000])
%         grid on;
%         ttt=['Dust + Gaussian filter: w=' num2str(w)];
%         title(ttt, 'FontWeight','bold','FontSize',12)
%         legend('0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','location','northwest');
pause(2);
eval(['print -djpeg -r300 /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/Profiles/JAK/Profile_and_Map_gauss/Calibrated_filters_w' num2str(w)])
close all
end


for w=[5 10 20 40 80 100];
        n=1;
                
figure('units', 'centimeters','position', [0 0 30 40] , 'paperpositionmode', 'auto');        
        for f=[0.1:0.1:0.9];

        subplot(3,3,n)
        %eval(['[Vel_map_gauss_' num2str(w) '_' num2str(ff(n,:)) ',Rs1_gauss_' num2str(w) '_' num2str(ff(n,:)) ']=geotiffread(''VEL_km_y_' date(1:17) '_filter_' num2str(w) '_' num2str(f) '.tif'');']);
        
           eval(['Vel_map=Vel_map_gauss_' num2str(w) '_' num2str(ff(n,:)) '; Rs1=Rs1_gauss_' num2str(w) '_' num2str(ff(n,:)) ';']);
           
           Vel_map(Vel_map<=0)=nan;
           
           h=imagesc(Vel_map*1000);
tt=double(~isnan(Vel_map));set(h,'AlphaData', tt);
axis off;
caxis([0 8000])


        ttt=['w=' num2str(w) ' f=' num2str(f) ];
        title(ttt, 'FontWeight','bold','FontSize',8)
%         legend('0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','location','northwest');
        
        n=n+1;
        end
        
        c=colorbar('location','south','Position',...
    [0.60150709219858 0.0485159817351597 0.299645390070922 0.045662100456621]);
        
annotation(gcf,'textbox',...
    [0.726190476190475 0.035 0.0992063466439803 0.0529100518588245],...
    'String',{'m.yr^{-1}'},...
    'LineStyle','none',...
    'FitBoxToText','off');


pause(2);
eval(['print -djpeg -r300 /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/A4/162/Profiles/JAK/Profile_and_Map_gauss/Calibrated_filters_maps_w' num2str(w)])
close all
end











