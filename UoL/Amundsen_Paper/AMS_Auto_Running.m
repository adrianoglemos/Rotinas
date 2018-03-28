

cd /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/PIG/Processing/T3

% Create the S1_running file:

track=['079';'125';'137'];

data_079{i,3} %date
data_079{i+1,3} %date2
data_079{i,4} %lat
data_079{i,5} %lon

j=1;k=1;l=1;m=1;n=1;o=1;p=1;q=1;

for i=1:size(data_079,1)

    d1=data_079{i,3}{1,1}
    la=data_079{i,4}{1,1}
    lo=data_079{i,5}{1,1}
    
    if (la=='-074' & lo=='-111')
     data_79_74_111{j,1}= data_079{i,1}; 
     data_79_74_111{j,2}= data_079{i,2} ;
     data_79_74_111{j,3}= data_079{i,3} ;
     data_79_74_111{j,4}= data_079{i,4} ;
     data_79_74_111{j,5}= data_079{i,5};
     j=j+1;
            
    end
    
   if (la=='-074' & lo=='-114')
     data_79_74_114{k,1}= data_079{i,1} ;
     data_79_74_114{k,2}= data_079{i,2} ;
     data_79_74_114{k,3}= data_079{i,3} ;
     data_79_74_114{k,4}= data_079{i,4} ;
     data_79_74_114{k,5}= data_079{i,5};
     k=k+1;
            
   end 
    
    if (la=='-075' & lo=='-106')
     data_79_75_106{l,1}= data_079{i,1} ;
     data_79_75_106{l,2}= data_079{i,2} ;
     data_79_75_106{l,3}= data_079{i,3} ;
     data_79_75_106{l,4}= data_079{i,4} ;
     data_79_75_106{l,5}= data_079{i,5};
     l=l+1;
            
    end
    
%     if (la=='-075' & lo=='-106')
%      data_79_75_106{l,1}= data_079{i,1} ;
%      data_79_75_106{l,2}= data_079{i,2} ;
%      data_79_75_106{l,3}= data_079{i,3} ;
%      data_79_75_106{l,4}= data_079{i,4} ;
%      data_79_75_106{l,5}= data_079{i,5};
%      l=l+1;
%             
%     end
    
    if (la=='-076' & lo=='-100')
     data_79_76_100{n,1}= data_079{i,1} ;
     data_79_76_100{n,2}= data_079{i,2} ;
     data_79_76_100{n,3}= data_079{i,3} ;
     data_79_76_100{n,4}= data_079{i,4} ;
     data_79_76_100{n,5}= data_079{i,5};
     n=n+1;
            
    end
    
    if (la=='-076' & lo=='-093')
     data_79_76_093{o,1}= data_079{i,1} ;
     data_79_76_093{o,2}= data_079{i,2} ;
     data_79_76_093{o,3}= data_079{i,3} ;
     data_79_76_093{o,4}= data_079{i,4} ;
     data_79_76_093{o,5}= data_079{i,5};
     o=o+1;
            
    end
    
    if (la=='-074' & lo=='-112')
     data_79_74_112{p,1}= data_079{i,1} ;
     data_79_74_112{p,2}= data_079{i,2} ;
     data_79_74_112{p,3}= data_079{i,3} ;
     data_79_74_112{p,4}= data_079{i,4} ;
     data_79_74_112{p,5}= data_079{i,5};
     p=p+1;
            
    end
    
    if (la=='-075' & lo=='-107')
     data_79_75_107{q,1}= data_079{i,1} ;
     data_79_75_107{q,2}= data_079{i,2} ;
     data_79_75_107{q,3}= data_079{i,3} ;
     data_79_75_107{q,4}= data_079{i,4} ;
     data_79_75_107{q,5}= data_079{i,5};
     q=q+1;
            
    end
end


