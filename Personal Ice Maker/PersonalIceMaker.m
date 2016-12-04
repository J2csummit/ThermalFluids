%% Piston Calculations %% 

syms r2

T1 = 255;
T2 = 303;

tTotal = 28800;
tank = 1728;

p = 999;
V = 0.00001638706*1.5;
c = 4.180;
E = (p*V*c*(T2-T1) + 353.55*p*V)*1000;

rcube = 0.02;
rpist = 0.0145;
L = V/((pi*(rcube^2)) - (pi*(rpist^2)));

kw = 0.606; ki = 1.88;

q = (T1 - T2)/((log(r2/rpist)/(2*pi*ki*L)) + (log(rcube/r2)/(2*pi*kw*L)));
fplot(q, [rpist, rcube])
xlabel('Radius (m)');
ylabel('Heat Transfer (W)');
title('Heat Transfer as a Function of Radius');
qr = double(int(q, rpist, rcube));
Qr = qr/(rpist - rcube);

t = E/Qr;

rcube
rpist
L
E
Qr
t
cycles = ceil(tTotal/t)
Vcube = (L * pi * rcube^2)*61024;
cubes = ceil(tank/Vn)
pistons = floor(cubes/cycles) + 2
cyc = ceil(cubes/pistons)
cyc * t