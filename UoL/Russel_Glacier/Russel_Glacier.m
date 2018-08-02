
pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2014/'];

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



%%%%%%%%%%%
% Copy the S1_running_PIG.sh script
%%%%%%%%%%%

clear all

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2014/'];

d_opt=dir(pathsate_opt);
j=1;
for i=3:length(d_opt)-1;
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name


j=3;
for i=1:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1} '/'];
    cd(path1)
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    d=dir(pwd);
    name1=d(j,1).name; name1=name1(end-7:end-4);
    name2=d(j+1,1).name; name2=name2(end-7:end-4);
    
    a=list_opt{i,1};
    date1=a(1:6);
    date2=a(8:end);
    
    Tbaseline=num2str(datenum(date2,'yymmdd')-datenum(date1,'yymmdd'));

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


%%%%%%%%
% Prepare a shell file to run
%%%%%%%%

clear all

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2014/'];

d_opt=dir(pathsate_opt);
j=1;
for i=3:length(d_opt)-1;
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name


list_opt,1);
path1=[pathsate_opt list_opt{i,1}];
path2=[pathsate_opt list_opt{i+1,1}];
path3=[pathsate_opt list_opt{i+2,1}];
path4=[pathsate_opt list_opt{i+3,1}];

cd(pathsate_opt)

     a1=list_opt{i,1};
     a2=list_opt{i+1,1};
     a3=list_opt{i+2,1};
     a4=list_opt{i+3,1};

    !cp ../Automatic_S1_im_run.sh ./
    
    eval(['!sed -i ''' '3s/year/2014/' ''' Automatic_S1_im_run.sh'])
    eval(['!sed -i ''' '3s/date1/' a1 '/' ''' Automatic_S1_im_run.sh'])
    
    eval(['!sed -i ''' '20s/year/2014/' ''' Automatic_S1_im_run.sh'])
    eval(['!sed -i ''' '20s/date1/' a2 '/' ''' Automatic_S1_im_run.sh'])
    
    eval(['!sed -i ''' '37s/year/2014/' ''' Automatic_S1_im_run.sh'])
    eval(['!sed -i ''' '37s/date1/' a3 '/' ''' Automatic_S1_im_run.sh'])
    
    
    eval(['!sed -i ''' '54s/year/2014/' ''' Automatic_S1_im_run.sh'])
    eval(['!sed -i ''' '54s/date1/' a4 '/' ''' Automatic_S1_im_run.sh'])
        


%%%%%%%%%%%%%%%%%%%%% 
% 2015
%%%%%%%%%%%%%%%%%%%%%
clear all


pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2015/'];

d_opt=dir(pathsate_opt);
j=1;
for i=7:length(d_opt)-1;
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
    
    a1=list_opt{i,1};
    a2=list_opt{i+1,1};
    date1=a1(27:32);
    date2=a2(27:32);

    cd(pathsate_opt)
    %path1=[pathsate_opt1 list_opt{i,1} '/'];
    %path2=[pathsate_opt2 list_opt{i,1} '/'];
  eval(['!mkdir ./20' date1 '_20' date2]); 

  cd(['./' date1 '_' date2])
  
  eval(['!cp ' path1 '*zip ./'])
  eval(['!cp ' path2 '*zip ./'])
  
    %date=list_opt{i,1};

    %cd(path1);

 %eval( ['!mv ' path '*.zip ' destination]);
 %eval( ['!mv ' path2 '*' date2 '*.zip ' path]);

i
end


%%%%%%%%%%%
% Copy the S1_running_PIG.sh script
%%%%%%%%%%%

clear all

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2015/'];

d_opt=dir(pathsate_opt);
j=1;
for i=4:length(d_opt)-5;
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name


j=3;
for i=1:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1} '/'];
    cd(path1)
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    d=dir(pwd);
    name1=d(j,1).name; name1=name1(end-7:end-4);
    name2=d(j+1,1).name; name2=name2(end-7:end-4);
    
    a=list_opt{i,1};
    date1=a(1:6);
    date2=a(8:end);
    
    Tbaseline=num2str(datenum(date2,'yymmdd')-datenum(date1,'yymmdd'));

    !cp ../S1_running_PIG.sh ./
    
    eval(['!sed -i ''' '4s/20160427/20' date1 '/' ''' S1_running_PIG.sh'])
    eval(['!sed -i ''' '5s/20160825/20' date2 '/' ''' S1_running_PIG.sh'])

    eval(['!sed -i ''' '9s/D642/' name1 '/' ''' S1_running_PIG.sh'])
    eval(['!sed -i ''' '10s/3B97/' name2 '/' ''' S1_running_PIG.sh'])
    
    eval(['!sed -i ''' '36s/120/' Tbaseline '/' ''' S1_running_PIG.sh'])
   
    %dest=[destination];    
    %eval(['!mkdir ' dest]);

i
end


%%%%%%%%
% Prepare a shell file to run
%%%%%%%%

clear all

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2015/'];

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


j=3;
for i=1:5:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1}];
    path2=[pathsate_opt list_opt{i+1,1}];
    path3=[pathsate_opt list_opt{i+2,1}];
    path4=[pathsate_opt list_opt{i+3,1}];
    path5=[pathsate_opt list_opt{i+4,1}];

    
    cd(pathsate_opt)
    
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
%     d=dir(pwd);
%     name1=d(j,1).name; name1=name1(end-7:end-4);
%     name2=d(j+1,1).name; name2=name2(end-7:end-4);
    
     a1=list_opt{i,1};
     a2=list_opt{i+1,1};
     a3=list_opt{i+2,1};
     a4=list_opt{i+3,1};
     a5=list_opt{i+4,1};
     
%      date1=a(1:6);
%      date2=a(8:end);
    
    %Tbaseline=num2str(datenum(date2,'yymmdd')-datenum(date1,'yymmdd'));

    eval(['!cp ../Automatic_S1_im_run.sh ./Automatic_S1_im_run_' a1(1:6) '_' a5(8:end) '.sh']);
    
    eval(['!sed -i ''' '3s/year/2015/' ''' Automatic_S1_im_run_' a1(1:6) '_' a5(8:end) '.sh']);
    eval(['!sed -i ''' '3s/date1/' a1 '/' ''' Automatic_S1_im_run_' a1(1:6) '_' a5(8:end) '.sh']);
    
    eval(['!sed -i ''' '20s/year/2015/' ''' Automatic_S1_im_run_' a1(1:6) '_' a5(8:end) '.sh']);
    eval(['!sed -i ''' '20s/date1/' a2 '/' ''' Automatic_S1_im_run_' a1(1:6) '_' a5(8:end) '.sh']);
    
    eval(['!sed -i ''' '37s/year/2015/' ''' Automatic_S1_im_run_' a1(1:6) '_' a5(8:end) '.sh']);
    eval(['!sed -i ''' '37s/date1/' a3 '/' ''' Automatic_S1_im_run_' a1(1:6) '_' a5(8:end) '.sh']);
    
    
    eval(['!sed -i ''' '54s/year/2015/' ''' Automatic_S1_im_run_' a1(1:6) '_' a5(8:end) '.sh']);
    eval(['!sed -i ''' '54s/date1/' a4 '/' ''' Automatic_S1_im_run_' a1(1:6) '_' a5(8:end) '.sh']);
        
    eval(['!sed -i ''' '71s/year/2015/' ''' Automatic_S1_im_run_' a1(1:6) '_' a5(8:end) '.sh']);
    eval(['!sed -i ''' '71s/date1/' a5 '/' ''' Automatic_S1_im_run_' a1(1:6) '_' a5(8:end) '.sh']);
    

i
end



%%%%%%%%%%%%%%%%%%%%% 
% 2016
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

%%%%%
clear all
%%%%%

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2016/'];

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

% Sort dates

for i=1:size(list_opt,1);
    a1=list_opt{i,1};
    date_2016(i,:)=a1(18:25);
    
    date_2016_num(i,1)=datenum(a1(18:25),'yyyymmdd');
    
end


[date_2016_num_sort,I_sort]=sort(date_2016_num);

date_2016_sort=date_2016(I_sort,:);

%%%%%
% Create folder and copy the image ;
%%%%%

for i=1:size(date_2016_sort,1)-1;
    %path=[pathsate_opt];
%     path1=[pathsate_opt list_opt{i,1} '/'];
%     path2=[pathsate_opt list_opt{i+1,1} '/'];
    
    
    date1=date_2016_sort(i,:);
    date2=date_2016_sort(i+1,:);

    cd(pathsate_opt)
    %path1=[pathsate_opt1 list_opt{i,1} '/'];
    %path2=[pathsate_opt2 list_opt{i,1} '/'];
  eval(['!mkdir ./' date1 '_' date2]); 

  cd(['./' date1 '_' date2])
  
  eval(['!cp ../*' date1 '*zip ./'])
  eval(['!cp ../*' date2 '*zip ./'])
  
    %date=list_opt{i,1};

    %cd(path1);

 %eval( ['!mv ' path '*.zip ' destination]);
 %eval( ['!mv ' path2 '*' date2 '*.zip ' path]);

i
end

%%%%%%%%%%%
% Copy the S1_running_PIG.sh script
%%%%%%%%%%%

clear all

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2016/'];

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


j=3;
for i=1:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1} '/'];
    cd(path1)
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    d=dir(pwd);
    
    a=list_opt{i,1};
    date1=a(1:8);
    date2=a(10:end);

    name1t=d(j,1).name; 
    name2t=d(j+1,1).name;
    
    if (contains(name1t, date1))
        rr=1
     name1=name1t(end-7:end-4);
     name2=name2t(end-7:end-4);
     
    else
        rr=2
     name1=name2t(end-7:end-4);
     name2=name1t(end-7:end-4);   
     
    end
    
    Tbaseline=num2str(datenum(date2,'yyyymmdd')-datenum(date1,'yyyymmdd'));

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


%%%%%%%%
% Prepare a shell file to run
%%%%%%%%

clear all

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2016/'];

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


j=3;
for i=1:6:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1}];
    path2=[pathsate_opt list_opt{i+1,1}];
    path3=[pathsate_opt list_opt{i+2,1}];
    path4=[pathsate_opt list_opt{i+3,1}];
    path5=[pathsate_opt list_opt{i+4,1}];
    path6=[pathsate_opt list_opt{i+5,1}];
    
    cd(pathsate_opt)
    
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
%     d=dir(pwd);
%     name1=d(j,1).name; name1=name1(end-7:end-4);
%     name2=d(j+1,1).name; name2=name2(end-7:end-4);
    
     a1=list_opt{i,1};
     a2=list_opt{i+1,1};
     a3=list_opt{i+2,1};
     a4=list_opt{i+3,1};
     a5=list_opt{i+4,1};
     a6=list_opt{i+5,1};
    
%      date1=a(1:6);
%      date2=a(8:end);
    
    %Tbaseline=num2str(datenum(date2,'yymmdd')-datenum(date1,'yymmdd'));

    eval(['!cp ../Automatic_S1_im_run6.sh ./Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    
    eval(['!sed -i ''' '3s/year/2016/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    eval(['!sed -i ''' '3s/date1/' a1 '/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    
    eval(['!sed -i ''' '20s/year/2016/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    eval(['!sed -i ''' '20s/date1/' a2 '/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    
    eval(['!sed -i ''' '37s/year/2016/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    eval(['!sed -i ''' '37s/date1/' a3 '/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    
    
    eval(['!sed -i ''' '54s/year/2016/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    eval(['!sed -i ''' '54s/date1/' a4 '/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
        
    eval(['!sed -i ''' '71s/year/2016/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    eval(['!sed -i ''' '71s/date1/' a5 '/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);

    eval(['!sed -i ''' '88s/year/2016/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    eval(['!sed -i ''' '88s/date1/' a6 '/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);


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

list_opt=cellstr(list_opt);

for i=1:size(list_opt,1);
 
    path1=[list_opt(i,:) '/'];
    cd(pathsate_opt)
    eval(['!cp ' path1 '*zip ./'])

i
end

%%%%%
clear all
%%%%%

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2017/'];

d_opt=dir(pathsate_opt);
j=1;
for i=6:length(d_opt);
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name

% Sort dates

for i=1:size(list_opt,1);
    a1=list_opt{i,1};
    date_2017(i,:)=a1(18:25);
    
    date_2017_num(i,1)=datenum(a1(18:25),'yyyymmdd');
    
end


[date_2017_num_sort,I_sort]=sort(date_2017_num);

date_2017_sort=date_2017(I_sort,:);

%%%%%
% Create folder and copy the image ;
%%%%%

for i=1:size(date_2017_sort,1)-1;
    %path=[pathsate_opt];
%     path1=[pathsate_opt list_opt{i,1} '/'];
%     path2=[pathsate_opt list_opt{i+1,1} '/'];
    
    
    date1=date_2017_sort(i,:);
    date2=date_2017_sort(i+1,:);

    cd(pathsate_opt)
    %path1=[pathsate_opt1 list_opt{i,1} '/'];
    %path2=[pathsate_opt2 list_opt{i,1} '/'];
  eval(['!mkdir ./' date1 '_' date2]); 

  cd(['./' date1 '_' date2])
  
  eval(['!cp ../*' date1 '*zip ./'])
  eval(['!cp ../*' date2 '*zip ./'])
  
    %date=list_opt{i,1};

    %cd(path1);

 %eval( ['!mv ' path '*.zip ' destination]);
 %eval( ['!mv ' path2 '*' date2 '*.zip ' path]);

i
end


%%%%%%%%%%%
% Copy the S1_running_PIG.sh script
%%%%%%%%%%%

clear all

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2017/'];

d_opt=dir(pathsate_opt);
j=1;
for i=4:length(d_opt)-4;
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name


j=3;
for i=1:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1} '/'];
    cd(path1)
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    d=dir(pwd);
    
    a=list_opt{i,1};
    date1=a(1:8);
    date2=a(10:end);

    name1t=d(j,1).name; 
    name2t=d(j+1,1).name;
    
    if (contains(name1t, date1))
        rr=1
     name1=name1t(end-7:end-4);
     name2=name2t(end-7:end-4);
     
    else
        rr=2
     name1=name2t(end-7:end-4);
     name2=name1t(end-7:end-4);   
     
    end
    
    Tbaseline=num2str(datenum(date2,'yyyymmdd')-datenum(date1,'yyyymmdd'));

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

%%%%%%%%
% Prepare a shell file to run
%%%%%%%%

clear all

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2017/'];

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


j=3;
for i=1:6:size(list_opt,1);
%     path1=[pathsate_opt list_opt{i,1}];
%     path2=[pathsate_opt list_opt{i+1,1}];
%     path3=[pathsate_opt list_opt{i+2,1}];
%     path4=[pathsate_opt list_opt{i+3,1}];
%     path5=[pathsate_opt list_opt{i+4,1}];
%     path6=[pathsate_opt list_opt{i+5,1}];
%     
    cd(pathsate_opt)
    
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
%     d=dir(pwd);
%     name1=d(j,1).name; name1=name1(end-7:end-4);
%     name2=d(j+1,1).name; name2=name2(end-7:end-4);
    
     a1=list_opt{i,1};
     a2=list_opt{i+1,1};
     a3=list_opt{i+2,1};
     a4=list_opt{i+3,1};
     a5=list_opt{i+4,1};
     a6=list_opt{i+5,1};
    
%      date1=a(1:6);
%      date2=a(8:end);
    
    %Tbaseline=num2str(datenum(date2,'yymmdd')-datenum(date1,'yymmdd'));

    eval(['!cp ../Automatic_S1_im_run6.sh ./Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    
    eval(['!sed -i ''' '3s/year/2017/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    eval(['!sed -i ''' '3s/date1/' a1 '/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    
    eval(['!sed -i ''' '20s/year/2017/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    eval(['!sed -i ''' '20s/date1/' a2 '/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    
    eval(['!sed -i ''' '37s/year/2017/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    eval(['!sed -i ''' '37s/date1/' a3 '/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    
    
    eval(['!sed -i ''' '54s/year/2017/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    eval(['!sed -i ''' '54s/date1/' a4 '/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
        
    eval(['!sed -i ''' '71s/year/2017/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    eval(['!sed -i ''' '71s/date1/' a5 '/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);

    eval(['!sed -i ''' '88s/year/2017/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);
    eval(['!sed -i ''' '88s/date1/' a6 '/' ''' Automatic_S1_im_run_' a1(1:8) '_' a6(10:end) '.sh']);


i
end


%% Organize to merge


clear all

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2015/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Stack/'];
d_opt=dir(pathsate_opt);
j=1;
for i=4:length(d_opt)-7;
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name


j=1;
for i=1:length(list_opt);
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    
cd(path1);

eval( ['!cp ./*mag_yrF.gc.tiff ' destination]);
 
eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' destination]);
 
  date=list_opt{i,1};
  date_2015(i,:)=['20' date(1:7) '20' date(8:end)];
  
end

list_opt_Russel2015=list_opt;
clear path1 list_opt pathsate_opt date data ans i j


% 2016 


pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2016/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Stack/'];
d_opt=dir(pathsate_opt);
j=1;
for i=4:length(d_opt)-10;
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name


j=1;
for i=1:length(list_opt);
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    
cd(path1);

%eval( ['!cp ./*mag_yrF.gc.tiff ' destination]);
 
%eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' destination]);
 
  
  date_2016(i,:)=list_opt{i,1};
  
end

list_opt_Russel2016=list_opt;
clear path1 list_opt pathsate_opt date data ans i j


% 2017


pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2017/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Stack/'];
d_opt=dir(pathsate_opt);
j=1;
for i=4:length(d_opt)-19;
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name


j=1;
for i=1:length(list_opt);
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    
cd(path1);

eval( ['!cp ./*mag_yrF.gc.tiff ' destination]);
 
eval( ['!cp ./*mag_DuFil_yrF.gc.tiff ' destination]);
 
date_2017(i,:)=list_opt{i,1};
  
end

list_opt_Russel2017=list_opt;
clear path1 list_opt pathsate_opt date data ans i j


%%%%%% Merge using gdal_merge.py (use in command line)

cd /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Stack

ls -1 *mag_DuFil_yrF.gc.tiff > tiff_list.txt

gdal_merge.py -n -99999 -a_nodata -99999 -separate -of GTiff -o ../Russel_vel_filtered.tif ./*mag_DuFil_yrF.gc.tiff


ls -1 *mag_yrF.gc.tiff > tiff_nofilter_list.txt

gdal_merge.py -n -99999 -a_nodata -99999 -separate -of GTiff -o  ../Russel_vel_NOfilter.tif ./*mag_yrF.gc.tiff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Organize to merge


pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2015/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Stack_SNR/'];

list_opt=list_opt_Russel2015;

j=1;
for i=1:length(list_opt);
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    
cd(path1);

eval( ['!cp ./*ccpN.gc.tiff ' destination]);
 
eval( ['!cp ./*ccsN.gc.tiff ' destination]);
 
%   date=list_opt{i,1};
%   date_2015(i,:)=['20' date(1:7) '20' date(8:end)];
%   
end


clear path1 list_opt pathsate_opt date data ans i j


% 2016 


pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2016/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Stack_SNR/'];

list_opt=list_opt_Russel2016;

j=1;
for i=1:length(list_opt);
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    
cd(path1);

eval( ['!cp ./*ccpN.gc.tiff ' destination]);
 
eval( ['!cp ./*ccsN.gc.tiff ' destination]);
 
  
  %date_2016(i,:)=list_opt{i,1};
  
end

clear path1 list_opt pathsate_opt date data ans i j


% 2017


pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2017/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Stack_SNR/'];

list_opt=list_opt_Russel2017;

j=1;
for i=1:length(list_opt);
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    
cd(path1);

eval( ['!cp ./*ccpN.gc.tiff ' destination]);
 
eval( ['!cp ./*ccsN.gc.tiff ' destination]);
 
%date_2017(i,:)=list_opt{i,1};
  
end

clear path1 list_opt pathsate_opt date data ans i j

%%%%%% Merge using gdal_merge.py (use in command line)

cd /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Stack_SNR/

!ls -1 *ccpN.gc.tiff > ccp_tiff_list.txt

!gdal_merge.py -n -99999 -a_nodata -99999 -separate -of GTiff -o ../Russel_ccp.tif ./*ccpN.gc.tiff


!ls -1 *ccsN.gc.tiff > ccs_tiff_list.txt

!gdal_merge.py -n -99999 -a_nodata -99999 -separate -of GTiff -o  ../Russel_ccs.tif ./*ccsN.gc.tiff



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Organize to merge


pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2015/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Stack_Im_Real/'];

list_opt=list_opt_Russel2015;

j=1;
for i=1:length(list_opt);
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    
cd(path1);

eval( ['!cp ./*real.gc.tiff ' destination]);
 
eval( ['!cp ./*im.gc.tiff ' destination]);
 
%   date=list_opt{i,1};
%   date_2015(i,:)=['20' date(1:7) '20' date(8:end)];
%   
end


clear path1 list_opt pathsate_opt date data ans i j


% 2016 


pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2016/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Stack_Im_Real/'];

list_opt=list_opt_Russel2016;

j=1;
for i=1:length(list_opt);
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    
cd(path1);

eval( ['!cp ./*real.gc.tiff ' destination]);
 
eval( ['!cp ./*im.gc.tiff ' destination]);
 
  
  %date_2016(i,:)=list_opt{i,1};
  
end

clear path1 list_opt pathsate_opt date data ans i j


% 2017


pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/2017/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Stack_Im_Real/'];

list_opt=list_opt_Russel2017;

j=1;
for i=1:length(list_opt);
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    %dest=[destination list_opt{i,1} '/'];    
    %eval(['!mkdir ' dest]);

    
cd(path1);

eval( ['!cp ./*real.gc.tiff ' destination]);
 
eval( ['!cp ./*im.gc.tiff ' destination]);
 
%date_2017(i,:)=list_opt{i,1};
  
end

clear path1 list_opt pathsate_opt date data ans i j

%%%%%% Merge using gdal_merge.py (use in command line)

cd /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Stack_Im_Real/

!ls -1 *real.gc.tiff > real_tiff_list.txt

!gdal_merge.py -n -99999 -a_nodata -99999 -separate -of GTiff -o ../Russel_real.tif ./*real.gc.tiff


!ls -1 *im.gc.tiff > im_tiff_list.txt

!gdal_merge.py -n -99999 -a_nodata -99999 -separate -of GTiff -o  ../Russel_im.tif ./*im.gc.tiff


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
[Vel_Russel,R_russel]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Russel_vel_filtered.tif');

Vel_Russel(Vel_Russel==0)=nan;Vel_Russel(Vel_Russel<-99998)=nan;

Vel_Russel_mean=nanmean(Vel_Russel,3);

density_Russel=Vel_Russel./Vel_Russel; density_Russel=nansum(density_Russel,3);

info_Russel = geotiffinfo('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Russel_vel_filtered.tif');
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Russel_density.tif', density_Russel, R_russel,'GeoKeyDirectoryTag',info_Russel.GeoTIFFTags.GeoKeyDirectoryTag);


xRussel=[R_russel.XWorldLimits(1):R_russel.CellExtentInWorldX:R_russel.XWorldLimits(2)-R_russel.CellExtentInWorldX];
yRussel=[R_russel.YWorldLimits(1):R_russel.CellExtentInWorldY:R_russel.YWorldLimits(2)-R_russel.CellExtentInWorldY];
[XRussel,YRussel] = meshgrid(xRussel,yRussel);

% Apply moving mean

V=Vel_Russel;
V=movmean(V,10,'omitnan');

Vel_Russel=V;

%%% Error
[CCP_Russel,R_ccp_russel]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Russel_ccp.tif');
CCP_Russel(CCP_Russel<-99998)=nan;CCP_Russel(CCP_Russel==0)=nan;

[CCS_Russel,R_ccs_russel]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Russel_ccs.tif');
CCS_Russel(CCS_Russel<-99998)=nan;CCS_Russel(CCS_Russel==0)=nan;

SNR_Russel=CCP_Russel./CCS_Russel;

Noise_Russel=Vel_Russel./SNR_Russel;
Noise_Russel_mean=nanmean(Noise_Russel,3);

Noise_Russel_percentage=(Noise_Russel_mean./Vel_Russel_mean).*100;

geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Russel_noise.tif', Noise_Russel_mean, R_russel,'GeoKeyDirectoryTag',info_Russel.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Russel_noise_percentage.tif', Noise_Russel_percentage, R_russel,'GeoKeyDirectoryTag',info_Russel.GeoTIFFTags.GeoKeyDirectoryTag);


% imagesc((Noise_Russel_mean./Vel_Russel_mean).*100)
% 
% caxis([0 20])

%%% Vel X (real) and Y (im)
[VX_Russel,R_VX_russel]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Russel_real.tif');
VX_Russel(VX_Russel<-99998)=nan;VX_Russel(VX_Russel==0)=nan;

[VY_Russel,R_VY_russel]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Russel_im.tif');
VY_Russel(VY_Russel<-99998)=nan;VY_Russel(VY_Russel==0)=nan;


list_opt1=[list_opt_Russel2015]
list_opt2=[list_opt_Russel2016;list_opt_Russel2017];


for i=1:size(list_opt1,1);
   
    a=list_opt1{i,1};
    date1=a(1:6);
    date2=a(8:end);

    
    Tbaseline=datenum(date2,'yymmdd')-datenum(date1,'yymmdd');

    VX_Russel_m_yr(:,:,i)=(VX_Russel(:,:,i)*365/Tbaseline);
    VY_Russel_m_yr(:,:,i)=(VY_Russel(:,:,i)*365/Tbaseline);

end

j=size(list_opt1,1)+1;
for i=1:size(list_opt2,1);
   
    a=list_opt2{i,1};
    date1=a(1:8);
    date2=a(10:end);

    
    Tbaseline=datenum(date2,'yyyymmdd')-datenum(date1,'yyyymmdd');

    VX_Russel_m_yr(:,:,j)=(VX_Russel(:,:,j)*365/Tbaseline);
    VY_Russel_m_yr(:,:,j)=(VY_Russel(:,:,j)*365/Tbaseline);

j=j+1;

end


figure; imagesc(xRussel(1150:1400),yRussel(1400:1750),Vel_Russel(1400:1750,1150:1400,93))
hold on
quiver(XRussel(1400:10:2200,1100:10:1650),YRussel(1400:10:2200,1100:10:1650),VX_Russel_m_yr(1400:10:2200,1100:10:1650,93),VY_Russel_m_yr(1400:10:2200,1100:10:1650,93).*(-1),'k')
quiver(XRussel(1400:20:2200,1100:20:1650),YRussel(1400:20:2200,1100:20:1650),VX_Russel_m_yr(1400:20:2200,1100:20:1650,93),VY_Russel_m_yr(1400:20:2200,1100:20:1650,93).*(-1),'k')

figure; imagesc(xRussel,yRussel,Vel_Russel(:,:,93))
hold on
caxis([0 200])
quiver(XRussel(1400:20:2200,1100:20:1650),YRussel(1400:20:2200,1100:20:1650),VX_Russel_m_yr(1400:20:2200,1100:20:1650,93),VY_Russel_m_yr(1400:20:2200,1100:20:1650,93).*(-1),'k')


XY_stream=stream2(XRussel,YRussel,VX_Russel_m_yr(:,:,93),VY_Russel_m_yr(:,:,93).*(-1),XRussel(1400:50:2200,1100:50:1650),YRussel(1400:50:2200,1100:50:1650));





%% VelX and Vel Y Filtered
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
!app setup canopy python-libs

path_im_real=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Stack_Im_Real/'];

for i=1:size(imtifflist,1)

script_filt{i,1}=['float2dem.pl ' path_im_real imtifflist{i,1} ' ' imtifflist{i,1} '_temp.gc ' imtifflist{i,1} '.par'];

end

T = cell2table(script_filt);
writetable(T,'Float_im.dat')

j=1;
for i=1:size(imtifflist,1)
[s,width]=system(['grep width: ' imtifflist{i,1} '.par | cut -c23-26']);
[s,lines]=system(['grep nlines: ' imtifflist{i,1} '.par | cut -c23-26']);

script_filt_part2{j,1}=['gaussian_filter.py ' imtifflist{i,1} '_temp.gc float32 ' num2str(width) ' ' num2str(lines) ' ' imtifflist{i,1} '_mag_Fil.gc -w 10 -fmax 0.3'];
j=j+1;
script_filt_part2{j,1}=['dust_filter.py ' imtifflist{i,1} '_mag_Fil.gc float32 ' num2str(width) ' ' num2str(lines) ' ' imtifflist{i,1} '_mag_DuFil.gc'];

j=j+1;
script_filt_part2{j,1}=['data2geotiff ' imtifflist{i,1} '.par ' imtifflist{i,1} '_mag_DuFil.gc 2 ' imtifflist{i,1} '_mag_DuFil.tiff'];

j=j+1;

clear s width lines
end


T2 = cell2table(script_filt_part2);
writetable(T2,'Filter_im.dat','Delimiter','none')


for i=1:size(realtifflist,1)

script_filt_real{i,1}=['float2dem.pl ' path_im_real realtifflist{i,1} ' ' realtifflist{i,1} '_temp.gc ' realtifflist{i,1} '.par'];

end

Treal = cell2table(script_filt_real);
writetable(Treal,'Float_real.dat')

%%%%
cd /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Stack_Im_Real_Filtered/Russel_im_filter

!ls -1 *coffsN_im.gc.tiff_mag_DuFil.tiff > Russel_VelY_filtered_list.txt

!gdal_merge.py -n -99999 -a_nodata -99999 -separate -of GTiff -o ../Russel_VelY_filtered.tif ./*coffsN_im.gc.tiff_mag_DuFil.tiff

cd /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Stack_Im_Real_Filtered/Russel_real_filter

!ls -1 *coffsN_real.gc.tiff_mag_DuFil.tiff > Russel_VelX_filtered_list.txt

!gdal_merge.py -n -99999 -a_nodata -99999 -separate -of GTiff -o  ../Russel_VelX_filtered.tif ./*coffsN_real.gc.tiff_mag_DuFil.tiff

%%%%

cd /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Stack_Im_Real_Filtered

VY_Russel_filtered=imread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Stack_Im_Real_Filtered/Russel_VelY_filtered.tif');
VX_Russel_filtered=imread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Stack_Im_Real_Filtered/Russel_VelX_filtered.tif');

VX_Russel_filtered(VX_Russel_filtered<-99998)=nan;%VX_Russel_filtered(VX_Russel_filtered==0)=nan;
VY_Russel_filtered(VY_Russel_filtered<-99999)=nan;%VY_Russel_filtered(VY_Russel_filtered==0)=nan;


%%%%%%%%

list_opt1=[list_opt_Russel2015];
list_opt2=[list_opt_Russel2016;list_opt_Russel2017];


for i=1:size(list_opt1,1);
   
    a=list_opt1{i,1};
    date1=a(1:6);
    date2=a(8:end);

    
    Tbaseline=datenum(date2,'yymmdd')-datenum(date1,'yymmdd');

    VX_Russel_filtered_m_yr(:,:,i)=(VX_Russel_filtered(:,:,i).*(365/Tbaseline));
    VY_Russel_filtered_m_yr(:,:,i)=(VY_Russel_filtered(:,:,i).*(365/Tbaseline));

end

j=size(list_opt1,1)+1;
for i=1:size(list_opt2,1);
   
    a=list_opt2{i,1};
    date1=a(1:8);
    date2=a(10:end);

    
    Tbaseline=datenum(date2,'yyyymmdd')-datenum(date1,'yyyymmdd');

    VX_Russel_filtered_m_yr(:,:,j)=(VX_Russel_filtered(:,:,j).*(365/Tbaseline));
    VY_Russel_filtered_m_yr(:,:,j)=(VY_Russel_filtered(:,:,j).*(365/Tbaseline));

j=j+1;

end




figure; imagesc(xRussel(1150:1400),yRussel(1400:1750),Vel_Russel(1400:1750,1150:1400,92))
hold on
quiver(XRussel(1400:10:2200,1100:10:1650),YRussel(1400:10:2200,1100:10:1650),VX_Russel_m_yr(1400:10:2200,1100:10:1650,92),VY_Russel_m_yr(1400:10:2200,1100:10:1650,92).*(-1),'k')
quiver(XRussel(1400:20:2200,1100:20:1650),YRussel(1400:20:2200,1100:20:1650),VX_Russel_m_yr(1400:20:2200,1100:20:1650,93),VY_Russel_m_yr(1400:20:2200,1100:20:1650,93).*(-1),'k')

% figure; imagesc(xRussel,yRussel,Vel_Russel(:,:,93))
% hold on
% caxis([0 200])
% quiver(XRussel(1400:20:2200,1100:20:1650),YRussel(1400:20:2200,1100:20:1650),VX_Russel_m_yr(1400:20:2200,1100:20:1650,93),VY_Russel_m_yr(1400:20:2200,1100:20:1650,93).*(-1),'k')
% 
% 
% XY_stream=stream2(XRussel,YRussel,VX_Russel_m_yr(:,:,93),VY_Russel_m_yr(:,:,93).*(-1),XRussel(1400:50:2200,1100:50:1650),YRussel(1400:50:2200,1100:50:1650));



figure; imagesc(xRussel(1150:1400),yRussel(1400:1750),Vel_Russel(1400:1750,1150:1400,92))
hold on
quiver(XRussel(1400:10:2200,1100:10:1650),YRussel(1400:10:2200,1100:10:1650),VX_Russel_filtered_m_yr(1400:10:2200,1100:10:1650,92),VY_Russel_filtered_m_yr(1400:10:2200,1100:10:1650,92).*(1),'k')
quiver(XRussel(1400:20:2200,1100:20:1650),YRussel(1400:20:2200,1100:20:1650),VX_Russel_filtered_m_yr(1400:20:2200,1100:20:1650,93),VY_Russel_filtered_m_yr(1400:20:2200,1100:20:1650,93).*(-0),'k')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% h=imagesc(xRussel, yRussel,Vel_Russel_mean); tt=double(~isnan(Vel_Russel_mean)); set(h,'AlphaData', tt);
% h=imagesc(xRussel, yRussel,V_mean); tt=double(~isnan(V_mean)); set(h,'AlphaData', tt);
% 
% caxis([0 250])
% CT=cbrewer('div', 'RdYlGn',100);
% colormap(flip(CT));
% cb=colorbar
% %set(cb,'XTick',[-200:100:200],'Xticklabel',[])
% xlim([-250000 -50000])
% ylim([-2550000 -2350000])

date_Russel=cat(1,date_2015(:,10:end),date_2016(:,10:end),date_2017(:,10:end));
date_Russel_num=datenum(date_Russel,'yyyymmdd');

summer_ind_2015=find(date_Russel_num>=datenum('20150510','yyyymmdd') & date_Russel_num<=datenum('20150709','yyyymmdd'))
summer_ind_2016=find(date_Russel_num>=datenum('20160510','yyyymmdd') & date_Russel_num<=datenum('20160709','yyyymmdd'))
summer_ind_2017=find(date_Russel_num>=datenum('20170510','yyyymmdd') & date_Russel_num<=datenum('20170709','yyyymmdd'))

winter_ind_2015=find(date_Russel_num>=datenum('20150808','yyyymmdd') & date_Russel_num<=datenum('20160420','yyyymmdd'))
winter_ind_2016=find(date_Russel_num>=datenum('20160808','yyyymmdd') & date_Russel_num<=datenum('20170420','yyyymmdd'))
winter_ind_2017=find(date_Russel_num>=datenum('20170808','yyyymmdd') & date_Russel_num<=datenum('20180420','yyyymmdd'))



% Seasonal mean and error

summer_2015=nanmean(Vel_Russel(:,:,summer_ind_2015),3);
summer_2016=nanmean(Vel_Russel(:,:,summer_ind_2016),3);
summer_2017=nanmean(Vel_Russel(:,:,summer_ind_2017),3);

summer_Russel=mean(cat(3,summer_2016,summer_2017),3);
summer_Russel(summer_Russel<29)=nan;

winter_2015=nanmean(Vel_Russel(:,:,winter_ind_2015),3);
winter_2016=nanmean(Vel_Russel(:,:,winter_ind_2016),3);
winter_2017=nanmean(Vel_Russel(:,:,winter_ind_2017),3);

winter_Russel=mean(cat(3,winter_2016,winter_2017),3);
%winter_Russel=movmean(winter_Russel,10,'omitnan');
winter_Russel(winter_Russel<29)=nan;


summer_minus_winter_Russel=summer_Russel-winter_Russel;
summer_over_winter_Russel=((summer_Russel./winter_Russel)-1)*100;
%summer_minus_winter_Russel=movmean(summer_minus_winter_Russel,10,'omitnan');

geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Summer_Russel.tif', summer_Russel, R_russel,'GeoKeyDirectoryTag',info_Russel.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Winter_Russel.tif', winter_Russel, R_russel,'GeoKeyDirectoryTag',info_Russel.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Summer_minus_winter_Russel.tif',summer_minus_winter_Russel, R_russel,'GeoKeyDirectoryTag',info_Russel.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Summer_over_winter_Russel_percentage.tif',summer_over_winter_Russel, R_russel,'GeoKeyDirectoryTag',info_Russel.GeoTIFFTags.GeoKeyDirectoryTag);


% Seasonal error

%summer
Noise_Russel_SummerMean=nanmean(Noise_Russel(:,:,[summer_ind_2016;summer_ind_2017]),3);

%winter
Noise_Russel_WinterMean=nanmean(Noise_Russel(:,:,[winter_ind_2016;winter_ind_2017]),3);

Noise_Russel_percentageSummer=(Noise_Russel_SummerMean./summer_Russel).*100;
Noise_Russel_percentageWinter=(Noise_Russel_WinterMean./winter_Russel).*100;

geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Noise_Russel_percentageSummer.tif', Noise_Russel_percentageSummer, R_russel,'GeoKeyDirectoryTag',info_Russel.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Noise_Russel_percentageWinter.tif', Noise_Russel_percentageWinter, R_russel,'GeoKeyDirectoryTag',info_Russel.GeoTIFFTags.GeoKeyDirectoryTag);









%plot

figure('PaperOrientation','landscape','position',[1 1 1520 1000])
%figure('PaperOrientation','landscape','position',[1 1 1520 500])
subplot(231)

h=imagesc(xRussel, yRussel,summer_2015); tt=double(~isnan(summer_2015)); set(h,'AlphaData', tt);
caxis([0 400])
CT=cbrewer('div', 'RdYlGn',90);
c=colormap(flipud(CT));
%cb=colorbar
%set(cb,'XTick',[-200:100:200],'Xticklabel',[])
xlim([-250000 -50000])
ylim([-2550000 -2350000])
grid on
set(gca,'fontsize',12)
title('Summer 2015')

subplot(232)

h=imagesc(xRussel, yRussel,summer_2016); tt=double(~isnan(summer_2016)); set(h,'AlphaData', tt);
caxis([0 400])
%CT=cbrewer('div', 'RdYlGn',9);
c=colormap(flipud(CT));
cb=colorbar('location','south');
ylabel(cb,'[m yr^{-1}]','fontsize',12)
%set(cb,'XTick',[-200:100:200],'Xticklabel',[])
xlim([-250000 -50000])
ylim([-2550000 -2350000])
set(gca,'fontsize',12)
grid on
title('Summer 2016')

subplot(233)

h=imagesc(xRussel, yRussel,summer_2017); tt=double(~isnan(summer_2017)); set(h,'AlphaData', tt);
caxis([0 400])
%CT=cbrewer('div', 'RdYlGn',9);
c=colormap(flipud(CT));
%cb=colorbar

%set(cb,'XTick',[-200:100:200],'Xticklabel',[])
xlim([-250000 -50000])
ylim([-2550000 -2350000])
set(gca,'fontsize',12)
grid on

title('Summer 2017')

%%%%%%%%%%%%%%%%%
%%% Winter

%figure('PaperOrientation','landscape','position',[1 1 1520 500])
subplot(234)

h=imagesc(xRussel, yRussel,winter_2015); tt=double(~isnan(winter_2015)); set(h,'AlphaData', tt);
caxis([0 400])
CT=cbrewer('div', 'RdYlGn',90);
c=colormap(flipud(CT));
%cb=colorbar
%set(cb,'XTick',[-200:100:200],'Xticklabel',[])
xlim([-250000 -50000])
ylim([-2550000 -2350000])
grid on
set(gca,'fontsize',12)
title('Winter 2015')

subplot(235)

h=imagesc(xRussel, yRussel,winter_2016); tt=double(~isnan(winter_2016)); set(h,'AlphaData', tt);
caxis([0 400])
%CT=cbrewer('div', 'RdYlGn',9);
c=colormap(flipud(CT));
cb=colorbar('location','south');
ylabel(cb,'[m yr^{-1}]','fontsize',12)
%set(cb,'XTick',[-200:100:200],'Xticklabel',[])
xlim([-250000 -50000])
ylim([-2550000 -2350000])
set(gca,'fontsize',12)
grid on
title('Winter 2016')

subplot(236)

h=imagesc(xRussel, yRussel,winter_2017); tt=double(~isnan(winter_2017)); set(h,'AlphaData', tt);
caxis([0 400])
%CT=cbrewer('div', 'RdYlGn',9);
c=colormap(flipud(CT));
%cb=colorbar

%set(cb,'XTick',[-200:100:200],'Xticklabel',[])
xlim([-250000 -50000])
ylim([-2550000 -2350000])
set(gca,'fontsize',12)
grid on

title('Winter 2017')



print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Summer_Winter_Russel

%%%%%%%%%%%%%
% Seasonal (Summer - Winter)


figure('PaperOrientation','landscape','position',[1 1 1020 500])
subplot(121)

h=imagesc(xRussel, yRussel,summer_2016-winter_2015); tt=double(~isnan(summer_2016-winter_2015)); set(h,'AlphaData', tt);
caxis([0 150])
CT=cbrewer('div', 'RdYlBu',9);
c=colormap(flip(CT));
%cb=colorbar
%set(cb,'XTick',[-200:100:200],'Xticklabel',[])
xlim([-250000 -50000])
ylim([-2550000 -2350000])
grid on
set(gca,'fontsize',12)
title('Summer-Winter (2015/2016)')

subplot(122)

h=imagesc(xRussel, yRussel,summer_2017-winter_2016); tt=double(~isnan(summer_2017-winter_2016)); set(h,'AlphaData', tt);
caxis([0 150])
CT=cbrewer('div', 'RdYlBu',9);
c=colormap(flip(CT));
cb=colorbar('location','east');
ylabel(cb,'[m yr^{-1}]','fontsize',12)
%set(cb,'XTick',[-200:100:200],'Xticklabel',[])
xlim([-250000 -50000])
ylim([-2550000 -2350000])
set(gca,'fontsize',12)
grid on
title('Summer-Winter (2016/2017)')


print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Summer_minus_Winter_Russel






[SAR_mosaic]=imread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/SAR_100mCbandmultiyearSigma.tif');
[Summer_2016_minus_winter_2017,Rs16_w17]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/SUMMER_2016_minus_WINTER_jan2017.tiff');
Rsar=Rs16_w17;

clear Summer_2016_minus_winter_2017 Rs16_w17

xSAR=[Rsar.XWorldLimits(1):Rsar.CellExtentInWorldX:Rsar.XWorldLimits(2)-Rsar.CellExtentInWorldX];
ySAR=[Rsar.YWorldLimits(1):Rsar.CellExtentInWorldY:Rsar.YWorldLimits(2)-Rsar.CellExtentInWorldY];
[XSAR,YSAR] = meshgrid(xSAR,ySAR);




% Create two axes

figure('PaperOrientation','landscape','position',[1 1 1020 500])

ax1 = axes('Position',[0.13 0.11 0.335 0.815]);
imagesc(ax1,xSAR,ySAR,flipud(SAR_mosaic));
set(ax1,'Ydir','Normal')
ax2 = axes('Position',[0.13 0.11 0.335 0.815]);
h=imagesc(ax2,xRussel, yRussel,summer_2016-winter_2015); tt=double(~isnan(summer_2016-winter_2015)); set(h,'AlphaData', tt);

% Link them together
linkaxes([ax1,ax2])
% Hide the top axes
ax2.Visible = 'off';
ax2.XTick = [];
ax2.YTick = [];
% Give each one its own colormap
colormap(ax1,'gray')

CT=cbrewer('div', 'RdYlBu',9);
colormap(ax2,flip(CT))

caxis(ax1,[-30 -3.44625])
caxis(ax2,[0 150]);

xlim(ax1,[-250000 -50000])
ylim(ax1,[-2550000 -2350000])

xlim(ax2,[-250000 -50000])
ylim(ax2,[-2550000 -2350000])
% Then add colorbars and get everything lined up
set([ax1,ax2],'Position',[0.13 0.11 0.335 0.815]);

grid(ax2,'on')
grid(ax1,'on')
title(ax1,'Summer-Winter (2015/2016)','fontsize',14)

%%%%%%%%

ax1 = axes('Position',[0.57 0.11 0.335 0.815]);
imagesc(ax1,xSAR,ySAR,flipud(SAR_mosaic));
set(ax1,'Ydir','Normal')
ax2 = axes('Position',[0.57 0.11 0.335 0.815]);
h=imagesc(ax2,xRussel, yRussel,summer_2017-winter_2016); tt=double(~isnan(summer_2017-winter_2016)); set(h,'AlphaData', tt);

% Link them together
linkaxes([ax1,ax2])
% Hide the top axes
ax2.Visible = 'off';
ax2.XTick = [];
ax2.YTick = [];
% Give each one its own colormap
colormap(ax1,'gray')

CT=cbrewer('div', 'RdYlBu',9);
colormap(ax2,flip(CT))

caxis(ax1,[-30 -3.44625])
caxis(ax2,[0 150]);

xlim(ax1,[-250000 -50000])
ylim(ax1,[-2550000 -2350000])

xlim(ax2,[-250000 -50000])
ylim(ax2,[-2550000 -2350000])
% Then add colorbars and get everything lined up
set([ax1,ax2],'Position',[0.57 0.11 0.335 0.815]);
%cb1 = colorbar(ax1,'Position',[.05 .11 .0675 .815]);
grid(ax2,'on')
grid(ax1,'on')
title(ax1,'Summer-Winter (2016/2017)','fontsize',14)

cb2 = colorbar(ax2,'Position',[.91 .11 .035 .815]);
set(cb2,'fontsize',12)
ylabel(cb2,'[m yr^{-1}]','fontsize',14)

print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Summer_minus_Winter_Russel
export_fig('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Summer_minus_Winter_Russel_exportF.png','-dpng','-r600');

%%%%%%%%%%%%
G_coastline=shaperead('/nfs/a59/eeagdl/DATABASE/GREENLAND/Coastline/Greenland_Cosatline.shp');
X_coast=extractfield(G_coastline,'X');
Y_coast=extractfield(G_coastline,'Y');

G1_prof=shaperead('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Profiles/Glacier1_profile.shp');
X_g1=extractfield(G1_prof,'X');
Y_g1=extractfield(G1_prof,'Y');

G2_prof=shaperead('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Profiles/Glacier2_profile.shp');
X_g2=extractfield(G2_prof,'X');
Y_g2=extractfield(G2_prof,'Y');

G3_prof=shaperead('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Profiles/Glacier3_profile.shp');
X_g3=extractfield(G3_prof,'X');
Y_g3=extractfield(G3_prof,'Y');

G4_prof=shaperead('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Profiles/Glacier4_profile.shp');
X_g4=extractfield(G4_prof,'X');
Y_g4=extractfield(G4_prof,'Y');

G5_prof=shaperead('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Profiles/Glacier5_profile.shp');
X_g5=extractfield(G5_prof,'X');
Y_g5=extractfield(G5_prof,'Y');


V=Vel_Russel; V=movmean(V,10,'omitnan');
V_mean=nanmean(V,3);

geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Russel_V_mean.tif', V_mean, R_russel,'GeoKeyDirectoryTag',info_Russel.GeoTIFFTags.GeoKeyDirectoryTag);



% summer_2015=nanmean(V(:,:,summer_ind_2015),3);
% summer_2016=nanmean(V(:,:,summer_ind_2016),3);
% summer_2017=nanmean(V(:,:,summer_ind_2017),3);
% 
% winter_2015=nanmean(V(:,:,winter_ind_2015),3);
% winter_2016=nanmean(V(:,:,winter_ind_2016),3);
% winter_2017=nanmean(V(:,:,winter_ind_2017),3);



V_g1=profile_ext(X_g1,Y_g1,V_mean,R_russel);
V_g2=profile_ext(X_g2,Y_g2,V_mean,R_russel);
V_g3=profile_ext(X_g3,Y_g3,V_mean,R_russel);
V_g4=profile_ext(X_g4,Y_g4,V_mean,R_russel);
V_g5=profile_ext(X_g5,Y_g5,V_mean,R_russel);

V_g1summer=profile_ext(X_g1,Y_g1,summer_Russel,R_russel);
V_g2summer=profile_ext(X_g2,Y_g2,summer_Russel,R_russel);
V_g3summer=profile_ext(X_g3,Y_g3,summer_Russel,R_russel);
V_g4summer=profile_ext(X_g4,Y_g4,summer_Russel,R_russel);
V_g5summer=profile_ext(X_g5,Y_g5,summer_Russel,R_russel);


V_g1winter=profile_ext(X_g1,Y_g1,winter_Russel,R_russel);
V_g2winter=profile_ext(X_g2,Y_g2,winter_Russel,R_russel);
V_g3winter=profile_ext(X_g3,Y_g3,winter_Russel,R_russel);
V_g4winter=profile_ext(X_g4,Y_g4,winter_Russel,R_russel);
V_g5winter=profile_ext(X_g5,Y_g5,winter_Russel,R_russel);

% for i=1:size(V,3)
% V_g1(:,i)=profile_ext(X_g1,Y_g1,V(:,:,i),R_russel);
% end

% Profiles lengths

% g1=28663.5;
% g2=28918;
% g3=16880.7;
% g4=30625.9;
% g5=34024;

dist_G1=0:(28663.5/(length(V_g1)-1)):28663.5;
dist_G2=0:(28918/(length(V_g2)-1)):28918;
dist_G3=0:(16880.7/(length(V_g3)-1)):16880.7;
dist_G4=0:(30625.9/(length(V_g4)-1)):30625.9;
dist_G5=0:(34024/(length(V_g5)-1)):34024;


%% Plotting Profiles

figure('units','centimeters','position',[0 0 35 20]);

subplot(231)
plot(dist_G1/1000,V_g1,'.k','linewidth',2);hold on
plot(dist_G1/1000,V_g1summer,'.r','linewidth',2);
plot(dist_G1/1000,V_g1winter,'.b','linewidth',2);
title('Glacier 1','fontsize',14)
ylim([0 370])
grid on
set(gca,'fontsize',12)
ylabel('Velocity (m yr^{-1})','fontsize',14,'fontweight','bold')

subplot(232)
plot(dist_G2/1000,V_g2,'.k','linewidth',2);hold on
plot(dist_G2/1000,V_g2summer,'.r','linewidth',2);
plot(dist_G2/1000,V_g2winter,'.b','linewidth',2);
title('Glacier 2','fontsize',14)
ylim([0 370])
grid on
set(gca,'fontsize',12)
xlabel('Distance (km)','fontsize',16,'fontweight','bold')

subplot(233)
plot(dist_G3/1000,V_g3,'.k','linewidth',2);hold on
plot(dist_G3/1000,V_g3summer,'.r','linewidth',2);
plot(dist_G3/1000,V_g3winter,'.b','linewidth',2);
title('Glacier 3','fontsize',14)
ylim([0 370])
grid on
set(gca,'fontsize',12)

subplot(2,3,4.5)
plot(dist_G4/1000,V_g4,'.k','linewidth',2);hold on
plot(dist_G4/1000,V_g4summer,'.r','linewidth',2);
plot(dist_G4/1000,V_g4winter,'.b','linewidth',2);
title('Glacier 4','fontsize',14)
ylim([0 370])
grid on
set(gca,'fontsize',12)
ylabel('Velocity (m yr^{-1})','fontsize',14,'fontweight','bold')

subplot(2,3,5.5)
plot(dist_G5/1000,V_g5,'.k','linewidth',2);hold on
plot(dist_G5/1000,V_g5summer,'.r','linewidth',2);
plot(dist_G5/1000,V_g5winter,'.b','linewidth',2);
ylim([0 370])
grid on
set(gca,'fontsize',12)
title('Glacier 5','fontsize',14)
annotation(gcf,'textbox',[0.46 0.01354 0.15 0.06],'String',{'Distance (km)'},'LineStyle','none','fontweight','bold','FontSize',16,'FitBoxToText','on');

legend('Mean','Summer','Winter','location','northeast');

print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Profiles_Russel


%% Summer-Winter
figure('units','centimeters','position',[0 0 35 20]);

subplot(231)
plot(dist_G1/1000,V_g1summer-V_g1winter,'.k','linewidth',2);
%plot(dist_G1/1000,V_g1winter,'.b','linewidth',2);
title('Glacier 1','fontsize',14)
ylim([-50 150])
grid on
set(gca,'fontsize',12)
ylabel('Velocity (m yr^{-1})','fontsize',14,'fontweight','bold')

subplot(232)
plot(dist_G2/1000,V_g2summer-V_g2winter,'.k','linewidth',2);
title('Glacier 2','fontsize',14)
ylim([-50 150])
grid on
set(gca,'fontsize',12)
xlabel('Distance (km)','fontsize',16,'fontweight','bold')

subplot(233)
plot(dist_G3/1000,V_g3summer-V_g3winter,'.k','linewidth',2);
title('Glacier 3','fontsize',14)
ylim([-50 150])
grid on
set(gca,'fontsize',12)

subplot(2,3,4.5)
plot(dist_G4/1000,V_g4summer-V_g4winter,'.k','linewidth',2);
title('Glacier 4','fontsize',14)
ylim([-50 150])
grid on
set(gca,'fontsize',12)
ylabel('Velocity (m yr^{-1})','fontsize',14,'fontweight','bold')

subplot(2,3,5.5)
plot(dist_G5/1000,V_g5summer-V_g5winter,'.k','linewidth',2);
title('Glacier 5','fontsize',14)
ylim([-50 150])
grid on
set(gca,'fontsize',12)
annotation(gcf,'textbox',[0.46 0.01354 0.15 0.06],'String',{'Distance (km)'},'LineStyle','none','fontweight','bold','FontSize',16,'FitBoxToText','on');

annotation(gcf,'textbox',[0.46 0.95 0.15 0.06],'String',{'Summer-Winter'},'LineStyle','none','fontweight','bold','FontSize',16,'FitBoxToText','on');

print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Profiles_Difference_Russel


%% Points

Russel_pts=shaperead('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Profiles/Russel_pts');
X_pts=extractfield(Russel_pts,'X');
Y_pts=extractfield(Russel_pts,'Y');
Names_pts=extractfield(Russel_pts,'Ident');

for i=1:size(V,3)
G1_pts(i,1)=profile_ext(X_pts(1),Y_pts(1),V(:,:,i),R_russel);
G1_pts(i,2)=profile_ext(X_pts(2),Y_pts(2),V(:,:,i),R_russel);
G1_pts(i,3)=profile_ext(X_pts(11),Y_pts(11),V(:,:,i),R_russel);

G2_pts(i,1)=profile_ext(X_pts(3),Y_pts(3),V(:,:,i),R_russel);
G2_pts(i,2)=profile_ext(X_pts(4),Y_pts(4),V(:,:,i),R_russel);
G2_pts(i,3)=profile_ext(X_pts(12),Y_pts(12),V(:,:,i),R_russel);

G3_pts(i,1)=profile_ext(X_pts(5),Y_pts(5),V(:,:,i),R_russel);
G3_pts(i,2)=profile_ext(X_pts(6),Y_pts(6),V(:,:,i),R_russel);
G3_pts(i,3)=profile_ext(X_pts(13),Y_pts(13),V(:,:,i),R_russel);


G4_pts(i,1)=profile_ext(X_pts(7),Y_pts(7),V(:,:,i),R_russel);
G4_pts(i,2)=profile_ext(X_pts(8),Y_pts(8),V(:,:,i),R_russel);
G4_pts(i,3)=profile_ext(X_pts(14),Y_pts(14),V(:,:,i),R_russel);


G5_pts(i,1)=profile_ext(X_pts(9),Y_pts(9),V(:,:,i),R_russel);
G5_pts(i,2)=profile_ext(X_pts(10),Y_pts(10),V(:,:,i),R_russel);
G5_pts(i,3)=profile_ext(X_pts(15),Y_pts(15),V(:,:,i),R_russel);


end


figure('units','centimeters','position',[0 0 35 20]);

subplot(231)
plot(date_Russel_num,G1_pts(:,1),'k','linewidth',2);hold on
plot(date_Russel_num,G1_pts(:,2),'color','r','linewidth',2);
title('Glacier 1','fontsize',14)
ylim([0 500])
grid on
set(gca,'fontsize',12)
datetick('x','yyyy','keeplimits');
ylabel('Velocity (m yr^{-1})','fontsize',14,'fontweight','bold')

subplot(232)
plot(date_Russel_num,G2_pts(:,1),'k','linewidth',2);hold on
plot(date_Russel_num,G2_pts(:,2),'r','linewidth',2);
title('Glacier 2','fontsize',14)
ylim([0 500])
grid on
set(gca,'fontsize',12)
datetick('x','yyyy','keeplimits');
%xlabel('Distance (km)','fontsize',16,'fontweight','bold')

subplot(233)
plot(date_Russel_num,G3_pts(:,1),'k','linewidth',2);hold on
plot(date_Russel_num,G3_pts(:,2),'r','linewidth',2);
title('Glacier 3','fontsize',14)
ylim([0 500])
grid on
set(gca,'fontsize',12)
datetick('x','yyyy','keeplimits');

subplot(2,3,4.5)
plot(date_Russel_num,G4_pts(:,1),'k','linewidth',2);hold on
plot(date_Russel_num,G4_pts(:,2),'r','linewidth',2);
title('Glacier 4','fontsize',14)
ylim([0 500])
grid on
set(gca,'fontsize',12)
datetick('x','yyyy','keeplimits');
ylabel('Velocity (m yr^{-1})','fontsize',14,'fontweight','bold')

subplot(2,3,5.5)
plot(date_Russel_num,G5_pts(:,1),'k','linewidth',2);hold on
plot(date_Russel_num,G5_pts(:,2),'r','linewidth',2);
title('Glacier 5','fontsize',14)
ylim([0 500])
grid on
set(gca,'fontsize',12)
datetick('x','yyyy','keeplimits');
%annotation(gcf,'textbox',[0.46 0.01354 0.15 0.06],'String',{'Distance (km)'},'LineStyle','none','fontweight','bold','FontSize',16,'FitBoxToText','on');

legend('P1','P2','location','northeast');


print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Pts_Russel

%% Plot using days of year

% year 2015: 1:12
% 2016:  13:44
% 2017: 45:end

date_days_2015=date_Russel_num-735965;
date_days_2016=date_Russel_num-735965-365;
date_days_2017=date_Russel_num-735965-365-365;
date_days=[date_days_2015(1:12);date_days_2016(13:44);date_days_2017(45:end)];

aa_temp=[1:365]';

% G1
G_pts_days_temp(:,1)=interp1(date_days(1:12,1),G1_pts(1:12,1),aa_temp);
G_pts_days_temp(:,2)=interp1(date_days(13:43,1),G1_pts(13:43,1),aa_temp);
G_pts_days_temp(:,3)=interp1(date_days(44:end,1),G1_pts(44:end,1),aa_temp);
G1_pts_days(:,1)=nanmean([G_pts_days_temp(:,1),G_pts_days_temp(:,2),G_pts_days_temp(:,3)],2);
clear G_pts_temp

G_pts_days_temp(:,1)=interp1(date_days(1:12,1),G1_pts(1:12,2),aa_temp);
G_pts_days_temp(:,2)=interp1(date_days(13:43,1),G1_pts(13:43,2),aa_temp);
G_pts_days_temp(:,3)=interp1(date_days(44:end,1),G1_pts(44:end,2),aa_temp);
G1_pts_days(:,2)=nanmean([G_pts_days_temp(:,1),G_pts_days_temp(:,2),G_pts_days_temp(:,3)],2);
clear G_pts_temp

G_pts_days_temp(:,1)=interp1(date_days(1:12,1),G1_pts(1:12,3),aa_temp);
G_pts_days_temp(:,2)=interp1(date_days(13:43,1),G1_pts(13:43,3),aa_temp);
G_pts_days_temp(:,3)=interp1(date_days(44:end,1),G1_pts(44:end,3),aa_temp);
G1_pts_days(:,3)=nanmean([G_pts_days_temp(:,1),G_pts_days_temp(:,2),G_pts_days_temp(:,3)],2);
clear G_pts_temp

% G2
G_pts_days_temp(:,1)=interp1(date_days(1:12,1),G2_pts(1:12,1),aa_temp);
G_pts_days_temp(:,2)=interp1(date_days(13:43,1),G2_pts(13:43,1),aa_temp);
G_pts_days_temp(:,3)=interp1(date_days(44:end,1),G2_pts(44:end,1),aa_temp);
G2_pts_days(:,1)=nanmean([G_pts_days_temp(:,1),G_pts_days_temp(:,2),G_pts_days_temp(:,3)],2);
clear G_pts_temp

G_pts_days_temp(:,1)=interp1(date_days(1:12,1),G2_pts(1:12,2),aa_temp);
G_pts_days_temp(:,2)=interp1(date_days(13:43,1),G2_pts(13:43,2),aa_temp);
G_pts_days_temp(:,3)=interp1(date_days(44:end,1),G2_pts(44:end,2),aa_temp);
G2_pts_days(:,2)=nanmean([G_pts_days_temp(:,1),G_pts_days_temp(:,2),G_pts_days_temp(:,3)],2);
clear G_pts_temp

G_pts_days_temp(:,1)=interp1(date_days(1:12,1),G2_pts(1:12,3),aa_temp);
G_pts_days_temp(:,2)=interp1(date_days(13:43,1),G2_pts(13:43,3),aa_temp);
G_pts_days_temp(:,3)=interp1(date_days(44:end,1),G2_pts(44:end,3),aa_temp);
G2_pts_days(:,3)=nanmean([G_pts_days_temp(:,1),G_pts_days_temp(:,2),G_pts_days_temp(:,3)],2);
clear G_pts_temp


% G3
G_pts_days_temp(:,1)=interp1(date_days(1:12,1),G3_pts(1:12,1),aa_temp);
G_pts_days_temp(:,2)=interp1(date_days(13:43,1),G3_pts(13:43,1),aa_temp);
G_pts_days_temp(:,3)=interp1(date_days(44:end,1),G3_pts(44:end,1),aa_temp);
G3_pts_days(:,1)=nanmean([G_pts_days_temp(:,1),G_pts_days_temp(:,2),G_pts_days_temp(:,3)],2);
clear G_pts_temp

G_pts_days_temp(:,1)=interp1(date_days(1:12,1),G3_pts(1:12,2),aa_temp);
G_pts_days_temp(:,2)=interp1(date_days(13:43,1),G3_pts(13:43,2),aa_temp);
G_pts_days_temp(:,3)=interp1(date_days(44:end,1),G3_pts(44:end,2),aa_temp);
G3_pts_days(:,2)=nanmean([G_pts_days_temp(:,1),G_pts_days_temp(:,2),G_pts_days_temp(:,3)],2);
clear G_pts_temp

G_pts_days_temp(:,1)=interp1(date_days(1:12,1),G3_pts(1:12,3),aa_temp);
G_pts_days_temp(:,2)=interp1(date_days(13:43,1),G3_pts(13:43,3),aa_temp);
G_pts_days_temp(:,3)=interp1(date_days(44:end,1),G3_pts(44:end,3),aa_temp);
G3_pts_days(:,3)=nanmean([G_pts_days_temp(:,1),G_pts_days_temp(:,2),G_pts_days_temp(:,3)],2);
clear G_pts_temp

% G4
G_pts_days_temp(:,1)=interp1(date_days(1:12,1),G4_pts(1:12,1),aa_temp);
G_pts_days_temp(:,2)=interp1(date_days(13:43,1),G4_pts(13:43,1),aa_temp);
G_pts_days_temp(:,3)=interp1(date_days(44:end,1),G4_pts(44:end,1),aa_temp);
G4_pts_days(:,1)=nanmean([G_pts_days_temp(:,1),G_pts_days_temp(:,2),G_pts_days_temp(:,3)],2);
clear G_pts_temp

G_pts_days_temp(:,1)=interp1(date_days(1:12,1),G4_pts(1:12,2),aa_temp);
G_pts_days_temp(:,2)=interp1(date_days(13:43,1),G4_pts(13:43,2),aa_temp);
G_pts_days_temp(:,3)=interp1(date_days(44:end,1),G4_pts(44:end,2),aa_temp);
G4_pts_days(:,2)=nanmean([G_pts_days_temp(:,1),G_pts_days_temp(:,2),G_pts_days_temp(:,3)],2);
clear G_pts_temp

G_pts_days_temp(:,1)=interp1(date_days(1:12,1),G4_pts(1:12,3),aa_temp);
G_pts_days_temp(:,2)=interp1(date_days(13:43,1),G4_pts(13:43,3),aa_temp);
G_pts_days_temp(:,3)=interp1(date_days(44:end,1),G4_pts(44:end,3),aa_temp);
G4_pts_days(:,3)=nanmean([G_pts_days_temp(:,1),G_pts_days_temp(:,2),G_pts_days_temp(:,3)],2);
clear G_pts_temp

% G5
G_pts_days_temp(:,1)=interp1(date_days(1:12,1),G5_pts(1:12,1),aa_temp);
G_pts_days_temp(:,2)=interp1(date_days(13:43,1),G5_pts(13:43,1),aa_temp);
G_pts_days_temp(:,3)=interp1(date_days(44:end,1),G5_pts(44:end,1),aa_temp);
G5_pts_days(:,1)=nanmean([G_pts_days_temp(:,1),G_pts_days_temp(:,2),G_pts_days_temp(:,3)],2);
clear G_pts_temp

G_pts_days_temp(:,1)=interp1(date_days(1:12,1),G5_pts(1:12,2),aa_temp);
G_pts_days_temp(:,2)=interp1(date_days(13:43,1),G5_pts(13:43,2),aa_temp);
G_pts_days_temp(:,3)=interp1(date_days(44:end,1),G5_pts(44:end,2),aa_temp);
G5_pts_days(:,2)=nanmean([G_pts_days_temp(:,1),G_pts_days_temp(:,2),G_pts_days_temp(:,3)],2);
clear G_pts_temp

G_pts_days_temp(:,1)=interp1(date_days(1:12,1),G5_pts(1:12,3),aa_temp);
G_pts_days_temp(:,2)=interp1(date_days(13:43,1),G5_pts(13:43,3),aa_temp);
G_pts_days_temp(:,3)=interp1(date_days(44:end,1),G5_pts(44:end,3),aa_temp);
G5_pts_days(:,3)=nanmean([G_pts_days_temp(:,1),G_pts_days_temp(:,3),G_pts_days_temp(:,3)],2);
clear G_pts_temp

%%%% Plot

plot((G1_pts_days(:,1)/G1_winter_mean(1,1)-1)*100,'o','linestyle','none','markersize',4,'markerfacecolor','k','markeredgecolor','k');hold on
plot((G1_pts_days(:,2)/G1_winter_mean(1,2)-1)*100,'^','markersize',4,'markerfacecolor',[0.6 0.6 0.6],'markeredgecolor',[0.6 0.6 0.6]);
%plot((G1_pts_days(:,3)/G1_winter_mean(1,3)-1)*100,'square','linestyle','none','markersize',4,'markerfacecolor',[0 0.4470 0.7410],'markeredgecolor',[0 0.4470 0.7410]);
plot((G1_pts_days(:,3)/G1_winter_mean(1,3)-1)*100,'square','linestyle','none','markersize',4,'markerfacecolor',[0.8500 0.3250 0.0980],'markeredgecolor',[0.8500 0.3250 0.0980]);



figure('units','centimeters','position',[0 0 35 20]);

subplot(231)
plot(G1_pts_days(:,1),'o','linestyle','none','markersize',4,'markerfacecolor','k','markeredgecolor','k');hold on
plot(G1_pts_days(:,2),'^','markersize',4,'markerfacecolor',[0.6 0.6 0.6],'markeredgecolor',[0.6 0.6 0.6]);
plot(G1_pts_days(:,3),'square','linestyle','none','markersize',4,'markerfacecolor',[0.8500 0.3250 0.0980],'markeredgecolor',[0.8500 0.3250 0.0980]);
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[0:50:400])
title('Glacier 1','fontsize',14)
ylim([0 400])
set(gca,'fontsize',12)
ylabel('Velocity (m yr^{-1})','fontsize',14,'fontweight','bold')

%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

%fill([220,365,365,220],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','--','EdgeColor',[0.5 0.5 0.5])
%fill([0,110,110,0],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','--','EdgeColor',[0.5 0.5 0.5])

subplot(232)
plot(G2_pts_days(:,1),'o','linestyle','none','markersize',4,'markerfacecolor','k','markeredgecolor','k');hold on
plot(G2_pts_days(:,2),'^','markersize',4,'markerfacecolor',[0.6 0.6 0.6],'markeredgecolor',[0.6 0.6 0.6]);
plot(G2_pts_days(:,3),'square','linestyle','none','markersize',4,'markerfacecolor',[0.8500 0.3250 0.0980],'markeredgecolor',[0.8500 0.3250 0.0980]);
title('Glacier 2','fontsize',14)
ylim([0 400])
set(gca,'fontsize',12)
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[0:50:400])
xlabel('Days of year','fontsize',16,'fontweight','bold')
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

subplot(233)
plot(G3_pts_days(:,1),'o','linestyle','none','markersize',4,'markerfacecolor','k','markeredgecolor','k');hold on
plot(G3_pts_days(:,2),'^','markersize',4,'markerfacecolor',[0.6 0.6 0.6],'markeredgecolor',[0.6 0.6 0.6]);
plot(G3_pts_days(:,3),'square','linestyle','none','markersize',4,'markerfacecolor',[0.8500 0.3250 0.0980],'markeredgecolor',[0.8500 0.3250 0.0980]);
title('Glacier 3','fontsize',14)
ylim([0 400])
set(gca,'fontsize',12)
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[0:50:400])
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])


subplot(2,3,4.5)
plot(G4_pts_days(:,1),'o','linestyle','none','markersize',4,'markerfacecolor','k','markeredgecolor','k');hold on
plot(G4_pts_days(:,2),'^','markersize',4,'markerfacecolor',[0.6 0.6 0.6],'markeredgecolor',[0.6 0.6 0.6]);
plot(G4_pts_days(:,3),'square','linestyle','none','markersize',4,'markerfacecolor',[0.8500 0.3250 0.0980],'markeredgecolor',[0.8500 0.3250 0.0980]);
title('Glacier 4','fontsize',14)
ylim([0 400])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[0:50:400])
set(gca,'fontsize',12)
ylabel('Velocity (m yr^{-1})','fontsize',14,'fontweight','bold')
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

subplot(2,3,5.5)
plot(G5_pts_days(:,1),'o','linestyle','none','markersize',4,'markerfacecolor','k','markeredgecolor','k');hold on
plot(G5_pts_days(:,2),'^','markersize',4,'markerfacecolor',[0.6 0.6 0.6],'markeredgecolor',[0.6 0.6 0.6]);
plot(G5_pts_days(:,3),'square','linestyle','none','markersize',4,'markerfacecolor',[0.8500 0.3250 0.0980],'markeredgecolor',[0.8500 0.3250 0.0980]);
title('Glacier 5','fontsize',14)
ylim([0 400])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[0:50:400])
set(gca,'fontsize',12)
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

annotation(gcf,'textbox',[0.46 0.01354 0.15 0.06],'String',{'Days of year'},'LineStyle','none','fontweight','bold','FontSize',16,'FitBoxToText','on');

legend('P1','P2','P3','location','northeast');

print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Pts_Russel_DaysOfYear
%print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Pts_Russel_DaysOfYear_Shadow



%%
%%%% Plot dividing winter mean
G1_winter_mean(1,1)=nanmean([G1_pts_days(1:110,1);G1_pts_days(220:365,1)]);
G1_winter_mean(1,2)=nanmean([G1_pts_days(1:110,2);G1_pts_days(220:365,2)]);
G1_winter_mean(1,3)=nanmean([G1_pts_days(1:110,3);G1_pts_days(220:365,3)]);

G2_winter_mean(1,1)=nanmean([G2_pts_days(1:110,1);G2_pts_days(220:365,1)]);
G2_winter_mean(1,2)=nanmean([G2_pts_days(1:110,2);G2_pts_days(220:365,2)]);
G2_winter_mean(1,3)=nanmean([G2_pts_days(1:110,3);G2_pts_days(220:365,3)]);

G3_winter_mean(1,1)=nanmean([G3_pts_days(1:110,1);G3_pts_days(220:365,1)]);
G3_winter_mean(1,2)=nanmean([G3_pts_days(1:110,2);G3_pts_days(220:365,2)]);
G3_winter_mean(1,3)=nanmean([G3_pts_days(1:110,3);G3_pts_days(220:365,3)]);

G4_winter_mean(1,1)=nanmean([G4_pts_days(1:110,1);G4_pts_days(220:365,1)]);
G4_winter_mean(1,2)=nanmean([G4_pts_days(1:110,2);G4_pts_days(220:365,2)]);
G4_winter_mean(1,3)=nanmean([G4_pts_days(1:110,3);G4_pts_days(220:365,3)]);

G5_winter_mean(1,1)=nanmean([G5_pts_days(1:110,1);G5_pts_days(220:365,1)]);
G5_winter_mean(1,2)=nanmean([G5_pts_days(1:110,2);G5_pts_days(220:365,2)]);
G5_winter_mean(1,3)=nanmean([G5_pts_days(1:110,3);G5_pts_days(220:365,3)]);


figure('units','centimeters','position',[0 0 35 20]);

subplot(231)
plot(G1_pts_days(:,1)-G1_winter_mean(1,1),'k','linewidth',2);hold on
plot(G1_pts_days(:,2)-G1_winter_mean(1,2),'color',[0.6 0.6 0.6],'linewidth',2);
title('Glacier 1','fontsize',14)
plot([0 400],[0 0],'linestyle','--','color',[0.7 0.7 0.7])
ylim([-80 160])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[-50:50:200])
set(gca,'fontsize',12)
ylabel('Speed-up relative to winter (m yr^{-1})','fontsize',12,'fontweight','bold')

%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

%fill([220,365,365,220],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','--','EdgeColor',[0.5 0.5 0.5])
%fill([0,110,110,0],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','--','EdgeColor',[0.5 0.5 0.5])

subplot(232)
plot(G2_pts_days(:,1)-G2_winter_mean(1,1),'k','linewidth',2);hold on
plot(G2_pts_days(:,2)-G2_winter_mean(1,2),'color',[0.6 0.6 0.6],'linewidth',2);
plot([0 400],[0 0],'linestyle','--','color',[0.7 0.7 0.7])
title('Glacier 2','fontsize',14)
ylim([-80 160])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[-50:50:200])
set(gca,'fontsize',12)
xlabel('Days of year','fontsize',16,'fontweight','bold')
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

subplot(233)
plot(G3_pts_days(:,1)-G3_winter_mean(1,1),'k','linewidth',2);hold on
plot(G3_pts_days(:,2)-G3_winter_mean(1,2),'color',[0.6 0.6 0.6],'linewidth',2);
plot([0 400],[0 0],'linestyle','--','color',[0.7 0.7 0.7])
title('Glacier 3','fontsize',14)
ylim([-80 160])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[-50:50:200])
set(gca,'fontsize',12)
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])


subplot(2,3,4.5)
plot(G4_pts_days(:,1)-G4_winter_mean(1,1),'k','linewidth',2);hold on
plot(G4_pts_days(:,2)-G4_winter_mean(1,2),'color',[0.6 0.6 0.6],'linewidth',2);
plot([0 400],[0 0],'linestyle','--','color',[0.7 0.7 0.7])
title('Glacier 4','fontsize',14)
ylim([-80 160])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[-50:50:200])
set(gca,'fontsize',12)
ylabel('Speed-up relative to winter (m yr^{-1})','fontsize',12,'fontweight','bold')
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

subplot(2,3,5.5)
plot(G5_pts_days(:,1)-G5_winter_mean(1,1),'k','linewidth',2);hold on
plot(G5_pts_days(:,2)-G5_winter_mean(1,2),'color',[0.6 0.6 0.6],'linewidth',2);
plot([0 400],[0 0],'linestyle','--','color',[0.7 0.7 0.7])
title('Glacier 5','fontsize',14)
ylim([-80 160])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[-50:50:200])
set(gca,'fontsize',12)
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

annotation(gcf,'textbox',[0.46 0.01354 0.15 0.06],'String',{'Days of year'},'LineStyle','none','fontweight','bold','FontSize',16,'FitBoxToText','on');

legend('P1','P2','location','northeast');

print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Pts_Russel_DaysOfYear_Vel_minus_Winter
%print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Pts_Russel_DaysOfYear_Shadow




figure('units','centimeters','position',[0 0 35 20]);

subplot(231)
plot((G1_pts_days(:,1)/G1_winter_mean(1,1)-1)*100,'o','linestyle','none','markersize',4,'markerfacecolor','k','markeredgecolor','k');hold on
plot((G1_pts_days(:,2)/G1_winter_mean(1,2)-1)*100,'^','markersize',4,'markerfacecolor',[0.6 0.6 0.6],'markeredgecolor',[0.6 0.6 0.6]);
%plot((G1_pts_days(:,3)/G1_winter_mean(1,3)-1)*100,'square','linestyle','none','markersize',4,'markerfacecolor',[0 0.4470 0.7410],'markeredgecolor',[0 0.4470 0.7410]);
plot((G1_pts_days(:,3)/G1_winter_mean(1,3)-1)*100,'square','linestyle','none','markersize',4,'markerfacecolor',[0.8500 0.3250 0.0980],'markeredgecolor',[0.8500 0.3250 0.0980]);

title('Glacier 1','fontsize',14)
plot([0 400],[0 0],'linestyle','--','color',[0.7 0.7 0.7])
ylim([-50 120])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[-40:20:120])
set(gca,'fontsize',12)
ylabel('Speed-up relative to winter (%)','fontsize',12,'fontweight','bold')

%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

%fill([220,365,365,220],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','--','EdgeColor',[0.5 0.5 0.5])
%fill([0,110,110,0],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','--','EdgeColor',[0.5 0.5 0.5])

subplot(232)
plot((G2_pts_days(:,1)/G2_winter_mean(1,1)-1)*100,'o','linestyle','none','markersize',4,'markerfacecolor','k','markeredgecolor','k');hold on
plot((G2_pts_days(:,2)/G2_winter_mean(1,2)-1)*100,'^','markersize',4,'markerfacecolor',[0.6 0.6 0.6],'markeredgecolor',[0.6 0.6 0.6]);
%plot((G1_pts_days(:,3)/G1_winter_mean(1,3)-1)*100,'square','linestyle','none','markersize',4,'markerfacecolor',[0 0.4470 0.7410],'markeredgecolor',[0 0.4470 0.7410]);
plot((G2_pts_days(:,3)/G2_winter_mean(1,3)-1)*100,'square','linestyle','none','markersize',4,'markerfacecolor',[0.8500 0.3250 0.0980],'markeredgecolor',[0.8500 0.3250 0.0980]);
title('Glacier 2','fontsize',14)
plot([0 400],[0 0],'linestyle','--','color',[0.7 0.7 0.7])
ylim([-50 120])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[-40:20:120])
set(gca,'fontsize',12)
xlabel('Days of year','fontsize',16,'fontweight','bold')
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

subplot(233)
plot((G3_pts_days(:,1)/G3_winter_mean(1,1)-1)*100,'o','linestyle','none','markersize',4,'markerfacecolor','k','markeredgecolor','k');hold on
plot((G3_pts_days(:,2)/G3_winter_mean(1,2)-1)*100,'^','markersize',4,'markerfacecolor',[0.6 0.6 0.6],'markeredgecolor',[0.6 0.6 0.6]);
%plot((G1_pts_days(:,3)/G1_winter_mean(1,3)-1)*100,'square','linestyle','none','markersize',4,'markerfacecolor',[0 0.4470 0.7410],'markeredgecolor',[0 0.4470 0.7410]);
plot((G3_pts_days(:,3)/G3_winter_mean(1,3)-1)*100,'square','linestyle','none','markersize',4,'markerfacecolor',[0.8500 0.3250 0.0980],'markeredgecolor',[0.8500 0.3250 0.0980]);
title('Glacier 3','fontsize',14)
plot([0 400],[0 0],'linestyle','--','color',[0.7 0.7 0.7])
ylim([-50 120])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[-40:20:120])
set(gca,'fontsize',12)
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])


subplot(2,3,4.5)
plot((G4_pts_days(:,1)/G4_winter_mean(1,1)-1)*100,'o','linestyle','none','markersize',4,'markerfacecolor','k','markeredgecolor','k');hold on
plot((G4_pts_days(:,2)/G4_winter_mean(1,2)-1)*100,'^','markersize',4,'markerfacecolor',[0.6 0.6 0.6],'markeredgecolor',[0.6 0.6 0.6]);
%plot((G1_pts_days(:,3)/G1_winter_mean(1,3)-1)*100,'square','linestyle','none','markersize',4,'markerfacecolor',[0 0.4470 0.7410],'markeredgecolor',[0 0.4470 0.7410]);
plot((G4_pts_days(:,3)/G4_winter_mean(1,3)-1)*100,'square','linestyle','none','markersize',4,'markerfacecolor',[0.8500 0.3250 0.0980],'markeredgecolor',[0.8500 0.3250 0.0980]);
title('Glacier 4','fontsize',14)
plot([0 400],[0 0],'linestyle','--','color',[0.7 0.7 0.7])
ylim([-50 120])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[-40:20:120])
set(gca,'fontsize',12)
ylabel('Speed-up relative to winter (%)','fontsize',12,'fontweight','bold')
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

subplot(2,3,5.5)
plot((G5_pts_days(:,1)/G5_winter_mean(1,1)-1)*100,'o','linestyle','none','markersize',4,'markerfacecolor','k','markeredgecolor','k');hold on
plot((G5_pts_days(:,2)/G5_winter_mean(1,2)-1)*100,'^','markersize',4,'markerfacecolor',[0.6 0.6 0.6],'markeredgecolor',[0.6 0.6 0.6]);
%plot((G1_pts_days(:,3)/G1_winter_mean(1,3)-1)*100,'square','linestyle','none','markersize',4,'markerfacecolor',[0 0.4470 0.7410],'markeredgecolor',[0 0.4470 0.7410]);
plot((G5_pts_days(:,3)/G5_winter_mean(1,3)-1)*100,'square','linestyle','none','markersize',4,'markerfacecolor',[0.8500 0.3250 0.0980],'markeredgecolor',[0.8500 0.3250 0.0980]);
title('Glacier 5','fontsize',14)
plot([0 400],[0 0],'linestyle','--','color',[0.7 0.7 0.7])
ylim([-50 120])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[-40:20:120])
set(gca,'fontsize',12)
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

annotation(gcf,'textbox',[0.46 0.01354 0.15 0.06],'String',{'Days of year'},'LineStyle','none','fontweight','bold','FontSize',16,'FitBoxToText','on');

legend('P1','P2','P3','location','northeast');

print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Pts_Russel_DaysOfYear_Divided_Winter
%print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Pts_Russel_DaysOfYear_Shadow



%% Mean relative velocity for the 3 points:

P1_relativeWinter=[(G1_pts_days(:,1)/G1_winter_mean(1,1)-1)*100, (G2_pts_days(:,1)/G2_winter_mean(1,1)-1)*100,(G3_pts_days(:,1)/G3_winter_mean(1,1)-1)*100,(G4_pts_days(:,1)/G4_winter_mean(1,1)-1)*100,(G5_pts_days(:,1)/G5_winter_mean(1,1)-1)*100];
P1_relativeWinter_mean=nanmean(P1_relativeWinter,2);

P2_relativeWinter=[(G1_pts_days(:,2)/G1_winter_mean(2)-1)*100, (G2_pts_days(:,2)/G2_winter_mean(2)-1)*100,(G3_pts_days(:,2)/G3_winter_mean(2)-1)*100,(G4_pts_days(:,2)/G4_winter_mean(2)-1)*100,(G5_pts_days(:,2)/G5_winter_mean(2)-1)*100];
P2_relativeWinter_mean=nanmean(P2_relativeWinter,2);

P3_relativeWinter=[(G1_pts_days(:,3)/G1_winter_mean(3)-1)*100, (G2_pts_days(:,3)/G2_winter_mean(3)-1)*100,(G3_pts_days(:,3)/G3_winter_mean(3)-1)*100,(G4_pts_days(:,3)/G4_winter_mean(3)-1)*100,(G5_pts_days(:,3)/G5_winter_mean(3)-1)*100];
P3_relativeWinter_mean=nanmean(P3_relativeWinter,2);


figure('units','centimeters','position',[0 0 12 12]);
plot(P1_relativeWinter_mean,'o','linestyle','none','markersize',4,'markerfacecolor','k','markeredgecolor','k');hold on
plot(P2_relativeWinter_mean,'^','markersize',4,'markerfacecolor',[0.6 0.6 0.6],'markeredgecolor',[0.6 0.6 0.6]);
%plot((G1_pts_days(:,3)/G1_winter_mean(1,3)-1)*100,'square','linestyle','none','markersize',4,'markerfacecolor',[0 0.4470 0.7410],'markeredgecolor',[0 0.4470 0.7410]);
plot(P3_relativeWinter_mean,'square','linestyle','none','markersize',4,'markerfacecolor',[0.8500 0.3250 0.0980],'markeredgecolor',[0.8500 0.3250 0.0980]);
%title('Glacier 5','fontsize',14)
plot([0 400],[0 0],'linestyle','--','color',[0.7 0.7 0.7])
ylim([-40 100])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[-40:20:120])
set(gca,'fontsize',12)
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])
xlabel('Days of year','fontsize',14,'fontweight','bold')
ylabel('Speed-up relative to winter (%)','fontsize',14,'fontweight','bold')

legend('P1','P2','P3','location','northeast');

print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Pts_Russel_DaysOfYear_Relative_to_Winter_mean


figure('units','centimeters','position',[0 0 36 12]);
subplot(131)
plot(P1_relativeWinter_mean,'o','linestyle','none','markersize',4,'markerfacecolor','k','markeredgecolor','k');hold on
%title('Glacier 5','fontsize',14)
plot([0 400],[0 0],'linestyle','--','color',[0.7 0.7 0.7])
ylim([-40 100])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[-40:20:120])
set(gca,'fontsize',12)
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])
ylabel('Speed-up relative to winter (%)','fontsize',14,'fontweight','bold')
title('P1','fontsize',14)

subplot(132)
plot(P2_relativeWinter_mean,'^','markersize',4,'markerfacecolor',[0.6 0.6 0.6],'markeredgecolor',[0.6 0.6 0.6]);hold on;
xlabel('Days of year','fontsize',14,'fontweight','bold')
plot([0 400],[0 0],'linestyle','--','color',[0.7 0.7 0.7])
ylim([-40 100])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[-40:20:120])
set(gca,'fontsize',12)
title('P2','fontsize',14)

%plot((G1_pts_days(:,3)/G1_winter_mean(1,3)-1)*100,'square','linestyle','none','markersize',4,'markerfacecolor',[0 0.4470 0.7410],'markeredgecolor',[0 0.4470 0.7410]);
subplot(133)
plot(P3_relativeWinter_mean,'square','linestyle','none','markersize',4,'markerfacecolor',[0.8500 0.3250 0.0980],'markeredgecolor',[0.8500 0.3250 0.0980]);hold on;
plot([0 400],[0 0],'linestyle','--','color',[0.7 0.7 0.7])
ylim([-40 100])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[-40:20:120])
set(gca,'fontsize',12)
title('P3','fontsize',14)


print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Pts_Russel_DaysOfYear_Relative_to_Winter_mean_subplots


 








[latRussel,lonRussel] = ps2ll(YRussel,XRussel,'TrueLat',70,'meridian',-45); 

[latRussel,lonRussel] = projinv(info_Russel,XRussel,YRussel);
[x_la,y_lo] = projfwd(info_Russel,lat,lon);



%%% Mean
figure('units','centimeters','position',[0 0 12 12]);
    set(gcf,'color','w')
    
    ax1 = axes; hold on;
h1=imagesc(ax1,xSAR,ySAR,flipud(SAR_mosaic));
set(ax1,'Ydir','Normal')
daspect([1000 1000 1])

hold on;
%axis off
co1=plot(ax1,X_coast,Y_coast,'k');



ax2 = axes;
h=imagesc(ax2,xRussel, yRussel,Vel_Russel_mean); tt=double(~isnan(Vel_Russel_mean)); set(h,'AlphaData', tt*0.65);
daspect([1000 1000 1])
%axis off

% Link them together
linkaxes([ax1,ax2])
% Hide the top axes
ax2.Visible = 'off';
ax2.XTick = [];
ax2.YTick = [];
% Give each one its own colormap
colormap(ax1,'gray')

CT=cbrewer('div', 'RdYlGn',90);
colormap(ax2,flip(CT))

caxis(ax1,[-30 -3.44625])
caxis(ax2,[0 300]);

xlim(ax1,[-250000 -50000])
ylim(ax1,[-2550000 -2350000])

xlim(ax2,[-250000 -50000])
ylim(ax2,[-2550000 -2350000])
% Then add colorbars and get everything lined up
set([ax1,ax2],'Position',[.17 .11 .685 .815]);
%cb1 = colorbar(ax1,'Position',[.05 .11 .0675 .815]);
%grid(ax2,'on')
%grid(ax1,'on')
%title(ax1,'Mean','fontsize',14)

%xlabel(cb2,'[m yr^{-1}]','fontsize',14)
    c1 = colorbar(ax2,'south','Fontsize',8,'Fontname','Arial');
    xlabel(c1,'[m yr^{-1}]','HorizontalAlignment','Center','position',[10 0.2])
    set(c1,'position',[0.55 0.2 0.25 0.05])
   % set(c1,'Xtick',[-7:1:7],'XTicklabel',{'','6','','4','','2','','0','','-2','','-4','','-6',''})
export_fig('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Mean_Russel.png','-dpng','-r600');



ax3=axesm('MapProjection','mercator', 'MapLatLimit',[66 68],'MapLonLimit',[-80 -20]);
h=imagesc(ax3,xRussel, yRussel,Vel_Russel_mean); tt=double(~isnan(Vel_Russel_mean)); set(h,'AlphaData', tt*0.65);
h=mapshow(xRussel, yRussel,double(Vel_Russel_mean));
X = get(h,'XData'); 
Y = get(h,'YData');
f=isnan(Vel_Russel_mean);
f(end+1,:)=true;
f(:,end+1)=true;
X(f)=nan;
Y(f)=nan;
set(h,'XData',X,'YData',Y);



plotm(x,y)



%    [X,Y]=meshgrid(1:11);
figure; hold on;
plot(XRussel,YRussel,'k');
plot(YRussel,XRussel,'k');axis off
% I=(rand(11));
% surface(I);
h=linspace(0.5,1,64);
h=[h',h',h'];
set(gcf,'Colormap',h);
N=100:-1:1;q=1;
x=linspace(1.5,10.5,10);
y=linspace(1.5,10.5,10);
for n=1:10
    for p=1:10
        text(y(n)-.5,x(p),num2str(N(q)),'FontWeight','bold');
        q=q+1;
    end
end

x=linspace(min(xRussel),max(xRussel),50000);
y=linspace(min(yRussel),max(yRussel),50000);

figure; line(x,y),'k')



xlim([-250000 -50000])
ylim([-2550000 -2350000])




%%
%%% Load Cryosat elevation change

load('/nfs/a59/cryosat/output/py10ts/gis_smb_v2/cs_cumdz_stack_to0817.mat','cs_cumdz_stack','ts_midpt_sampling_vec','gridx','gridy','cs_z_stack');

load('/nfs/a59/cryosat/output/py10ts/gis_dhdt/mats/model_filled_dhdt.mat','power_correct_dzdt_grc_vfilled_25kmsm_gr');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% where:
% 
% gridx/gridy = x/y grids
% 
% cs_cumdz_stack = monthly cumulative elevation change stack at 5 km
% 
% ts_midpt_sampling_vec = time series vector
% 
% In all my plots I smooth the time series using a Gaussian with a 6 month window
%  
% To get ice thickness just subtract the bedrock height from each of the monthly grids.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
[tom_mask,Rcryo]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/tom_mask.tif');
clear tom_mask

% Mask_Cryosat=shaperead('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Tom_mask/Altimetry_mask_polygon.shp');
% X_mask_cryosat=


[Y,M] = meshgrid(2010:2017, 1:12);
time_cryo = datenum([Y(:), M(:), ones(numel(Y),1)]);

%time_cryo=datenum({'01082010': '01102017'],'ddmmyyy');


% bedmap

cd /nfs/a59/eeagdl/DATABASE/GREENLAND/Bed_Map

ncdisp('/nfs/a59/eeagdl/DATABASE/GREENLAND/BedMachine_V3/BedMachineGreenland-2017-09-20.nc');
x_Bed_GRIS=ncread('/nfs/a59/eeagdl/DATABASE/GREENLAND/BedMachine_V3/BedMachineGreenland-2017-09-20.nc','x');
x_Bed_GRIS=double(x_Bed_GRIS);

y_Bed_GRIS=ncread('/nfs/a59/eeagdl/DATABASE/GREENLAND/BedMachine_V3/BedMachineGreenland-2017-09-20.nc','y');
y_Bed_GRIS=double(y_Bed_GRIS);

Bed_GRIS=ncread('/nfs/a59/eeagdl/DATABASE/GREENLAND/BedMachine_V3/BedMachineGreenland-2017-09-20.nc','bed');


%% Flux gates per elevation:
%%%%%%%%%%%%%%%
%%% Straight line gates
IFlux_g600_SLine=shaperead('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Profiles/IFlux_gate_600m_SLine_pts.shp');
X_g600_SLine=extractfield(IFlux_g600_SLine,'X');
Y_g600_SLine=extractfield(IFlux_g600_SLine,'Y');

IFlux_g700_SLine=shaperead('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Profiles/IFlux_gate_700m_SLine_pts.shp');
X_g700_SLine=extractfield(IFlux_g700_SLine,'X');
Y_g700_SLine=extractfield(IFlux_g700_SLine,'Y');

IFlux_g800_SLine=shaperead('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Profiles/IFlux_gate_800m_SLine_pts.shp');
X_g800_SLine=extractfield(IFlux_g800_SLine,'X');
Y_g800_SLine=extractfield(IFlux_g800_SLine,'Y');

IFlux_g900_SLine=shaperead('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Profiles/IFlux_gate_900m_SLine_pts.shp');
X_g900_SLine=extractfield(IFlux_g900_SLine,'X');
Y_g900_SLine=extractfield(IFlux_g900_SLine,'Y');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IFlux_g600=shaperead('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Profiles/IFlux_gate_600m_pts.shp');
X_g600=extractfield(IFlux_g600,'X');
Y_g600=extractfield(IFlux_g600,'Y');

IFlux_g650=shaperead('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Profiles/IFlux_gate_650m_pts.shp');
X_g650=extractfield(IFlux_g650,'X');
Y_g650=extractfield(IFlux_g650,'Y');

IFlux_g700=shaperead('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Profiles/IFlux_gate_700m_pts.shp');
X_g700=extractfield(IFlux_g700,'X');
Y_g700=extractfield(IFlux_g700,'Y');

IFlux_g750=shaperead('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Profiles/IFlux_gate_750m_pts.shp');
X_g750=extractfield(IFlux_g750,'X');
Y_g750=extractfield(IFlux_g750,'Y');

IFlux_g800=shaperead('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Profiles/IFlux_gate_800m_pts.shp');
X_g800=extractfield(IFlux_g800,'X');
Y_g800=extractfield(IFlux_g800,'Y');

IFlux_g850=shaperead('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Profiles/IFlux_gate_850m_pts.shp');
X_g850=extractfield(IFlux_g850,'X');
Y_g850=extractfield(IFlux_g850,'Y');

IFlux_g900=shaperead('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Profiles/IFlux_gate_900m_pts.shp');
X_g900=extractfield(IFlux_g900,'X');
Y_g900=extractfield(IFlux_g900,'Y');


% plot(X_g600,Y_g600); hold on
% plot(X_g650,Y_g650);
% plot(X_g700,Y_g700);
% plot(X_g750,Y_g750);
% plot(X_g800,Y_g800);
% plot(X_g850,Y_g850);
% plot(X_g900,Y_g900);

% GIMP

[gimp,Rgimp]=geotiffread('/nfs/a59/eeagdl/DATABASE/GREENLAND/GIMP_DEM/gimpdem_90m.tif');

% BedMachine V3


[Bed_GRIS,R_bed]=geotiffread('/nfs/a59/eeagdl/DATABASE/GREENLAND/BedMachine_V3/BedMachineV3.tif');


% Extract elevation
Elev_600=profile_ext_mean(X_g600,Y_g600,gimp,Rgimp,5);
Elev_650=profile_ext_mean(X_g650,Y_g650,gimp,Rgimp,5);
Elev_700=profile_ext_mean(X_g700,Y_g700,gimp,Rgimp,5);
Elev_750=profile_ext_mean(X_g750,Y_g750,gimp,Rgimp,5);
Elev_800=profile_ext_mean(X_g800,Y_g800,gimp,Rgimp,5);
Elev_850=profile_ext_mean(X_g850,Y_g850,gimp,Rgimp,5);
Elev_900=profile_ext_mean(X_g900,Y_g900,gimp,Rgimp,5);

Bed_600=profile_ext_mean(X_g600,Y_g600,Bed_GRIS,R_bed,5);
Bed_650=profile_ext_mean(X_g650,Y_g650,Bed_GRIS,R_bed,5);
Bed_700=profile_ext_mean(X_g700,Y_g700,Bed_GRIS,R_bed,5);
Bed_750=profile_ext_mean(X_g750,Y_g750,Bed_GRIS,R_bed,5);
Bed_800=profile_ext_mean(X_g800,Y_g800,Bed_GRIS,R_bed,5);
Bed_850=profile_ext_mean(X_g850,Y_g850,Bed_GRIS,R_bed,5);
Bed_900=profile_ext_mean(X_g900,Y_g900,Bed_GRIS,R_bed,5);

%%% Bed and Elevation for the Slines:

Elev_600_SLine=profile_ext_mean_size_def(X_g600_SLine,Y_g600_SLine,gimp,Rgimp,5,size(X_g600_SLine,2));
Elev_700_SLine=profile_ext_mean_size_def(X_g700_SLine,Y_g700_SLine,gimp,Rgimp,5,size(X_g700_SLine,2));
Elev_800_SLine=profile_ext_mean_size_def(X_g800_SLine,Y_g800_SLine,gimp,Rgimp,5,size(X_g800_SLine,2));
Elev_900_SLine=profile_ext_mean_size_def(X_g900_SLine,Y_g900_SLine,gimp,Rgimp,5,size(X_g900_SLine,2));

Bed_600_SLine=profile_ext_mean_size_def(X_g600_SLine,Y_g600_SLine,Bed_GRIS,R_bed,5,size(X_g600_SLine,2));
Bed_700_SLine=profile_ext_mean_size_def(X_g700_SLine,Y_g700_SLine,Bed_GRIS,R_bed,5,size(X_g700_SLine,2));
Bed_800_SLine=profile_ext_mean_size_def(X_g800_SLine,Y_g800_SLine,Bed_GRIS,R_bed,5,size(X_g800_SLine,2));
Bed_900_SLine=profile_ext_mean_size_def(X_g900_SLine,Y_g900_SLine,Bed_GRIS,R_bed,5,size(X_g900_SLine,2));


% 2455
% 2319
% 4320
% 4863
% 10352
% 6705
% 7635

dist_600=(120897/(size(X_g600,2)))*-2455:(120897/(size(X_g600,2)-1)):(120897/(size(X_g600,2)))*(size(X_g600,2)-2455);

dist_650=(75162/(size(X_g650,2)))*-2319:(75162/(size(X_g650,2)-1)):(75162/(size(X_g650,2)))*(size(X_g650,2)-2319);

dist_700=(89885/(size(X_g700,2)))*-4320:(89885/(size(X_g700,2)-1)):(89885/(size(X_g700,2)))*(size(X_g700,2)-4320);

dist_750=(73579/(size(X_g750,2)))*-4863:(73579/(size(X_g750,2)-1)):(73579/(size(X_g750,2)))*(size(X_g750,2)-4863);

dist_800=(98713/(size(X_g800,2)))*-10352:(98713/(size(X_g800,2)-1)):(98713/(size(X_g800,2)))*(size(X_g800,2)-10352);

dist_850=(67725/(size(X_g850,2)))*-6705:(67725/(size(X_g850,2)-1)):(67725/(size(X_g850,2)))*(size(X_g850,2)-6705);

dist_900=(86318/(size(X_g900,2)))*-7635:(86318/(size(X_g900,2)-1)):(86318/(size(X_g900,2)))*(size(X_g900,2)-7635);

% dist_600=120897;
% dist_650=75162;
% dist_700=89885;
% dist_750=73579;
% dist_800=98713;
% dist_850=67725;
% dist_900=86318;



%%%%%%%%%%%5 Distance along the SLine gates 

dist_600_SLine=0:(66076.4/(size(X_g600_SLine,2)-1)):66076.4;

dist_700_SLine=0:(64046.2/(size(X_g700_SLine,2)-1)):64046.2;

dist_800_SLine=0:(61306.1/(size(X_g800_SLine,2)-1)):61306.1;

dist_900_SLine=0:(56967.7/(size(X_g900_SLine,2)-1)):56967.7;

% dist_600_SLine=66076.4;
% dist_700_SLine=64046.2;
% dist_800_SLine=61306.1;
% dist_900_SLine=56967.7;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(dist_600,Elev_600);hold on;
plot(dist_650,Elev_650);
plot(dist_700,Elev_700);
plot(dist_750,Elev_750);
plot(dist_800,Elev_800);
plot(dist_850,Elev_850);
plot(dist_900,Elev_900);

plot(dist_600,Bed_600);hold on;
plot(dist_650,Bed_650);
plot(dist_700,Bed_700);
plot(dist_750,Bed_750);
plot(dist_800,Bed_800);
plot(dist_850,Bed_850);
plot(dist_900,Bed_900);




Vel_winter_600=profile_ext_mean(X_g600,Y_g600,winter_Russel,R_russel,5);
Vel_winter_650=profile_ext_mean(X_g650,Y_g650,winter_Russel,R_russel,5);
Vel_winter_700=profile_ext_mean(X_g700,Y_g700,winter_Russel,R_russel,5);
Vel_winter_750=profile_ext_mean(X_g750,Y_g750,winter_Russel,R_russel,5);
Vel_winter_800=profile_ext_mean(X_g800,Y_g800,winter_Russel,R_russel,5);
Vel_winter_850=profile_ext_mean(X_g850,Y_g850,winter_Russel,R_russel,5);
Vel_winter_900=profile_ext_mean(X_g900,Y_g900,winter_Russel,R_russel,5);

Vel_summer_600=profile_ext_mean(X_g600,Y_g600,summer_Russel,R_russel,5);
Vel_summer_650=profile_ext_mean(X_g650,Y_g650,summer_Russel,R_russel,5);
Vel_summer_700=profile_ext_mean(X_g700,Y_g700,summer_Russel,R_russel,5);
Vel_summer_750=profile_ext_mean(X_g750,Y_g750,summer_Russel,R_russel,5);
Vel_summer_800=profile_ext_mean(X_g800,Y_g800,summer_Russel,R_russel,5);
Vel_summer_850=profile_ext_mean(X_g850,Y_g850,summer_Russel,R_russel,5);
Vel_summer_900=profile_ext_mean(X_g900,Y_g900,summer_Russel,R_russel,5);

plot(dist_600,Vel_winter_600);hold on;
plot(dist_650,Vel_winter_650);
plot(dist_700,Vel_winter_700);
plot(dist_750,Vel_winter_750);
plot(dist_800,Vel_winter_800);
plot(dist_850,Vel_winter_850);
plot(dist_900,Vel_winter_900);

plot(dist_600,Vel_summer_600);hold on;
plot(dist_650,Vel_summer_650);
plot(dist_700,Vel_summer_700);
plot(dist_750,Vel_summer_750);
plot(dist_800,Vel_summer_800);
plot(dist_850,Vel_summer_850);
plot(dist_900,Vel_summer_900);



%%%%%% Sline 
Vel_winter_600_SLine=profile_ext_mean_size_def(X_g600_SLine,Y_g600_SLine,winter_Russel,R_russel,5,size(X_g600_SLine,2));
Vel_winter_700_SLine=profile_ext_mean_size_def(X_g700_SLine,Y_g700_SLine,winter_Russel,R_russel,5,size(X_g700_SLine,2));
Vel_winter_800_SLine=profile_ext_mean_size_def(X_g800_SLine,Y_g800_SLine,winter_Russel,R_russel,5,size(X_g800_SLine,2));
Vel_winter_900_SLine=profile_ext_mean_size_def(X_g900_SLine,Y_g900_SLine,winter_Russel,R_russel,5,size(X_g900_SLine,2));

Vel_summer_600_SLine=profile_ext_mean_size_def(X_g600_SLine,Y_g600_SLine,summer_Russel,R_russel,5,size(X_g600_SLine,2));
Vel_summer_700_SLine=profile_ext_mean_size_def(X_g700_SLine,Y_g700_SLine,summer_Russel,R_russel,5,size(X_g700_SLine,2));
Vel_summer_800_SLine=profile_ext_mean_size_def(X_g800_SLine,Y_g800_SLine,summer_Russel,R_russel,5,size(X_g800_SLine,2));
Vel_summer_900_SLine=profile_ext_mean_size_def(X_g900_SLine,Y_g900_SLine,summer_Russel,R_russel,5,size(X_g900_SLine,2));

plot(dist_600_SLine,Vel_winter_600_SLine);hold on;
plot(dist_700_SLine,Vel_winter_700_SLine);
plot(dist_800_SLine,Vel_winter_800_SLine);
plot(dist_900_SLine,Vel_winter_900_SLine);

plot(dist_600_SLine,Vel_summer_600_SLine);hold on;
plot(dist_700_SLine,Vel_summer_700_SLine);
plot(dist_800_SLine,Vel_summer_800_SLine);
plot(dist_900_SLine,Vel_summer_900_SLine);



% Interpolating the IB to GIMP resolution and transform to GAMMA format


window=[7 7];
%cs_z_stack_median20x20=movmedian(cs_z_stack,window,'omitnan');

addpath('/nfs/a59/cryosat/output/py10ts/scripts/')

for i=1:87
cs_z_stack_median20x20(:,:,i) = nanmedfilt2(cs_z_stack(:,:,i),window);
end


% figure; h = imagesc(test); set(h,'alphadata',~isnan(test))
% axis xy



for i=1: size(cs_z_stack,3)
Z_600(:,i)=profile_ext_mean(X_g600,Y_g600,flipud(cs_z_stack_median20x20(:,:,i)),Rcryo,1);
Z_650(:,i)=profile_ext_mean(X_g650,Y_g650,flipud(cs_z_stack_median20x20(:,:,i)),Rcryo,1);
Z_700(:,i)=profile_ext_mean(X_g700,Y_g700,flipud(cs_z_stack_median20x20(:,:,i)),Rcryo,1);
Z_750(:,i)=profile_ext_mean(X_g750,Y_g750,flipud(cs_z_stack_median20x20(:,:,i)),Rcryo,1);
Z_800(:,i)=profile_ext_mean(X_g800,Y_g800,flipud(cs_z_stack_median20x20(:,:,i)),Rcryo,1);
Z_850(:,i)=profile_ext_mean(X_g850,Y_g850,flipud(cs_z_stack_median20x20(:,:,i)),Rcryo,1);
Z_900(:,i)=profile_ext_mean(X_g900,Y_g900,flipud(cs_z_stack_median20x20(:,:,i)),Rcryo,1);
end

%  for i=1: size(cs_z_stack,3)
% Z_600(:,i)=profile_ext_mean(X_g600,Y_g600,cs_z_stack(:,:,i),Rcryo,20);
% Z_650(:,i)=profile_ext_mean(X_g650,Y_g650,cs_z_stack(:,:,i),Rcryo,20);
% Z_700(:,i)=profile_ext_mean(X_g700,Y_g700,cs_z_stack(:,:,i),Rcryo,20);
% Z_750(:,i)=profile_ext_mean(X_g750,Y_g750,cs_z_stack(:,:,i),Rcryo,20);
% Z_800(:,i)=profile_ext_mean(X_g800,Y_g800,cs_z_stack(:,:,i),Rcryo,20);
% Z_850(:,i)=profile_ext_mean(X_g850,Y_g850,cs_z_stack(:,:,i),Rcryo,20);
% Z_900(:,i)=profile_ext_mean(X_g900,Y_g900,cs_z_stack(:,:,i),Rcryo,20);
% end


time_cryo = datenum([Y(:), M(:), ones(numel(Y),1)]);


for i=1:size(Z_600,2)
Thick_600(:,i)=Z_600(:,i)-Bed_600;
Thick_650(:,i)=Z_650(:,i)-Bed_650;
Thick_700(:,i)=Z_700(:,i)-Bed_700;
Thick_750(:,i)=Z_750(:,i)-Bed_750;
Thick_800(:,i)=Z_800(:,i)-Bed_800;
Thick_850(:,i)=Z_850(:,i)-Bed_850;
Thick_900(:,i)=Z_900(:,i)-Bed_900;

end

% % Calculate the area under the curve:
% for i=1:size(Z_600,2)
% Area_600(:,i)=trapz(dist_600(1,:)',fillgaps(Thick_600(:,i)));
% Area_650(:,i)=trapz(dist_650(1,:)',fillgaps(Thick_650(:,i)));
% 
% Area_700(:,i)=trapz(dist_700(1,:)',fillgaps(Thick_700(:,i)));
% Area_750(:,i)=trapz(dist_750(1,:)',fillgaps(Thick_750(:,i)));
% 
% Area_800(:,i)=trapz(dist_800(1,:)',fillgaps(Thick_800(:,i)));
% Area_850(:,i)=trapz(dist_850(1,:)',fillgaps(Thick_850(:,i)));
% 
% Area_900(:,i)=trapz(dist_900(1,:)',fillgaps(Thick_900(:,i)));
% 
% end

% Calculate the area under the curve:
for i=1:size(Z_600,2)
 
 try
     k=1;
for j=1:100:size(Thick_600,1)
Area_600(i,k)=trapz(dist_600(1,j:j+99)',fillgaps(Thick_600(j:j+99,i)));
k=k+1;
end
 end

 try
   k=1;  
for j=1:100:size(Thick_650,1)
Area_650(i,k)=trapz(dist_650(1,j:j+99)',fillgaps(Thick_650(j:j+99,i)));
k=k+1;
end
 end

try
  k=1;    
for j=1:100:size(Thick_700,1)
Area_700(i,k)=trapz(dist_700(1,j:j+99)',fillgaps(Thick_700(j:j+99,i)));
k=k+1;
end
end

try
   k=1;
for j=1:100:size(Thick_750,1)
Area_750(i,k)=trapz(dist_750(1,j:j+99)',fillgaps(Thick_750(j:j+99,i)));
k=k+1;
end
end

try
  k=1;   
for j=1:100:size(Thick_800,1)
Area_800(i,k)=trapz(dist_800(1,j:j+99)',fillgaps(Thick_800(j:j+99,i)));
k=k+1;
end
end

try
  k=1;   
for j=1:100:size(Thick_850,1)
Area_850(i,k)=trapz(dist_850(1,j:j+99)',fillgaps(Thick_850(j:j+99,i)));
k=k+1;
end
end

try
  k=1;   
for j=1:100:size(Thick_900,1)
Area_900(i,k)=trapz(dist_900(1,j:j+99)',fillgaps(Thick_900(j:j+99,i)));
k=k+1;
end
end

end

% 
% 
% 
% figure; plot(Area_600(1,:).*Vel_temp(1:end-1)')


[Vel_monthly_mean,t_downsamp] = downsample_ts(Vel_Russel,date_Russel_num,'function','nanmean');

% removing months from 2015 but December: 
Vel_monthly_mean(:,:,1:6)=[];
t_downsamp(1:6)=[];


% Extract monthly Vel profile (along the gate):

j=1;
for i=1:25
  Vel_600(:,i)=profile_ext_mean(X_g600,Y_g600,Vel_monthly_mean(:,:,i),R_russel,5);  
  Vel_650(:,i)=profile_ext_mean(X_g650,Y_g650,Vel_monthly_mean(:,:,i),R_russel,5);
  
  Vel_700(:,i)=profile_ext_mean(X_g700,Y_g700,Vel_monthly_mean(:,:,i),R_russel,5);  
  Vel_750(:,i)=profile_ext_mean(X_g750,Y_g750,Vel_monthly_mean(:,:,i),R_russel,5);
  
  Vel_800(:,i)=profile_ext_mean(X_g800,Y_g800,Vel_monthly_mean(:,:,i),R_russel,5);  
  Vel_850(:,i)=profile_ext_mean(X_g850,Y_g850,Vel_monthly_mean(:,:,i),R_russel,5);

  Vel_900(:,i)=profile_ext_mean(X_g900,Y_g900,Vel_monthly_mean(:,:,i),R_russel,5);  

end


% Mean velocity every 100m:

for i=1:25
 
 try
     k=1;
for j=1:100:size(Vel_600,1)
Vel_600_mean(i,k)=nanmean(Vel_600(j:j+99,i));
k=k+1;
end
 end
 
 try
     k=1;
for j=1:100:size(Vel_650,1)
Vel_650_mean(i,k)=nanmean(Vel_650(j:j+99,i));
k=k+1;
end
 end

try
     k=1;
for j=1:100:size(Vel_700,1)
Vel_700_mean(i,k)=nanmean(Vel_700(j:j+99,i));
k=k+1;
end
 end

try
     k=1;
for j=1:100:size(Vel_750,1)
Vel_750_mean(i,k)=nanmean(Vel_750(j:j+99,i));
k=k+1;
end
 end

try
     k=1;
for j=1:100:size(Vel_800,1)
Vel_800_mean(i,k)=nanmean(Vel_800(j:j+99,i));
k=k+1;
end
end
 
try
     k=1;
for j=1:100:size(Vel_850,1)
Vel_850_mean(i,k)=nanmean(Vel_850(j:j+99,i));
k=k+1;
end
 end

try
     k=1;
for j=1:100:size(Vel_900,1)
Vel_900_mean(i,k)=nanmean(Vel_900(j:j+99,i));
k=k+1;
end
end
 
end



%Flux calculation (Dec_2015 to Dec_2017) j=63 => Dec_2015

j=63;
for i=1:25
Flux_600(i,:)=(Area_600(j,:).*Vel_600_mean(i,:));
Flux_650(i,:)=(Area_650(j,:).*Vel_650_mean(i,:));

Flux_700(i,:)=(Area_700(j,:).*Vel_700_mean(i,:));
Flux_750(i,:)=(Area_750(j,:).*Vel_750_mean(i,:));

Flux_800(i,:)=(Area_800(j,:).*Vel_800_mean(i,:));
Flux_850(i,:)=(Area_850(j,:).*Vel_850_mean(i,:));

Flux_900(i,:)=(Area_900(j,:).*Vel_900_mean(i,:));

j=j+1;
end



% Monthly Discharge (Dec_2015 to Dec_2017)

for i=1:25
Flux_600_monthly(i)=nansum(Flux_600(i,:));
Flux_650_monthly(i)=nansum(Flux_650(i,:));

Flux_700_monthly(i)=nansum(Flux_700(i,:));
Flux_750_monthly(i)=nansum(Flux_750(i,:));

Flux_800_monthly(i)=nansum(Flux_800(i,:));
Flux_850_monthly(i)=nansum(Flux_850(i,:));

Flux_900_monthly(i)=nansum(Flux_900(i,:));


end


% Cumulative discharge (Jan_2016 to Dec_2017)

cum_Flux_600=nansum(Flux_600(1,:));
cum_Flux_650=nansum(Flux_650(1,:));
cum_Flux_700=nansum(Flux_700(1,:));
cum_Flux_750=nansum(Flux_750(1,:));
cum_Flux_800=nansum(Flux_800(1,:));
cum_Flux_850=nansum(Flux_850(1,:));
cum_Flux_900=nansum(Flux_900(1,:));

for i=2:25
cum_Flux_600(i)=[cum_Flux_600(i-1)+nansum(Flux_600(i,:))];
cum_Flux_650(i)=[cum_Flux_650(i-1)+nansum(Flux_650(i,:))];

cum_Flux_700(i)=[cum_Flux_700(i-1)+nansum(Flux_700(i,:))];
cum_Flux_750(i)=[cum_Flux_750(i-1)+nansum(Flux_750(i,:))];

cum_Flux_800(i)=[cum_Flux_800(i-1)+nansum(Flux_800(i,:))];
cum_Flux_850(i)=[cum_Flux_850(i-1)+nansum(Flux_850(i,:))];

cum_Flux_900(i)=[cum_Flux_900(i-1)+nansum(Flux_900(i,:))];


end


time_cryo_Flux=time_cryo(63:end);

Vel_summer_600(1:100:end);


dist_fill=[dist_600(1:100:end-99),fliplr(dist_600(1:100:end-99))];
thick_fill=[fillgaps(Thick_600(1:100:end-99,1));fliplr(fillgaps(Thick_600(1:100:end-99,1)))];

fill(dist_fill',thick_fill,'k');        

figure
pcolor(dist_600(1:100:end-99),fillgaps(Thick_600(1:100:end-99,1)),Flux_grid)
area(dist_600(1:100:end-99),fillgaps(Thick_600(1:100:end-99,1))),Flux_grid)

[dist_mesh,Thick_mesh]=meshgrid(dist_600(1:100:end-99),fillgaps(Thick_600(1:100:end-99,1)));
Flux_grid=griddata(dist_600(1:100:end-99),fillgaps(Thick_600(1:100:end-99,1)),Flux_600(1,:),dist_mesh,Thick_mesh);

Thick_mesh=Thick_mesh';
%% All calculations using the straight gates

window=[7 7];
%cs_z_stack_median20x20=movmedian(cs_z_stack,window,'omitnan');

addpath('/nfs/a59/cryosat/output/py10ts/scripts/')

for i=1:87
cs_z_stack_median20x20(:,:,i) = nanmedfilt2(cs_z_stack(:,:,i),window);
end


% figure; h = imagesc(test); set(h,'alphadata',~isnan(test))
% axis xy



for i=1: size(cs_z_stack,3)
Z_600_SLine(:,i)=profile_ext_mean_size_def(X_g600_SLine,Y_g600_SLine,flipud(cs_z_stack_median20x20(:,:,i)),Rcryo,1,size(X_g600_SLine,2));
Z_700_SLine(:,i)=profile_ext_mean_size_def(X_g700_SLine,Y_g700_SLine,flipud(cs_z_stack_median20x20(:,:,i)),Rcryo,1,size(X_g700_SLine,2));
Z_800_SLine(:,i)=profile_ext_mean_size_def(X_g800_SLine,Y_g800_SLine,flipud(cs_z_stack_median20x20(:,:,i)),Rcryo,1,size(X_g800_SLine,2));
Z_900_SLine(:,i)=profile_ext_mean_size_def(X_g900_SLine,Y_g900_SLine,flipud(cs_z_stack_median20x20(:,:,i)),Rcryo,1,size(X_g900_SLine,2));
end

%  for i=1: size(cs_z_stack,3)
% Z_600(:,i)=profile_ext_mean(X_g600,Y_g600,cs_z_stack(:,:,i),Rcryo,20);
% Z_650(:,i)=profile_ext_mean(X_g650,Y_g650,cs_z_stack(:,:,i),Rcryo,20);
% Z_700(:,i)=profile_ext_mean(X_g700,Y_g700,cs_z_stack(:,:,i),Rcryo,20);
% Z_750(:,i)=profile_ext_mean(X_g750,Y_g750,cs_z_stack(:,:,i),Rcryo,20);
% Z_800(:,i)=profile_ext_mean(X_g800,Y_g800,cs_z_stack(:,:,i),Rcryo,20);
% Z_850(:,i)=profile_ext_mean(X_g850,Y_g850,cs_z_stack(:,:,i),Rcryo,20);
% Z_900(:,i)=profile_ext_mean(X_g900,Y_g900,cs_z_stack(:,:,i),Rcryo,20);
% end

mapshow(cs_z_stack_median20x20(:,:,3),Rcryo, 'DisplayType','surface');
time_cryo = datenum([Y(:), M(:), ones(numel(Y),1)]);


for i=1:size(Z_600_SLine,2)
Thick_600_SLine(:,i)=Z_600_SLine(:,i)-Bed_600_SLine;
Thick_700_SLine(:,i)=Z_700_SLine(:,i)-Bed_700_SLine;
Thick_800_SLine(:,i)=Z_800_SLine(:,i)-Bed_800_SLine;
Thick_900_SLine(:,i)=Z_900_SLine(:,i)-Bed_900_SLine;

end

% % Calculate the area under the curve:
% for i=1:size(Z_600,2)
% Area_600(:,i)=trapz(dist_600(1,:)',fillgaps(Thick_600(:,i)));
% Area_650(:,i)=trapz(dist_650(1,:)',fillgaps(Thick_650(:,i)));
% 
% Area_700(:,i)=trapz(dist_700(1,:)',fillgaps(Thick_700(:,i)));
% Area_750(:,i)=trapz(dist_750(1,:)',fillgaps(Thick_750(:,i)));
% 
% Area_800(:,i)=trapz(dist_800(1,:)',fillgaps(Thick_800(:,i)));
% Area_850(:,i)=trapz(dist_850(1,:)',fillgaps(Thick_850(:,i)));
% 
% Area_900(:,i)=trapz(dist_900(1,:)',fillgaps(Thick_900(:,i)));
% 
% end

% Calculate the area under the curve every 200m:

for i=1:size(Z_600_SLine,2)
 
 try
     k=1;
for j=1:2:size(Thick_600_SLine,1)
Area_600_SLine(i,k)=trapz(dist_600_SLine(1,j:j+1)',fillgaps(Thick_600_SLine(j:j+1,i)));
k=k+1;
end
 end

try
  k=1;    
for j=1:2:size(Thick_700_SLine,1)
Area_700_SLine(i,k)=trapz(dist_700_SLine(1,j:j+1)',fillgaps(Thick_700_SLine(j:j+1,i)));
k=k+1;
end
end


try
  k=1;   
for j=1:2:size(Thick_800_SLine,1)
Area_800_SLine(i,k)=trapz(dist_800_SLine(1,j:j+1)',fillgaps(Thick_800_SLine(j:j+1,i)));
k=k+1;
end
end


try
  k=1;   
for j=1:2:size(Thick_900_SLine,1)
Area_900_SLine(i,k)=trapz(dist_900_SLine(1,j:j+1)',fillgaps(Thick_900_SLine(j:j+1,i)));
k=k+1;
end
end

end


%%%%  Gate angle variation along the glaciers:
%
% alpha=arctan[(y2-y1)/x2-x1)];  %angle between the gate in the cartesian plan
% 
% beta= arctan(Velx/Vely);  % Velocity angle in the cartesian plan
%
% theta= (alpha - beta); % angle between the Velocity vector and the gate.
%
% atan2d -> https://uk.mathworks.com/help/matlab/ref/atan2d.html
%
% 

% gate angles:

for i=1:size(Y_g600_SLine,2)-1
angle_g600_Sline(i)=atan2d(Y_g600_SLine(i+1)-Y_g600_SLine(i),X_g600_SLine(i+1)-X_g600_SLine(i));
end

for i=1:size(Y_g700_SLine,2)-1
angle_g700_Sline(i)=atan2d(Y_g700_SLine(i+1)-Y_g700_SLine(i),X_g700_SLine(i+1)-X_g700_SLine(i));
end

for i=1:size(Y_g800_SLine,2)-1
angle_g800_Sline(i)=atan2d(Y_g800_SLine(i+1)-Y_g800_SLine(i),X_g800_SLine(i+1)-X_g800_SLine(i));
end

for i=1:size(Y_g900_SLine,2)-1
angle_g900_Sline(i)=atan2d(Y_g900_SLine(i+1)-Y_g900_SLine(i),X_g900_SLine(i+1)-X_g900_SLine(i));
end

% Plot the gates and the angles

figure;
scatter(X_g600_SLine, Y_g600_SLine,5,[angle_g600_Sline,angle_g600_Sline(end)],'filled'); hold on;
scatter(X_g700_SLine, Y_g700_SLine,5,[angle_g700_Sline,angle_g700_Sline(end)],'filled')
scatter(X_g800_SLine, Y_g800_SLine,5,[angle_g800_Sline,angle_g800_Sline(end)],'filled')
scatter(X_g900_SLine, Y_g900_SLine,5,[angle_g900_Sline,angle_g900_Sline(end)],'filled')
c_degree=colorbar;
caxis([70 170])
ylabel(c_degree,'gate angle (degrees)','fontsize',12,'fontweight','b')

% window2=[7 7];
% 
% for i=1:93
% 
%  VX_Russel_MedFilt(:,:,i)=nanmedfilt2(VX_Russel_m_yr(:,:,i),window2);
%  VY_Russel_MedFilt(:,:,i)=nanmedfilt2(VY_Russel_m_yr(:,:,i),window2);
% 
% end
 
window_vxy=[5 5];
%cs_z_stack_median20x20=movmedian(cs_z_stack,window,'omitnan');

addpath('/nfs/a59/cryosat/output/py10ts/scripts/')

for i=1:93
VX_Russel_filtered_m_yr_medianFilter(:,:,i) = nanmedfilt2(VX_Russel_filtered_m_yr(:,:,i),window_vxy);
VY_Russel_filtered_m_yr_medianFilter(:,:,i) = nanmedfilt2(VY_Russel_filtered_m_yr(:,:,i),window_vxy);
end


for i=1:93
    
  VelX_600_SLine_medFilter(:,i)=profile_ext(X_g600_SLine,Y_g600_SLine,VX_Russel_filtered_m_yr_medianFilter(:,:,i),R_russel);
  VelY_600_SLine(:,i)=profile_ext(X_g600_SLine,Y_g600_SLine,VY_Russel_filtered_m_yr_medianFilter(:,:,i),R_russel);  
  
  VelX_700_SLine(:,i)=profile_ext(X_g700_SLine,Y_g700_SLine,VX_Russel_filtered_m_yr_medianFilter(:,:,i),R_russel);  
  VelY_700_SLine(:,i)=profile_ext(X_g700_SLine,Y_g700_SLine,VY_Russel_filtered_m_yr_medianFilter(:,:,i),R_russel);  

  VelX_800_SLine(:,i)=profile_ext(X_g800_SLine,Y_g800_SLine,VX_Russel_filtered_m_yr_medianFilter(:,:,i),R_russel);  
  VelY_800_SLine(:,i)=profile_ext(X_g800_SLine,Y_g800_SLine,VY_Russel_filtered_m_yr_medianFilter(:,:,i),R_russel);  

  VelX_900_SLine(:,i)=profile_ext(X_g900_SLine,Y_g900_SLine,VX_Russel_filtered_m_yr_medianFilter(:,:,i),R_russel);  
  VelY_900_SLine(:,i)=profile_ext(X_g900_SLine,Y_g900_SLine,VY_Russel_filtered_m_yr_medianFilter(:,:,i),R_russel);  
  
end
% 
% for i=1:93
%     
%   VelX_600_SLine(:,i)=profile_ext_mean(X_g600_SLine,Y_g600_SLine,VX_Russel_filtered_m_yr(:,:,i),R_russel,7);
%   VelY_600_SLine(:,i)=profile_ext_mean(X_g600_SLine,Y_g600_SLine,VY_Russel_filtered_m_yr(:,:,i),R_russel,7);  
%   
%   VelX_700_SLine(:,i)=profile_ext_mean(X_g700_SLine,Y_g700_SLine,VX_Russel_filtered_m_yr(:,:,i),R_russel,7);  
%   VelY_700_SLine(:,i)=profile_ext_mean(X_g700_SLine,Y_g700_SLine,VY_Russel_filtered_m_yr(:,:,i),R_russel,7);  
% 
%   VelX_800_SLine(:,i)=profile_ext_mean(X_g800_SLine,Y_g800_SLine,VX_Russel_filtered_m_yr(:,:,i),R_russel,7);  
%   VelY_800_SLine(:,i)=profile_ext_mean(X_g800_SLine,Y_g800_SLine,VY_Russel_filtered_m_yr(:,:,i),R_russel,7);  
% 
%   VelX_900_SLine(:,i)=profile_ext_mean(X_g900_SLine,Y_g900_SLine,VX_Russel_filtered_m_yr(:,:,i),R_russel,7);  
%   VelY_900_SLine(:,i)=profile_ext_mean(X_g900_SLine,Y_g900_SLine,VY_Russel_filtered_m_yr(:,:,i),R_russel,7);  
%   
% end

size(X_g600_SLine)
plot(VelX_600_SLine(:,93))

figure; imagesc((nansum(cat(3,VX_Russel_filtered(:,:,93).^2,VY_Russel_filtered(:,:,93).^2),3)).^0.5)

figure; plot((nansum(cat(2,VelX_600_SLine(:,93).^2,VelY_600_SLine(:,93).^2),2)).^0.5)

% %%% Hannes email
% with ice thickness H and velocity components U and V.
% DIV = divergence(X,Y,H.*U,H.*V)

addpath('/nfs/a59/cryosat/output/py10ts/scripts/')
addpath(genpath('/nfs/a59/eeagdl/DATABASE/MATLAB/matlab_biblioteca/'))

[VX_Russel_m_yr_monthly_mean,time_VX_monthly] = downsample_ts(VX_Russel_m_yr,date_Russel_num,'function','nanmean');
[VY_Russel_m_yr_monthly_mean,time_VY_monthly] = downsample_ts(VY_Russel_m_yr,date_Russel_num,'function','nanmean');

% removing months from 2015 but December: 
VX_Russel_m_yr_monthly_mean(:,:,1:6)=[];
VY_Russel_m_yr_monthly_mean(:,:,1:6)=[];

time_VX_monthly(1:6)=[];
time_VY_monthly(1:6)=[];

% making the elevation a better resolution (bringing the elevation to the vel resolution: 100m)

for i=1:size(cs_z_stack_median20x20,3);
 cs_z_stack_median20x20_interp(:,:,i)= interp2(gridx,gridy,cs_z_stack_median20x20(:,:,i),XRussel,YRussel);
end


% making a coarse resolution of the Vel (taking to 5km resolution):

xRussel_5km=xRussel(1):5000:xRussel(end);
yRussel_5km=yRussel(1):5000:yRussel(end);
[XRussel_5km,YRussel_5km]=meshgrid(xRussel_5km,yRussel_5km);

for i=1:size(VY_Russel_m_yr,3);
 VX_Russel_myr_interp(:,:,i)= interp2(XRussel,YRussel,VX_Russel_m_yr(:,:,i),XRussel_5km,YRussel_5km);
 VY_Russel_myr_interp(:,:,i)= interp2(XRussel,YRussel,VY_Russel_m_yr(:,:,i),XRussel_5km,YRussel_5km);

end

for i=1:size(cs_z_stack_median20x20,3);
 cs_z_stack_median20x20_interp(:,:,i)= interp2(gridx,gridy,cs_z_stack_median20x20(:,:,i),XRussel_5km,YRussel_5km);
end


%  Divergence


%Summer & winter

% summer: May - Aug
% winter: Sep - April

%summer_2016: 68:71
%winter_2016/2017: 72:79
%summer 2017: 80:83
%winter2017: 84:end

% 2016

DIV_summer_2016 = divergence(XRussel_5km,YRussel_5km,nanmean(cs_z_stack_median20x20_interp(:,:,68:71),3).*nanmean(VX_Russel_myr_interp(:,:,6:9),3),nanmean(cs_z_stack_median20x20_interp(:,:,68:71),3).*nanmean(VY_Russel_myr_interp(:,:,6:9),3));

DIV_winter_2016 = divergence(XRussel_5km,YRussel_5km,nanmean(cs_z_stack_median20x20_interp(:,:,72:79),3).*nanmean(VX_Russel_myr_interp(:,:,10:17),3),nanmean(cs_z_stack_median20x20_interp(:,:,72:79),3).*nanmean(VY_Russel_myr_interp(:,:,10:17),3));

% 2017

DIV_summer_2017 = divergence(XRussel_5km,YRussel_5km,nanmean(cs_z_stack_median20x20_interp(:,:,80:83),3).*nanmean(VX_Russel_myr_interp(:,:,18:21),3),nanmean(cs_z_stack_median20x20_interp(:,:,80:83),3).*nanmean(VY_Russel_myr_interp(:,:,18:21),3));

DIV_winter_2017 = divergence(XRussel_5km,YRussel_5km,nanmean(cs_z_stack_median20x20_interp(:,:,84:end),3).*nanmean(VX_Russel_myr_interp(:,:,21:end),3),nanmean(cs_z_stack_median20x20_interp(:,:,84:end),3).*nanmean(VY_Russel_myr_interp(:,:,21:end),3));




figure('PaperOrientation','portrait','position',[1 1 820 825])
subplot(221)
h=imagesc(xRussel_5km,yRussel_5km,DIV_summer_2016); tt=double(~isnan(DIV_summer_2016)); set(h,'AlphaData', tt);
%figure; imagesc(xRussel_5km,yRussel_5km,DIV_summer);
caxis([-50 50]);
title('Summer 2016','fontsize',14,'fontweight','b')
colormap redbluecmap
set(gca,'fontsize',12)

%figure;
subplot(222)
h=imagesc(xRussel_5km,yRussel_5km,DIV_winter_2016); tt=double(~isnan(DIV_winter_2016)); set(h,'AlphaData', tt);
%figure; imagesc(xRussel_5km,yRussel_5km,DIV_summer);
caxis([-50 50]);
title('Winter 2016','fontsize',14,'fontweight','b')
colormap redbluecmap
cc=colorbar('location','south outside');
ylabel(cc,'m yr^{-1}','fontsize',12,'fontweight','b')
set(gca,'fontsize',12)

%figure;
subplot(223)
h=imagesc(xRussel_5km,yRussel_5km,DIV_summer_2017); tt=double(~isnan(DIV_summer_2017)); set(h,'AlphaData', tt);
%figure; imagesc(xRussel_5km,yRussel_5km,DIV_summer);
caxis([-50 50]);
title('Summer 2017','fontsize',14,'fontweight','b')
colormap redbluecmap
set(gca,'fontsize',12)

%figure;
subplot(224)
h=imagesc(xRussel_5km,yRussel_5km,DIV_winter_2017); tt=double(~isnan(DIV_winter_2017)); set(h,'AlphaData', tt);
%figure; imagesc(xRussel_5km,yRussel_5km,DIV_summer);
caxis([-50 50]);
title('Winter 2017','fontsize',14,'fontweight','b')
colormap redbluecmap
%colorbar('location','east outside')
set(gca,'fontsize',12)

print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Divergence_Summer_Winter

imagesc(nanmean(VX_Russel_myr_interp(15:50,18:40,10:17),3))



%%% DIVERGE - Mean 2016 and 2017 - 100 m resolution

cs_z_stack_median20x20_interp_summer= cat(3, cs_z_stack_median20x20_interp(:,:,68:71),cs_z_stack_median20x20_interp(:,:,80:83));
cs_z_stack_median20x20_interp_winter= cat(3, cs_z_stack_median20x20_interp(:,:,72:79),cs_z_stack_median20x20_interp(:,:,84:end));

VX_Russel_myr_interp_summer_100= cat(3, VX_Russel_m_yr(:,:,6:9), VX_Russel_m_yr(:,:,18:21));
VX_Russel_myr_interp_winter_100= cat(3, VX_Russel_m_yr(:,:,10:17), VY_Russel_m_yr(:,:,21:end));

VY_Russel_myr_interp_summer_100= cat(3, VY_Russel_m_yr(:,:,6:9), VY_Russel_m_yr(:,:,18:21));
VY_Russel_myr_interp_winter_100= cat(3, VY_Russel_m_yr(:,:,10:17), VY_Russel_m_yr(:,:,21:end));



DIV_summer_100 = divergence(XRussel,YRussel,nanmean(cs_z_stack_median20x20_interp_summer,3).*nanmean(VX_Russel_myr_interp_summer_100,3),nanmean(cs_z_stack_median20x20_interp_summer,3).*nanmean(VY_Russel_myr_interp_summer_100,3));

DIV_winter_100 = divergence(XRussel,YRussel,nanmean(cs_z_stack_median20x20_interp_winter,3).*nanmean(VX_Russel_myr_interp_winter_100,3),nanmean(cs_z_stack_median20x20_interp_winter,3).*nanmean(VY_Russel_myr_interp_winter_100,3));

DIV_summer_100_median=nanmedfilt2(DIV_summer_100,[21 21]);
DIV_winter_100_median=nanmedfilt2(DIV_winter_100,[21 21]);



figure('PaperOrientation','portrait','position',[1 1 1220 525])

h1=subplot(141)
h=imagesc(xRussel(1400:2300),yRussel(1000:2000),Vel_Russel_mean(1400:2300,1000:2000)); tt=double(~isnan(Vel_Russel_mean(1400:2300,1000:2000))); set(h,'AlphaData', tt);
%figure; imagesc(xRussel_5km,yRussel_5km,DIV_summer);
caxis([0 250]);
title('Mean Velocity','fontsize',14,'fontweight','b')
colormap(h1, 'jet');
set(gca,'fontsize',12)
cc1=colorbar('location','west outside');
ylabel(cc1,'m yr^{-1}','fontsize',12,'fontweight','b')


subplot(142)
h=imagesc(xRussel(1400:2300),yRussel(1000:2000),DIV_summer_100_median(1400:2300,1000:2000)); tt=double(~isnan(DIV_summer_100_median(1400:2300,1000:2000))); set(h,'AlphaData', tt);
%figure; imagesc(xRussel_5km,yRussel_5km,DIV_summer);
caxis([-50 50]);
title('Summer','fontsize',14,'fontweight','b')
colormap redbluecmap
set(gca,'fontsize',12)

%figure;
subplot(143)
h=imagesc(xRussel(1400:2300),yRussel(1000:2000),DIV_winter_100_median(1400:2300,1000:2000)); tt=double(~isnan(DIV_winter_100_median(1400:2300,1000:2000))); set(h,'AlphaData', tt);
%figure; imagesc(xRussel_5km,yRussel_5km,DIV_summer);
caxis([-50 50]);
title('Winter','fontsize',14,'fontweight','b')
colormap redbluecmap
cc=colorbar('location','east outside');
ylabel(cc,'m yr^{-1}','fontsize',12,'fontweight','b')
set(gca,'fontsize',12)

print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Divergente_Vel_Summer_Winter_median_Filter


%figure('units','centimeters','position',[0 0 12 12]);
subplot(144)
h=imagesc(xRussel(1400:2300),yRussel(1000:2000),DIV_summer_100_median(1400:2300,1000:2000)-DIV_winter_100_median(1400:2300,1000:2000)); tt=double(~isnan(DIV_summer_100_median(1400:2300,1000:2000)-DIV_winter_100_median(1400:2300,1000:2000))); set(h,'AlphaData', tt);
%figure; imagesc(xRussel_5km,yRussel_5km,DIV_summer);
caxis([-50 50]);
title('Summer-Winter','fontsize',14,'fontweight','b')
colormap redbluecmap
cc=colorbar('location','east outside');
ylabel(cc,'m yr^{-1}','fontsize',12,'fontweight','b')
set(gca,'fontsize',12)

print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Divergente_Difference_Summer_minus_Winter

print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Divergente_Vel_Summer_Winter_Difference_median_Filter


%%

%%% Mean
figure('units','centimeters','position',[0 0 12 12]);
    %set(gcf,'color','w')
    
ax1 = axes; hold on;
h=pcolor(XRussel(1400:2300,1000:2000),YRussel(1400:2300,1000:2000),DIV_summer_100_median(1400:2300,1000:2000)-DIV_winter_100_median(1400:2300,1000:2000));
shading flat;
%figure; imagesc(xRussel_5km,yRussel_5km,DIV_summer);
caxis([-50 50]);
title('Summer-Winter','fontsize',14,'fontweight','b')
colormap redbluecmap
cc=colorbar('location','east outside');
ylabel(cc,'m yr^{-1}','fontsize',12,'fontweight','b')
set(gca,'fontsize',12)

set(ax1,'Ydir','reverse')
%daspect([1000 1000 1])


ax2 = axes;
contour(XRussel(1400:2300,1000:2000),YRussel(1400:2300,1000:2000),Vel_Russel_mean(1400:2300,1000:2000),[100,150,200,250],'color','k','linewidth',1,'ShowText','on');
%daspect([1000 1000 1])
set(ax2,'Ydir','reverse')

axis off

% Link them together
linkaxes([ax1,ax2])
% Hide the top axes
ax2.Visible = 'off';
ax2.XTick = [];
ax2.YTick = [];

xlim(ax1,[XRussel(1400,1000) XRussel(2300,2000)])
ylim(ax1,[YRussel(1400,1000) YRussel(2300,2000)])

xlim(ax2,[XRussel(1400,1000) XRussel(2300,2000)])
ylim(ax2,[YRussel(1400,1000) YRussel(2300,2000)])





% Give each one its own colormap
colormap(ax1,'gray')

CT=cbrewer('div', 'RdYlGn',90);
colormap(ax2,flip(CT))

caxis(ax1,[-30 -3.44625])
caxis(ax2,[0 300]);

xlim(ax1,[-250000 -50000])
ylim(ax1,[-2550000 -2350000])

xlim(ax2,[-250000 -50000])
ylim(ax2,[-2550000 -2350000])
% Then add colorbars and get everything lined up
set([ax1,ax2],'Position',[.17 .11 .685 .815]);
%cb1 = colorbar(ax1,'Position',[.05 .11 .0675 .815]);
%grid(ax2,'on')
%grid(ax1,'on')
%title(ax1,'Mean','fontsize',14)

%xlabel(cb2,'[m yr^{-1}]','fontsize',14)
    c1 = colorbar(ax2,'south','Fontsize',8,'Fontname','Arial');
    xlabel(c1,'[m yr^{-1}]','HorizontalAlignment','Center','position',[10 0.2])
    set(c1,'position',[0.55 0.2 0.25 0.05])
   % set(c1,'Xtick',[-7:1:7],'XTicklabel',{'','6','','4','','2','','0','','-2','','-4','','-6',''})
export_fig('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Mean_Russel.png','-dpng','-r600');



ax3=axesm('MapProjection','mercator', 'MapLatLimit',[66 68],'MapLonLimit',[-80 -20]);
h=imagesc(ax3,xRussel, yRussel,Vel_Russel_mean); tt=double(~isnan(Vel_Russel_mean)); set(h,'AlphaData', tt*0.65);
h=mapshow(xRussel, yRussel,double(Vel_Russel_mean));
X = get(h,'XData'); 
Y = get(h,'YData');
f=isnan(Vel_Russel_mean);
f(end+1,:)=true;
f(:,end+1)=true;
X(f)=nan;
Y(f)=nan;
set(h,'XData',X,'YData',Y);



plotm(x,y)









%%










%%% DIVERGE - Mean 2016 and 2017 - 5km resolution

cs_z_stack_median20x20_interp_summer= cat(3, cs_z_stack_median20x20_interp(:,:,68:71),cs_z_stack_median20x20_interp(:,:,80:83));
cs_z_stack_median20x20_interp_winter= cat(3, cs_z_stack_median20x20_interp(:,:,72:79),cs_z_stack_median20x20_interp(:,:,84:end));

VX_Russel_myr_interp_summer= cat(3, VX_Russel_myr_interp(:,:,6:9), VX_Russel_myr_interp(:,:,18:21));
VX_Russel_myr_interp_winter= cat(3, VX_Russel_myr_interp(:,:,10:17), VY_Russel_myr_interp(:,:,21:end));

VY_Russel_myr_interp_summer= cat(3, VY_Russel_myr_interp(:,:,6:9), VY_Russel_myr_interp(:,:,18:21));
VY_Russel_myr_interp_winter= cat(3, VY_Russel_myr_interp(:,:,10:17), VY_Russel_myr_interp(:,:,21:end));



DIV_summer = divergence(XRussel_5km,YRussel_5km,nanmean(cs_z_stack_median20x20_interp_summer,3).*nanmean(VX_Russel_myr_interp_summer,3),nanmean(cs_z_stack_median20x20_interp_summer,3).*nanmean(VY_Russel_myr_interp_summer,3));

DIV_winter = divergence(XRussel_5km,YRussel_5km,nanmean(cs_z_stack_median20x20_interp_winter,3).*nanmean(VX_Russel_myr_interp_winter,3),nanmean(cs_z_stack_median20x20_interp_winter,3).*nanmean(VY_Russel_myr_interp_winter,3));


figure('PaperOrientation','portrait','position',[1 1 1020 525])
subplot(121)
h=imagesc(xRussel_5km,yRussel_5km,DIV_summer); tt=double(~isnan(DIV_summer)); set(h,'AlphaData', tt);
%figure; imagesc(xRussel_5km,yRussel_5km,DIV_summer);
caxis([-50 50]);
title('Summer 2016','fontsize',14,'fontweight','b')
colormap redbluecmap
set(gca,'fontsize',12)

%figure;
subplot(122)
h=imagesc(xRussel_5km,yRussel_5km,DIV_winter); tt=double(~isnan(DIV_winter)); set(h,'AlphaData', tt);
%figure; imagesc(xRussel_5km,yRussel_5km,DIV_summer);
caxis([-50 50]);
title('Winter 2016','fontsize',14,'fontweight','b')
colormap redbluecmap
cc=colorbar('location','east outside');
ylabel(cc,'m yr^{-1}','fontsize',12,'fontweight','b')
set(gca,'fontsize',12)






j=1;
for i=1:25
  Vel_600_SLine(:,i)=profile_ext_mean_size_def(X_g600_SLine,Y_g600_SLine,Vel_monthly_mean(:,:,i),R_russel,5,size(X_g600_SLine,2));  
  
  Vel_700_SLine(:,i)=profile_ext_mean_size_def(X_g700_SLine,Y_g700_SLine,Vel_monthly_mean(:,:,i),R_russel,5,size(X_g700_SLine,2));  
  
  Vel_800_SLine(:,i)=profile_ext_mean_size_def(X_g800_SLine,Y_g800_SLine,Vel_monthly_mean(:,:,i),R_russel,5,size(X_g800_SLine,2));  

  Vel_900_SLine(:,i)=profile_ext_mean_size_def(X_g900_SLine,Y_g900_SLine,Vel_monthly_mean(:,:,i),R_russel,5,size(X_g900_SLine,2));  

end



% Mean velocity every 200m:

for i=1:25
 
 try
     k=1;
for j=1:2:size(Vel_600_SLine,1)
Vel_600_mean_SLine(i,k)=nanmean(Vel_600_SLine(j:j+1,i));
k=k+1;
end
 end
 

try
     k=1;
for j=1:2:size(Vel_700_SLine,1)
Vel_700_mean_SLine(i,k)=nanmean(Vel_700_SLine(j:j+1,i));
k=k+1;
end
 end


try
     k=1;
for j=1:2:size(Vel_800_SLine,1)
Vel_800_mean_SLine(i,k)=nanmean(Vel_800_SLine(j:j+1,i));
k=k+1;
end
end
 

try
     k=1;
for j=1:2:size(Vel_900_SLine,1)
Vel_900_mean_SLine(i,k)=nanmean(Vel_900_SLine(j:j+1,i));
k=k+1;
end
end
 
end



%Flux calculation (Dec_2015 to Dec_2017) j=63 => Dec_2015

j=63;
for i=1:25
Flux_600_SLine(i,:)=(Area_600_SLine(j,:).*Vel_600_mean_SLine(i,:));

Flux_700_SLine(i,:)=(Area_700_SLine(j,:).*Vel_700_mean_SLine(i,:));

Flux_800_SLine(i,:)=(Area_800_SLine(j,:).*Vel_800_mean_SLine(i,:));

Flux_900_SLine(i,:)=(Area_900_SLine(j,:).*Vel_900_mean_SLine(i,:));

j=j+1;
end



% Monthly Discharge (Dec_2015 to Dec_2017)

for i=1:25
Flux_600_monthly_SLine(i)=nansum(Flux_600_SLine(i,:));

Flux_700_monthly_SLine(i)=nansum(Flux_700_SLine(i,:));

Flux_800_monthly_SLine(i)=nansum(Flux_800_SLine(i,:));

Flux_900_monthly_SLine(i)=nansum(Flux_900_SLine(i,:));


end


% Cumulative discharge (Jan_2016 to Dec_2017)

cum_Flux_600_SLine=nansum(Flux_600_SLine(1,:));
cum_Flux_700_SLine=nansum(Flux_700_SLine(1,:));
cum_Flux_800_SLine=nansum(Flux_700_SLine(1,:));
cum_Flux_900_SLine=nansum(Flux_900_SLine(1,:));

for i=2:25
cum_Flux_600_SLine(i)=[cum_Flux_600_SLine(i-1)+nansum(Flux_600_SLine(i,:))];

cum_Flux_700_SLine(i)=[cum_Flux_700_SLine(i-1)+nansum(Flux_700_SLine(i,:))];

cum_Flux_800_SLine(i)=[cum_Flux_800_SLine(i-1)+nansum(Flux_800_SLine(i,:))];

cum_Flux_900_SLine(i)=[cum_Flux_900_SLine(i-1)+nansum(Flux_900_SLine(i,:))];


end



%save('-v7.3','/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Russel_12_06_2018.mat')




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% % Glacier 1
% gate 600-> 1053:4963
% gate 650-> 
% 
% 
% 
% profile 600: 2455
% profile 650: 2319
% profile 700: 
% profile 750: 4863
% 
% % Glacier 2
% gate 600 -> 32341:44027
% 
% profile 600: 36889
% profile 650: 21633
% profile 700: 28885
% profile 750: 22309
% profile 800: 33669
% profile 850: 22637
% profile 900: 29018
% 
% 
% % Glacier 3
% gate 600 -> 69322:75958
% 
% profile 600: 73376
% profile 650: 45224
% profile 700: 56578
% profile 750: 47126
% profile 800: 64967
% profile 850: 46111
% profile 900: 57686
% 
% % Glacier 4
% gate 600 -> 82224:89567
% 
% prifile 600: 86596
% profile 650: 53069
% profile 700: 65142
% profile 750: 51961
% profile 800: 68521
% profile 850: 47541
% profile 900: 57686
% 
% % Glacier 5
% gate 600 -> 98150:102780
% 
% profile 600: 100362
% profile 650: 63758
% profile 700: 78412
% profile 750: 63146
% profile 800: 83458
% profile 850: 57139
% profile 900: 70817
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% GT= the mass of 1.091 cubic km of ice
ice_density=917; % kg/m3

figure('PaperOrientation','landscape','position',[1 1 820 825])
subplot(711)
plot(dist_600(1:100:end-99)/1000,(nanmean(Flux_600,1)/1e+12)*(ice_density))
ylim([0 0.1]);
xlim([-10 120])
title('600 m','fontsize',12)


subplot(712)
plot(dist_650(1:100:end-99)/1000,(nanmean(Flux_650,1)/1e+12)*(ice_density))
ylim([0 0.1]);
xlim([-10 120])
title('650 m','fontsize',12)

subplot(713)
plot(dist_700(1:100:end-99)/1000,(nanmean(Flux_700,1)/1e+12)*(ice_density))
ylim([0 0.1]);
xlim([-10 120])
title('700 m','fontsize',12)

subplot(714)
plot(dist_750(1:100:end-99)/1000,(nanmean(Flux_750,1)/1e+12)*(ice_density))
ylabel('Mean ice discharge [Gt yr^{-1}]','fontsize',16,'fontweight','b')
ylim([0 0.1]);
xlim([-10 120])
title('750 m','fontsize',12)

subplot(715)
plot(dist_800(1:100:end-99)/1000,(nanmean(Flux_800,1)/1e+12)*(ice_density))
ylim([0 0.1]);
xlim([-10 120])
title('800 m','fontsize',12)


subplot(716)
plot(dist_850(1:100:end-99)/1000,(nanmean(Flux_850,1)/1e+12)*(ice_density))
ylim([0 0.1]);
xlim([-10 120])
title('850 m','fontsize',12)

subplot(717)
plot(dist_900(1:100:end-99)/1000,(nanmean(Flux_900,1)/1e+12)*(ice_density))
ylim([0 0.1]);
xlim([-10 120])
xlabel('Distance along the gate [km]','fontsize',16,'fontweight','b')
title('900 m','fontsize',12)

print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Mean_Fluxes_600m_to_900m


figure('PaperOrientation','portrait','position',[1 1 950 825])
subplot(331)
plot([1:12],(Flux_600_monthly(2:13)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); hold on
plot([1:11],(Flux_600_monthly(14:end-1)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); 
xlim([0 13])
set(gca,'XTick',[1:12],'xticklabel',['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'],'fontsize',14)
ylabel('Ice discharge [Gt yr^{-1}]','fontsize',14,'fontweight','b')
%legend('2016','2017')
title('600 m','fontsize',12)
ylim([0 10]);

subplot(332)
plot([1:12],(Flux_650_monthly(2:13)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); hold on
plot([1:11],(Flux_650_monthly(14:end-1)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); 
xlim([0 13])
set(gca,'XTick',[1:12],'xticklabel',['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'],'fontsize',14)
%ylabel('Ice discharge [Gt yr^{-1}]','fontsize',14,'fontweight','b')
%legend('2016','2017')
title('650 m','fontsize',12)
ylim([0 10]);

subplot(333)
plot([1:12],(Flux_700_monthly(2:13)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); hold on
plot([1:11],(Flux_700_monthly(14:end-1)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); 
xlim([0 13])
set(gca,'XTick',[1:12],'xticklabel',['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'],'fontsize',14)
%ylabel('Ice discharge [Gt yr^{-1}]','fontsize',14,'fontweight','b')
%legend('2016','2017')
title('700 m','fontsize',12)
ylim([0 10]);

subplot(334)
plot([1:12],(Flux_750_monthly(2:13)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); hold on
plot([1:11],(Flux_750_monthly(14:end-1)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); 
xlim([0 13])
set(gca,'XTick',[1:12],'xticklabel',['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'],'fontsize',14)
ylabel('Ice discharge [Gt yr^{-1}]','fontsize',14,'fontweight','b')
%legend('2016','2017')
title('750 m','fontsize',12)
ylim([0 10]);

subplot(335)
plot([1:12],(Flux_800_monthly(2:13)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); hold on
plot([1:11],(Flux_800_monthly(14:end-1)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); 
xlim([0 13])
set(gca,'XTick',[1:12],'xticklabel',['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'],'fontsize',14)
%ylabel('Ice discharge [Gt yr^{-1}]','fontsize',14,'fontweight','b')
%legend('2016','2017')
title('800 m','fontsize',12)
ylim([0 10.1]);

subplot(336)
plot([1:12],(Flux_850_monthly(2:13)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); hold on
plot([1:11],(Flux_850_monthly(14:end-1)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); 
xlim([0 13])
set(gca,'XTick',[1:12],'xticklabel',['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'],'fontsize',14)
%ylabel('Ice discharge [Gt yr^{-1}]','fontsize',14,'fontweight','b')
%legend('2016','2017')
title('850 m','fontsize',12)
ylim([0 10]);

subplot(337)
plot([1:12],(Flux_900_monthly(2:13)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); hold on
plot([1:11],(Flux_900_monthly(14:end-1)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); 
xlim([0 13])
set(gca,'XTick',[1:12],'xticklabel',['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'],'fontsize',14)
ylabel('Ice discharge [Gt yr^{-1}]','fontsize',14,'fontweight','b')
%legend('2016','2017')
title('900 m','fontsize',12)
ylim([0 10]);


Flux_monthly_mean_2016=mean([Flux_600_monthly(2:13);Flux_650_monthly(2:13); Flux_700_monthly(2:13); Flux_750_monthly(2:13); Flux_800_monthly(2:13); Flux_850_monthly(2:13); Flux_900_monthly(2:13)])
Flux_monthly_mean_2017=mean([Flux_600_monthly(14:end-1); Flux_650_monthly(14:end-1); Flux_700_monthly(14:end-1); Flux_750_monthly(14:end-1); Flux_800_monthly(14:end-1); Flux_850_monthly(14:end-1); Flux_900_monthly(14:end-1)]); 

subplot(3,3,8:9)
plot([1:12],(Flux_monthly_mean_2016/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); hold on
plot([1:11],(Flux_monthly_mean_2017/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); 
xlim([0 13])
set(gca,'XTick',[1:12],'xticklabel',['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'],'fontsize',14)
%ylabel('Ice discharge [Gt yr^{-1}]','fontsize',14,'fontweight','b')
legend('2016','2017')
title('Mean','fontsize',12)
ylim([0 10]);



print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Monthly_Mean_Discharge_600m_to_900m

%%

figure('PaperOrientation','landscape','position',[1 1 820 825])

subplot(3,1,1)
plot(dist_600_SLine/1000, Bed_600_SLine, 'color',[0.2 0 0],'linewidth',3)
hold on
plot(dist_600_SLine/1000, Elev_600_SLine, 'color','blue','linewidth',3)
title('600 m','fontsize',14,'fontweight','b')
l=legend('Bed','Mean Elevation','location','south')
set(l,'EdgeColor',[1 1 1])

ylabel('Elevation (m)','fontsize',12,'fontweight','b')
set(gca,'fontsize',14)

subplot(3,1,2)
plot(dist_600_SLine/1000, Thick_600_SLine, 'color','blue')
ylabel('Surface Change (m)','fontsize',12,'fontweight','b')
set(gca,'fontsize',14)
ylim([0 1000])


subplot(3,1,3)
plot(dist_600_SLine/1000, Vel_summer_600_SLine, 'color','r','linewidth',3)
hold on
plot(dist_600_SLine/1000, Vel_winter_600_SLine, 'color','b','linewidth',3)
xlabel('Distance along the gate [km]','fontsize',14,'fontweight','b')
ylabel('Velocity (m/yr)','fontsize',12,'fontweight','b')
l=legend('Summer','Winter')
set(l,'EdgeColor',[1 1 1])
set(gca,'fontsize',14)

print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Elevation_Thick_Vel_600m_Sline

%700
figure('PaperOrientation','landscape','position',[1 1 820 825])

subplot(3,1,1)
plot(dist_700_SLine/1000, Bed_700_SLine, 'color',[0.2 0 0],'linewidth',3)
hold on
plot(dist_700_SLine/1000, Elev_700_SLine, 'color','blue','linewidth',3)
title('700 m','fontsize',14,'fontweight','b')
l=legend('Bed','Mean Elevation','location','south')
set(l,'EdgeColor',[1 1 1])

ylabel('Elevation (m)','fontsize',12,'fontweight','b')
set(gca,'fontsize',14)

subplot(3,1,2)
plot(dist_700_SLine/1000, Thick_700_SLine, 'color','blue')
ylabel('Surface Change (m)','fontsize',12,'fontweight','b')
set(gca,'fontsize',14)
ylim([0 1000])


subplot(3,1,3)
plot(dist_700_SLine/1000, Vel_summer_700_SLine, 'color','r','linewidth',3)
hold on
plot(dist_700_SLine/1000, Vel_winter_700_SLine, 'color','b','linewidth',3)
xlabel('Distance along the gate [km]','fontsize',14,'fontweight','b')
ylabel('Velocity (m/yr)','fontsize',12,'fontweight','b')
l=legend('Summer','Winter')
set(l,'EdgeColor',[1 1 1])
set(gca,'fontsize',14)

print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Elevation_Thick_Vel_700m_Sline


%800
figure('PaperOrientation','landscape','position',[1 1 820 825])

subplot(3,1,1)
plot(dist_800_SLine/1000, Bed_800_SLine, 'color',[0.2 0 0],'linewidth',3)
hold on
plot(dist_800_SLine/1000, Elev_800_SLine, 'color','blue','linewidth',3)
title('800 m','fontsize',14,'fontweight','b')
l=legend('Bed','Mean Elevation','location','south')
set(l,'EdgeColor',[1 1 1])

ylabel('Elevation (m)','fontsize',12,'fontweight','b')
set(gca,'fontsize',14)

subplot(3,1,2)
plot(dist_800_SLine/1000, Thick_800_SLine, 'color','blue')
ylabel('Surface Change (m)','fontsize',12,'fontweight','b')
set(gca,'fontsize',14)
ylim([0 1000])


subplot(3,1,3)
plot(dist_800_SLine/1000, Vel_summer_800_SLine, 'color','r','linewidth',3)
hold on
plot(dist_800_SLine/1000, Vel_winter_800_SLine, 'color','b','linewidth',3)
xlabel('Distance along the gate [km]','fontsize',14,'fontweight','b')
ylabel('Velocity (m/yr)','fontsize',12,'fontweight','b')
l=legend('Summer','Winter')
set(l,'EdgeColor',[1 1 1])
set(gca,'fontsize',14)

print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Elevation_Thick_Vel_800m_Sline

%900
figure('PaperOrientation','landscape','position',[1 1 820 825])

subplot(3,1,1)
plot(dist_900_SLine/1000, Bed_900_SLine, 'color',[0.2 0 0],'linewidth',3)
hold on
plot(dist_900_SLine/1000, Elev_900_SLine, 'color','blue','linewidth',3)
title('900 m','fontsize',14,'fontweight','b')
l=legend('Bed','Mean Elevation','location','south')
set(l,'EdgeColor',[1 1 1])

ylabel('Elevation (m)','fontsize',12,'fontweight','b')
set(gca,'fontsize',14)

subplot(3,1,2)
plot(dist_900_SLine/1000, Thick_900_SLine, 'color','blue')
ylabel('Surface Change (m)','fontsize',12,'fontweight','b')
set(gca,'fontsize',14)
ylim([0 1150])


subplot(3,1,3)
plot(dist_900_SLine/1000, Vel_summer_900_SLine, 'color','r','linewidth',3)
hold on
plot(dist_900_SLine/1000, Vel_winter_900_SLine, 'color','b','linewidth',3)
xlabel('Distance along the gate [km]','fontsize',14,'fontweight','b')
ylabel('Velocity (m/yr)','fontsize',12,'fontweight','b')
l=legend('Summer','Winter')
set(l,'EdgeColor',[1 1 1])
set(gca,'fontsize',14)

print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Elevation_Thick_Vel_900m_Sline



%%

ice_density=1000; % kg/m3

figure('PaperOrientation','portrait','position',[1 1 950 825])
subplot(321)
plot([1:12],(Flux_600_monthly_SLine(2:13)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); hold on
plot([1:11],(Flux_600_monthly_SLine(14:end-1)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); 
xlim([0 13])
set(gca,'XTick',[1:12],'xticklabel',['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'],'fontsize',14)
ylabel('Ice discharge [km^3 s^{-1}]','fontsize',14,'fontweight','b')
%legend('2016','2017')
title('600 m','fontsize',12)
ylim([0 4]);

% subplot(332)
% plot([1:12],(Flux_650_monthly_SLine(2:13)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); hold on
% plot([1:11],(Flux_650_monthly_SLine(14:end-1)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); 
% xlim([0 13])
% set(gca,'XTick',[1:12],'xticklabel',['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'],'fontsize',14)
% %ylabel('Ice discharge [Gt yr^{-1}]','fontsize',14,'fontweight','b')
% %legend('2016','2017')
% title('650 m','fontsize',12)
% ylim([0 10]);

subplot(322)
plot([1:12],(Flux_700_monthly_SLine(2:13)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); hold on
plot([1:11],(Flux_700_monthly_SLine(14:end-1)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); 
xlim([0 13])
set(gca,'XTick',[1:12],'xticklabel',['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'],'fontsize',14)
%ylabel('Ice discharge [Gt yr^{-1}]','fontsize',14,'fontweight','b')
%legend('2016','2017')
title('700 m','fontsize',12)
ylim([0 4]);

% subplot(334)
% plot([1:12],(Flux_750_monthly(2:13)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); hold on
% plot([1:11],(Flux_750_monthly(14:end-1)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); 
% xlim([0 13])
% set(gca,'XTick',[1:12],'xticklabel',['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'],'fontsize',14)
% ylabel('Ice discharge [Gt yr^{-1}]','fontsize',14,'fontweight','b')
% %legend('2016','2017')
% title('750 m','fontsize',12)
% ylim([0 10]);

subplot(323)
plot([1:12],(Flux_800_monthly_SLine(2:13)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); hold on
plot([1:11],(Flux_800_monthly_SLine(14:end-1)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); 
xlim([0 13])
set(gca,'XTick',[1:12],'xticklabel',['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'],'fontsize',14)
%ylabel('Ice discharge [Gt yr^{-1}]','fontsize',14,'fontweight','b')
%legend('2016','2017')
ylabel('Ice discharge [km^3 s^{-1}]','fontsize',14,'fontweight','b')
title('800 m','fontsize',12)
ylim([0 4]);

% subplot(336)
% plot([1:12],(Flux_850_monthly(2:13)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); hold on
% plot([1:11],(Flux_850_monthly(14:end-1)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); 
% xlim([0 13])
% set(gca,'XTick',[1:12],'xticklabel',['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'],'fontsize',14)
% %ylabel('Ice discharge [Gt yr^{-1}]','fontsize',14,'fontweight','b')
% %legend('2016','2017')
% title('850 m','fontsize',12)
% ylim([0 10]);

subplot(324)
plot([1:12],(Flux_900_monthly_SLine(2:13)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); hold on
plot([1:11],(Flux_900_monthly_SLine(14:end-1)/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); 
xlim([0 13])
set(gca,'XTick',[1:12],'xticklabel',['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'],'fontsize',14)
%legend('2016','2017')
title('900 m','fontsize',12)
ylim([0 4]);


Flux_monthly_mean_2016_SLine=mean([Flux_600_monthly_SLine(2:13); Flux_700_monthly_SLine(2:13);  Flux_800_monthly_SLine(2:13); Flux_900_monthly_SLine(2:13)]);
Flux_monthly_mean_2017_SLine=mean([Flux_600_monthly_SLine(14:end-1); Flux_700_monthly_SLine(14:end-1); Flux_800_monthly_SLine(14:end-1); Flux_900_monthly_SLine(14:end-1)]); 

subplot(3,2,5:6)
plot([1:12],(Flux_monthly_mean_2016_SLine/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); hold on
plot([1:11],(Flux_monthly_mean_2017_SLine/1e+12)*(ice_density),'linestyle','-','linewidth',2, 'marker','.','markersize',15); 
xlim([0 13])
set(gca,'XTick',[1:12],'xticklabel',['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'],'fontsize',14)
%ylabel('Ice discharge [Gt yr^{-1}]','fontsize',14,'fontweight','b')
legend('2016','2017')
title('Mean','fontsize',12)
ylim([0 4]);
ylabel('Ice discharge [km^3 s^{-1}]','fontsize',14,'fontweight','b')



print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Monthly_Mean_Discharge_600m_to_900m_Sline



%%




% get fluxes in velocities summer and winter



figure('PaperOrientation','portrait','position',[1 1 820 825])

plot(dist_600(1:100:end-99),Vel_600_mean(2:13,:))

plot(dist_600,Elev_600);hold on;
plot(dist_600,Bed_600);hold on;

plot(dist_600,Vel_summer_600+800);hold on;
plot(dist_600,Vel_winter_600+800);hold on;

plot(dist_600,Z_600_summer);
plot(dist_600,Z_600_winter);

set(gca,'yTick',[1:100:1400],'yticklabel',[0:100:700, 0:100:1400],'fontsize',12)


figure('PaperOrientation','portrait','position',[1 1 820 825])
subplot(311)
plot(dist_900/1000,Elev_900);hold on;
plot(dist_900/1000,Bed_900);hold on;
plot(dist_900/1000,Z_900_summer);
plot(dist_900/1000,Z_900_winter);
set(gca,'fontsize',14)
ylabel('Elevation (m)','fontsize',14)
xlim([-10 80])
ylabel('Elevation (m)','fontsize',14)

subplot(3,1,2:3)

plot(dist_900/1000,Vel_summer_900);hold on;
plot(dist_900/1000,Vel_winter_900);hold on;
legend('Summer','Winter')
xlabel('Distance along the gate (km)','fontsize',14)
ylabel('Velocity (m yr^{-1})','fontsize',14)
set(gca,'fontsize',14)
xlim([-10 80])

set(gca,'yTick',[1:200:1600],'yticklabel',[0:200:1000, 0:200:400],'fontsize',12)


figure; plot(Z_600)

size(Z_600)
size(Thick_600)
% 63:87

% Summer and winter elevation  MEAN

Z_600_summer2016=nanmean(Z_600(:,68:71),2);
Z_600_winter2016=nanmean(Z_600(:,[64:67, 72:75]),2);

Z_600_summer2017=nanmean(Z_600(:,80:83),2);
Z_600_winter2017=nanmean(Z_600(:,[76:79, 84:87]),2);

%650
Z_650_summer2016=nanmean(Z_650(:,68:71),2);
Z_650_winter2016=nanmean(Z_650(:,[64:67, 72:75]),2);

Z_650_summer2017=nanmean(Z_650(:,80:83),2);
Z_650_winter2017=nanmean(Z_650(:,[76:79, 84:87]),2);


%700
Z_700_summer2016=nanmean(Z_700(:,68:71),2);
Z_700_winter2016=nanmean(Z_700(:,[64:67, 72:75]),2);

Z_700_summer2017=nanmean(Z_700(:,80:83),2);
Z_700_winter2017=nanmean(Z_700(:,[76:79, 84:87]),2);

%750
Z_750_summer2016=nanmean(Z_750(:,68:71),2);
Z_750_winter2016=nanmean(Z_750(:,[64:67, 72:75]),2);

Z_750_summer2017=nanmean(Z_750(:,80:83),2);
Z_750_winter2017=nanmean(Z_750(:,[76:79, 84:87]),2);

%800
Z_800_summer2016=nanmean(Z_800(:,68:71),2);
Z_800_winter2016=nanmean(Z_800(:,[64:67, 72:75]),2);

Z_800_summer2017=nanmean(Z_800(:,80:83),2);
Z_800_winter2017=nanmean(Z_800(:,[76:79, 84:87]),2);

%850
Z_850_summer2016=nanmean(Z_850(:,68:71),2);
Z_850_winter2016=nanmean(Z_850(:,[64:67, 72:75]),2);

Z_850_summer2017=nanmean(Z_850(:,80:83),2);
Z_850_winter2017=nanmean(Z_850(:,[76:79, 84:87]),2);

%900
Z_900_summer2016=nanmean(Z_900(:,68:71),2);
Z_900_winter2016=nanmean(Z_900(:,[64:67, 72:75]),2);

Z_900_summer2017=nanmean(Z_900(:,80:83),2);
Z_900_winter2017=nanmean(Z_900(:,[76:79, 84:87]),2);


% 
Z_600_summer=nanmean([Z_600_summer2016,Z_600_summer2017],2);
Z_600_winter=nanmean([Z_600_winter2016,Z_600_winter2017],2);

Z_650_summer=nanmean([Z_650_summer2016,Z_650_summer2017],2);
Z_650_winter=nanmean([Z_650_winter2016,Z_650_winter2017],2);

Z_700_summer=nanmean([Z_700_summer2016,Z_700_summer2017],2);
Z_700_winter=nanmean([Z_700_winter2016,Z_700_winter2017],2);

Z_750_summer=nanmean([Z_750_summer2016,Z_750_summer2017],2);
Z_750_winter=nanmean([Z_750_winter2016,Z_750_winter2017],2);

Z_800_summer=nanmean([Z_800_summer2016,Z_800_summer2017],2);
Z_800_winter=nanmean([Z_800_winter2016,Z_800_winter2017],2);

Z_850_summer=nanmean([Z_850_summer2016,Z_850_summer2017],2);
Z_850_winter=nanmean([Z_850_winter2016,Z_850_winter2017],2);

Z_900_summer=nanmean([Z_900_summer2016,Z_900_summer2017],2);
Z_900_winter=nanmean([Z_900_winter2016,Z_900_winter2017],2);

size(Vel_summer_600(1:100:end-99))


figure
plot(dist_600,Z_600_summer2016);hold on
plot(dist_600,Z_600_winter2016)

plot(dist_600,Z_600_summer2017);hold on
plot(dist_600,Z_600_winter2017)




figure
plot(dist_700,Z_700_summer2016);hold on
plot(dist_700,Z_700_winter2016)

plot(dist_700,Z_700_summer2017);hold on
plot(dist_700,Z_700_winter2017)




figure;

plot(dist_600,Z_600_summer);hold on
plot(dist_600,Z_600_winter)

plot(dist_650,Z_650_summer);hold on
plot(dist_650,Z_650_winter)

plot(dist_700,Z_700_summer);hold on
plot(dist_700,Z_700_winter)

plot(dist_750,Z_750_summer);hold on
plot(dist_750,Z_750_winter)

plot(dist_800,Z_800_summer);hold on
plot(dist_800,Z_800_winter)

plot(dist_850,Z_850_summer);hold on
plot(dist_850,Z_850_winter)

plot(dist_900,Z_900_summer);hold on
plot(dist_900,Z_900_winter)
