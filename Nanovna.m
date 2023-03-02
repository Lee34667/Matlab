% OPEN
bopen = dlmread('BALUN_O.txt'); 
freqbo = bopen(1:end, 1);
realbo = bopen(1:end,2);
imagbo = bopen(1:end,3);
 
% SHORT
bshort = dlmread('BALUN_S.txt'); 
freqbs = bshort(1:end, 1);
realbs = bshort(1:end,2);
imagbs = bshort(1:end,3);
 
%Balun TERM
bt = dlmread('BALUN_T.txt'); 
freqbt = bt(1:end, 1);
realbt = bt(1:end,2);
imagbt = bt(1:end,3);

%S11 values
Ro = rebo + (1i.*imbo);
Rs = rebs + (1i.*imbs);
Rt = rebt + (1i.*imbt);
R = 50;
 
%Z
Zo = R.*(1+Ro)./(1-Ro);
Zs = R.*(1+Rs)./(1-Rs);
Zt = R.*(1+Rt)./(1-Rt);
 
%ABCD matrix comp.
A = Zo.*sqrt((Zs-Zt)./(R.*(Zt-Zo).*(Zo-Zs)));
B = Zs.*sqrt(R.*(Zt-Zo)./((Zs-Zt).*(Zo-Zs)));
C = sqrt((Zs-Zt)./(R.*(Zt-Zo).*(Zo-Zs)));
D = sqrt(R.*(Zt-Zo)./((Zs-Zt).*(Zo-Zs)));
  

%CABLE OPEN
copen = dlmread('CABLE_O.txt'); 
freqco = copen(1:end, 1);
realco = copen(1:end,2);
imagco = copen(1:end,3);
 
%CABLE SHORT
cshort = dlmread('CABLE_S.txt'); 
freqcs = cshort(1:end, 1);
realcs = cshort(1:end,2);
imagcs = cshort(1:end,3);

%S11 values
Rmco = reco + (1i.*imagco);
Rmcs = recs + (1i.*imagcs);


%Zc values
Zmco = R.* (1i.*Rmco)./ (1-Rmco);
Zmcs = R.* (1i.*Rmcs)./ (1-Rmcs);

%Actual cable impedance 
Zaopen = (B - D.*Zmco) ./ (C.*Zmco - A)
Zashort = (B - D.*Zmcs)./ (C.*Zmcs - A)
 
%CHARACTERISTIC IMPEDANCE
Zxt = sqrt(Zashort.*Zaopen);
figure;
subplot(2,1,1); %REAL
plot(freqbo, abs(Zxt))
grid on
xlabel('frequency')
ylabel('ABS(Z_o)')
title('The Characteristic Impedance')
 
subplot(2,1,2); %IMAGINARY
plot(freqbo, angle(Zxt))
grid on
xlabel('frequency')
ylabel('PHASE(Z_o)')
 
%PROPAGATION CONSTANT
Y = atanh( sqrt( Zashort./Zaopen ) );
figure;
%REAL 
subplot(2,1,1); 
plot(freqbo, real(Y))
grid on
xlabel('frequency')
ylabel('Re(Y) alpha')
title('Propagation Constant')

%IMAGINARY
subplot(2,1,2);
plot(freqbo, imag(Y))
grid on
xlabel('frequency')
ylabel('Im(Y) beta')




