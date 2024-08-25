% Define constant parameters
dFe = 7;                                    % Rotor disk thickness
Di = 80;                                    % Inner diameter of PM 
Do = 150;                                   % Outer diameter of PM 
Tp = 3;                                     % Pole pitch 
Ia = 2 * 10;                                % Electrical current
dag = 1;                                    % Air gap thickness 
Kw = 0.966;                                 % Winding factor
p = 10;                                     % Number of pole pairs
f = 50;                                     % Frequency
m = 3;                                      % Number of phases
Ur = 1;                                     % Relative permeability of steel.
Urec = 1;                                   % µr the relative permeability of steel.
Br = 1;                                     % Remanent magnetic flux density
N1 = 6;                                     % Number of turns per coil
lfe = 1;                                    % Assumed

% Define varying parameters
Tpm_values = 20:30; % Different Tpm values

% Create figure outside the loop
figure;

for j = 1:length(Tpm_values)
    Tpm = Tpm_values(j);
    
    % Initialize arrays to store values of varying parameters
    Tem_values = zeros(8, 1);
    E_values = zeros(8, 1);
    
    for i = 1:8
        Ksat = 1 + ((lfe) / (2 * Ur) * (dag + 0.5 * dFe));

        Bz = Br / (1 + (Urec * ((dag + 0.5 * ds) / Di) * Ksat));

        ai = (Tpm + i) / Tp;

        Phi = cos(ai) * Bz * (pi / 8 * p) * (Do^2 - Di^2);

        E = pi * sqrt(2) * f * N1 * Kw * Phi;

        Tem = (1 / 4) * cos(ai) * Bz * m * Ia * N1 * Kw * (Do^2 - Di^2);

        Tem_values(i) = Tem;
        
        E_values(i) = E;
    end
    
    % Plot results
    plot(1:8, Tem_values, 'DisplayName', ['Tpm = ' num2str(Tpm)]);
    hold on;
end

xlabel('Rotation angle (ai)');
ylabel('Torque (Tem)');
title('Influence of Tpm on Torque (Tem)');
legend('Location', 'Best');
ylim([-900000 900000]); % Set y-axis range to -5000000 to 5000000
