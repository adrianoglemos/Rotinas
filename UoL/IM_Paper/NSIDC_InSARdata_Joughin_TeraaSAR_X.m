cd /nfs/a59/eeagdl/DATABASE/GREENLAND/Joughin_Data_GRIS/TerraSAR_X/W69_10N/

pathsate_TSX=['/nfs/a59/eeagdl/DATABASE/GREENLAND/Joughin_Data_GRIS/TerraSAR_X/W69_10N/'];
d_TSX=dir(pathsate_TSX);
j=1;
for i=4:length(d_TSX);
    name=d_TSX(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_TSX(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_TSX i j name

%%%%%%%%%%%%%%%%%%%%%%%%%
% apr= 1:22;
% aug= 23:51;
% dec= 52:84;
% feb= 85:105;
% jan= 106:125;
% jul= 126:154;
% jun= 155:184;
% mar= 185:202;
% may= 203:220;
% nov= 221:254;
% oct= 255:281;
% sep= 282:298;
%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sorting the dates:

for i=1: length(list_TSX)
    
   date=list_TSX{i,1};
   n(i,1) = datenum(date(5:15),'mmm-dd-yyyy');
   n(i,2)=  datenum(date(17:27),'mmm-dd-yyyy');
   n(i,3:5)=  datenum(date(29:30),'HH');
   n(i,4)=  datenum(date(32:33),'MM');
   n(i,5:6)=  date(35:36);
   %n(i,:) = date(5:15);
end

[n_sorted,I]=sort(n(:,1));
n_sorted(:,2)=n(I,2);
n_sorted(:,3)=n(I,3);
n_sorted(:,4)=n(I,4);
n_sorted(:,5)=n(I,5);
n_sorted(:,6)=n(I,6);

for i=1:length(list_TSX)
n_sorted_str(i,:)=[datestr(n_sorted(i,1),'mmm-dd-yyyy') '_' datestr(n_sorted(i,2),'mmm-dd-yyyy') '_' datestr(n_sorted(i,3),'HH') '-' datestr(n_sorted(i,4),'MM') '-' n_sorted(i,5) n_sorted(i,6)];
end


j=1;
for i=1:length(list_TSX);
    path1=[pathsate_TSX 'TSX_' n_sorted_str(i,:)];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    
    %date=list_TSX{i,1};
    
% path_pro=dir(path1);   
 cd(path1)
% cd([pathsate_TSX path_pro.name]);
arq_name(i,:)=[n_sorted_str(i,5:6) n_sorted_str(i,1:3) n_sorted_str(i,10:11) '_' n_sorted_str(i,17:18) n_sorted_str(i,13:15) n_sorted_str(i,22:23)];


eval(['[velx_TSX(:,:,j),R_TSX'  ']=geotiffread(''TSX_W69.10N_' arq_name(i,:) '.vx.tif'');']);
eval(['vely_TSX(:,:,j)=imread(''TSX_W69.10N_' arq_name(i,:) '.vy.tif'');']);
eval(['errx_TSX(:,:,j)=imread(''TSX_W69.10N_' arq_name(i,:) '.ex.tif'');']);
eval(['erry_TSX(:,:,j)=imread(''TSX_W69.10N_' arq_name(i,:) '.ey.tif'');']);

Vel_TSX(:,:,j)=sqrt((velx_TSX(:,:,j).^2)+(vely_TSX(:,:,j).^2));

% eval(['[row,col] = map2pix(Ropt_' date(13:16) '_' date(18:19) ',X_p_curve_JAK,Y_p_curve_JAK);']);
% eval(['vel=Vel_opt_' date(13:16) '_' date(18:19) ';']);

j=j+1;


end


Vel_TSX(Vel_TSX>1000000)=nan;
Vel_mean_TSX=nanmean(Vel_TSX,3);
Vel_mean_TSX_log=log10(Vel_mean_TSX);

[row_TSX,col_TSX] = map2pix(R_TSX ,X_p_curve_JAK,Y_p_curve_JAK);

prof_TSX_mean=improfile(Vel_mean_TSX,col_TSX(~isnan(col_TSX)),row_TSX(~isnan(row_TSX)));

for i=1:length(list_TSX);
   prof_TSX(:,i)=improfile(Vel_TSX(:,:,i),col_TSX(~isnan(col_TSX)),row_TSX(~isnan(row_TSX)));
end

info = geotiffinfo('/nfs/a59/eeagdl/DATABASE/GREENLAND/Joughin_Data_GRIS/TerraSAR_X/W69_10N/TSX_Apr-01-2011_Apr-12-2011_10-05-23/TSX_W69.10N_01Apr11_12Apr11.vy.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/Vel_mean_TSX_JAK.tif', Vel_mean_TSX, R_TSX,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/Vel_mean_TSX_JAK_log.tif', Vel_mean_TSX_log, R_TSX,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/JAK/stack/Vel_mean_TSX_stack.tif', Vel_TSX, R_TSX,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
 

eval(['[row,col] = map2pix(Ropt_' date(13:16) '_' date(18:19) ',X_p_curve_JAK,Y_p_curve_JAK);']);
eval(['vel=Vel_opt_' date(13:16) '_' date(18:19) ';']);

%%%%%% the overlapping time TSX vs S1 %%%%%%%%%%%%%%%%%%%%
plot(nanmean(prof_curve_JAK_5window_mean(:,1:4),2)*1000,'.')
hold on
plot(nanmean(prof_TSX(:,end-22:end),2),'.')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% pts_TSX_Joughin_JAK = shaperead('/nfs/a59/eeagdl/NRT_project/JkI/Joughin_Points/Joughin_pt_JAK.shp');
% X_pts_TSX_Joughin_JAK=extractfield(pts_TSX_Joughin_JAK,'xx');
% Y_pts_TSX_Joughin_JAK=extractfield(pts_TSX_Joughin_JAK,'yy');

pts_TSX_Joughin_JAK = shaperead('/nfs/a59/eeagdl/NRT_project/JkI/Joughin_Points/Joughin_pt_JAK_points_email_proj.shp');
X_pts_TSX_Joughin_JAK=extractfield(pts_TSX_Joughin_JAK,'xx');
Y_pts_TSX_Joughin_JAK=extractfield(pts_TSX_Joughin_JAK,'yy');

pts_TSX_Joughin_JAK_Npts = shaperead('/nfs/a59/eeagdl/NRT_project/JkI/Joughin_Points/N_Points_Joughin.shp');
X_pts_TSX_Joughin_JAK_Npts=extractfield(pts_TSX_Joughin_JAK_Npts,'X');
Y_pts_TSX_Joughin_JAK_Npts=extractfield(pts_TSX_Joughin_JAK_Npts,'Y');

% pt_TSX_Joughin_JAK : 1:6 are the M points //// 7:11 are the N points //// 12:end --> Pad points

for j=[1:length(Y_pts_TSX_Joughin_JAK)]
for i=1:size(Vel_TSX,3) 
% pt_TSX_Joughin_JAK(i,1)=profile_ext_mean(X_pts_TSX_Joughin_JAK(1,1),Y_pts_TSX_Joughin_JAK(1,1),Vel_TSX(:,:,i),R_TSX,5);
% pt_TSX_Joughin_JAK(i,2)=profile_ext_mean(X_pts_TSX_Joughin_JAK(1,2),Y_pts_TSX_Joughin_JAK(1,2),Vel_TSX(:,:,i),R_TSX,5);
% pt_TSX_Joughin_JAK(i,3)=profile_ext_mean(X_pts_TSX_Joughin_JAK(1,3),Y_pts_TSX_Joughin_JAK(1,3),Vel_TSX(:,:,i),R_TSX,5);
% pt_TSX_Joughin_JAK(i,4)=profile_ext_mean(X_pts_TSX_Joughin_JAK(1,4),Y_pts_TSX_Joughin_JAK(1,4),Vel_TSX(:,:,i),R_TSX,5);
% pt_TSX_Joughin_JAK(i,5)=profile_ext_mean(X_pts_TSX_Joughin_JAK(1,5),Y_pts_TSX_Joughin_JAK(1,5),Vel_TSX(:,:,i),R_TSX,5);
% pt_TSX_Joughin_JAK(i,6)=profile_ext_mean(X_pts_TSX_Joughin_JAK(1,6),Y_pts_TSX_Joughin_JAK(1,6),Vel_TSX(:,:,i),R_TSX,5);
pt_TSX_Joughin_JAK(i,j)=profile_ext_mean(X_pts_TSX_Joughin_JAK(1,j),Y_pts_TSX_Joughin_JAK(1,j),Vel_TSX(:,:,i),R_TSX,5);

end
end

for j=[1:length(Y_pts_TSX_Joughin_JAK)]
for i=1:size(Vel_Stack,3) 
% pt_S1_Joughin_JAK(i,1)=profile_ext_mean(X_pts_TSX_Joughin_JAK(1,1),Y_pts_TSX_Joughin_JAK(1,1),Vel_Stack(:,:,i),R_stack,5);
% pt_S1_Joughin_JAK(i,2)=profile_ext_mean(X_pts_TSX_Joughin_JAK(1,2),Y_pts_TSX_Joughin_JAK(1,2),Vel_Stack(:,:,i),R_stack,5);
% pt_S1_Joughin_JAK(i,3)=profile_ext_mean(X_pts_TSX_Joughin_JAK(1,3),Y_pts_TSX_Joughin_JAK(1,3),Vel_Stack(:,:,i),R_stack,5);
% pt_S1_Joughin_JAK(i,4)=profile_ext_mean(X_pts_TSX_Joughin_JAK(1,4),Y_pts_TSX_Joughin_JAK(1,4),Vel_Stack(:,:,i),R_stack,5);
% pt_S1_Joughin_JAK(i,5)=profile_ext_mean(X_pts_TSX_Joughin_JAK(1,5),Y_pts_TSX_Joughin_JAK(1,5),Vel_Stack(:,:,i),R_stack,5);
% pt_S1_Joughin_JAK(i,6)=profile_ext_mean(X_pts_TSX_Joughin_JAK(1,6),Y_pts_TSX_Joughin_JAK(1,6),Vel_Stack(:,:,i),R_stack,5);
pt_S1_Joughin_JAK(i,j)=profile_ext_mean(X_pts_TSX_Joughin_JAK(1,j),Y_pts_TSX_Joughin_JAK(1,j),Vel_Stack(:,:,i),R_stack,5);
end
end


for j=[1:length(Y_pts_TSX_Joughin_JAK_Npts)]
for i=1:size(Vel_TSX,3)
% pt_TSX_Joughin_JAK(i,7)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,1),Y_pts_TSX_Joughin_JAK_Npts(1,1),Vel_TSX(:,:,i),R_TSX,5);
% pt_TSX_Joughin_JAK(i,8)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,2),Y_pts_TSX_Joughin_JAK_Npts(1,2),Vel_TSX(:,:,i),R_TSX,5);
% pt_TSX_Joughin_JAK(i,9)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,3),Y_pts_TSX_Joughin_JAK_Npts(1,3),Vel_TSX(:,:,i),R_TSX,5);
% pt_TSX_Joughin_JAK(i,10)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,4),Y_pts_TSX_Joughin_JAK_Npts(1,4),Vel_TSX(:,:,i),R_TSX,5);
% pt_TSX_Joughin_JAK(i,11)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,5),Y_pts_TSX_Joughin_JAK_Npts(1,5),Vel_TSX(:,:,i),R_TSX,5);
% pt_TSX_Joughin_JAK(i,12)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,6),Y_pts_TSX_Joughin_JAK_Npts(1,6),Vel_TSX(:,:,i),R_TSX,5);
% pt_TSX_Joughin_JAK(i,13)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,7),Y_pts_TSX_Joughin_JAK_Npts(1,7),Vel_TSX(:,:,i),R_TSX,5);
% pt_TSX_Joughin_JAK(i,14)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,8),Y_pts_TSX_Joughin_JAK_Npts(1,8),Vel_TSX(:,:,i),R_TSX,5);
% pt_TSX_Joughin_JAK(i,15)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,9),Y_pts_TSX_Joughin_JAK_Npts(1,9),Vel_TSX(:,:,i),R_TSX,5);
% pt_TSX_Joughin_JAK(i,16)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,10),Y_pts_TSX_Joughin_JAK_Npts(1,10),Vel_TSX(:,:,i),R_TSX,5);
%pt_TSX_Joughin_JAK(i,17)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,11),Y_pts_TSX_Joughin_JAK_Npts(1,11),Vel_TSX(:,:,i),R_TSX,5);
pt_TSX_Joughin_JAK(i,j+6)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,j),Y_pts_TSX_Joughin_JAK_Npts(1,j),Vel_TSX(:,:,i),R_TSX,5);

