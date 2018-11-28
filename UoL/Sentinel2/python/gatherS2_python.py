#module load python3 python-libs

import numpy as np
import matplotlib.pyplot as plt
import scipy.io as sio
import matplotlib.colors as colors
import os, sys # ferramenta de GIS
import matplotlib.cm as cm
import matplotlib as mpl
import pandas as pd

#from skimage import io
from osgeo import ogr # ferramenta de GIS
from osgeo import gdal, gdalconst # ferramenta de GIS
from mpl_toolkits.basemap import Basemap
from matplotlib.mlab import bivariate_normal
from matplotlib.ticker import LogFormatter 

#load Matlab files:
import hdf5storage
from scipy.io import loadmat

# set the working directory
os.chdir('/nfs/a59/eeagdl/Data/Available_Images/S2')
# name of the file
ds=gdal.Open('/nfs/a59/eeagdl/Data/Available_Images/S2/JAK/STACK/Vel_S2_stack_DuFil.tif')
#read the TIF all bands
VelS2 = ds.ReadAsArray();
np.shape(VelS2)

##Load a MLI image####################
ds1=gdal.Open('/nfs/a59/eeagdl/DATABASE/GREENLAND/GIMP_DEM/gimpdem_90m.tif')
gimp = ds1.ReadAsArray()
gimp = np.ma.MaskedArray(gimp, mask=np.isnan(gimp))

x0_gimp, dx_gimp, dxdy_gimp, y0_gimp, dydx_gimp, dy_gimp = ds1.GetGeoTransform()
nrows_gimp, ncols_gimp = np.shape(gimp)
londata_gimp = np.linspace(x0_gimp, x0_gimp+dx_gimp*ncols_gimp,num=ncols_gimp)
latdata_gimp = np.linspace(y0_gimp, y0_gimp+dy_gimp*nrows_gimp,num=nrows_gimp)
lons, lats = np.meshgrid(londata_gimp, latdata_gimp)  

#####################################################
## In case you want to selct one band
#band = thw.GetRasterBand(1)
#arr = band.ReadAsArray()
###############


#eliminate nan values
VelS2=np.where(np.abs(VelS2)<=0.5,np.nan,VelS2)

#print the file size (BANDS,ROW,COL)
print(VelS2.shape)

#Masking the nan values
VelS2_nan = np.ma.MaskedArray(VelS2, mask=np.isnan(VelS2))

#Calculate the nanmean:

VelS2_mean=np.nanmean(VelS2_nan,axis=0);


x0, dx, dxdy, y0, dydx, dy = ds.GetGeoTransform()
ndim, nrows, ncols = np.shape(VelS2)
Xdata = np.linspace(x0, x0+dx*ncols,num=ncols)
Ydata = np.linspace(y0, y0+dy*nrows,num=nrows)
Xs, Ys = np.meshgrid(Xdata, Ydata)  


#Transform X and Y in Lat Lon
#m = Basemap(width=1000000,height=600000,projection='npstere',lat_ts=72, lat_0=68,lon_0=-50,resolution='h')#JAK
#Lon, Lat = m(Xdata,Ydata,inverse=True)
#Lons, Lats = m(Xs, Ys,inverse=True)

#############################################################################
### plotting the figure LOG scale
#fig, ax = plt.subplots(2, 1)
#ax=plt.subplots(1,2)
#cmap = mpl.cm.RdYlBu
#plt.clim(np.log10(10),np.log10(4000))

plt.imshow(thw_mli,cmap='Greys_r',vmin=0, vmax=0.27)
plt.imshow(np.log10(thw_mean),cmap='RdYlBu_r', vmin=np.log10(100), vmax=np.log10(4000),alpha=0.85)
#plt.imshow(np.log10(thw_mean),cmap='RdYlBu_r')
cb = plt.colorbar(ticks=[np.log10(100),np.log10(500),np.log10(1500),np.log10(4000)],extend='both')
cb.ax.set_yticklabels(['100','500','1500','4000'])
plt.savefig("/nfs/a59/eeagdl/test_THW4.png", dpi=300)

plt.show()




#################################################
# Plot things with Basemap

import pyproj
p=pyproj.Proj(init='epsg:32622')  # UTM zone 22N W - Sentinel 2 projection

lonxx,latxx=p(Xs,Ys,inverse=True) # Convert from UTM to lat lon
lonx,latx=p(Xdata,Ydata,inverse=True)