for i=1:size(data_79_74_111,1)
n(i)=datenum(data_79_74_111{i,3}{1,1},'yymmdd');
end
[dates_79_74_111_sorted,I]=sort(n);
dates_79_74_111_yyyymmdd_sorted=datestr(dates_79_74_111_sorted,'yyyymmdd');
clear n I

for i=1:size(data_79_74_114,1)
n(i)=datenum(data_79_74_114{i,3}{1,1},'yymmdd');
end
[dates_79_74_114_sorted,I]=sort(n);
dates_79_74_114_yyyymmdd_sorted=datestr(dates_79_74_114_sorted,'yyyymmdd');
clear n I

for i=1:size(data_79_75_106,1)
n(i)=datenum(data_79_75_106{i,3}{1,1},'yymmdd');
end
[dates_79_75_106_sorted,I]=sort(n);
dates_79_75_106_yyyymmdd_sorted=datestr(dates_79_75_106_sorted,'yyyymmdd');
clear n I

for i=1:size(data_79_76_100,1)
n(i)=datenum(data_79_76_100{i,3}{1,1},'yymmdd');
end
[dates_79_76_100_sorted,I]=sort(n);
dates_79_76_100_yyyymmdd_sorted=datestr(dates_79_76_100_sorted,'yyyymmdd');
clear n I

for i=1:size(data_79_76_093,1)
n(i)=datenum(data_79_76_093{i,3}{1,1},'yymmdd');
end
[dates_79_76_093_sorted,I]=sort(n);
dates_79_76_093_yyyymmdd_sorted=datestr(dates_79_76_093_sorted,'yyyymmdd');
clear n I

for i=1:size(data_79_74_112,1)
n(i)=datenum(data_79_74_112{i,3}{1,1},'yymmdd');
end
[dates_79_74_112_sorted,I]=sort(n);
dates_79_74_112_yyyymmdd_sorted=datestr(dates_79_74_112_sorted,'yyyymmdd');
clear n I

for i=1:size(data_79_75_107,1)
n(i)=datenum(data_79_75_107{i,3}{1,1},'yymmdd');
end
[dates_79_75_107_sorted,I]=sort(n);
dates_79_75_107_yyyymmdd_sorted=datestr(dates_79_75_107_sorted,'yyyymmdd');
clear n I

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
j=1;k=1;l=1;m=1;n=1;o=1;p=1;q=1;

for i=1:size(data_125,1)

    d1=data_125{i,3}{1,1}
    la=data_125{i,4}{1,1}
    lo=data_125{i,5}{1,1}
    
    if (la=='-076' & lo=='-111')
     data_125_76_111{j,1}= data_125{i,1}; 
     data_125_76_111{j,2}= data_125{i,2} ;
     data_125_76_111{j,3}= data_125{i,3} ;
     data_125_76_111{j,4}= data_125{i,4} ;
     data_125_76_111{j,5}= data_125{i,5};
     j=j+1;
            
    end

if (la=='-076' & lo=='-106')
     data_125_76_106{k,1}= data_125{i,1}; 
     data_125_76_106{k,2}= data_125{i,2} ;
     data_125_76_106{k,3}= data_125{i,3} ;
     data_125_76_106{k,4}= data_125{i,4} ;
     data_125_76_106{k,5}= data_125{i,5};
     k=k+1;
            
