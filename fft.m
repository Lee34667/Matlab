f = 10; % frequency = 10Hz
fs = 100; % sample rate = fs
t = 0:1/fs:1;
x = sin(2*pi*f*t); % generate 1 second sine wave 

% plot the first 200 data
subplot(221);
stem(t, x); grid on; axis([0 0.4 -2 2]); 
title('x(t) = sin(2*pi*f*t) in Time Domain');
ylabel('x(t) -------->');
xlabel('discrete time t------>');

y = fft(x);
magnitude = abs(y);
phase = angle(y);
F = linspace(0, fs, length(x)); % frequency range in (0, fs]

subplot(222); % display the spectrum in frequency domain 
stem(F, magnitude); 
grid on;
title('Magnitude in DFT Domain of x(t)'); ylabel('magnitude -------->');
xlabel('frequency f------>');

W = linspace(0, 2*pi, length(x)); % discrete frequency W in [0, 2\pi]

subplot(223);
stem(W, phase); grid on;
title('phase in DFT Domain of x(t)'); ylabel('phase(rad) -------->');
xlabel('discrete frequency W \in (0,2\pi)------>');

subplot(224); % display the spectrum in DFT domain 
stem(W, magnitude);
grid on;
title('Magnitude of DFT Domain of x(t)'); ylabel('magnitude -------->');
xlabel('discrete frequency W \in (0,2\pi)------>');
