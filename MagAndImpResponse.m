clear all; % Clear workspace
close all;

% Global variables
numPoints = 2048;
sampFreq = 20000;

% -------------- Filter (i) -----------------------
% Calculate magnitude response
bi = [0.16 -0.48 0.48 -0.16];
ai = [1 0.13 0.52 0.3];
[hi,fi] = freqz(bi,ai,numPoints, sampFreq);

% Plot magnitude response
figure();
subplot(2,1,1);
plot(fi,20*log10(abs(hi)));
title("Magnitude response - Part (i)");
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');

% Plot impulse response
subplot(2,1,2);
impz(bi, ai);
title('Impulse response - Part (i)');


% -------------- Filter (ii) -----------------------
% Calculate magnitude response
bii = [0.634 0 -0.634];
aii = [1 0 -0.268];
[hii,fii] = freqz(bii,aii,numPoints, sampFreq);

% Plot magnitude response
figure(); 
subplot(2,1,1);
plot(fii,20*log10(abs(hii))); 
title("Magnitude response - Part (ii)");
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');

% Plot impulse response
subplot(2,1,2);
impz(bii, aii); 
title('Impulse response - Part (ii)');


% -------------- Filter (iii) -----------------------
% Calculate magnitude response
biii = [0.634 0 0.634];
aiii = [1 0 0.268];
[hiii,fiii] = freqz(biii,aiii,numPoints, sampFreq);

% Plot magnitude response
figure(); 
subplot(2,1,1);
plot(fiii,20*log10(abs(hiii))); 
title("Magnitude response - Part (iii)");
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');

% Plot impulse response
subplot(2,1,2);
impz(biii, aiii); 
title('Impulse response - Part (iii)');


% -------------- Filter (iv) -----------------------
% Calculate magnitude response
biv = [0.634 -5 10];
aiv = [10 -5 1];
[hiv,fiv] = freqz(biv,aiv,numPoints, sampFreq);

% Plot magnitude response
figure(); 
subplot(2,1,1);
plot(fiv,20*log10(abs(hiv))); 
title("Magnitude response - Part (iv)");
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');

% Plot impulse response
subplot(2,1,2);
impz(biv, aiv); 
title('Impulse response - Part (iv)');