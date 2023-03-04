% Generate a random signal
fs = 1000; % Sample rate
t = 0:1/fs:1; % Time vector
x = randn(size(t)); % Random signal

% Compute the power spectrum
pxx = pspectrum(x,fs);

% Plot the power spectrum
plot(pxx.Frequencies, 10*log10(pxx.Data));
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
title('Power Spectrum of Random Signal');
