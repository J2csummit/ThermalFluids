classdef ThermodynamicPanel
    %ThermodynamicPanel Thermodyanmic Panel for a water heating system
    %   Thermodynamic Panel for a water heating system that operates off of
    %   solar energy alone.
    
    properties
        % Assumed or Given Values %
        A % Surface Area of Panel
        D % Diameter of tube running through panel
        V % Velocity of Coolant running through Panel
        L % Length of tube running through panel
        % To % Temperature of Coolant coming out of Panel
        % Ti % Temperature of Coolant flowing into Panel
        % Tinf % Temperature of Ambient Air
        t % Panel wall thickness
        k % Panel conductivity constant
        p % Coolant Density
        cp % Coolant Specific Heat
        hair % Air Convection Value
        
        % Obtained Values %
        Ts % Temperature of Panel Surface
    end
    
    methods
        function obj = ThermodyamicPanel(A, D, V, L, t)
            obj.A = A;
            obj.D = D;
            obj.V = V;
            obj.L = L;
            obj.t = t;
            % obj.k =
            % obj.p =
            % obj.cp =
            % obj.v =
            % obj.hair = 
        end
        
        function Ts = caluculateTs(qs, Ti, To, Tinf, ts)
            % Caluculate the Surface Temperature of the Thermodyanimc Panel
            
            % Initialize Temperatures
            obj.To = To;
            obj.Ti = Ti;
            obj.Tinf = Tinf;
            
            % Initialzie other properties
            P = pi * obj.D; % Perimeter
            Re = obj.V * obj.D / obj.v; % Reynold's Number
            
            % Energy Balance
            Erad = qs * P * obj.L * 0.5; % Energy from radiation
            m = obj.p * obj.V * (pi*obj.D/4); % mass flow rate
            Ecoolant = m * obj.cp * (obj.To - obj.Ti); % Energy going into coolant
            Eair = Erad - Ecoolant; % Remaining Energy from air
            
            % Set table for Film Temperature Interpolation
            Tvalues = []; kvalues = []; cpvalues = []; avalues = []; Prvalues = []; 
            values = cat(2, Tvalues, kvalues);
            values = cat(2, values, cpvalues);
            values = cat(2, values, avalues);
            values = cat(2, values, Prvalues);
            
            % Set up film temperature
            Ts = ts; % initial guess for surface temperature
            Tfilm = (Ts+Tinf)/2; % film temperature based on initial guess
            
            % Set up parameters for looping
            error = 0.001;
            difference = 1;
            
            while difference > error
                
                % Get all values at film temperature
                kair = interpolate(Tfilm, values, 2);
                cpair = interpolate(Tfilm, values, 3);
                a = interpolate(Tfilm, values, 4);
                Pr = interpolate(Tfilm, values, 5);
                
                % Get convective coefficient
                Ra = (9.81*(1/Tinf)*(Ts - Tinf)*obj.L^3)/(obj.v*a); % Rayleigh's Number
                Nu = 0.68 + (0.67*(Ra^(1/4)))/(1+((0.492/Pr)^(9/16))^(4/9)); % Nusselts Number
                h = (Nu*kir)/obj.L; % Average Concection Coefficient
                
                Tsnew = Eair/h + Tinf;
                difference = abs(Tsnew - Ts);
                Ts = Tsnew;
            end
            
        end
    end
    
end

