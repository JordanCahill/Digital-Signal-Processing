clear all;
close all;

% Initialise variables
Fs = 8000; % Sampling freq in Hz
Fc = 2000; % Cutoff freq in Hz
Tb = 300; % Transition bandwidth in Hz
numSamp = 2048; % Number of samples for freq response
nF = Fs/2; % Nyquist Frequency - Max frequency in the band

% Normalise Fc and Tb
FcNorm = Fc/nF;
TbNorm = Tb/nF;

% Create normalised freq vector, and the respective amplititudes vector
f = [0 FcNorm FcNorm+TbNorm 1]; % Range 0-1 in ascending order
a = [1 1 0 0];

for n = 20:5:50 % Loop from 21 to 51 coefficients in steps of 5
   
    figure();
    
    % Using Parks-Mclellan
    b=firpm(n,f,a); % Outputs nth+1 order coefficients
    [h,freq] = freqz(b,1,numSamp,Fs);
    
    % Using Hamming Window
    bHamming=fir1(n,FcNorm); % Outputs nth+1 order coefficients
    [hH,fH] = freqz(bHamming,1,numSamp,Fs); 
    
    % Plot magnitude response
    plot(freq,20*log10(abs(h)),fH,20*log10(abs(hH)));
    title(['Parks-McClellan vs Hamming Window, order: ' num2str(n+1)]);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    legend('Parks-McClellan','Hamming Window');
    grid on;
end
