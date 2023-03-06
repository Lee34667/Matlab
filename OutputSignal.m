% Define the input signal
fs = 100;       % Sample rate in Hz
t = 0:(1/fs):0.5;   % Time vector for 0.5 seconds
f1 = 10;        % Frequency in Hz for sin(2*pi*f1*t)
f2 = 40;        % Frequency in Hz for sin(2*pi*f2*t)
x = sin(2*pi*f1*t) + sin(2*pi*f2*t);  % Input signal

% Define the system coefficients
b = [2 3 4 5];  % Numerator coefficients
a = 1;          % Denominator coefficient (only 1 in this case)

% Compute the output signal
y = filter(b, a, x);

% Plot the input and output signals in time domain
figure;
subplot(2,1,1);
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Input Signal');
subplot(2,1,2);
plot(t, y);
xlabel('Time (s)');
ylabel('Amplitude');
title('Output Signal');

% Plot the input and output signals in frequency domain
X = abs(fft(x));
Y = abs(fft(y));
f = linspace(0, fs, length(t));
figure;
subplot(2,1,1);
plot(f, X);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Spectrum of Input Signal');
subplot(2,1,2);
plot(f, Y);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Spectrum of Output Signal');