m = Basemap(width=1000000,height=600000,projection='stere',lat_ts=72, lat_0=68,lon_0=-50,resolution='i')

xxs, yys = m(lonxx, latxx) #put the coordinates into the Basemap figure
xxdata, yydata = m(lonx, latx)

# Convert GIMP cordinates:
p2=pyproj.Proj(init='epsg:3413') # WGS84 nsidc north pole

LonGimp,LatGimp=p2(lons,lats,inverse=True)
Xgimp,Ygimp= m(LonGimp,LatGimp) #put the coordinates into the Basemap figure




plt.contourf(xxs, yys,VelS2_mean,20)


plt.pcolormesh(Xgimp,Ygimp,gimp,cmap='gray')

plt.figure()
#m.drawcoastlines()
plt.pcolormesh(xxs, yys,VelS2_mean,vmin=0, vmax=10000,cmap='RdYlBu_r',alpha=0.5)
plt.colorbar()
plt.axis('off')
plt.savefig("/nfs/a59/eeagdl/test_S2.png", dpi=300)



#m.drawmapscale()
#m.drawcoastlines()
#m.fillcontinents(color='gray')

#m.shadedrelief()


#plt.pcolormesh(londata_mli, latdata_mli,thw_mli,cmap='Greys_r',vmin=0, vmax=0.3, rasterized=False)

