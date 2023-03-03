% Define the system coefficients
b = [2 3 4 5];
a = 1;

% Generate the input signal
x = [1 0 0 0];

% Compute the output signal
y = filter(b, a, x);

% Compute the Fourier transform of the input and output signals
X = fft(x);
Y = fft(y);

% Compute the magnitude and phase response of the system
H = Y ./ X;
magH = abs(H);
phaseH = angle(H);

% Plot the magnitude response
figure;
plot(magH);
xlabel('Frequency (Hz)');
ylabel('Magnitude response');
title('Magnitude and phase response of the system');

% Plot the phase response
figure;
plot(phaseH);
xlabel('Frequency (Hz)');
ylabel('Phase response (rad)');
title('Magnitude and phase response of the system');