end

  if (la=='-074' & lo=='-095')
     data_125_74_095{l,1}= data_125{i,1}; 
     data_125_74_095{l,2}= data_125{i,2} ;
     data_125_74_095{l,3}= data_125{i,3} ;
     data_125_74_095{l,4}= data_125{i,4} ;
     data_125_74_095{l,5}= data_125{i,5};
     l=l+1;
            
  end 
    
  if (la=='-075' & lo=='-101')
     data_125_75_101{m,1}= data_125{i,1}; 
     data_125_75_101{m,2}= data_125{i,2} ;
     data_125_75_101{m,3}= data_125{i,3} ;
     data_125_75_101{m,4}= data_125{i,4} ;
     data_125_75_101{m,5}= data_125{i,5};
     m=m+1;
            
  end
  if (la=='-075' & lo=='-102')
     data_125_75_102{n,1}= data_125{i,1}; 
     data_125_75_102{n,2}= data_125{i,2} ;
     data_125_75_102{n,3}= data_125{i,3} ;
     data_125_75_102{n,4}= data_125{i,4} ;
     data_125_75_102{n,5}= data_125{i,5};
     n=n+1;
            
  end

  if (la=='-074' & lo=='-096')
     data_125_74_096{o,1}= data_125{i,1}; 
     data_125_74_096{o,2}= data_125{i,2} ;
     data_125_74_096{o,3}= data_125{i,3} ;
     data_125_74_096{o,4}= data_125{i,4} ;
     data_125_74_096{o,5}= data_125{i,5};
     o=o+1;
            
  end 

end


for i=1:length(data_125_74_095)
n(i)=datenum(data_125_74_095{i,3}{1,1},'yymmdd');
end
[dates_125_74_095_sorted,I]=sort(n);
dates_125_74_095_yyyymmdd_sorted=datestr(dates_125_74_095_sorted,'yyyymmdd');
clear n I

for i=1:length(data_125_74_096)
n(i)=datenum(data_125_74_096{i,3}{1,1},'yymmdd');
end
[dates_125_74_096_sorted,I]=sort(n);
dates_125_74_096_yyyymmdd_sorted=datestr(dates_125_74_096_sorted,'yyyymmdd');
clear n I

for i=1:length(data_125_75_101)
n(i)=datenum(data_125_75_101{i,3}{1,1},'yymmdd');
end
[dates_125_75_101_sorted,I]=sort(n);
dates_125_75_101_yyyymmdd_sorted=datestr(dates_125_75_101_sorted,'yyyymmdd');
clear n I

for i=1:length(data_125_75_102)
n(i)=datenum(data_125_75_102{i,3}{1,1},'yymmdd');
end
[dates_125_75_102_sorted,I]=sort(n);
dates_125_75_102_yyyymmdd_sorted=datestr(dates_125_75_102_sorted,'yyyymmdd');
clear n I

for i=1:length(data_125_76_106)
n(i)=datenum(data_125_76_106{i,3}{1,1},'yymmdd');
end
[dates_125_76_106_sorted,I]=sort(n);
dates_125_76_106_yyyymmdd_sorted=datestr(dates_125_76_106_sorted,'yyyymmdd');
clear n I

for i=1:length(data_125_76_111)
n(i)=datenum(data_125_76_111{i,3}{1,1},'yymmdd');
end
[dates_125_76_111_sorted,I]=sort(n);
dates_125_76_111_yyyymmdd_sorted=datestr(dates_125_76_111_sorted,'yyyymmdd');
clear n I

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
j=1;k=1;l=1;m=1;n=1;o=1;p=1;q=1;

