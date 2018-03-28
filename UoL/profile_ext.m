function prof=profile_ext(X,Y,data,R)

[row,col]=map2pix(R,X,Y); data(data<=0)=nan;
prof=improfile(data,col(~isnan(col)),row(~isnan(row)));


end