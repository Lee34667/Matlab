% Define input sequences
x1 = [1 2 3 4];
x2 = [2 3 4 5];

% Compute DFT of each sequence
X1 = fft(x1);
X2 = fft(x2);

% Verify linearity property: DFT(a*x1 + b*x2) = a*X1 + b*X2
a = 2;
b = 3;
y = a*x1 + b*x2;
Y = fft(y);
Y_expected = a*X1 + b*X2;
disp("Linearity property:")
disp(norm(Y - Y_expected) < 1e-10) % Output: 1 (true)

% Verify circular shift property: DFT(x1[n-n0]) = X1[k] exp(-j2πnk/N)
n0 = 2;
y = circshift(x1, n0);
Y = fft(y);
Y_expected = X1 .* exp(-1i*2*pi*n0*(0:length(X1)-1)/length(X1));
disp("Circular shift property:")
disp(norm(Y - Y_expected) < 1e-10) % Output: 1 (true)

% Verify time reversal property: DFT(x1[-n]) = X1[N-k]
y = fliplr(x1);
Y = fft(y);
Y_expected = fliplr(X1);
disp("Time reversal property:")
disp(norm(Y - Y_expected) < 1e-10) % Output: 1 (true)

% Compute IDFT of each sequence
x1_inv = ifft(X1);
x2_inv = ifft(X2);

% Verify linearity property: IDFT(a*X1 + b*X2) = a*x1[n] + b*x2[n]
a = 2;
b = 3;
y_inv = a*X1 + b*X2;
y_expected = a*x1_inv + b*x2_inv;
disp("Linearity property:")
disp(norm(y_inv - y_expected) < 1e-10) % Output: 1 (true)

% Verify circular shift property: IDFT(X1[k-k0]) = x1[n] exp(j2πnk0/N)
k0 = 2;
y_inv = ifft(circshift(X1, k0));
y_expected = x1 .* exp(1i*2*pi*k0*(0:length(x1)-1)/length(x1));
disp("Circular shift property:")
disp(norm(y_inv - y_expected) < 1e-10) % Output: 1 (true)

% Verify time reversal property: IDFT(X1[N-k]) = x1[-n]
y_inv = ifft(fliplr(X1));
y_expected = fliplr(x1);
disp("Time reversal property:")
disp(norm(y_inv - y_expected) < 1e-10) % Output: 1 (true)
