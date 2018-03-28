%% ZAC
%cd /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/

[stack_FJ,Rstack_FJ]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/updated/stack/Vel_Stack_FJ_Portal_updated.tif');


%Profile Curve FJ 

prof_curve_read_ZAC = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Zack/ZAC_prof_curve.shp');
X_p_curve_ZAC=extractfield(prof_curve_read_ZAC,'X');
Y_p_curve_ZAC=extractfield(prof_curve_read_ZAC,'Y');

X_p_curve_ZAC=X_p_curve_ZAC(~isnan(X_p_curve_ZAC));
Y_p_curve_ZAC=Y_p_curve_ZAC(~isnan(Y_p_curve_ZAC));



%Profile Across ZAC 1

prof_across_ZAC1 = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Zack/ZAC1_cross.shp');
X_across_ZAC1=extractfield(prof_across_ZAC1,'X');
Y_across_ZAC1=extractfield(prof_across_ZAC1,'Y');

X_across_ZAC1=X_across_ZAC1(~isnan(X_across_ZAC1));
Y_across_ZAC1=Y_across_ZAC1(~isnan(Y_across_ZAC1));

%Profile Across ZAC 2

prof_across_ZAC2 = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Zack/ZAC2_cross.shp');
X_across_ZAC2=extractfield(prof_across_ZAC2,'X');
Y_across_ZAC2=extractfield(prof_across_ZAC2,'Y');

X_across_ZAC2=X_across_ZAC2(~isnan(X_across_ZAC2));
Y_across_ZAC2=Y_across_ZAC2(~isnan(Y_across_ZAC2));

%Profile Across ZAC 3

prof_across_ZAC3 = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Zack/ZAC3_cross.shp');
X_across_ZAC3=extractfield(prof_across_ZAC3,'X');
Y_across_ZAC3=extractfield(prof_across_ZAC3,'Y');

X_across_ZAC3=X_across_ZAC3(~isnan(X_across_ZAC3));
Y_across_ZAC3=Y_across_ZAC3(~isnan(Y_across_ZAC3));


% Including nan's

% stack_FJ(stack_FJ<=0)=nan;


% Extract the profiles

prof_curve_ZAC=nan(1659,size(stack_FJ,3));

prof_across_ZAC1=nan(162,size(stack_FJ,3));
prof_across_ZAC2=nan(209,size(stack_FJ,3));
prof_across_ZAC3=nan(402,size(stack_FJ,3));

for i=1:size(stack_FJ,3) 
prof_across_ZAC1(:,i)=profile_ext_mean(X_across_ZAC1,Y_across_ZAC1,stack_FJ(:,:,i),Rstack_FJ,5);
prof_across_ZAC2(:,i)=profile_ext_mean(X_across_ZAC2,Y_across_ZAC2,stack_FJ(:,:,i),Rstack_FJ,5);
prof_across_ZAC3(:,i)=profile_ext_mean(X_across_ZAC3,Y_across_ZAC3,stack_FJ(:,:,i),Rstack_FJ,5);

% prof_curve_ZAC(:,i)=profile_ext_mean(X_p_curve_ZAC,Y_p_curve_ZAC,stack_FJ(:,:,i),Rstack_FJ,5);

end
dist_ZAC=0:((0.09995*1619)/(length(prof_curve_ZAC)-1)):(0.09995*1619);

dist_ZAC_GL=(-dist_ZAC(2)*length([1:112])):dist_ZAC(2):(length([114:1659])*dist_ZAC(2));

%%%%%%%%%%%%%%%%%  Across Profiles


