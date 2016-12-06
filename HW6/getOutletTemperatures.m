function [ Tco, tco, Tpo, tpo ] = getOutletTemperatures( T1,t1,mh,mc,measure,tableh,tablec,L,R )

    Ida = measure(1);
    Idp = measure(2);
    Odp = measure(3);
    Ap = measure(4);
    Aa = measure(5);
    Dh = measure(6);
    De = measure(7);
    Tmh = T1; tmc = t1;
    ph = interpolate(Tmh,tableh,1,2);
    pc = interpolate(tmc,tablec,1,2);
    Cph = interpolate(Tmh,tableh,1,3); 
    Cpc = interpolate(tmc,tablec,1,3);
    vh = interpolate(Tmh,tableh,1,4);
    vc = interpolate(tmc,tablec,1,4);
    kh = interpolate(Tmh,tableh,1,5);
    kc = interpolate(tmc,tablec,1,5);
    ah = interpolate(Tmh,tableh,1,6); 
    ac = interpolate(tmc,tablec,1,6);
    Prh = interpolate(Tmh,tableh,1,7); 
    Prc = interpolate(tmc,tablec,1,7);
    
    if Aa > Ap
        if mh > mc
            Va = mh/(ph*Aa);
            Vp = mc/(pc*Ap);
            Rea = Va*De/vh;
            Rep = Vp*IDp/vc;
            Pra = Prh;
            Prp = Prc;
            ka = kh;
            kp = kc;
            na = 0.3;
            np = 0.4;
        else
            Va = mc/(pc*Aa);
            Vp = mh/(ph*Ap);
            Rea = Va*De/vc;
            Rep = Vp*Idp/vh;
            Pra = Prc;
            Prp = Prh;
            ka = kc;
            kp = kh;
            na = 0.4;
            np = 0.3;
        end
    else
        if mh > mc
            Vp = mh/(ph*Ap);
            Va = mc/(pc*Aa);
            Rea = Va*De/vc;
            Rep = Vp*IDp/vh;
            Pra = Prc;
            Prp = Prh;
            ka = kc;
            kp = kh;
            na = 0.4;
            np = 0.3;
        else
            Vp = mc/(pc*Ap);
            Va = mh/(ph*Aa);
            Rea = Va*De/vh;
            Rep = Vp*IDp/vc;
            Pra = Prh;
            Prp = Prc;
            ka = kh;
            kp = kc;
            na = 0.3;
            np = 0.4;
        end
    end
    ha = getNusselt(Rea,De,L,Pra,ka,na);
    hp = getNusselt(Rep,Idp,L,Prp,kp,np);
    
    Uo = (1/ha + 1/hp)^(-1);
    U = (1/ha + 1/hp + R)^(-1);
    r = mc*Cpc/(mh*Cph);
    Ao = pi*Odp*L;
    
    Ec = exp(U*Ao*(r-1)/(mc*Cpc));
    Tco = (T1*(r-1) - r*t1*(1-Ec))/(r*Ec - 1);
    tco = t1 + (T1 - Tco)/r;
    
    Ep = exp(U*Ao*(r+1)/(mc*Cpc));
    Tpo = ((r + Ep)*T1 + r*t1*(Ep - 1))/((r + 1)*Ep);
    tpo = t1 + (T1 - Tpo)/r;

end

