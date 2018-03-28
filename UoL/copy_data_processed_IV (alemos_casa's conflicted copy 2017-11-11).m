%% FJ 
pathsate_opt=['/nfs/a41/S1_CPOM_www/IV_out/Fj/WWW/T146_0079_-026/FT_v27/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/'];
d_opt=dir(pathsate_opt);
j=1;
for i=4:length(d_opt)-1;
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name


j=1;
for i=[1:15 17 19 20 22 23];%length(list_opt);
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    dest=[destination list_opt{i,1} '/'];    
    eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

eval( ['!cp ./*ccpN.gc.tiff ' dest]);
 
 eval( ['!cp ./*mag_yrF.gc.tiff ' dest]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' dest]);
 
 eval( ['!cp ./*_SO.txt ' dest]);
 
 eval( ['!cp ./*.mligc.gc.tiff ' dest]);
 
 eval( ['!cp ./*.mliFgc.gc.tiff ' dest]);


end


%% PG

pathsate_opt=['/nfs/a41/S1_CPOM_www/IV_out/PG/WWW/T098_0080_-060/FT_v27/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/'];
d_opt=dir(pathsate_opt);
j=1;
for i=4:length(d_opt)-3;
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name


j=1;
for i=[1:4 6 8:length(list_opt)];
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    dest=[destination list_opt{i,1} '/'];    
    eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

eval( ['!cp ./*ccpN.gc.tiff ' dest]);
 
 eval( ['!cp ./*mag_yrF.gc.tiff ' dest]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' dest]);
 
 eval( ['!cp ./*_SO.txt ' dest]);
 
 eval( ['!cp ./*.mligc.gc.tiff ' dest]);
 
 eval( ['!cp ./*.mliFgc.gc.tiff ' dest]);


end

clear all

% Part 2

pathsate_opt=['/nfs/a41/S1_CPOM_www/IV_out/PG/WWW/T098_0080_-061/FT_v27/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/'];
d_opt=dir(pathsate_opt);
j=1;
for i=[4:10 12 14];%length(d_opt)-3;
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name


j=1;
for i=[1:4 6 8:length(list_opt)];
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    dest=[destination list_opt{i,1} '/'];    
    eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

eval( ['!cp ./*ccpN.gc.tiff ' dest]);
 
 eval( ['!cp ./*mag_yrF.gc.tiff ' dest]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' dest]);
 
 eval( ['!cp ./*_SO.txt ' dest]);
 
 eval( ['!cp ./*.mligc.gc.tiff ' dest]);
 
 eval( ['!cp ./*.mliFgc.gc.tiff ' dest]);


end


clear all

% Part 3

pathsate_opt=['/nfs/a41/S1_CPOM_www/IV_out/PG/WWW/T098_0080_-062/FT_v27/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/'];
d_opt=dir(pathsate_opt);
j=1;
for i=4:length(d_opt)-2;
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name


j=1;
for i=[1:4 6 8:length(list_opt)];
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    dest=[destination list_opt{i,1} '/'];    
    eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

eval( ['!cp ./*ccpN.gc.tiff ' dest]);
 
 eval( ['!cp ./*mag_yrF.gc.tiff ' dest]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' dest]);
 
 eval( ['!cp ./*_SO.txt ' dest]);
 
 eval( ['!cp ./*.mligc.gc.tiff ' dest]);
 
 eval( ['!cp ./*.mliFgc.gc.tiff ' dest]);


end


clear all


%% Separando vel magnitude


% FJ

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/Nioghalvfjerdsfjorden/stack/'];
d_opt=dir(pathsate_opt);
j=1;
for i=5:length(d_opt)-3;
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name


j=1;
for i=[1:length(list_opt)];
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*mag_yrF.gc.tiff ' destination]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' destination]);
 

end

clear all

% PG

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/Processing/IM_paper_processing/PG/stack/'];
d_opt=dir(pathsate_opt);
j=1;
for i=7:length(d_opt);
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name


j=1;
for i=[1:length(list_opt)];
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*mag_yrF.gc.tiff ' destination]);
 
 eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' destination]);
 

end
 