dist_across_ZAC1_=((0.099635*(161))/(length(prof_across_ZAC1)-1))*(-72):((0.099635*(161))/(length(prof_across_ZAC1)-1)):((0.099635*(161))/(length(prof_across_ZAC1)-1))*((length(prof_across_ZAC1)-1)-72);
dist_across_ZAC2_=((0.099986*(208))/(length(prof_across_ZAC2)-1))*(-90):((0.099986*(208))/(length(prof_across_ZAC2)-1)):((0.099986*(208))/(length(prof_across_ZAC2)-1))*((length(prof_across_ZAC2)-1)-90);
dist_across_ZAC3_=((0.099989*(401))/(length(prof_across_ZAC3)-1))*(-158):((0.099989*(401))/(length(prof_across_ZAC3)-1)):((0.099989*(401))/(length(prof_across_ZAC3)-1))*((length(prof_across_ZAC3)-1)-158);

%%%%%%%%%  plot profile across (IM_Figures.m)

%%%%%%%%%%%%%%%%%  Pts

%%%%% Calculating a mean in an moving mean, around 5 pixels (**profile_ext_mean** function)
% Including nan's

% stack_FJ(stack_FJ<=0)=nan;

% Extract the profiles
% 
% prof_curve_ZAC_5window_mean=nan(1997,size(stack_FJ,3) );
% 
% prof_across_ZAC1_5window_mean=nan(999,size(stack_FJ,3) );
% prof_across_ZAC2_5window_mean=nan(999,size(stack_FJ,3) );
% prof_across_ZAC3_5window_mean=nan(999,size(stack_FJ,3) );
% 
% for i=1:size(stack_FJ,3) 
% prof_across_FJ1_5window_mean(:,i)=profile_ext_mean(X_across_FJ1,Y_across_FJ1,stack_FJ(:,:,i),Rstack_FJ,5);
% prof_across_FJ2_5window_mean(:,i)=profile_ext_mean(X_across_FJ2,Y_across_FJ2,stack_FJ(:,:,i),Rstack_FJ,5);
% prof_across_FJ3_5window_mean(:,i)=profile_ext_mean(X_across_FJ3,Y_across_FJ3,stack_FJ(:,:,i),Rstack_FJ,5);
% 
% prof_curve_FJ_5window_mean(:,i)=profile_ext_mean(X_p_curve_FJ,Y_p_curve_FJ,stack_FJ(:,:,i),Rstack_FJ,5);
% 
% end
% 
% for i=1:size(stack_FJ,3) 
% pt_FJ1_5window_mean(i)=prof_across_FJ1_5window_mean(595,i);
% pt_FJ2_5window_mean(i)=prof_across_FJ2_5window_mean(599,i);
% pt_FJ3_5window_mean(i)=prof_across_FJ3_5window_mean(629,i);
% 
% end
% 
% mdl_pt_FJ1_5window_mean = fitlm(data_str_FJ_num,pt_FJ1_5window_mean/1000);
% mdl_pt_FJ2_5window_mean = fitlm(data_str_FJ_num,pt_FJ2_5window_mean/1000);
% mdl_pt_FJ3_5window_mean = fitlm(data_str_FJ_num,pt_FJ3_5window_mean/1000);


%%%%%%  Plot Pts (IM_Figures.m)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FJ Summer & Winter

for i=1:size(FJ_summer2,3)
FJ_summer2_profile(:,i)=profile_ext_mean(X_p_curve_FJ,Y_p_curve_FJ,FJ_summer2(:,:,i),Rstack_FJ,5);
end

for i=1:size(FJ_winter2,3)
FJ_winter2_profile(:,i)=profile_ext_mean(X_p_curve_FJ,Y_p_curve_FJ,FJ_winter2(:,:,i),Rstack_FJ,5);
end

%%%%%%  Plot Summer and Winter (IM_Figures.m)


%%%%%%%% FJ Terra_SAR_X points
%pts_TSX_Joughin_PG = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/Qgis/PG_Pts.shp');
pts_TSX_Joughin_ZAC = shaperead('/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Zack/ZAC_Pts_used.shp');

X_pts_TSX_Joughin_ZAC=extractfield(pts_TSX_Joughin_ZAC,'X');
Y_pts_TSX_Joughin_ZAC=extractfield(pts_TSX_Joughin_ZAC,'Y');

