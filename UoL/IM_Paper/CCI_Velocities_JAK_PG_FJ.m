% PG

cd /nfs/a59/eeagdl/DATABASE/GREENLAND/CCI_products/Velocity/PG/greenland_iv_250m_s1_20150123_20160610_Petermann_Gletsjer/

ncdisp('greenland_iv_250m_s1_20150123_20160610_Petermann_Gletsjer_v1_0.nc');
x=ncread('greenland_iv_250m_s1_20150123_20160610_Petermann_Gletsjer_v1_0.nc','x');
y=ncread('greenland_iv_250m_s1_20150123_20160610_Petermann_Gletsjer_v1_0.nc','y');
crs=ncread('greenland_iv_250m_s1_20150123_20160610_Petermann_Gletsjer_v1_0.nc','crs');
time_bnds=ncread('greenland_iv_250m_s1_20150123_20160610_Petermann_Gletsjer_v1_0.nc','time_bnds');

east_vel_PG=ncread('greenland_iv_250m_s1_20150123_20160610_Petermann_Gletsjer_v1_0.nc','land_ice_surface_east_velocity');
north_vel_PG=ncread('greenland_iv_250m_s1_20150123_20160610_Petermann_Gletsjer_v1_0.nc','land_ice_surface_north_velocity');

imagesc((north_vel_PG(:,:,1).^2+east_vel_PG(:,:,1).^2).^0.5)
imagesc(y,x,(north_vel_PG(:,:,1).^2+east_vel_PG(:,:,1).^2).^0.5)
geoshow(x,y,(north_vel_PG(:,:,1).^2+east_vel_PG(:,:,1).^2).^0.5)

bed=ncread('MCdataset-2015-04-27.nc','bed');

errbed=ncread('MCdataset-2015-04-27.nc','errbed');

thick=ncread('MCdataset-2015-04-27.nc','thickness');

dem=ncread('MCdataset-2015-04-27.nc','surface');

geoid=ncread('MCdataset-2015-04-27.nc','geoid');

imagesc(x,y,bed);



ncdisp('/nfs/a59/eeagdl/DATABASE/GREENLAND/Velocity_Uni_Dresden/JAK/GRL_100_all.EPSG3413.vel_md.nc')




