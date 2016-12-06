function [ h ] = getNusselt( Re, D, L, Pr, k, n )

if Re < 2200
    Nu = 1.86*(D*Re*Pr/L)^(1/3);
elseif Re >= 10000
    Nu = 0.023*(Re^(4/5))*(Pr^n);
else
    Nu1 = 1.86*(D*Re*Pr/L)^(1/3);
    Nu2 = 0.023*(Re^(4/5))*(Pr^n);
    Nu = (Re - 2200)/(10000-2200) * (Nu2 - Nu1) + Nu1;
end

h = Nu*k/D;

end