name_ZAC_pts=extractfield(pts_TSX_Joughin_ZAC,'name');


for j=[1:length(Y_pts_TSX_Joughin_ZAC)]
for i=1:size(Vel_TSX_ZAC,3)
pt_TSX_Joughin_ZAC(i,j)=profile_ext_mean(X_pts_TSX_Joughin_ZAC(1,j),Y_pts_TSX_Joughin_ZAC(1,j),Vel_TSX_ZAC(:,:,i),R_TSX_ZAC,5);

%pt_JAK_main(i)=prof_curve_JAK(10,i);
end
end

for j=[1:length(Y_pts_TSX_Joughin_ZAC)]
for i=1:size(Vel_Stack_FJ,3) 

    pt_S1_ZAC(i,j)=profile_ext_mean(X_pts_TSX_Joughin_ZAC(1,j),Y_pts_TSX_Joughin_ZAC(1,j),Vel_Stack_FJ(:,:,i),Rstack_FJ,5);

end
%pt_JAK_main(i)=prof_curve_JAK(10,i);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  FJ

%  CM_PGs=[0 0 1; 0 0 0; 1 0 0; 0.333 0.333 0.333;1 1 0; 0 1 0; 1 0 1;0.68 0.92 1; 0 1 1; 1 1 1; 0.5 0.5 0.5;0.0 0.2 0.5]
% figure(1)

% for i=[1:size(pt_TSX_Joughin_FJ,2)-1]
%   plot(n_sorted_FJ(:,1),pt_TSX_Joughin_FJ(:,i),'MarkerFaceColor',CM_PGs(i,:),'Marker','square','MarkerSize',3,'LineStyle','none','MarkerEdgeColor','k');hold on;%pad15
%  
% end
figure(1)
    %subplot(3,1,1)
    j=1;
 for(i=[2:size(pt_S1_ZAC,2)])
   plot(date_pt_S1_FJ,pt_S1_ZAC(:,i),'LineStyle','none','MarkerSize',5,'MarkerFaceColor',CM_PGs(j,:),'Marker','^','MarkerEdgeColor','k','color',CM_PGs(j,:));hold on; %N6
   j=j+1;
 end

   legend([name_ZAC_pts],'location','northwest');
%    legend('Pad6','Pad7','Pad8','Pad9','Pad11','Pad12','Pad13','Pad14','Pad15')%,'Pad16','Pad17','Pad18','Pad19','Pad20');
%xlim([datenum('122008','mmyyyy')  datenum('042017','mmyyyy')])
 %   legend('N6','N8','N11','N15','Pad1','Pad2','Pad3','Pad4','Pad5','Pad6','Pad7','Pad8','Pad9','Pad10','Pad11','Pad12','Pad13','Pad14','Pad15')%,'Pad16','Pad17','Pad18','Pad19','Pad20');
ylim([1500 3000])

