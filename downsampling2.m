f = 10;
fs = 100;
ds_factor = 2;
downsampled_fs = fs / ds_factor;
t = 0:1/fs:1; % sampling instants corresponding to the new fs.
x = sin(2*pi*f*t); % we did not change ’f’, it is still 1000 Hz.
x_downsampled = downsample(x, ds_factor); % downsample signal by a factor of 2
t_downsampled = 0:1/downsampled_fs:1; % adjust sampling instants for new sampling rate

% First plot for the discrete time of x
subplot(2,1,1);
stem(t, x); grid on; axis([0 0.4 -2 2]);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Signal');

% Second plot for the downsampled x
subplot(2,1,2);
stem(t_downsampled, x_downsampled); grid on; axis([0 0.4 -2 2]);
xlabel('Time (s)');
ylabel('Amplitude');
title(sprintf('Downsampled Signal (Factor of %d)', ds_factor));