plt.contourf(Xs,Ys,VelS2_mean,20,colors='RdYlBu_r', vmin=0, vmax=8000,alpha=0.5)
cb = plt.colorbar(ticks=[np.log10(100),np.log10(500),np.log10(1500),np.log10(4000)],extend='both')
map.readshapefile(

cb.ax.set_yticklabels(['100','500','1500','4000'])
#cb = plt.colorbar(extend='max')
cb.set_label('Velocity [m/yr]')

plt.savefig("/nfs/a59/eeagdl/test_THW4.png", dpi=300)
#plt.clim(10,3500)



######################################################################
### Creating a discrete plot:
# By Jake VanderPlas
# License: BSD-style

import matplotlib.pyplot as plt
import numpy as np


def discrete_cmap(N, base_cmap=None):
    """Create an N-bin discrete colormap from the specified input map"""

    # Note that if base_cmap is a string or None, you can simply do
    #    return plt.cm.get_cmap(base_cmap, N)
    # The following works for string, None, or a colormap instance:

    base = plt.cm.get_cmap(base_cmap)
    color_list = base(np.linspace(0, 1, N))
    cmap_name = base.name + str(N)
    return base.from_list(cmap_name, color_list, N)
    #return LinearSegmentedColormap.from_list(cmap_name, color_list, N)


#######################################################################

mp=plt.pcolormesh(londata, latdata,thw_mean,cmap=discrete_cmap(4,'RdYlBu_r'),alpha=0.09, vmin=0, vmax=4000)

plt.colorbar( cmap=discrete_cmap(4,'RdYlBu_r'),spacing='proportional', ticks=np.linspace(0,4000,5),extend='both')

CS=plt.contour(londata, latdata,thw_mean,5,colors='k',linestyles='dashed',linewidths=1.0)

plt.clabel(CS, fontsize=9, inline=1);

#cb.ax.set_yticklabels(['0','500','1500','3500'])
plt.show()

plt.pcolor(londata, latdata,thw_mean,cmap='RdYlBu_r',alpha=0.3, vmin=0, vmax=4000)

plt.contourf(xxs, yys,VelS2_mean,levels=np.linspace(0,18000,100),cmap='RdYlBu_r',alpha=0.5,linestyle='none',vmins=0,vmaxs=18000)
plt.colorbar(extend='both')
#plt.colorbar( spacing='proportional', extend='both')

###############################################################
# Plotting time series along a 3D matrix:

plt.plot(thw[:,1185,1305], linewidth=2.0,linestyle='--');

#setting
plt.ylabel('Velocity [m yr$^-1$]',fontsize=14,fontweight='bold');
plt.xlabel('Date',fontsize=14,fontweight='bold');
plt.title('Thwaites velocity',fontsize=14,fontweight='bold');

plt.ylim(1000,1300);
plt.xlim(-2,25);

# adding some text:
plt.text(5, 1100, r'$\mu=100,\ \sigma=15$')





###################################################################################
# Interactive plot:

import numpy as np 
import matplotlib.pyplot as plt  

# Handle mouse clicks on the plot:
class LineSlice:
    '''Allow user to drag a line on a pcolor/pcolormesh plot, and plot the Z values from that line on a separate axis.

    Example
    -------
    fig, (ax1, ax2) = plt.subplots( nrows=2 )    # one figure, two axes
    img = ax1.pcolormesh( x, y, Z )     # pcolormesh on the 1st axis
    lntr = LineSlice( img, ax2 )        # Connect the handler, plot LineSlice onto 2nd axis

    Arguments
    ---------
    img: the pcolormesh plot to extract data from and that the User's clicks will be recorded for.
    ax2: the axis on which to plot the data values from the dragged line.


    '''
    def __init__(self, img, ax):
        '''
        img: the pcolormesh instance to get data from/that user should click on
        ax: the axis to plot the line slice on
        '''
        self.img = img
        self.ax = ax
        self.data = img.get_array().reshape(img._meshWidth, img._meshHeight)

        # register the event handlers:
        self.cidclick = img.figure.canvas.mpl_connect('button_press_event', self)
        self.cidrelease = img.figure.canvas.mpl_connect('button_release_event', self)

        self.markers, self.arrow = None, None   # the lineslice indicators on the pcolormesh plot
        self.line = None    # the lineslice values plotted in a line
    #end __init__

    def __call__(self, event):
        '''Matplotlib will run this function whenever the user triggers an event on our figure'''
        if event.inaxes != self.img.axes: return     # exit if clicks weren't within the `img` axes
        if self.img.figure.canvas.manager.toolbar._active is not None: return   # exit if pyplot toolbar (zooming etc.) is active

        if event.name == 'button_press_event':
            self.p1 = (event.xdata, event.ydata)    # save 1st point
        elif event.name == 'button_release_event':
            self.p2 = (event.xdata, event.ydata)    # save 2nd point
            self.drawLineSlice()    # draw the Line Slice position & data
    #end __call__

    def drawLineSlice( self ):
        ''' Draw the region along which the Line Slice will be extracted, onto the original self.img pcolormesh plot.  Also update the self.axis plot to show the line slice data.'''
        '''Uses code from these hints:
        http://stackoverflow.com/questions/7878398/how-to-extract-an-arbitrary-line-of-values-from-a-numpy-array
        http://stackoverflow.com/questions/34840366/matplotlib-pcolor-get-array-returns-flattened-array-how-to-get-2d-data-ba
        '''

        x0,y0 = self.p1[0], self.p1[1]  # get user's selected coordinates
        x1,y1 = self.p2[0], self.p2[1]
        length = int( np.hypot(x1-x0, y1-y0) )
        x, y = np.linspace(x0, x1, length),   np.linspace(y0, y1, length)

        # Extract the values along the line with nearest-neighbor pixel value:
        # get temp. data from the pcolor plot
        zi = self.data[x.astype(np.int), y.astype(np.int)]
        # Extract the values along the line, using cubic interpolation:
        #import scipy.ndimage
        #zi = scipy.ndimage.map_coordinates(self.data, np.vstack((x,y)))

        # if plots exist, delete them:
        if self.markers != None:
            if isinstance(self.markers, list):
                self.markers[0].remove()
            else:
                self.markers.remove()
        if self.arrow != None:
            self.arrow.remove()

        # plot the endpoints
        self.markers = self.img.axes.plot([x0, x1], [y0, y1], 'wo')   
        # plot an arrow:
        self.arrow = self.img.axes.annotate("",
                    xy=(x0, y0),    # start point
                    xycoords='data',
                    xytext=(x1, y1),    # end point
                    textcoords='data',
                    arrowprops=dict(
                        arrowstyle="<-",
                        connectionstyle="arc3", 
                        color='white',
                        alpha=0.7,
                        linewidth=3
                        ),

                    )

        # plot the data along the line on provided `ax`:
        if self.line != None:
            self.line[0].remove()   # delete the plot
        self.line = self.ax.plot(zi)
    #end drawLineSlice()

#end class LineTrace

D = np.genfromtxt(DataFilePath, ...)
D=VelS2_mean;
fig, axes = plt.subplots(nrows=2, ncols=1)

# plot the data
img = axes[0].pcolormesh( np.arange( len(D[0,:]) ), np.arange(len(D[:,0])), D )

# register the event handler:
LnTr = LineSlice(img, axes[1])    # args: the pcolor plot (img) & the axis to plot the values on (ax2)


