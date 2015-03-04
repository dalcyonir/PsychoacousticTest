function [stereo1]=createReverberant(room,distance);

clc
cd ('C:\Program Files\Matlab\R2007b\work\equalizationfolder2')
cd aachen

airpar.fs = 44100;
airpar.rir_type=1;
airpar.room=room;
airpar.head=1;
airpar.rir_no=distance; 
airpar.azimuth=0; 

% Load  BRIRs
% Right
airpar.channel = '0';
BRIR_r = load_air(airpar);

% Left
airpar.channel = '1';
BRIR_l = load_air(airpar);

cd ..
cd Anechoic
cello1=wavread('Male.wav');


cello1=cello1(1:250000);

% normalizing the anechoic signal at a factor specified above in order to be
% between -1 and +1 and no clipping to occur in the convolved signal

%cello1=cello1./(max(abs(cello1)));

%convolving
cd ..
left2=FFTconv(BRIR_l',cello1);
right2=FFTconv(BRIR_r',cello1);

cd asked

norm=max(max(abs(left2)),max(abs(right2)));
left2=left2./norm;
right2=right2./norm;

stereo1=[left2,right2];
wavwrite(stereo1,44100,16,'booth_2m.wav');

cd ..

%[B1f fff]=averfft(stereo1,0,length(stereo1));
%semilogx(fff,B1f,'r');



