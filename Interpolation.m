% Jordan Cahill
% 27/02/2018

clear all; close all;

n = 512; % Number of samples
fs = 6000; % Sampling frequency (Hz)
N = 5; % Order of interpolation = (30 kHz/6 kHz) = 5
t = n/fs; % Time (0.0853s)
ff = 600; % Fundamental frequency (Hz)

% Create first three harmonics of 600 Hz
y1 = sin(2.*pi.*(0:n-1).*(ff/fs)); 
y2 = sin(2.*pi.*(0:n-1).*(ff*2/fs));
y3 = sin(2.*pi.*(0:n-1).*(ff*3/fs));

% Sum harmonics to create final wave
y = y1 + y2 + y3;

% Insert zero-value samples
yZ = zeros(n*N,1); % Zero vector with length N times of original signal
yZ(1:N:end) = y; % Insert original samples at N intervals

% Design and apply low pass filter
order = 40; % Order of filter
fc = fs/2; % Cut-off frequency (Hz)
r = 500; % Roll-off (Hz)
fc = fc - r; % 'Realistic' cut-off frequency (Hz)
Wn = fc/((fs*N)/2); % Normalised cut-off frequency (Hz)
F = fir1(order, Wn); % Design low pass filter

yF = filter(F,1,yZ); % Apply LPF

% Original signal & interpolated signal time axes
% Both signals use different time axes so must be scaled appopriately
t1 = 0:1/fs:(t-(1/fs));
t2 = 0:1/(fs*N):(t-(1/(fs*N))); % Frequency * Interpolation rate

% Plot original sample vs interpolated signal
plot(t1,y); hold on; plot(t2,yF); grid on;
title('Original Signal vs Interpolated Signal');
xlabel('Time (s)'); ylabel('Magnitude'); hold off;
legend('Original Signal','Interpolated Signal');

nFFT = 8192; % FFT with 8192 points

% Calculate magnitude spectrum for original signal
yOrg = fft(y, nFFT); % Calculate FFT of original signal with zero padding
dfOrg = fs/nFFT;
fOrg = (0:nFFT-1) * dfOrg;
% Plotting from DC -> fs/2, so we discard the second half
fOrg = fOrg(1:end/2); yOrg = yOrg(1:end/2);

% Plot magnitude spectrum for original signal
figure(2); plot(fOrg/1000, abs(yOrg));  grid on;
xlabel('Frequency (kHz)'); ylabel('Magnitude');
title('Magnitude Spectrum - Original Signal');

% Calculate magnitude spectrum for interpolated signal
yInt = fft(yZ, nFFT); % Calculate FFT of interpolated signal with zero padding
dfInt = (fs*N)/nFFT;
fInt = (0:nFFT-1) * dfInt; % Normalized frequency 
% Plotting from DC -> fs/2, so we discard the second half
yInt = yInt(1:end/2); fInt = fInt(1:end/2); 

% Plot magnitude spectrum for interpolated signal
figure(3); plot(fInt/1000, abs(yInt));  grid on;
xlabel('Frequency (kHz)'); ylabel('Magnitude');
title('Magnitude Spectrum - Upsampled Signal (Interpolated)');

% Calculate magnitude spectrum for filtered signal
yFil = fft(yF, nFFT); % Calculate FFT of filtered signal with zero padding
fFil = fInt; % Can be reused from filtered signal
% Plotting from DC -> fs/2, so we discard the second half
yFil = yFil(1:end/2);

% Plot magnitude spectrum for filtered signal
figure(4); plot(fFil/1000, abs(yFil));  grid on;
xlabel('Frequency (kHz)'); ylabel('Magnitude');
title('Magnitude Spectrum - Filtered Signal');


