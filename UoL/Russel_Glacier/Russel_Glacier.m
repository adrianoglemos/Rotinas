

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2014/'];

% pathsate_opt1=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Summer_2017/'];
% %pathsate_opt2=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D240_2016/'];
% 
% destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D170_2017/'];

d_opt=dir(pathsate_opt);
j=1;
for i=3:length(d_opt);
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name

% date1=num2str('20170528')
% date2=num2str('20170603')


for i=1:size(list_opt,1)-1;
    %path=[pathsate_opt];
    path1=[pathsate_opt list_opt{i,1} '/'];
    path2=[pathsate_opt list_opt{i+1,1} '/'];
    
    a1=list_opt{i,1}
    a2=list_opt{i+1,1}
    date1=a1(27:32);
    date2=a2(27:32);

    cd(pathsate_opt)
    %path1=[pathsate_opt1 list_opt{i,1} '/'];
    %path2=[pathsate_opt2 list_opt{i,1} '/'];
  eval(['!mkdir ./' date1 '_' date2]); 

  cd(['./' date1 '_' date2])
  
  eval(['!cp ' path1 '*zip ./'])
  eval(['!cp ' path2 '*zip ./'])
  
    %date=list_opt{i,1};

    %cd(path1);

 %eval( ['!mv ' path '*.zip ' destination]);
 %eval( ['!mv ' path2 '*' date2 '*.zip ' path]);

i
end


%%%%%%%%%%%%%%%%%%%%% 
% 2015
%%%%%%%%%%%%%%%%%%%%%
clear all


pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2016/'];

% pathsate_opt1=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Summer_2017/'];
% %pathsate_opt2=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D240_2016/'];
% 
% destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D170_2017/'];

d_opt=dir(pathsate_opt);
j=1;
for i=4:length(d_opt);
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name

% date1=num2str('20170528')
% date2=num2str('20170603')


for i=1:size(list_opt,1);
 
    path1=[pathsate_opt list_opt{i,1} '/'];
    cd(pathsate_opt)
    eval(['!cp ' path1 '*zip ./'])

i
end



%%%%%%%%%%%%%%%%
% 2017
%%%%%%%%%%%%%%%%

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2017/'];

% list of images

d_opt=cellstr(RusselG2017);


% pathsate_opt1=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Summer_2017/'];
% %pathsate_opt2=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D240_2016/'];
% 
% destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D170_2017/'];

%d_opt=dir(pathsate_opt);
j=1;
for i=1:length(d_opt);
    name=d_opt{i,1};
    %data=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,:)=name;
    j=j+1;
%folder=char(folder, data);
end
clear i j name

for i=1:size(list_opt,1);
 
    path1=[list_opt(i,:) '/'];
    cd(pathsate_opt)
    eval(['!cp ' path1 '*zip ./'])

i
end




Tbaseline=num2str(datenum(date2,'yyyymmdd')-datenum(date1,'yyyymmdd'));
%

j=3;
for i=1:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1} '/'];
    cd(path1)
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    d=dir(pwd);
    name1=d(j,1).name; name1=name1(end-7:end-4);
    name2=d(j+1,1).name; name2=name2(end-7:end-4);
    
    !cp ../S1_running_PIG.sh ./
    
    eval(['!sed -i ''' '4s/20160427/' date1 '/' ''' S1_running_PIG.sh'])
    eval(['!sed -i ''' '5s/20160825/' date2 '/' ''' S1_running_PIG.sh'])

    eval(['!sed -i ''' '9s/D642/' name1 '/' ''' S1_running_PIG.sh'])
    eval(['!sed -i ''' '10s/3B97/' name2 '/' ''' S1_running_PIG.sh'])
    
    eval(['!sed -i ''' '36s/120/' Tbaseline '/' ''' S1_running_PIG.sh'])
   
    %dest=[destination];    
    %eval(['!mkdir ' dest]);

i
end