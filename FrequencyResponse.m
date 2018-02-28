clear all; % Clear workspace variables

% Initialise Variables
sampFreq = 16000; % In Hz
numPoints = 1024;

% Filter coefficients
b = [1 0.5]; % Numerator
a = [1 -1.8*cos(pi/16) 0.81]; % Denominator


% Calculate the Frequency Response
[h,f] = freqz(b,a,numPoints,sampFreq); % h = freq response vector, f = freq vector

% Plot the Frequency Response
plot(f,20*log10(abs(h))); grid on;
xlabel('Frequency Vector (Hz)');
ylabel('Magnitude (dB)');
title('Magnitude Response')


