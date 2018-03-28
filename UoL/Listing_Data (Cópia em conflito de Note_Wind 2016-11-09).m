

pathsate=['/nfs/a41/L0data/S1/'];
d=dir(pathsate);

j=1;
for i=4:20;
name=d(i,1).name;
data{j,1}=cellstr(name);
list(j,1)=cellstr(data{j,1});
j=j+1;
%folder=char(folder, data);
end
clear d

Tdata_list=[];
for i=1:length(list);
    temp=[pathsate list{i,1}];
    d=dir(temp);
    ii=1;
    for j=4:length(d)
        name=d(j,1).name;
        dd{ii,1}=cellstr(name);
        list2(ii,1)=cellstr(dd{ii,1});
        ii=ii+1;
    end
    Tdata_list=[Tdata_list;list2];
    clear list2 dd d
end
clear pathsate temp name i j ii list data

a=fliplr(char(Tdata_list));
b=char(strtrim(cellstr(a)));
num=fliplr(char(b(:,15:20)));

%div=str2num(num)/175;
modulo_(:,1)=mod(str2num(num),175);
modulo_(:,2)=str2num(num)-floor(str2num(num)/175)*175;

TABLE=tabulate(num);
TABLE(:,4)=str2num(TABLE(:,1))/175;
table_mod=tabulate(modulo_(:,1));



  