%pt_JAK_main(i)=prof_curve_JAK(10,i);
end
end

for j=[1:length(Y_pts_TSX_Joughin_JAK_Npts)]
for i=1:size(Vel_Stack,3) 

% pt_S1_Joughin_JAK(i,7)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,1),Y_pts_TSX_Joughin_JAK_Npts(1,1),Vel_Stack(:,:,i),R_stack,5);
% pt_S1_Joughin_JAK(i,8)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,2),Y_pts_TSX_Joughin_JAK_Npts(1,2),Vel_Stack(:,:,i),R_stack,5);
% pt_S1_Joughin_JAK(i,9)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,3),Y_pts_TSX_Joughin_JAK_Npts(1,3),Vel_Stack(:,:,i),R_stack,5);
% pt_S1_Joughin_JAK(i,10)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,4),Y_pts_TSX_Joughin_JAK_Npts(1,4),Vel_Stack(:,:,i),R_stack,5);
% pt_S1_Joughin_JAK(i,11)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,5),Y_pts_TSX_Joughin_JAK_Npts(1,5),Vel_Stack(:,:,i),R_stack,5);
% pt_S1_Joughin_JAK(i,12)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,6),Y_pts_TSX_Joughin_JAK_Npts(1,6),Vel_Stack(:,:,i),R_stack,5);
% pt_S1_Joughin_JAK(i,13)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,7),Y_pts_TSX_Joughin_JAK_Npts(1,7),Vel_Stack(:,:,i),R_stack,5);
% pt_S1_Joughin_JAK(i,14)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,8),Y_pts_TSX_Joughin_JAK_Npts(1,8),Vel_Stack(:,:,i),R_stack,5);
% pt_S1_Joughin_JAK(i,15)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,9),Y_pts_TSX_Joughin_JAK_Npts(1,9),Vel_Stack(:,:,i),R_stack,5);
% pt_S1_Joughin_JAK(i,16)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,10),Y_pts_TSX_Joughin_JAK_Npts(1,10),Vel_Stack(:,:,i),R_stack,5);
pt_S1_Joughin_JAK(i,j+6)=profile_ext_mean(X_pts_TSX_Joughin_JAK_Npts(1,j),Y_pts_TSX_Joughin_JAK_Npts(1,j),Vel_Stack(:,:,i),R_stack,5);

