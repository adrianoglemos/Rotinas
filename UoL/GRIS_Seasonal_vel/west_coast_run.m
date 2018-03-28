%% D30_Oct_2016

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D300_2016/12days/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D300_2016/12days/'];
d_opt=dir(pathsate_opt);
j=1;
for i=1:length(d_opt);
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name

j=1;
for i=1:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    dest=[destination];    
    %eval(['!mkdir ' dest]);

   
cd(path1);

 eval( ['!cp ./*zip ' dest]);

i
end

for i=1:15
    
    eval(['!mkdir ./i' num2str(i)]);
    
end
    
%

 pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D30_Oct_2016/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D30_Oct_2016/'];
d_opt=dir(pathsate_opt);
j=1;
for i=1:length(d_opt);
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
    
    !cp ../S1_running_PIG.sh ./
    
    eval(['!sed -i ''' '9s/D9D4/' name1 '/' ''' S1_running_PIG.sh'])
    eval(['!sed -i ''' '10s/78D9/' name2 '/' ''' S1_running_PIG.sh'])
    
    %dest=[destination];    
    %eval(['!mkdir ' dest]);

i
end










%% D120_2016

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D120_2016/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D120_2016/'];
d_opt=dir(pathsate_opt);
j=1;
for i=1:length(d_opt);
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name

j=1;
for i=1:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    dest=[destination];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*zip ' dest]);

i
end

cd(pathsate_opt)

for i=1:14
    
    eval(['!mkdir ./i' num2str(i)]);
    
end


%

%  pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D30_Oct_2016/'];
% destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D30_Oct_2016/'];
d_opt=dir(pathsate_opt);
j=1;
for i=1:length(d_opt);
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
    
    !cp ../S1_running_PIG.sh ./
    
    eval(['!sed -i ''' '9s/D9D4/' name1 '/' ''' S1_running_PIG.sh'])
    eval(['!sed -i ''' '10s/78D9/' name2 '/' ''' S1_running_PIG.sh'])
    
    %dest=[destination];    
    %eval(['!mkdir ' dest]);

i
end


%% D240_2016

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D240_2016/'];
destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D240_2016/'];
d_opt=dir(pathsate_opt);
j=1;
for i=1:length(d_opt);
    name=d_opt(i,1).name;
    data{j,1}=cellstr(name);
    %date{j,1}=cellstr(name(18:25));
    list_opt(j,1)=cellstr(data{j,1});
    j=j+1;
%folder=char(folder, data);
end
clear d_opt i j name

j=1;
for i=1:size(list_opt,1);
    path1=[pathsate_opt list_opt{i,1} '/'];
%   path2=[pathsate list{i+1,1} '/'];
    %d=dir(temp);
    dest=[destination];    
    %eval(['!mkdir ' dest]);

    date=list_opt{i,1};
cd(path1);

 eval( ['!cp ./*zip ' dest]);

i
end

cd(pathsate_opt)

for i=1:13
    
    eval(['!mkdir ./i' num2str(i)]);
    
end


%

pathsate_opt=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D240_2016/'];
% destination=['/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/D30_Oct_2016/'];
d_opt=dir(pathsate_opt);
j=1;
for i=1:length(d_opt);
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
    
    !cp ../S1_running_PIG.sh ./
    
    eval(['!sed -i ''' '9s/D9D4/' name1 '/' ''' S1_running_PIG.sh'])
    eval(['!sed -i ''' '10s/78D9/' name2 '/' ''' S1_running_PIG.sh'])
    
    %dest=[destination];    
    %eval(['!mkdir ' dest]);

i
end



%%

[Summer_2016_minus_winter_2017,Rs16_w17]=geotiffread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/SUMMER_2016_minus_WINTER_jan2017.tiff');

sar_mosaic=imread('/nfs/a59/eeagdl/Data/Available_Images/GRIS_Mosaic_test/SAR_100mCbandmultiyearSigma.tif');



Summer_2016_minus_winter_2017(-0.00001<Summer_2016_minus_winter_2017<0.00001)=nan;

figure
h=imagesc(Summer_2016_minus_winter_2017); tt=double(~isnan(Summer_2016_minus_winter_2017)); set(h,'AlphaData', tt);
caxis([-200 200]);

CT=cbrewer('div', 'RdYlBu',7);
colormap(flip(CT))
cb=colorbar
set(cb,'XTick',[-200:100:200])


imshow(sar_mosaic)
caxis([-30 -3.44625])













