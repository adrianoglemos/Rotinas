

pathsate=['/nfs/a41/L0data/S1/'];
d=dir(pathsate);

j=1;
for i=4:length(d);
name=d(i,1).name;
data{j,1}=cellstr(name);
list(j,1)=cellstr(data{j,1});
j=j+1;
%folder=char(folder, data);
end
clear d i j name

Tdata_list=[]; files_path=[];
for i=2:length(list);
    temp=[pathsate list{i,1}];
    d=dir(temp);
    ii=1;
    for j=3:length(d)
        name=d(j,1).name;
        dd{ii,1}=cellstr(name);
        list2(ii,1)=cellstr(dd{ii,1});
        ii=ii+1;
        FP=cellstr([temp '/']);
        files_path=[files_path;FP];
    end
    Tdata_list=[Tdata_list;list2];
    clear list2 dd d
end
clear pathsate temp name i j ii list data


% 'S1A_IW_SLC_161_089_004711_150220_191151_0082.2577_-047.3092'
% lat: 41:49 (4 after coma)
% lon: 51:59 (4 after coma)

% lat format: [0000.0000 0000.0000] 
% lon format: [0000.0000 0000.0000]

lat=[-074.0000 -068.000];
lon=[-080.0000 -065.0000];
destination=['/nfs/a59/eeagdl/Data/Available_Images/S1/kml/GeorgeVI/'];

% for i=1:length(Tdata_list)
% aaa=char(Tdata_list{i,1});
%     if (length(aaa)==59 & aaa(1:1)=='S' & aaa(1:10)=='S1A_IW_SLC')
%         if(str2num(aaa(41:49))>=(lat(1)-0.05) & str2num(aaa(41:49))<=(lat(2)+0.05) & str2num(aaa(51:59))>=(lon(1)-0.05) & str2num(aaa(51:59))<=(lon(2)+0.05))
%             eval(['cd ' char(files_path{i,1}) char(Tdata_list{i,1})]);
%             eval(['!cp *.kml ' destination char(Tdata_list{i,1}) '.kml']);
%         end
%       
%     end
% end


for i=1:length(Tdata_list)
aaa=char(Tdata_list{i,1});
    if (length(aaa)==59 & aaa(1:1)=='S' & aaa(1:10)=='S1A_IW_SLC')
        if(str2num(aaa(41:49))>=(lat(1)-0.05) & str2num(aaa(41:49))<=(lat(2)+0.05) & str2num(aaa(51:59))>=(lon(1)-0.05) & str2num(aaa(51:59))<=(lon(2)+0.05))
            eval(['cd ' char(files_path{i,1}) char(Tdata_list{i,1})]);
            eval(['!cp *.kml ' destination char(Tdata_list{i,1}) '.kml']);
        end
      
    end
end




 
% 
% for i=1781:length(Tdata_list)
% aaa=char(Tdata_list{i,1});
%     if (aaa(1:10)=='S1A_IW_SLC')
%         eval(['cd ' char(files_path{i,1}) char(Tdata_list{i,1})]);
%         eval(['!cp *.kml /nfs/a59/eeagdl/Data/Available_Images/S1/klm/' char(Tdata_list{i,1}) '.kml']);
%     end
% end
% 



  



