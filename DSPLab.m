%% Experiment with sampling of a sine wave.
% You are expected to run the program one section at a time and examine the
% results. %
% Create a tone (sine wave) of frequency 1 kHz (1000 Hz)
f = 1000;
% Choose a sampling rate of 8 kHz which is definitely way above twice the
% highest frequency in the signal. 
fs = 8000;
% Let the signal be 1 second long so we can hear it clearly without being
% too long.
t = 0:1/ fs :1;
x = sin(2*pi*f*t);
% Plot first six milliseconds of the tone. Observe that in 6 milliseconds,
% you get 6 complete cycles of the waveform as expected for a 1 kHz signal. 
plot(t,x); grid on; axis([0 6e-03 -1.2 1.2]);
% Listen to the signal. You can hear a 1 kHz tone, right?
sound(x,fs);
%% What would happen if you sampled at 1500 Hz (i.e. less than 2*f)?
% Fs/2 = 750 Hz, so f exceeds Fs/2. This means that the sampled signal
% would appear as -(Fs - f) = -(1500 - 1000) = -500 Hz. Let us check.
f = 10;
fs = 100;
ds_factor = 2;
downsampled_fs = fs / ds_factor;
t = 0:1/fs:1; % sampling instants corresponding to the new fs.
x = sin(2*pi*f*t); % we did not change ’f’, it is still 1000 Hz.
x_downsampled = downsample(x, ds_factor); % downsample signal by a factor of 2
t_downsampled = 0:1/downsampled_fs:1; % adjust sampling instants for new sampling rate
plot(t_downsampled, x_downsampled); grid on; axis([0 6e-03 -1.2 1.2]);
% Plot first 6 milliseconds. You expect to see 3 cycles since 500 Hz is 2ms
% per cycle. You also expect to see opposite phase since the frequency is
% negative. Check!
%plot(t,x); grid on; axis([0 6e-03 -1.2 1.2]);
% Listen to the signal. Does it sound the same as before? No, it is 500 Hz. sound(x,fs); 
% Don’t forget to specify ’fs’ in the ’sound’ command.
%% What if the sine wave being sampled has a frequency ’f’ that is higher than ’ fs’?
% The aparent frequency will again be (f - fs). Try sampling a
% 4500 Hz signal at a sampling rate of 4000 Hz and see (listen).
f = 2000;
fs = 1500;
t = 0:1/ fs :1;
x = sin(2*pi*f*t);
plot(t,x); grid on; axis([0 6e-03 -1.2 1.2]);
% Listen to the signal. It is 500 Hz as in the previous section but note % the initial phase in the plot. Why is it different from the previous
% section?
sound(x,fs);

