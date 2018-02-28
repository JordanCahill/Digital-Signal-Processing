% Jordan Cahill
% 26/02/2018

clear all; close all;

fs = 8000; % Sampling frequency (Hz)
t = 64e-3; % Duration (64 msec)
n = fs * t; % Number of samples = freq x duration (512)
ff = 600; % Fundamental frequency (Hz)

% Create first six harmonics of 600 Hz
y1 = sin(2.*pi.*(0:n-1).*(ff/fs)); 
y2 = sin(2.*pi.*(0:n-1).*(ff*2/fs));
y3 = sin(2.*pi.*(0:n-1).*(ff*3/fs));
y4 = sin(2.*pi.*(0:n-1).*(ff*4/fs));
y5 = sin(2.*pi.*(0:n-1).*(ff*5/fs));
y6 = sin(2.*pi.*(0:n-1).*(ff*6/fs));

% Create sine wave equal to the sum of the harmonics
y = y1 + y2 + y3 + y4 + y5 + y6;


% FIR Filter variables
d = 2; % Order of decimation = (8 kHz/4 kHz) = 2
order = 40; % Filter of order 40
fc = fs/(2*d); % Cutoff = 8000/4 = 2 kHz
r = 500; % Rolloff (Hz)
fc = fc - r; % 'Realistic cutoff frequency' (Hz)
Wn = fc/(fs/2); % Normalized frequency (Hz)

% Design and apply filter
F = fir1(order,Wn);
x = filter(F,1,y);

% Original sampling freq is 8 kHz so we can decimate the
% signal to 4 kHz by removing every second sample
xdec = x(1:d:end); 

% Original signal & decimated signal time axes
% Both signals use different time axes so must be scaled appopriately
t1 = 0:1/fs:(t-(1/fs));
t2 = 0:1/(fs/d):(t-(1/(fs/d))); % Frequency / Decimation rate

% Plot the original signal vs the decimated signal
plot(t1,y); hold on; plot(t2,xdec,'r');
xlabel('Time (s)'); ylabel('Magnitude');
title('Original Signal vs Decimated Signal');
legend('Original Signal', 'Decimated Signal');
hold off; grid on;

nFFT = 1024; % FFT with 1024 points

% Calculate magnitude spectrum for original signal
yFFT = fft(y, nFFT); % Calculate FFT of original signal with zero padding
df1 = fs/nFFT; 
fOrg = (0:nFFT-1)*df1; % Normalized frequency
% Plotting from DC -> fs/2, so we discard the second half
fOrg = fOrg(1:end/2); yFFT = yFFT(1:end/2);

% Plot magnitude spectrum for original signal
figure(2);
plot(fOrg/1000, abs(yFFT)); grid on;
xlabel('Frequency (kHz)'); ylabel('Magnitude');
title('Magnitude Spectrum - Original Signal');

% Generate magnitude spectrum for filtered signal
xFil = fft(x, nFFT); % FFT of filtered signal with zero padding
xFil = xFil(1:end/2); % Discard the second half
fFil = fOrg; % We can reuse the frequency from plotting the original signal

% Plot magnitude spectrum of filtered signal
figure(3);
plot(fFil/1000, abs(xFil)); grid on;
xlabel('Frequency (kHz)'); ylabel('Magnitude');
title('Magnitude Spectrum - Filtered Signal');

% Generate magnitude spectrum of decimated signal
xDec = fft(xdec, nFFT); % FFT of decimated signal with zero padding
df2 = (fs/d)/nFFT;
fDec = (0:nFFT-1)*df2; % Normalized frequency
xDec = xDec(1:end/2); fDec = fDec(1:end/2); % Discard second half

% Plot magnitude spectrum of decimated signal
figure(4);
plot(fDec/1000, abs(xDec)); grid on;
xlabel('Frequency (kHz)'); ylabel('Magnitude');
title('Magnitude Spectrum - Down-Sampled Signal (Decimated)');

