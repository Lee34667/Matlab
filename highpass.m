n = 50; % filter order
fs = 8000; % sampling frequency
fc = 1000; % cutoff frequency
wc = 2*pi*fc/fs; % normalized cutoff frequency
b = fir1(n, wc, 'high', hamming(n+1)); % design the filter using the Hamming window
% generate a test signal
t = 0:1/fs:1;
x = sin(2*pi*500*t) + sin(2*pi*1000*t) + sin(2*pi*1500*t) + sin(2*pi*2000*t);

% apply the highpass filter to the signal
y = filter(b, 1, x);

% plot the frequency response of the filtered signal
[H, W] = freqz(b, 1, 1024, fs);
figure;
plot(W, 20*log10(abs(H)));
title('Frequency Response of Highpass Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
