#{
Compression Testing Lab

Aim of test:

- To present the methodology for compression testing
- To plot the stress - strain curve in compression for steel
- To calculate the ultimate strength in compression for grey cast iron

The specimen:

Material: Steel
Height L_0 = 20mm
Diameter d_0 = 20mm
Cross section area S_0 =  314mm^2

Measurement of shortening Delta_L_i:
Using two 0.01 mm/div dial gauges

Formulae:

Based on the values (F_i, Delta_L_i) obtained experimentally, one calculates:
The normal stress: sigma_i = F_i / S_0
The normal strain: epsilon_i = (Delta_L_i/L_0) * 100 [%]

F_i is the force for which the extensometer registers 
the shortening Delta_L_i = L_i - L_0
#}

#Results for the steel specimen

#Height 
L_0 = 20;
#Diameter 
d_0 = 20;
#Cross section area 
S_0 =  314^2;
#d = div = 10^(-2)mm
d = 10^(-2);

#Compression force F[N]
F=[0,30000,60000,90000,120000,150000,180000,210000,240000,270000,300000];

#Left dial gauge shortening Delta_L_l [mm]
Delta_L_l = d*[0,-10,-17,-13,-8,10,33,62,110,170,245];

#Right dial gauge shortening Delta_L_r [mm]
Delta_L_r = d*[0,50,83,94,111,135,159,182,227,289,363];

#Average shortening for all measurements Delta_L [mm]
Delta_L = [];
for i = 1:length(Delta_L_l)
  #Average shortening Delta_L [mm]
  Delta_L(i) = (Delta_L_l(i) + Delta_L_r(i)) / 2;
end

#Normal Stress Values for all measurements [MPa]
sigma = [];
for i = 1:length(F)
  #Normal Stress sigma [MPa]
  sigma(i) = F(i) / S_0;
end

#Normal Strain Values for all measurements [mm/mm]
epsilon = [];
for i = 1:length(Delta_L)
  #Strain Values epsilon [mm/mm]
  epsilon(i) = Delta_L(i) / L_0;
end

#Young's modulus E [MPa]
#To find out the slope, the least squares method will be used
matrix_a=[(epsilon(1,1:11))', ones(size((epsilon(1,1:11))'))];
matrix_b=(sigma(1,1:11))';
solution_matrix = matrix_a\matrix_b;
#y_fit = solution_matrix(1)*epsilon+solution_matrix(2); 

#In our case the Young's Modulus is the first value of solution_matrix;
E = solution_matrix(1);

#Stress strain curve for the steel specimen graph plot
plot(epsilon, sigma, "linewidth",1, "o-");

#line([0.02 solution_matrix(2)],[0 solution_matrix(1)], "linestyle", "--");

#{
The above line is the way I have found the yield point using the 2% offset line
The yield point is needed to find the proportionality limit.
#}

title("Stress strain curve for the steel specimen");
set(gca,"fontsize", 24);
xlabel("Strain [mm/mm]");
ylabel("Stress [MPa]");
pbaspect([1 1 1]);



