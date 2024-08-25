% Define constant parameters
dFe = 7;                                    % Rotor disk thickness
Tpm = 25;                                   % Magnetic pitch 25◦
Di = 80;                                    % Inner diameter of PM 
Do = 150;                                   % Outer diameter of PM 
Tp = 1;                                     % Pole pitch 
Ia = 2 * 10;                                % Electrical current
dag = 1;                                    % Air gap thickness 
Kw = 0.966;                                 % Winding factor
p = 4;                                      % Number of pole pairs
f = 50;                                     % Frequency
m = 3;                                      % Number of phases
Ur = 1;                                     % Relative permeability of steel.
Urec = 1;                                   % µr the relative permeability of steel.
Br = 1;                                     % Remanent magnetic flux density
N1 = 6;                                     % Number of turns per coil
lfe = 1;                                    % Assumed

% Define varying parameters
ds_values = [15, 20, 25, 30, 40]; % Different winding thickness values

figure; % Create figure outside the loop

for j = 1:length(ds_values)
    ds = ds_values(j);
    
    % Initialize arrays to store values of varying parameters
    Bz_values = zeros(8, 1);
    for i = 1:8
        Ksat = 1 + ((lfe) / (2 * Ur) * (dag + 0.5 * dFe));
        Bz = Br / (1 + (Urec * ((dag + 0.5 * ds) / Di) * Ksat));
        ai = (Tpm + i) / Tp;
        Phi = cos(ai) * Bz * (pi / 8 * p) * (Do^2 - Di^2);
        E = pi * sqrt(2) * f * N1 * Kw * Phi;
        Tem = (1 / 4) * cos(ai) * Bz * m * Ia * N1 * Kw * (Do^2 - Di^2);
        Bz_values(i) = Bz;
    end
    % Plot results
    plot(1:8, Bz_values, 'DisplayName', ['ds = ' num2str(ds)]);
    hold on;
end

xlabel('Winding thickness');
ylabel('Bz');
title('Influence of Winding Thickness on the size of Bz.');
legend('Location', 'Best');
