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
            % Initialize Object Properties
            obj.A = A;
            obj.D = D;
            obj.V = V;
            obj.L = L;
            obj.t = t;
            
            % Coolant Properties
            % obj.k =
            % obj.p =
            % obj.cp =
            % obj.v =
        end
        
        function Ti = calculateTi(To, Tinf)
            % Calculate the Inlet Temperature of the coolant in the
            % Thermodynamic Panel
            rhs = exp(-( (obj.V * pi * obj.D)/(obj.p * obj.V * pi * (obj.D/4) * obj.cp) ));
            Ti = Tinf - ( (Tinf - To)/rhs) );
        end
        
        function Ts = caluculateTs(qs, Ti, To, Tinf, ts)
            % Caluculate the Surface Temperature of the Thermodyanimc Panel
            
            % Initialize Temperatures
            obj.To = To;
            obj.Ti = Ti;
            obj.Tinf = Tinf;
            
            % Initialzie other properties
            P = pi * obj.D; % Perimeter
            
            % Energy Balance
            Erad = qs * P * obj.L * 0.5; % Energy from radiation
            m = obj.p * obj.V * (pi*obj.D/4); % mass flow rate
            Ecoolant = m * obj.cp * (obj.To - obj.Ti); % Energy going into coolant
            Eair = Erad - Ecoolant; % Remaining Energy from air
            
            % Set table for Film Temperature Interpolation, values pulled
            % from pg. 991 of Introduction to Heat Transfer (Sixth Edition)
            Tvalues = [200;250;300;350;400]; 
            kvalues = [18.1;22.3;26.3;30.0;33.8]; 
            vvalues = [7.590;11.44;15.89;20.92;26.41]; 
            Prvalues = [0.737;0.720;0.707;0.700;0.690];
            values = cat(2, Tvalues, kvalues);
            values = cat(2, values, vvalues);
            values = cat(2, values, Prvalues);
            
            % Set up film temperature
            Ts = ts; % initial guess for surface temperature
            Tfilm = (Ts+Tinf)/2; % film temperature based on initial guess
            
            % Set up parameters for looping
            error = 0.001;
            difference = 1;
            
            while difference > error
                
                % Get all values at film temperature
                kair = interpolate(Tfilm, values, 1, 2);
                vair = interpolate(Tfilm, values, 1, 3);
                Pr = interpolate(Tfilm, values, 1, 4);
                
                % Get convective coefficient
                Re = obj.V * obj.D / vair; % Reynold's Number
                Nu = 0.3 + ((0.62*(Re^(1/2))*(Pr^(1/3)))/((1+(0.4/Pr)^(2/3))^(4/9)))*(1+(Re/282000)^(5/8))^(4/5); % Nusselts Number
                h = (Nu*kair)/obj.D; % Average Concection Coefficient
                
                % Get difference
                Tsnew = Eair/(h*P*obj.L) + Tinf;
                difference = abs(Tsnew - Ts);
                Ts = Tsnew;
            end
            
        end
    end
    
end