end
%pt_JAK_main(i)=prof_curve_JAK(10,i);
end

data_str_JAK=[data_str_JAK1;data_str_JAK2];
for i=1:length(data_str_JAK);

date_pt_S1_Joughin_JAK(i)=datenum(data_str_JAK(i,1:6),'yymmdd');

end



   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,1),'.','color','r');
   hold on;
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,2),'.','color','y');
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,3),'.','color','m');
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,4),'.','color','g');
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,5),'.','color','c');
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,6),'.','color','b');

    legend('M6','M9','M13','M17','M20','M26');
   
ylim([0 18000])

fill([date_pt_S1_Joughin_JAK(1) date_pt_S1_Joughin_JAK(1) n_sorted(end,1) n_sorted(end,1)],[0 20000 20000 0],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,1)*1000,'.','color','r');
   
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,2)*1000,'LineStyle','--','MarkerSize',2,'MarkerFaceColor','y','Marker','^','color','y');
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,3)*1000,'LineStyle','--','MarkerSize',2,'MarkerFaceColor','m','Marker','^','color','m');
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,4)*1000,'LineStyle','--','MarkerSize',2,'MarkerFaceColor','g','Marker','^','color','g');
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,5)*1000,'LineStyle','--','MarkerSize',2,'MarkerFaceColor','c','Marker','^','color','c');
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,6)*1000,'LineStyle','--','MarkerSize',2,'MarkerFaceColor','b','Marker','^','color','b');

