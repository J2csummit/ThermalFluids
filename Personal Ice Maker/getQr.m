function [ qr ] = getQr( t1, t2, r1, r2, r3, L )
kw = 0.606; ki = 1.88;
qr = (t1 - t2)/((log(r2/r1)/(2*pi*ki*L)) + (log(r3/r2)/(2*pi*kw*L)));
end

