clear all; % Clear workspace
close all;

% Initialise variables; all given in question
numPoints = 2048;
sampFreq = 20000; 
poleFreq = 3500;
poleRad = 0.95;

% Create our transfer functions
% Calculate center freq
w = 2*pi*(poleFreq/sampFreq);
% Calculate b1 & b2 fro transfer function
b1 = -2*poleRad*cos(w);
b2 = poleRad^2;
% Concanate to a transfer function
b = [1]; % Numerator
a = [1 b1 b2]; % Denominator

% Calculate and plot freq response
[h,f] = freqz(b,a,numPoints,sampFreq);
plot(f,20*log10(abs(h)));
xlabel('Frequency Vector (Hz)');
ylabel('Magnitude (dB)');
title('Magnitude Response')

% Calculate and plot impulse response
figure;
impz(b,a,100);
