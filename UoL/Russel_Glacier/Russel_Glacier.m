
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



% Seasonal mean

summer_2015=nanmean(Vel_Russel(:,:,summer_ind_2015),3);
summer_2016=nanmean(Vel_Russel(:,:,summer_ind_2016),3);
summer_2017=nanmean(Vel_Russel(:,:,summer_ind_2017),3);

summer_Russel=mean(cat(3,summer_2016,summer_2017),3);
summer_Russel(summer_Russel<29)=nan;

winter_2015=nanmean(Vel_Russel(:,:,winter_ind_2015),3);
winter_2016=nanmean(Vel_Russel(:,:,winter_ind_2016),3);
winter_2017=nanmean(Vel_Russel(:,:,winter_ind_2017),3);

winter_Russel=mean(cat(3,winter_2015,winter_2016,winter_2017),3);
%winter_Russel=movmean(winter_Russel,10,'omitnan');
winter_Russel(winter_Russel<29)=nan;


summer_minus_winter_Russel=summer_Russel-winter_Russel;
%summer_minus_winter_Russel=movmean(summer_minus_winter_Russel,10,'omitnan');

geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Summer_Russel.tif', summer_Russel, R_russel,'GeoKeyDirectoryTag',info_Russel.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Winter_Russel.tif', winter_Russel, R_russel,'GeoKeyDirectoryTag',info_Russel.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Summer_minus_winter_Russel.tif',summer_minus_winter_Russel, R_russel,'GeoKeyDirectoryTag',info_Russel.GeoTIFFTags.GeoKeyDirectoryTag);



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

V_g1summer=profile_ext(X_g1,Y_g1,summer_2016,R_russel);
V_g2summer=profile_ext(X_g2,Y_g2,summer_2016,R_russel);
V_g3summer=profile_ext(X_g3,Y_g3,summer_2016,R_russel);
V_g4summer=profile_ext(X_g4,Y_g4,summer_2016,R_russel);
V_g5summer=profile_ext(X_g5,Y_g5,summer_2016,R_russel);


V_g1winter=profile_ext(X_g1,Y_g1,winter_2016,R_russel);
V_g2winter=profile_ext(X_g2,Y_g2,winter_2016,R_russel);
V_g3winter=profile_ext(X_g3,Y_g3,winter_2016,R_russel);
V_g4winter=profile_ext(X_g4,Y_g4,winter_2016,R_russel);
V_g5winter=profile_ext(X_g5,Y_g5,winter_2016,R_russel);

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

G2_pts(i,1)=profile_ext(X_pts(3),Y_pts(3),V(:,:,i),R_russel);
G2_pts(i,2)=profile_ext(X_pts(4),Y_pts(4),V(:,:,i),R_russel);

G3_pts(i,1)=profile_ext(X_pts(5),Y_pts(5),V(:,:,i),R_russel);
G3_pts(i,2)=profile_ext(X_pts(6),Y_pts(6),V(:,:,i),R_russel);

G4_pts(i,1)=profile_ext(X_pts(7),Y_pts(7),V(:,:,i),R_russel);
G4_pts(i,2)=profile_ext(X_pts(8),Y_pts(8),V(:,:,i),R_russel);

G5_pts(i,1)=profile_ext(X_pts(9),Y_pts(9),V(:,:,i),R_russel);
G5_pts(i,2)=profile_ext(X_pts(10),Y_pts(10),V(:,:,i),R_russel);

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

%%%% Plot

figure('units','centimeters','position',[0 0 35 20]);

subplot(231)
plot(G1_pts_days(:,1),'k','linewidth',2);hold on
plot(G1_pts_days(:,2),'color',[0.6 0.6 0.6],'linewidth',2);
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[0:50:400])
title('Glacier 1','fontsize',14)
ylim([0 400])
set(gca,'fontsize',12)
ylabel('Velocity (m yr^{-1})','fontsize',14,'fontweight','bold')

%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

%fill([220,365,365,220],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','--','EdgeColor',[0.5 0.5 0.5])
%fill([0,110,110,0],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','--','EdgeColor',[0.5 0.5 0.5])

subplot(232)
plot(G2_pts_days(:,1),'k','linewidth',2);hold on
plot(G2_pts_days(:,2),'color',[0.6 0.6 0.6],'linewidth',2);
title('Glacier 2','fontsize',14)
ylim([0 400])
set(gca,'fontsize',12)
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[0:50:400])
xlabel('Days of year','fontsize',16,'fontweight','bold')
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

subplot(233)
plot(G3_pts_days(:,1),'k','linewidth',2);hold on
plot(G3_pts_days(:,2),'color',[0.6 0.6 0.6],'linewidth',2);
title('Glacier 3','fontsize',14)
ylim([0 400])
set(gca,'fontsize',12)
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[0:50:400])
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])


subplot(2,3,4.5)
plot(G4_pts_days(:,1),'k','linewidth',2);hold on
plot(G4_pts_days(:,2),'color',[0.6 0.6 0.6],'linewidth',2);
title('Glacier 4','fontsize',14)
ylim([0 400])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[0:50:400])
set(gca,'fontsize',12)
ylabel('Velocity (m yr^{-1})','fontsize',14,'fontweight','bold')
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

subplot(2,3,5.5)
plot(G5_pts_days(:,1),'k','linewidth',2);hold on
plot(G5_pts_days(:,2),'color',[0.6 0.6 0.6],'linewidth',2);
title('Glacier 5','fontsize',14)
ylim([0 400])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[0:50:400])
set(gca,'fontsize',12)
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

