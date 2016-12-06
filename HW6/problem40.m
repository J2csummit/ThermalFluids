watertable = [32,62.5248,1.0074,19.25E-6,0.319,5.07E-3,13.6;...
    68,62.4,0.9988,10.83E-6,0.345,5.54E-3,7.02;...
    104,62.0256,0.9980,7.08E-6,0.363,5.86E-3,4.34;...
    140,61.464,0.9994,5.14E-6,0.376,6.02E-3,3.02;...
    176,60.7776,1.0023,3.92E-6,0.386,6.34E-3,2.22;...
    212,59.904,1.0070,3.16E-6,0.393,6.51E-3,1.74;...
    248,58.968,1.015,2.66E-6,0.396,6.62E-3,1.446];

T1 = 210; t1 = 32; mc = 8500; mh = 8000; R = 0.001 + 0.002; L = 18;
measure = [0.1674,0.1076,0.1146,0.009093,0.01169,0.0528,0.1229];
t1array = [];
Tc2array = [];
tc2array = [];
Tp2array = [];
tp2array = [];

while t1 < 56
    t1array(end+1) = t1;
    [Tc2array(end+1),tc2array(end+1),Tp2array(end+1),tp2array(end+1)] = getOutletTemperatures(T1,t1,mh,mc,measure,watertable,watertable, L, R);
    t1 = t1+1;
end
Tci = rot90(t1array);
ThoCounter = rot90(Tc2array);
TcoCounter = rot90(tc2array);
ThoParallel = rot90(Tp2array);
TcoParallel = rot90(tp2array);

T = table(Tci,ThoCounter,TcoCounter,ThoParallel,TcoParallel)

plot(t1array,Tc2array,'r',t1array,tc2array,'y',t1array,Tp2array,'b',t1array,tp2array,'p')
x = xlabel('Inlet Temperature of Cold Fluid (degrees F)')
x.FontSize = 14
y = ylabel('Outlet Temperatures (degrees F)')
y.FontSize = 14
l = legend('Tho Counter Flow','Tco Counter Flow','Tho Parallel Flow','Tco Parallel Flow')
l.FontSize = 11