for i=1:size(data_137,1)

    d1=data_137{i,3}{1,1}
    la=data_137{i,4}{1,1}
    lo=data_137{i,5}{1,1}
    
    if (la=='-074' & lo=='-104')
     data_137_74_104{j,1}= data_137{i,1}; 
     data_137_74_104{j,2}= data_137{i,2} ;
     data_137_74_104{j,3}= data_137{i,3} ;
     data_137_74_104{j,4}= data_137{i,4} ;
     data_137_74_104{j,5}= data_137{i,5};
     j=j+1;
            
    end

    if (la=='-073' & lo=='-109')
     data_137_73_109{k,1}= data_137{i,1}; 
     data_137_73_109{k,2}= data_137{i,2} ;
     data_137_73_109{k,3}= data_137{i,3} ;
     data_137_73_109{k,4}= data_137{i,4} ;
     data_137_73_109{k,5}= data_137{i,5};
     k=k+1;

    end
    
    if (la=='-075' & lo=='-099')
     data_137_75_099{l,1}= data_137{i,1}; 
     data_137_75_099{l,2}= data_137{i,2} ;
     data_137_75_099{l,3}= data_137{i,3} ;
     data_137_75_099{l,4}= data_137{i,4} ;
     data_137_75_099{l,5}= data_137{i,5};
     l=l+1;

    end
    
    if (la=='-076' & lo=='-093')
     data_137_76_093{m,1}= data_137{i,1}; 
     data_137_76_093{m,2}= data_137{i,2} ;
     data_137_76_093{m,3}= data_137{i,3} ;
     data_137_76_093{m,4}= data_137{i,4} ;
     data_137_76_093{m,5}= data_137{i,5};
     m=m+1;

    end
    
    
    if (la=='-075' & lo=='-102')
     data_137_75_102{n,1}= data_137{i,1}; 
     data_137_75_102{n,2}= data_137{i,2} ;
     data_137_75_102{n,3}= data_137{i,3} ;
     data_137_75_102{n,4}= data_137{i,4} ;
     data_137_75_102{n,5}= data_137{i,5};
     n=n+1;

    end
    
    if (la=='-075' & lo=='-098')
     data_137_75_098{o,1}= data_137{i,1}; 
     data_137_75_098{o,2}= data_137{i,2} ;
     data_137_75_098{o,3}= data_137{i,3} ;
     data_137_75_098{o,4}= data_137{i,4} ;
     data_137_75_098{o,5}= data_137{i,5};
     o=o+1;

    end
    
    if (la=='-075' & lo=='-100')
     data_137_75_100{p,1}= data_137{i,1}; 
     data_137_75_100{p,2}= data_137{i,2} ;
     data_137_75_100{p,3}= data_137{i,3} ;
     data_137_75_100{p,4}= data_137{i,4} ;
     data_137_75_100{p,5}= data_137{i,5};
     p=p+1;

    end
end


for i=1:length(data_137_74_104)
n(i)=datenum(data_137_74_104{i,3}{1,1},'yymmdd');
end
[dates_137_74_104_sorted,I]=sort(n);
dates_137_74_104_yyyymmdd_sorted=datestr(dates_137_74_104_sorted,'yyyymmdd');
clear n I

for i=1:length(data_137_73_109)
n(i)=datenum(data_137_73_109{i,3}{1,1},'yymmdd');
end
[dates_137_73_109_sorted,I]=sort(n);
dates_137_73_109_yyyymmdd_sorted=datestr(dates_137_73_109_sorted,'yyyymmdd');
clear n I

for i=1:length(data_137_75_099)
n(i)=datenum(data_137_75_099{i,3}{1,1},'yymmdd');
end
[dates_137_75_099_sorted,I]=sort(n);
dates_137_75_099_yyyymmdd_sorted=datestr(dates_137_75_099_sorted,'yyyymmdd');
clear n I

for i=1:length(data_137_76_093)
n(i)=datenum(data_137_76_093{i,3}{1,1},'yymmdd');
end
[dates_137_76_093_sorted,I]=sort(n);
dates_137_76_093_yyyymmdd_sorted=datestr(dates_137_76_093_sorted,'yyyymmdd');
clear n I

for i=1:size(data_137_75_102,1)
n(i)=datenum(data_137_75_102{i,3}{1,1},'yymmdd');
end
[dates_137_75_102_sorted,I]=sort(n);
dates_137_75_102_yyyymmdd_sorted=datestr(dates_137_75_102_sorted,'yyyymmdd');
clear n I

for i=1:size(data_137_75_098,1)
n(i)=datenum(data_137_75_098{i,3}{1,1},'yymmdd');
end
[dates_137_75_098_sorted,I]=sort(n);
dates_137_75_098_yyyymmdd_sorted=datestr(dates_137_75_098_sorted,'yyyymmdd');
clear n I