date_pt_S1_TSX_Joughin_JAK_combined=datestr([min(n_sorted(:,1)):max(date_pt_S1_Joughin_JAK)],'mmmyy');
datetick('x','yyyy','keeplimits');
grid on
ylabel('velocity [m/yr]','fontsize',12,'fontweight','b')

print -dpng -r300 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Pt_JAK_Joughin_and_S1_data_2009_2016


%%%%%%%%%%%%%%%%
% Plotting the N points
   % tributary locations: N6, N8, N11, N15, pad1, pad2, pad3, pad10
   name_pts=extractfield(pts_TSX_Joughin_JAK_Npts,'Name');
   
   figure(1)
   subplot(3,1,1)
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,2),'.','MarkerFaceColor','y','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k'); hold on;%N6
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,3),'.','MarkerFaceColor','m','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');hold on;%N8
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,4),'.','MarkerFaceColor','g','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%N11
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,5),'.','MarkerFaceColor','c','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%N15
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,6),'.','MarkerFaceColor','r','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%pad1
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,7),'.','MarkerFaceColor','b','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%pad2
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,8),'.','MarkerFaceColor','k','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%pad3
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK_Npts(:,15),'.','MarkerFaceColor',[1 0.2 0.5],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%pad10
   legend(name_pts(2),name_pts(3),name_pts(4),name_pts(5),name_pts(6),name_pts(7),name_pts(8),name_pts(15));
   
   %legend('N6','N8','N11','N15','Pad1','Pad2','Pad3','Pad10')%,'Pad16','Pad17','Pad18','Pad19','Pad20');

   ylim([0 4000])
xlim([datenum('122008','mmyyyy')  datenum('032017','mmyyyy')])

fill([date_pt_S1_Joughin_JAK(1) date_pt_S1_Joughin_JAK(1) n_sorted(end,1) n_sorted(end,1)],[0 7000 7000 0],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');
    
   % extra locations: pad4 and pad5
   figure(2)
   subplot(3,1,2)
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,9),'.','MarkerFaceColor',[0.5 0.5 0.5],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');hold on;%pad4
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,10),'.','MarkerFaceColor',[0.68 0.92 1],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%pad5
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,21),'.','MarkerFaceColor','r','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%pad16
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,22),'.','MarkerFaceColor','g','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%pad17
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,23),'.','MarkerFaceColor','y','Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');%pad18
   
   legend(name_pts(9),name_pts(10),name_pts(21),name_pts(22),name_pts(23));
   %legend('Pad4','Pad5','Pad16','Pad17','Pad18')%,'Pad16','Pad17','Pad18','Pad19','Pad20');
xlim([datenum('122008','mmyyyy')  datenum('032017','mmyyyy')])

ylim([400 5000])

fill([date_pt_S1_Joughin_JAK(1) date_pt_S1_Joughin_JAK(1) n_sorted(end,1) n_sorted(end,1)],[0 7000 7000 0],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');
plot([datenum('15082015','ddmmyyyy') datenum('15082015','ddmmyyyy')],[0 7000],'linestyle','--','color','r');

    
    %main stream:
    % pad6, pad7, pad8, pad9, pad11, pad12, pad13, pad14, pad15
figure(3)
    subplot(3,1,3)
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,11),'.','MarkerFaceColor',[0.3 0.2 0.5],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor',[0.3 0.2 0.5]); hold on;%pad6
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,12),'.','MarkerFaceColor',[0.3 0.2 0.0],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor',[0.3 0.2 0.0]);%pad7
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,13),'.','MarkerFaceColor',[0.8 0.2 0.0],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor',[0.8 0.2 0.0]);%pad8
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,14),'.','MarkerFaceColor',[0.0 0.2 0.5],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor',[0.0 0.2 0.5]);%pad9
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,16),'.','MarkerFaceColor',[0.1 0.2 0.3],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor',[0.1 0.2 0.3]);%pad11
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,17),'.','MarkerFaceColor',[0.0 0.2 0.8],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor',[0.0 0.2 0.8]);%pad12
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,18),'.','MarkerFaceColor',[0.0 0.8 0.5],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor',[0.0 0.8 0.5]);%pad13
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,19),'.','MarkerFaceColor',[0.25 0.25 0.25],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor',[0.25 0.25 0.25]);%pad14
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,20),'.','MarkerFaceColor',[0.333 0.333 0.333],'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor',[0.333 0.333 0.333]);%pad15
   
   legend(name_pts(11),name_pts(12),name_pts(13),name_pts(14),name_pts(16),name_pts(17),name_pts(18),name_pts(19),name_pts(20));
   %legend('Pad6','Pad7','Pad8','Pad9','Pad11','Pad12','Pad13','Pad14','Pad15')%,'Pad16','Pad17','Pad18','Pad19','Pad20');
xlim([datenum('122008','mmyyyy')  datenum('032017','mmyyyy')])
 %   legend('N6','N8','N11','N15','Pad1','Pad2','Pad3','Pad4','Pad5','Pad6','Pad7','Pad8','Pad9','Pad10','Pad11','Pad12','Pad13','Pad14','Pad15')%,'Pad16','Pad17','Pad18','Pad19','Pad20');
   
ylim([1500 6500])

