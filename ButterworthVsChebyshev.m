close all;
clear all;

% Initialise variables
fs = 10000; % Sampling frequency (Hz)
fc = 3000; % Cutoff frequency (Hz)
tb = 400; % Transition bandwidth (Hz)
sba = 35; % Stop band attenuation (dB)
pbr = 0.1; % Pass band ripple (Hz)

nf = fs/2; % Nyquist frequency (Hz)
pcf = fc/nf;
scf = (fc+tb)/nf; % Stop band cutoff frequency (Hz)

% Determine the order of the filter
[n,scf] = cheb1ord(pcf,scf,pbr,sba);

% Calculate filter coefficients (Chebyshev)
[b,a] = cheby1(n,pbr,pcf);

% Calculate filer coefficients (Butterworth)
fNorm = fc/(fs/2);
[b2,a2] = butter(n,fNorm);

% Calculate and plot magnitude responses
[h,f] = freqz(b,a,2048,fs);
[h2,f2] = freqz(b2,a2,2048,fs);
plot(f,20*log10(abs(h)),f2,20*log10(abs(h2)));
title('Magnitude response - Chebyshev vs Butterworth');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
legend('Chebyshev','Butterworth');
grid on;

% Plot amplitude response
figure();
plot(f,abs(h),f2,abs(h2));
title('Amplitude response - Chebyshev vs Butterworth');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
legend('Chebyshev','Butterworth');
grid on;