for i=1:size(data_137_75_100,1)
n(i)=datenum(data_137_75_100{i,3}{1,1},'yymmdd');
end
[dates_137_75_100_sorted,I]=sort(n);
dates_137_75_100_yyyymmdd_sorted=datestr(dates_137_75_100_sorted,'yyyymmdd');
clear n I



% Replacing the information on the cript to run
info137=['137_075_100'; '137_075_098'; '137_075_102'; '137_076_093'; '137_075_099'; '137_073_109'; '137_074_104'];
info079=['079_075_107'; '079_074_112'; '079_076_093'; '079_076_100'; '079_075_106'; '079_074_114' ;'079_074_111'];
info125=['125_076_111'; '125_076_106';'125_075_102'; '125_075_101'; '125_074_096'; '125_074_095'];

for j=1:size(info137,1)

eval(['!mkdir /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/137/' info137(j,:)]);
    
for i=1:size(eval(['dates_137_' info137(j,6:end) '_sorted']),2)-1

date1=eval(['dates_137_' info137(j,6:end) '_yyyymmdd_sorted(i,:)']);
date2=eval(['dates_137_' info137(j,6:end) '_yyyymmdd_sorted(i+1,:)']);

eval(['!mkdir /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/137/' info137(j,:) '/' date1 '_' date2]);
eval(['cd /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/137/' info137(j,:) '/' date1 '_' date2]);

    
!cp /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/script/S1_running_PIG.sh ./

!sed -i '27s/track/137/' S1_running_PIG.sh