annotation(gcf,'textbox',[0.46 0.01354 0.15 0.06],'String',{'Days of year'},'LineStyle','none','fontweight','bold','FontSize',16,'FitBoxToText','on');

legend('P1','P2','location','northeast');

print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Pts_Russel_DaysOfYear
%print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Pts_Russel_DaysOfYear_Shadow



%%
%%%% Plot dividing winter mean
G1_winter_mean(1,1)=nanmean([G1_pts_days(1:110,1);G1_pts_days(220:365,1)]);
G1_winter_mean(1,2)=nanmean([G1_pts_days(1:110,2);G1_pts_days(220:365,2)]);

G2_winter_mean(1,1)=nanmean([G2_pts_days(1:110,1);G2_pts_days(220:365,1)]);
G2_winter_mean(1,2)=nanmean([G2_pts_days(1:110,2);G2_pts_days(220:365,2)]);

G3_winter_mean(1,1)=nanmean([G3_pts_days(1:110,1);G3_pts_days(220:365,1)]);
G3_winter_mean(1,2)=nanmean([G3_pts_days(1:110,2);G3_pts_days(220:365,2)]);

G4_winter_mean(1,1)=nanmean([G4_pts_days(1:110,1);G4_pts_days(220:365,1)]);
G4_winter_mean(1,2)=nanmean([G4_pts_days(1:110,2);G4_pts_days(220:365,2)]);

G5_winter_mean(1,1)=nanmean([G5_pts_days(1:110,1);G5_pts_days(220:365,1)]);
G5_winter_mean(1,2)=nanmean([G5_pts_days(1:110,2);G5_pts_days(220:365,2)]);


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
plot((G1_pts_days(:,1)/G1_winter_mean(1,1)-1)*100,'k','linewidth',2);hold on
plot((G1_pts_days(:,2)/G1_winter_mean(1,2)-1)*100,'color',[0.6 0.6 0.6],'linewidth',2);
title('Glacier 1','fontsize',14)
plot([0 400],[0 0],'linestyle','--','color',[0.7 0.7 0.7])
ylim([-40 110])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[-40:20:100])
set(gca,'fontsize',12)
ylabel('Speed-up relative to winter (%)','fontsize',12,'fontweight','bold')

%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

%fill([220,365,365,220],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','--','EdgeColor',[0.5 0.5 0.5])
%fill([0,110,110,0],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','--','EdgeColor',[0.5 0.5 0.5])

subplot(232)
plot((G2_pts_days(:,1)/G2_winter_mean(1,1)-1)*100,'k','linewidth',2);hold on
plot((G2_pts_days(:,2)/G2_winter_mean(1,2)-1)*100,'color',[0.6 0.6 0.6],'linewidth',2);
title('Glacier 2','fontsize',14)
plot([0 400],[0 0],'linestyle','--','color',[0.7 0.7 0.7])
ylim([-40 110])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[-40:20:100])
set(gca,'fontsize',12)
xlabel('Days of year','fontsize',16,'fontweight','bold')
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

subplot(233)
plot((G3_pts_days(:,1)/G3_winter_mean(1,1)-1)*100,'k','linewidth',2);hold on
plot((G3_pts_days(:,2)/G3_winter_mean(1,2)-1)*100,'color',[0.6 0.6 0.6],'linewidth',2);
title('Glacier 3','fontsize',14)
plot([0 400],[0 0],'linestyle','--','color',[0.7 0.7 0.7])
ylim([-40 110])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[-40:20:100])
set(gca,'fontsize',12)
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])


subplot(2,3,4.5)
plot((G4_pts_days(:,1)/G4_winter_mean(1,1)-1)*100,'k','linewidth',2);hold on
plot((G4_pts_days(:,2)/G4_winter_mean(1,2)-1)*100,'color',[0.6 0.6 0.6],'linewidth',2);
title('Glacier 4','fontsize',14)
plot([0 400],[0 0],'linestyle','--','color',[0.7 0.7 0.7])
ylim([-40 110])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[-40:20:100])
set(gca,'fontsize',12)
ylabel('Speed-up relative to winter (%)','fontsize',12,'fontweight','bold')
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

subplot(2,3,5.5)
plot((G5_pts_days(:,1)/G5_winter_mean(1,1)-1)*100,'k','linewidth',2);hold on
plot((G5_pts_days(:,2)/G5_winter_mean(1,2)-1)*100,'color',[0.6 0.6 0.6],'linewidth',2);
title('Glacier 5','fontsize',14)
plot([0 400],[0 0],'linestyle','--','color',[0.7 0.7 0.7])
ylim([-40 110])
set(gca,'xtick',[0:60:365],'xticklabel',[0:60:360],'XMinorTick','on','xgrid','on','ytick',[-40:20:100])
set(gca,'fontsize',12)
%fill([130,190,190,130],[0,0,400,400],[0.5 0.5 0.5],'FaceAlpha', 0.1,'linestyle','none','EdgeColor',[0.5 0.5 0.5])

annotation(gcf,'textbox',[0.46 0.01354 0.15 0.06],'String',{'Days of year'},'LineStyle','none','fontweight','bold','FontSize',16,'FitBoxToText','on');

legend('P1','P2','location','northeast');

print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Pts_Russel_DaysOfYear_Divided_Winter
%print -djpeg -r600 /nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/Russel_Glacier/Pts_Russel_DaysOfYear_Shadow



%%
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




