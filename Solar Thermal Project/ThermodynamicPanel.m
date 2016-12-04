classdef ThermodynamicPanel
    %ThermodynamicPanel Thermodyanmic Panel for a water heating system
    %   Thermodynamic Panel for a water heating system that operates off of
    %   solar energy alone.
    
    properties
        A % Surface Area of Panel
        D % Diameter of tube running through panel
        V % Velocity of Coolant running through Panel
        L % Length of tube running through panel
        To % Temperature of Coolant coming out of Panel
        Ti % Temperature of Coolant flowing into Panel
        Tinf % Temperature of Ambient Air
        Ts % Temperature of Panel Surface
    end
    
    methods
        function obj = ThermodynamicPanel(D, V, L, To, Ti)
            % Initialize Object Properties
            obj.D = D; % Pipe Diameter
            obj.V = V; % Coolant Flow Speed
            obj.L = L; % Length of Pipe
            obj.To = To; % Length of Pipe
            obj.Ti = Ti; % Length of Pipe
        end
        
        function Ts = caluculateTs(obj, qs, Tinf, ts)
            % Caluculate the Surface Temperature of the Thermodyanimc Panel
            
            % Initialize Temperatures
            obj.Tinf = Tinf;
            
            % Initialzie other properties
            P = pi * obj.D; % Perimeter
            
            % Get average temperature
            Tm = (obj.To + obj.Ti)/2
            
            % Set table for Average Temperature Interpolation, values pulled
            % from pg. 917 of Introduction to Heat Transfer (Sixth Edition)
            Tvalues = [230;240;250;260;270;280;290;300;310;320;330;340;350;360;370]; 
            pvalues = [1426.8;1397.7;1367.9;1337.1;1305.1;1271.8;1236.8;1199.7;1159.9;1116.8;1069.1;1015.0;951.3;870.1;740.3];
            cpvalues = [1.249;1.267;1.287;1.308;1.333;1.361;1.393;1.432;1.481;1.543;1.627;1.751;1.961;2.437;5.105];
            values = cat(2, Tvalues, pvalues);
            values = cat(2, values, cpvalues);
            
            % Get all values at film temperature
            pcool = interpolate(Tm, values, 1, 2)
            cpcool = interpolate(Tm, values, 1, 3) * 1000
            
            % Energy Balance
            m = pcool * (pi*(1/4)*obj.D^2) * obj.V;
            Ecoolant = m * cpcool * (obj.To - obj.Ti)
            dTo = (obj.Tinf - obj.To);
            dTi = (obj.Tinf - obj.Ti);
            dTlm = (dTo - dTi)/log(dTo/dTi);
            h = Ecoolant/(P * obj.L * dTlm);
            ex = exp(-P * obj.L * h/(m*cpcool));
            
            Ts = (obj.To - (obj.Ti/ex))/(1 - (1/ex))
            
        end
    end
    
end

