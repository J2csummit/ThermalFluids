clc, clear all

% Water  
g = 9.81;  %Gravity 
Tsuf = 64.7 ; %surface temperature
Tinf = 37.5; %*c %ambient temperature
kvis =  695e-6*1.007e-3; %kinematic visocisty 
kf =  628e-3;  %conduction coeffiecent of fluid 
alpha = (kf*1.007e-3)/4.197;  %diffusivity 
Pr =  4.62;  %prandel number 
cp = 4178; % specific heat
Beta = 361.9e-6;  %coefficient of thermal expansionn 
     
%Calculations 
Vol = 0.3028; % Volume of Tank
D = 0.5; % Diameter of Tank
Height = (Vol*4)/(pi*(D ^2)) % Height of Tank
Thickness = 0.00635; % Thickness of Tank Wall
L = (D*pi*Height/0.05398) % Length of Coolant Piping

Ra = (g*Beta*(Tsuf - Tinf)*L^3)/(kvis*alpha);  %Rayleigh number 
Nu = 0.68 + (0.67*(Ra^(1/4)))/(1+((0.492/Pr)^(9/16))^(4/9));  % Nusselt Number
h = (Nu*kf)/L % Average Convection Coefficient of Water
k = 54; % Conduction Coefficient of Tank Wall 
r1 = D/2; % Radius of Tank
r2 = r1+Thickness; % Radius of Tank Wall
Rtank = log(r2/r1)/(2*pi*L*k); % Conductive Resistance of Tank Wall
Rw = 1/(2*pi*r1*L*h); % Conductive Resistance of Water

% Results
q = 12327.3; % heat required to heat water
To = q * (Rtank+Rw) + 60  % Outlet temperature for Thermodynamic Plate
ToK = To + 273 % Outlet temperature in K

ID = 0.04976; % inner diameter of pipe
velo = 0.1; %m/s
density = 1116.8; %kg/m^3
massflow = pi*(ID/2)^2*velo*density; % kg/m^3
Ti = ToK - (q/(massflow*cp)) % Inlet Temperature for Thermodynamic Plate

panel = ThermodynamicPanel(0.04976, 0.1, 5, ToK, Ti);
Ts = caluculateTs(panel, 833, 296, 350);