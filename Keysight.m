%BALUN MEASUREMENT
%BALUN OPEN
bo = dlmread('BALUN_O.txt'); %reading measurements from BALUN_O file
bofrg = bo(1:end, 1);%the frequencies
boimag= bo(1:end,3);%imaginary part
boreal = bo(1:end,2);%real part

%BALUN SHORT
bs= dlmread('BALUN_S.txt'); 
bsfreq = bs(1:end, 1);
bsreal = bs(1:end,2);
bsimag = bs(1:end,3);
 
%BALUN TERM
bt= dlmread('BALUN_T.txt'); 
btfreq = bt(1:end, 1);
btreal = bt(1:end,2);
btimag = bt(1:end,3);
 
%S11 values
Ro = boreal + (1i.*boimag);
Rs = bsreal + (1i.*bsimag);
Rt = btreal + (1i.*btimag);
R = 47;

%Z
Zo = R.*(1+Ro)./(1-Ro);
Zs = R.*(1+Rs)./(1-Rs);
Zt = R.*(1+Rt)./(1-Rt);
 
%ABCD matrix comp.
ZTO = Zt - Zo; %USING THE FORMULAE
ZOS = Zo - Zs;
ZST = Zs-Zt;

%A = Zo*root( (Zs- Zt)/ R(Zt - Zo)(Zo - Zs) )
ad = R .* (Zt - Zo) .* (Zo - Zs);
adv =  ZST./ ad;
A = Zo .* sqrt(adv);
 
%B = Zs*root( R(Zt - Zo)/(Zs - Zt)(Zo - Zs))
b1 = R .* ZTO;
b2 = ZST .* ZOS;
b3 = b1 ./ b2;
B = Zs.*sqrt(b3);
 
%C = root( (Zs - Zt)/ R(Zt - Zo)(Zo - Zs) )
c1 = ZST;
c2 = R .* ZTO .* ZOS;
c3 = c1 ./ c2;
C = sqrt(c3);
 
%D = root( R(Zt - Zo) / (Zs - Zt)(Zo - Zs))
d1 = R .* ZTO;
d2 = ZST .* ZOS;
d3 = d1 ./ d2;
D = sqrt(d3);
 
%CABLE_Measurements
%CABLE OPEN
co = dlmread('CABLE_O.txt'); %reading measurements from CABLE_O file
cofreq = co(1:end, 1);%frequencies
coreal = co(1:end,2);%real part 
coimag = co(1:end,3);%imaginary part
 
%CABLE SHORT
cs = dlmread('CABLE_S.txt'); 
csfreq = cs(1:end, 1);
csreal = cs(1:end,2);
csimag = cs(1:end,3);

% Interpolate cable data to match balun frequency points
reco_interp = interp1(cofreq, coreal, bofrg);
imco_interp = interp1(cofreq, coimag, bofrg);
recs_interp = interp1(csfreq, csreal, bofrg);
imcs_interp = interp1(csfreq, csimag, bofrg);

% Calculate S11 values for interpolated cable data
Rmco = reco_interp + (1i * imco_interp);
Rmcs = recs_interp + (1i * imcs_interp);

%Zc values
Zcopen = R.* (1i.*Rmco)./ (1-Rmco);
Zcshort = R.* (1i.*Rmcs)./ (1-Rmcs);
  
%Zco actual
o1 = B - D .* Zcopen;
o2 = C .* Zcopen - A;
Zaco = o1 ./ o2; %fin

%Zcs actual
s1 = B - D .* Zcshort;
s2 = C .* Zcshort - A;
Zacs = s1 ./ s2; %fin

%CHARACTERISTIC IMPEDANCE
Zxt = sqrt(Zacs.*Zaco);
figure;
subplot(2,1,1); %RE
plot(bofrg, abs(Zxt))
grid on
xlabel('frequency')
ylabel('ABS(Z_o)')
title('Characteristic Impedance')
 
subplot(2,1,2); %IM
plot(bofrg, angle(Zxt))
grid on
xlabel('frequency')
ylabel('PHASE(Z_o)')
 
%PROPAGATION CONSTANT
Y = atanh( sqrt( Zacs./Zaco ) );
figure;
subplot(2,1,1); %RE
plot(bofrg, real(Y))
grid on
xlabel('frequency')
ylabel('Re(Y) alpha')
title('Propagation Constant')
 
subplot(2,1,2); %IM
plot(bofrg, imag(Y))
grid on
xlabel('frequency')
ylabel('Im(Y) beta')