fill([date_pt_S1_Joughin_JAK(1) date_pt_S1_Joughin_JAK(1) n_sorted(end,1) n_sorted(end,1)],[0 7000 7000 0],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');

   figure(1)
    subplot(3,1,1)

   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,2),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','y','Marker','^','MarkerEdgeColor','k','color','y');%N6
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,3),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','m','Marker','^','MarkerEdgeColor','k','color','m');%N8
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,4),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','g','Marker','^','MarkerEdgeColor','k','color','g');%N11
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,5),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','c','Marker','^','MarkerEdgeColor','k','color','c');%N15
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,6),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','r','Marker','^','MarkerEdgeColor','k','color','r');%pad1
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,7),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','b','Marker','^','MarkerEdgeColor','k','color','b');%pad2
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,8),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','k','Marker','^','MarkerEdgeColor','k','color','k');%pad3
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,15),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[1 0.2 0.5],'Marker','^','MarkerEdgeColor','k','color',[1 0.2 0.5]);%pad10
   set(gca,'XGrid','on','XAxisLocation','top')
   %legend('N6','N8','N11','N15','Pad1','Pad2','Pad3','Pad10')%,'Pad16','Pad17','Pad18','Pad19','Pad20');
date_pt_S1_TSX_Joughin_JAK_combined=datestr([min(n_sorted(:,1)):max(date_pt_S1_Joughin_JAK)],'mmmyy');
datetick('x','yyyy','keeplimits');
ylabel('velocity [m/yr]','fontsize',12,'fontweight','b')

figure(2)
   subplot(3,1,2)
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,9),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.5 0.5 0.5],'Marker','^','MarkerEdgeColor','k','color',[0.5 0.5 0.5]);hold on %pad4 
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,10),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.68 0.92 1],'Marker','^','MarkerEdgeColor','k','color',[0.68 0.92 1]);%pad5
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,21),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','r','Marker','^','MarkerEdgeColor','k','color','r');%pad16
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,22),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','g','Marker','^','MarkerEdgeColor','k','color','g');%pad17
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,23),'LineStyle','none','MarkerSize',5,'MarkerFaceColor','y','Marker','^','MarkerEdgeColor','k','color','y');%pad18
   
   %legend('Pad4','Pad5')%,'Pad16','Pad17','Pad18','Pad19','Pad20');
date_pt_S1_TSX_Joughin_JAK_combined=datestr([min(n_sorted(:,1)):max(date_pt_S1_Joughin_JAK)],'mmmyy');
datetick('x','yyyy','keeplimits');
set(gca,'XGrid','on','xticklabel',[])

ylabel('velocity [m/yr]','fontsize',12,'fontweight','b')

   subplot(3,1,3)
   figure(3)
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,11),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.3 0.2 0.5],'Marker','^','MarkerEdgeColor','k','color',[0.3 0.2 0.5]);%pad6
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,12),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.3 0.2 0.0],'Marker','^','MarkerEdgeColor','k','color',[0.3 0.2 0.0]);%pad7
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,13),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.8 0.2 0.0],'Marker','^','MarkerEdgeColor','k','color',[0.8 0.2 0.0]);%pad8
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,14),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.0 0.2 0.5],'Marker','^','MarkerEdgeColor','k','color',[0.0 0.2 0.5]);%pad9
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,16),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.1 0.2 0.3],'Marker','^','MarkerEdgeColor','k','color',[0.1 0.2 0.3]);%pad11
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,17),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.0 0.2 0.8],'Marker','^','MarkerEdgeColor','k','color',[0.0 0.2 0.8]);%pad12
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,18),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.0 0.8 0.5],'Marker','^','MarkerEdgeColor','k','color',[0.0 0.8 0.5]);%pad13
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,19),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.25 0.25 0.25],'Marker','^','MarkerEdgeColor','k','color',[0.25 0.25 0.25]);%pad14
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,20),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',[0.333 0.333 0.333],'Marker','^','MarkerEdgeColor','k','color',[0.333 0.333 0.333]);%pad15
    %legend('Pad6','Pad7','Pad8','Pad9','Pad11','Pad12','Pad13','Pad14','Pad15')%,'Pad16','Pad17','Pad18','Pad19','Pad20');


date_pt_S1_TSX_Joughin_JAK_combined=datestr([min(n_sorted(:,1)):max(date_pt_S1_Joughin_JAK)],'mmmyy');
datetick('x','yyyy','keeplimits');
ylabel('velocity [m/yr]','fontsize',12,'fontweight','b')
set(gca,'XGrid','on','YAxisLocation','left')
%box off


print -dpng -r300 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/N_Pts_JAK_Joughin_and_S1_data_2009_2016








%% Terra SAR-X Joughin

cd /nfs/a59/eeagdl/DATABASE/GREENLAND/Joughin_Data_GRIS/TerraSAR_X/W80_75N