fill([date_pt_S1_FJ(1) date_pt_S1_FJ(1) n_sorted_FJ(end,1) n_sorted_FJ(end,1)],[0 7000 7000 0],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none');


date_pt_S1_FJ_combined=datestr([min(n_sorted_FJ(:,1)):max(date_pt_S1_FJ)],'mmmyy');

% NumTicks = 11;
% L = [datenum('01012011','ddmmyyyy')  datenum('01042017','ddmmyyyy')];
% set(gca,'XTick',linspace(L(1),L(2),NumTicks))

datetick('x','mm/yyyy','keepticks');
xlim([datenum('01102015','ddmmyyyy')  datenum('01042017','ddmmyyyy')])

ylabel('velocity [m/yr]','fontsize',12,'fontweight','b')
set(gca,'XGrid','on','YAxisLocation','left')
%box off


print -djpeg -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pts_ZAC_IceFront
set(gcf,'Paperorientation','landscape')
print -dpdf -r600 /nfs/a59/eeagdl/Dropbox/Uni_Leeds/IM_paper/Updated/Pts_ZAC_IceFront





%%

cd /nfs/a59/eeagdl/DATABASE/GREENLAND/Joughin_Data_GRIS/TerraSAR_X/ZAC

pathsate_TSX_ZAC=['/nfs/a59/eeagdl/DATABASE/GREENLAND/Joughin_Data_GRIS/TerraSAR_X/ZAC/'];
d_TSX_ZAC=dir(pathsate_TSX_ZAC);
j=1;
for i=4:length(d_TSX_ZAC);
    name=d_TSX_ZAC(i,1).name;
    data_ZAC{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_TSX_ZAC(j,1)=cellstr(data_ZAC{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_TSX_ZAC i j name

% Sorting the dates:

for i=1: length(list_TSX_ZAC)
    
   date_ZAC=list_TSX_ZAC{i,1};
   n_ZAC(i,1) = datenum(date_ZAC(13:19),'ddmmmyy');
   n_ZAC(i,2)=  datenum(date_ZAC(21:27),'ddmmmyy');
%    n_ZAC(i,3:5)=  datenum(date_ZAC(29:30),'HH');
%    n_ZAC(i,4)=  datenum(date_ZAC(32:33),'MM');
%    n_ZAC(i,5:6)=  date_ZAC(35:36);
end

[n_sorted_ZAC,I_ZAC]=sort(n_ZAC(:,1));
n_sorted_ZAC(:,2)=n_ZAC(I_ZAC,2);
% n_sorted_ZAC(:,3)=n_ZAC(I_ZAC,3);
% n_sorted_ZAC(:,4)=n_ZAC(I_ZAC,4);
% n_sorted_ZAC(:,5)=n_ZAC(I_ZAC,5);
% n_sorted_ZAC(:,6)=n_ZAC(I_ZAC,6);

for i=1:length(list_TSX_ZAC)
n_sorted_str_ZAC(i,:)=[datestr(n_sorted_ZAC(i,1),'ddmmmyy') '_' datestr(n_sorted_ZAC(i,2),'ddmmmyy')];
end


j=1;
for i=1:8:length(list_TSX_ZAC);
    %path1=[pathsate_TSX_ZAC 'TSX_' n_sorted_str_ZAC(i,:)];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    
    %date=list_TSX{i,1};
    
% path_pro=dir(path1);   
%  cd(path1)
% cd([pathsate_TSX path_pro.name]);
arq_name_ZAC(i,:)=[n_sorted_str_ZAC(i,:)];


eval(['[velx_TSX_ZAC(:,:,j),R_TSX_ZAC]=geotiffread(''TSX_E78.90N_' arq_name_ZAC(i,:) '.vx.tif'');']);
eval(['vely_TSX_ZAC(:,:,j)=imread(''TSX_E78.90N_' arq_name_ZAC(i,:) '.vy.tif'');']);
eval(['errx_TSX_ZAC(:,:,j)=imread(''TSX_E78.90N_' arq_name_ZAC(i,:) '.ex.tif'');']);
eval(['erry_TSX_ZAC(:,:,j)=imread(''TSX_E78.90N_' arq_name_ZAC(i,:) '.ey.tif'');']);

Vel_TSX_ZAC(:,:,j)=sqrt((velx_TSX_ZAC(:,:,j).^2)+(vely_TSX_ZAC(:,:,j).^2));

% eval(['[row,col] = map2pix(Ropt_' date(13:16) '_' date(18:19) ',X_p_curve_JAK,Y_p_curve_JAK);']);
% eval(['vel=Vel_opt_' date(13:16) '_' date(18:19) ';']);

j=j+1;


end


Vel_TSX_ZAC(Vel_TSX_ZAC>1000000)=nan;
Vel_mean_TSX_ZAC=nanmean(Vel_TSX_ZAC,3);
Vel_mean_TSX_ZAC_log=log10(Vel_mean_TSX_ZAC);






