function [SNR1,SNR2] = snr_gamma(ccs, ccp, n,m)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I discussed with Charles if the ccp or ccs could be transformed in a sort of error estimate of the offset in pixels. We think it is, but be aware that this is only an indication that might be wrong for many estimates.
% 
% A simple expression that relates a cross-correlation parameter to the Signal-to-Noise Ratio (SNR) is given by E. Rodriguez and J. M. Martin, "Theory and design of interferometric synthetic aperture radars," Proc.
% Inst. Electr. Eng. Part F 139, 147-159 (1992).
% 
% (ccp) = 1/(1- 1/SNR).   (single pixel)
% 
% So the SNR = 1/(1/ccp -1).
% 
% The SNR improves proportional to sqrt(N) where N is the number of looks, and that is a big number for our patches, on the order of (n*m) where n and m are the height and width of the patch. Due to some oversampling of the original data  despite turning off explicit oversampling in the program, we propose a conservative estimate for the number of independent looks as N=(n*m/2):
% 
% So the estimated multi-look SNR looks like:
% 
% SNR = sqrt(N)/(1/ccp -1)
% 
% The uncertainty in the peak position is proportional to 1/sqrt(SNR)) in pixels.
% 
% Turning to the ccs, this is the average correlation value outside of the cross-correlation peak, something like the noise floor of the correlation function. It is a parameter that varies between 0.0 and 1.0. Charles was thinking that may be the SNR could be also estimated as
% 
% SNR = ccp/ccs
% 
% Error proportional to the SNR caclulated. The result is given in pixels
% 
% Error=1/sqrt(SNR);
% 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ccs=ccs;
ccp=ccp;
n=n; %height
m=m; %width

N=(m*n)/2; %N=number of looks
ind=find(ccp~=0);
SNR_1=sqrt(N).*ccp(ind)./(1.-ccp(ind));

[lin,col]=size(ccp);
snr1=nan((lin*col),1);
snr1(ind)=SNR_1;
SNR1=reshape(snr1,[lin,col]);
%error1=1./sqrt(SNR1);

ind2=find(ccs~=0 & ccp~=0);
SNR_2_=ccp(ind2)./ccs(ind2);
snr2=nan((lin*col),1);
snr2(ind)=SNR_2_;
SNR2=reshape(snr2,[lin,col]);
%error2=1./sqrt(SNR2);

end