pathsate_TSX_PG=['/nfs/a59/eeagdl/DATABASE/GREENLAND/Joughin_Data_GRIS/TerraSAR_X/W80_75N/'];
d_TSX_PG=dir(pathsate_TSX_PG);
j=1;
for i=4:length(d_TSX_PG);
    name=d_TSX_PG(i,1).name;
    data_PG{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_TSX_PG(j,1)=cellstr(data_PG{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_TSX_PG i j name

% Sorting the dates:

for i=1: length(list_TSX_PG)
    
   date_PG=list_TSX_PG{i,1};
   n_PG(i,1) = datenum(date_PG(5:15),'mmm-dd-yyyy');
   n_PG(i,2)=  datenum(date_PG(17:27),'mmm-dd-yyyy');
   n_PG(i,3:5)=  datenum(date_PG(29:30),'HH');
   n_PG(i,4)=  datenum(date_PG(32:33),'MM');
   n_PG(i,5:6)=  date_PG(35:36);
end

[n_sorted_PG,I_PG]=sort(n_PG(:,1));
n_sorted_PG(:,2)=n_PG(I_PG,2);
n_sorted_PG(:,3)=n_PG(I_PG,3);
n_sorted_PG(:,4)=n_PG(I_PG,4);
n_sorted_PG(:,5)=n_PG(I_PG,5);
n_sorted_PG(:,6)=n_PG(I_PG,6);

for i=1:length(list_TSX_PG)
n_sorted_str_PG(i,:)=[datestr(n_sorted_PG(i,1),'mmm-dd-yyyy') '_' datestr(n_sorted_PG(i,2),'mmm-dd-yyyy') '_' datestr(n_sorted_PG(i,3),'HH') '-' datestr(n_sorted_PG(i,4),'MM') '-' n_sorted_PG(i,5) n_sorted_PG(i,6)];
end


j=1;
for i=1:length(list_TSX_PG);
    path1=[pathsate_TSX_PG 'TSX_' n_sorted_str_PG(i,:)];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    
    %date=list_TSX{i,1};
    
% path_pro=dir(path1);   
 cd(path1)
% cd([pathsate_TSX path_pro.name]);
arq_name_PG(i,:)=[n_sorted_str_PG(i,5:6) n_sorted_str_PG(i,1:3) n_sorted_str_PG(i,10:11) '_' n_sorted_str_PG(i,17:18) n_sorted_str_PG(i,13:15) n_sorted_str_PG(i,22:23)];


eval(['[velx_TSX_PG(:,:,j),R_TSX_PG'  ']=geotiffread(''TSX_W80.75N_' arq_name_PG(i,:) '.vx.tif'');']);
eval(['vely_TSX_PG(:,:,j)=imread(''TSX_W80.75N_' arq_name_PG(i,:) '.vy.tif'');']);
eval(['errx_TSX_PG(:,:,j)=imread(''TSX_W80.75N_' arq_name_PG(i,:) '.ex.tif'');']);
eval(['erry_TSX_PG(:,:,j)=imread(''TSX_W80.75N_' arq_name_PG(i,:) '.ey.tif'');']);

Vel_TSX_PG(:,:,j)=sqrt((velx_TSX_PG(:,:,j).^2)+(vely_TSX_PG(:,:,j).^2));

% eval(['[row,col] = map2pix(Ropt_' date(13:16) '_' date(18:19) ',X_p_curve_JAK,Y_p_curve_JAK);']);
% eval(['vel=Vel_opt_' date(13:16) '_' date(18:19) ';']);

j=j+1;


end


Vel_TSX_PG(Vel_TSX_PG>1000000)=nan;
Vel_mean_TSX_PG=nanmean(Vel_TSX_PG,3);
Vel_mean_TSX_PG_log=log10(Vel_mean_TSX_PG);


info = geotiffinfo('/nfs/a59/eeagdl/DATABASE/GREENLAND/Joughin_Data_GRIS/TerraSAR_X/W80_75N/TSX_Sep-04-2015_Sep-15-2015_11-37-35/TSX_W80.75N_04Sep15_15Sep15.vx.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/Vel_mean_TSX_PG.tif', Vel_mean_TSX_PG, R_TSX_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/Vel_mean_TSX_PG_log.tif', Vel_mean_TSX_PG_log, R_TSX_PG,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);



for i=1:length(list_TSX_PG);
   prof_TSX_PG(:,i)=profile_ext_mean(X_p_curve_PG,Y_p_curve_PG,Vel_TSX_PG(:,:,i),R_TSX_PG,5);
   
   prof_across_TSX_PG1(:,i)=profile_ext_mean(X_across_PG1,Y_across_PG1,Vel_TSX_PG(:,:,i),R_TSX_PG,5);
   prof_across_TSX_PG5(:,i)=profile_ext_mean(X_across_PG5,Y_across_PG5,Vel_TSX_PG(:,:,i),R_TSX_PG,5);
   prof_across_TSX_PG6(:,i)=profile_ext_mean(X_across_PG6,Y_across_PG6,Vel_TSX_PG(:,:,i),R_TSX_PG,5);
   
end

plot(nanmean(prof_across_TSX_PG1,2),'.','color','b'); hold on
plot(nanmean(prof_across_PG1,2),'.','color','r');

plot(nanmean(prof_across_TSX_PG6,2),'.','color','b'); hold on
plot(nanmean(prof_across_PG6,2),'.','color','r');


plot(nanmean(prof_across_TSX_PG5,2),'.','color','b'); hold on
plot(nanmean(prof_across_PG5,2),'.','color','r');

for i=1:14
    subplot(3,5,i);
    imagesc(Vel_TSX_PG(:,:,i));    
end



%% Terra SAR-X Joughin

cd /nfs/a59/eeagdl/DATABASE/GREENLAND/Joughin_Data_GRIS/TerraSAR_X/E79_40

pathsate_TSX_FJ=['/nfs/a59/eeagdl/DATABASE/GREENLAND/Joughin_Data_GRIS/TerraSAR_X/E79_40/'];
d_TSX_FJ=dir(pathsate_TSX_FJ);
j=1;
for i=3:length(d_TSX_FJ);
    name=d_TSX_FJ(i,1).name;
    data_FJ{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_TSX_FJ(j,1)=cellstr(data_FJ{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_TSX_FJ i j name

% Sorting the dates:

for i=1: length(list_TSX_FJ)
    
   date_FJ=list_TSX_FJ{i,1};
   n_FJ(i,1) = datenum(date_FJ(5:15),'mmm-dd-yyyy');
   n_FJ(i,2)=  datenum(date_FJ(17:27),'mmm-dd-yyyy');
   n_FJ(i,3:5)=  datenum(date_FJ(29:30),'HH');
   n_FJ(i,4)=  datenum(date_FJ(32:33),'MM');
   n_FJ(i,5:6)=  date_FJ(35:36);
end

[n_sorted_FJ,I_FJ]=sort(n_FJ(:,1));
n_sorted_FJ(:,2)=n_FJ(I_FJ,2);
n_sorted_FJ(:,3)=n_FJ(I_FJ,3);
n_sorted_FJ(:,4)=n_FJ(I_FJ,4);
n_sorted_FJ(:,5)=n_FJ(I_FJ,5);
n_sorted_FJ(:,6)=n_FJ(I_FJ,6);

for i=1:length(list_TSX_FJ)
n_sorted_str_FJ(i,:)=[datestr(n_sorted_FJ(i,1),'mmm-dd-yyyy') '_' datestr(n_sorted_FJ(i,2),'mmm-dd-yyyy') '_' datestr(n_sorted_FJ(i,3),'HH') '-' datestr(n_sorted_FJ(i,4),'MM') '-' n_sorted_FJ(i,5) n_sorted_FJ(i,6)];
end


j=1;
for i=1:length(list_TSX_FJ);
    path1=[pathsate_TSX_FJ 'TSX_' n_sorted_str_FJ(i,:)];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    
    %date=list_TSX{i,1};
    
% path_pro=dir(path1);   
 cd(path1)
% cd([pathsate_TSX path_pro.name]);
arq_name_FJ(i,:)=[n_sorted_str_FJ(i,5:6) n_sorted_str_FJ(i,1:3) n_sorted_str_FJ(i,10:11) '_' n_sorted_str_FJ(i,17:18) n_sorted_str_FJ(i,13:15) n_sorted_str_FJ(i,22:23)];


eval(['[velx_TSX_FJ(:,:,j),R_TSX_FJ'  ']=geotiffread(''TSX_E79.40N_' arq_name_FJ(i,:) '.vx.tif'');']);
eval(['vely_TSX_FJ(:,:,j)=imread(''TSX_E79.40N_' arq_name_FJ(i,:) '.vy.tif'');']);
eval(['errx_TSX_FJ(:,:,j)=imread(''TSX_E79.40N_' arq_name_FJ(i,:) '.ex.tif'');']);
eval(['erry_TSX_FJ(:,:,j)=imread(''TSX_E79.40N_' arq_name_FJ(i,:) '.ey.tif'');']);

Vel_TSX_FJ(:,:,j)=sqrt((velx_TSX_FJ(:,:,j).^2)+(vely_TSX_FJ(:,:,j).^2));

% eval(['[row,col] = map2pix(Ropt_' date(13:16) '_' date(18:19) ',X_p_curve_JAK,Y_p_curve_JAK);']);
% eval(['vel=Vel_opt_' date(13:16) '_' date(18:19) ';']);

j=j+1;


end


Vel_TSX_FJ(Vel_TSX_FJ>1000000)=nan;
Vel_mean_TSX_FJ=nanmean(Vel_TSX_FJ,3);
Vel_mean_TSX_FJ_log=log10(Vel_mean_TSX_FJ);

info = geotiffinfo('/nfs/a59/eeagdl/DATABASE/GREENLAND/Joughin_Data_GRIS/TerraSAR_X/E79_40/TSX_Apr-18-2015_Apr-29-2015_08-53-58/TSX_E79.40N_18Apr15_29Apr15.vx.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/Vel_mean_TSX_FJ.tif', Vel_mean_TSX_FJ, R_TSX_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/Vel_mean_TSX_FJ_log.tif', Vel_mean_TSX_FJ_log, R_TSX_FJ,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);


for i=1:length(list_TSX_FJ);
   prof_TSX_FJ(:,i)=profile_ext_mean(X_p_curve_FJ,Y_p_curve_FJ,Vel_TSX_FJ(:,:,i),R_TSX_FJ,5);
   
   prof_across_TSX_FJ1(:,i)=profile_ext_mean(X_across_FJ1,Y_across_FJ1,Vel_TSX_FJ(:,:,i),R_TSX_FJ,5);
   prof_across_TSX_FJ2(:,i)=profile_ext_mean(X_across_FJ2,Y_across_FJ2,Vel_TSX_FJ(:,:,i),R_TSX_FJ,5);
   prof_across_TSX_FJ3(:,i)=profile_ext_mean(X_across_FJ3,Y_across_FJ3,Vel_TSX_FJ(:,:,i),R_TSX_FJ,5);
   
end


plot(nanmean(prof_across_TSX_FJ1,2),'.','color','b'); hold on
plot(nanmean(prof_across_FJ1,2),'.','color','r');

plot(nanmean(prof_across_TSX_FJ2,2),'.','color','b'); hold on
plot(nanmean(prof_across_FJ2,2),'.','color','r');


plot(nanmean(prof_across_TSX_FJ3,2),'.','color','b'); hold on
plot(nanmean(prof_across_FJ3,2),'.','color','r');


for i=1:13
    subplot(3,5,i);
    imagesc(Vel_TSX_FJ(:,:,i));    
end
    
for i=1:14
    subplot(3,5,i);
    imagesc(Vel_TSX_PG(:,:,i));    
end




%% Ice front position JAK - Cryoportal: http://cryoportal.enveo.at/disclaimer/

cd /nfs/a59/eeagdl/DATABASE/GREENLAND/Cryoportal/IceFront/CFL_Greenland.2.0_20160713/Jakobshavn_Isbrae_G310846E69083N

pathsate_JAK_Ice_Front=['/nfs/a59/eeagdl/DATABASE/GREENLAND/Cryoportal/IceFront/CFL_Greenland.2.0_20160713/Jakobshavn_Isbrae_G310846E69083N/'];
d_JAK_Ice_Front=dir([pathsate_JAK_Ice_Front '*.shp']);
j=1;
for i=1:length(d_JAK_Ice_Front);
    name=d_JAK_Ice_Front(i,1).name;
    data_JAK_Ice_Front{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_JAK_Ice_Front(j,1)=cellstr(data_JAK_Ice_Front{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_JAK_Ice_Front i j name

for i=1: length(list_JAK_Ice_Front)
    
   date_JAK_Ice_Front= list_JAK_Ice_Front{i,1};
   
   n_JAK_Ice_Front(i,1) = datenum(date_JAK_Ice_Front(38:45),'yyyymmdd');
 
end


IceFront_Pts_Cryoportal_JAK = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/ArcGIS/Profiles/Profile_JAK/Ice_Front_Pts_JAK.shp');
IceFront_Pts_Cryoportal_JAK_distance = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/ArcGIS/Profiles/Profile_JAK/Ice_Front_Pts_JAK_distance.shp');


date_Ice_Front_JAK=extractfield(IceFront_Pts_Cryoportal_JAK,'date');
date_Ice_Front_JAK=date_Ice_Front_JAK';

position_Ice_Front_JAK=extractfield(IceFront_Pts_Cryoportal_JAK,'Distance');
position_Ice_Front_JAK=position_Ice_Front_JAK';

position_Ice_Front_JAK(1,2)=0;
for i=2:length(date_Ice_Front_JAK);
    position_Ice_Front_JAK(i,2)=position_Ice_Front_JAK(i-1,2)+position_Ice_Front_JAK(i,1);
end

for i=1:length(date_Ice_Front_JAK)
date_num_Ice_Front_JAK(i,1)=datenum(date_Ice_Front_JAK(i,:),'yyyymmdd');
end

[date_num_Ice_Front_JAK_sorted,I]=sort(date_num_Ice_Front_JAK(:,1));
position_Ice_Front_JAK_sorted(:,2)=position_Ice_Front_JAK(I,2);

% Ice front variation time series CryoPortal
figure
subaxis(2,1,1)
plot(date_num_Ice_Front_JAK_sorted,position_Ice_Front_JAK_sorted(:,2),'LineStyle','--','MarkerSize',2,'MarkerFaceColor','k','Marker','^','color','k')
datetick('x','yyyy','keepticks');
set(gca,'XAxisLocation','top');

ylim([5000 11000])
ylabel('Distance [m]','fontsize',12,'fontweight','b')
xlim([datenum('102014','mmyyyy')  datenum('012016','mmyyyy')])
datetick('x','yyyy','keeplimits');
grid on


   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,1),'.','color','r');
   hold on;
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,2),'.','color','y');
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,3),'.','color','m');
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,4),'.','color','g');
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,5),'.','color','c');
   plot(n_sorted(:,1),pt_TSX_Joughin_JAK(:,6),'.','color','b');

 %plot(date_num_Ice_Front_JAK_sorted,position_Ice_Front_JAK_sorted(:,2),'LineStyle','--','MarkerSize',2,'MarkerFaceColor','k','Marker','^','color','k')
  
    legend('M6','M9','M13','M17','M20','M26','Orientation','horizontal','Location','north');
    
    
    
    set(gca,'XTick',[datenum('2009','yyyy'):366:datenum('2016','yyyy')])
   xlim([datenum('2009','yyyy')  datenum('062016','mmyyyy')])
ylim([0 18000])


fill([date_pt_S1_Joughin_JAK(1) date_pt_S1_Joughin_JAK(1) n_sorted(end,1) n_sorted(end,1)],[0 20000 20000 0],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,1)*1000,'.','color','r');
 subaxis(2,1,2)  
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,1)*1000,'LineStyle','--','MarkerSize',2,'MarkerFaceColor','r','Marker','^','color','r');hold on;
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,2)*1000,'LineStyle','--','MarkerSize',2,'MarkerFaceColor','y','Marker','^','color','y');
   plot(date_pt_S1_Joughin_JAK,fillgaps(pt_S1_Joughin_JAK(:,3)*1000),'LineStyle','--','MarkerSize',2,'MarkerFaceColor','m','Marker','^','color','m');
   plot(date_pt_S1_Joughin_JAK,fillgaps(pt_S1_Joughin_JAK(:,4)*1000),'LineStyle','--','MarkerSize',2,'MarkerFaceColor','g','Marker','^','color','g');
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,5)*1000,'LineStyle','--','MarkerSize',2,'MarkerFaceColor','c','Marker','^','color','c');
   plot(date_pt_S1_Joughin_JAK,pt_S1_Joughin_JAK(:,6)*1000,'LineStyle','--','MarkerSize',2,'MarkerFaceColor','b','Marker','^','color','b');

   xlim([datenum('2003','yyyy')  datenum('062016','mmyyyy')])
date_pt_S1_TSX_Joughin_JAK_combined=datestr([min(n_sorted(:,1)):max(date_pt_S1_Joughin_JAK)],'mmmyy');
datetick('x','yyyy','keeplimits');
grid on
ylabel('Velocity [m/yr]','fontsize',12,'fontweight','b')