eval(['!sed -i ''' '4s/master/' date1 '/' ''' S1_running_PIG.sh'])
eval(['!sed -i ''' '5s/slave/' date2 '/' ''' S1_running_PIG.sh'])


temp_B=eval(['dates_137_' info137(j,6:end) '_sorted(i+1)'])-eval(['dates_137_' info137(j,6:end) '_sorted(i)']);

eval(['!sed -i ''' '36s/tB/' num2str(temp_B) '/' ''' S1_running_PIG.sh'])


eval(['!sed -i ''' '9s/-Lati/-' info137(j,5:7) '/' ''' S1_running_PIG.sh'])
eval(['!sed -i ''' '10s/-Long/-' info137(j,9:end) '/' ''' S1_running_PIG.sh'])
eval(['!sed -i ''' '11s/-Lati2/-' info137(j,5:7) '/' ''' S1_running_PIG.sh'])
eval(['!sed -i ''' '12s/-Long2/-' info137(j,9:end) '/' ''' S1_running_PIG.sh'])
 
cd ../ 
 
end
end


for j=1:size(info125,1)

eval(['!mkdir /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/125/' info125(j,:)]);
    
for i=1:size(eval(['dates_125_' info125(j,6:end) '_sorted']),2)-1

date1=eval(['dates_125_' info125(j,6:end) '_yyyymmdd_sorted(i,:)']);
date2=eval(['dates_125_' info125(j,6:end) '_yyyymmdd_sorted(i+1,:)']);

eval(['!mkdir /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/125/' info125(j,:) '/' date1 '_' date2]);
eval(['cd /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/125/' info125(j,:) '/' date1 '_' date2]);

    
!cp /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/script/S1_running_PIG.sh ./

!sed -i '27s/track/125/' S1_running_PIG.sh

eval(['!sed -i ''' '4s/master/' date1 '/' ''' S1_running_PIG.sh'])
eval(['!sed -i ''' '5s/slave/' date2 '/' ''' S1_running_PIG.sh'])


temp_B=eval(['dates_125_' info125(j,6:end) '_sorted(i+1)'])-eval(['dates_125_' info125(j,6:end) '_sorted(i)']);

eval(['!sed -i ''' '36s/tB/' num2str(temp_B) '/' ''' S1_running_PIG.sh'])


eval(['!sed -i ''' '9s/-Lati/-' info125(j,5:7) '/' ''' S1_running_PIG.sh'])
eval(['!sed -i ''' '10s/-Long/-' info125(j,9:end) '/' ''' S1_running_PIG.sh'])
eval(['!sed -i ''' '11s/-Lati2/-' info125(j,5:7) '/' ''' S1_running_PIG.sh'])
eval(['!sed -i ''' '12s/-Long2/-' info125(j,9:end) '/' ''' S1_running_PIG.sh'])
 
cd ../ 
 
end
end


for j=1:size(info079,1)

eval(['!mkdir /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/079/' info079(j,:)]);
    
for i=1:size(eval(['dates_79_' info079(j,6:end) '_sorted']),2)-1

date1=eval(['dates_79_' info079(j,6:end) '_yyyymmdd_sorted(i,:)']);
date2=eval(['dates_79_' info079(j,6:end) '_yyyymmdd_sorted(i+1,:)']);

eval(['!mkdir /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/079/' info079(j,:) '/' date1 '_' date2]);
eval(['cd /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/079/' info079(j,:) '/' date1 '_' date2]);

    
!cp /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/script/S1_running_PIG.sh ./

!sed -i '27s/track/079/' S1_running_PIG.sh

eval(['!sed -i ''' '4s/master/' date1 '/' ''' S1_running_PIG.sh'])
eval(['!sed -i ''' '5s/slave/' date2 '/' ''' S1_running_PIG.sh'])


temp_B=eval(['dates_79_' info079(j,6:end) '_sorted(i+1)'])-eval(['dates_79_' info079(j,6:end) '_sorted(i)']);

eval(['!sed -i ''' '36s/tB/' num2str(temp_B) '/' ''' S1_running_PIG.sh'])


eval(['!sed -i ''' '9s/-Lati/-' info079(j,5:7) '/' ''' S1_running_PIG.sh'])
eval(['!sed -i ''' '10s/-Long/-' info079(j,9:end) '/' ''' S1_running_PIG.sh'])
eval(['!sed -i ''' '11s/-Lati2/-' info079(j,5:7) '/' ''' S1_running_PIG.sh'])
eval(['!sed -i ''' '12s/-Long2/-' info079(j,9:end) '/' ''' S1_running_PIG.sh'])
 
cd ../ 
 
end
end




% Running the automatic script:

for j=1:size(info137,1)

%eval(['!mkdir /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/137/' info137(j,:)]);
    
for i=1:size(eval(['dates_137_' info137(j,6:end) '_sorted']),2)-1

date1=eval(['dates_137_' info137(j,6:end) '_yyyymmdd_sorted(i,:)']);
date2=eval(['dates_137_' info137(j,6:end) '_yyyymmdd_sorted(i+1,:)']);

%eval(['!mkdir /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/137/' info137(j,:) '/' date1 '_' date2]);
eval(['cd /nfs/a59/eeagdl/Data/Available_Images/S1/Processing/Amundsen_Sector/137/' info137(j,:) '/' date1 '_' date2]);

    
!S1_running_PIG.sh
 
cd ../ 
 
end
end



eval(['!sed -i ''' '4s/master/' date1 '/' ''' S1_running_PIG.sh'])
eval(['!sed -i ''' '5s/slave/' date1 '/' ''' S1_running_PIG.sh'])

eval(['!sed -i ''' '9s/' lat '/' nlat '/' ''' S1_running_PIG.sh'])
eval(['!sed -i ''' '10s/' lon '/' nlon '/' ''' S1_running_PIG.sh'])
eval(['!sed -i ''' '11s/' lat '/' nlat '/' ''' S1_running_PIG.sh'])
eval(['!sed -i ''' '12s/' lon '/' nlon '/' ''' S1_running_PIG.sh'])

!sed -i '27s/track/137/' S1_running_PIG.sh

eval(['!sed -i ''' '36s/' temp_B '/' ntemp_B '/' ''' S1_running_PIG.sh'])

!sed -i '5s/10980/date2/' S1_running_PIG.sh
!sed -i '11s/-10/-100/' master.dem.par
!sed -i '12s/10/100/' master.dem.par



