f = 10;         % frequency = 10Hz
fs = 100;       % sample rate = fs
t = 0:1/fs:1;   % time vector
x = sin(2*pi*f*t); % generate 1 second sine wave 

% plot the first 200 data
subplot(221);
stem(t,x); grid on; axis([0 200*0.001 -1.2 1.2]); 
title('x(t) = sin(2*pi*f*t) in Time Domain');
ylabel('x(t) -------->');
xlabel('discrete time t------>');

% apply DFT
ln = length(x); 
y = zeros(1,ln);
for k=0:ln-1
    for n=0:ln-1
        y(k+1)=y(k+1)+(x(n+1)*exp(-(1i)*2*pi*k*n/ln)); 
    end
end
y = y/sqrt(ln); 

% compute inverse DFT
x_inv = zeros(1,ln);
for n=0:ln-1
    for k=0:ln-1
        x_inv(n+1) = x_inv(n+1) + (y(k+1) * exp((1i)*2*pi*k*n/ln));
    end
end
x_inv = real(x_inv) / max(abs(x_inv)); % scale the reconstructed signal

% plot the original and reconstructed signals
subplot(222);
stem(t,x_inv); grid on; axis([0 200*0.001 -1.2 1.2]); 
title('Reconstructed x(t) using Inverse DFT (scaled)');
ylabel('x_{inv}(t) -------->');
xlabel('discrete time t------>');

% compute and plot the DFT magnitude and phase
magnitude = abs(y);
phase = angle(y);
F = t * fs ; % frequency range in (0, fs]
W = t*2*pi; % discrete frequency W in [0, 2\pi]

subplot(223);
stem(W,phase); grid on;
title('phase in DFT Domain of x(t)'); ylabel('phase(rad) -------->');
xlabel('discrete frequency W \in (0,2\pi)------>');

subplot(224); % display the spectrum in DFT domain 
stem(W,magnitude);
grid on;
title('Magnitude of DFT Domain of x(t)'); ylabel('magnitude -------->');
xlabel('discrete frequency W \in (0,2\pi)------>');
