% Grid de Latitudes e Longitude em Lambert:

% Limites das MASCARAS aplicadas no Modelo

Tt=90024309;
Ll=((720*25067.525)-90024309);
Rr=-90024309;
Bb=((-720*25067.525)+90024309);

Lat_lambert=Tt:-25067.525:Bb;
Long_lambert=Rr:25067.525:Ll;


[Y,X]=meshgrid(Long_lambert,Lat_lambert);

%Y=fliplr(Y);

% X=X(2:end,2:end);
X=X(:);
% Y=Y(2:end,2:end);
Y=Y(:);

% load D:\Users\Juliana\Trabalho\ARTIGO\Auxiliares\index_mask_all.mat


% X=X(index_mask);
% Y=Y(index_mask);

for i=1:size(X,1)
    [phi,lambda]=Lambert_inverse(X(i),Y(i));
    Lat_geo(i,1)=phi;
    Lon_geo(i,1)=lambda;
end

LAT_Lamb=reshape(Lat_geo,721,721);
LON_Lamb=reshape(Lon_geo,721,721);

save /media/alemos_serv/Backup_Lab/Dissert/Resultados/ZSNU/lat_lon_Lamb.mat LAT_Lamb LON_Lamb;
