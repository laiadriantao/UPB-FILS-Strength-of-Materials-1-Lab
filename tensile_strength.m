#Tensile Testing following the standard SR EN 10002-1:2002

#{
Aim of the test:

To present the methodology for tensile testing and to obtain
elastic constants and mechanical characteristics of steel:
- Young's Modulus E
- Yield limit sigma_y
- Ultimate tensile strength sigma_u
- Percent elongation A
- Percent reduction of the area Z
#}

#{
Specimen:

Material: Steel
Diameter in the measurement zone: d_0 = 10mm
Cross section area S_0 = pi*((d_0/2)^2) = 78.5 mm^2 ; pi approx_= 3.14
Length of measurement zone: L_0 = 100mm
#}

#{
Measurement of the elongation Delta_L_i: 
using an extensometer with a 0.001 mm.div. dial gauge
#}

#{
Formulae:
Based on the values F_i and Delta_L_i obtained experimentally,
these will be calculated:

The normal stress: sigma_i = F_i / S_0 
The normal strain: epsilon_i = Delta_L_i / L_0
The percent elongation: A = (L_u - L_0) / L_0
The percent reduction of the area: Z = (S_u - S_0)/S_0 * 100 [%]

F_i = the force for which the extensometer registers the elongation
Delta_L_i = L_i - L_0

L_u = the ultimate length (measured between the marks of the extensometer after
final breaking)

S_u = (pi * (d_u)^2)/4 with d_u being the diameter in the failure section
#}

#Experimentally determined Traction Force, F [N]
F = [0,2500, 4000, 9400, 11100, 12800, 14500, 15300, 16000, 16800, 17800, 18500, 19400, 20300, 21200, 21700, 22300, 23300, 24000, 25700, 27000, 27400, 29400,30200, 30200, 30200, 30200, 30200, 30200, 30200, 30200, 31600, 33000, 34000, 45300, 35500, 37200, 41200];
#maximum Force = 41200 N

#division (d = 10^-3 mm)
d = 10^(-3);
#Experimentally determined Elongation, Delta_L [mm]
Delta_L = [0,2*d, 4*d, 6*d, 8*d, 10*d, 15*d, 20*d, 25*d, 30*d, 35*d, 40*d, 45*d, 50*d, 55*d, 60*d, 70*d, 80*d, 90*d, 100*d, 110*d, 120*d, 150*d, 170*d, 400*d,500*d, 600*d, 750*d, 850*d, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 18];
#final elongation = 18mm

#Cross Section area S [mm^2]
S = 78.5;

#Normal Stress Values for all measurements [MPa]
sigma = [];
for i = 1:length(F)
  #Normal Stress sigma [MPa]
  sigma(i) = F(i) / S;
end

#Length of measurement zone L_0 [mm]
L_0 = 100;

#Normal Strain Values for all measurements Delta_L/L_0 [mm/mm]
epsilon = [];
for i = 1:length(Delta_L)
  #Strain Values epsilon [mm/mm]
  epsilon(i) = Delta_L(i) / L_0;
end

#Stress strain curve for the steel specimen graph plot
plot(epsilon, sigma, "linewidth",1);
title("Stress strain curve for the steel specimen");
set(gca,"fontsize", 24);
xlabel("Strain [mm/mm]");
ylabel("Stress [MPa]");
pbaspect([1 1 1]);

#Elastics constants and mechanical characteristics of the specimen

#Young's modulus E [MPa]

#{
It is known that the Young's Modulus of a material can be determined from
a Stress Strain Curve by determining the value of the slope expressed by the
elastic region of the curve which can be determined by the straight line which
starts from the origin all the way to the point where the Stress Strain Curve
begins the curvature.

In our case we will determine the Young's Modulus from the 
first 23 experimentally determined values which correspond 
with the desired parameters as it can be seen in the zoomed plot.

#}

#To find out the slope, the least squares method will be used

#{
Source of inspiration: https://www.youtube.com/watch?v=F-jngIXAGA8
                       https://www.youtube.com/watch?v=y2EF-d-15Oo
                       
Programmatical and theoretical aspects:
  As from the source mentioned above, there is a way to perform the least
  squares method by referring to Linear Algebra.
  
  y_1 = m* x_1 + b
  y_2 = m* x_2 + b
  .
  .
  .
  y_n = m* x_n + b
  
  Such a system can be written as:
  matrix_y = [y_1, y_2, .... , y_n];
  matrix_x = [x_1, 1; x_2, 1, ...., x_n, 1]; -> this is a 2 x n matrix
  matrix_vector_x = [m, b]; -> contains the unknowns
  
  Then,
  
  matrix_y = matrix_x * matrix_mb;
  
  The result being:
  
  y_1 = x_1* m* 1 + b
  y_2 = x_2* m* 1 + b
  .
  .
  .
  
  To find out the least square method of this result
  solve the following matrix equation AX = B with
  X being the solution matrix. 
    
  The solution will be a 2x1 matrix with X = [value_of_m, value_of_b] 
  
Technical aspects: 
  ' : The apostrophe defines a transpose vector or matrix
  ones() : Return a matrix or N-dimensional array whose elements are all 1.
  size(a) : Return a row vector with the size (number of elements) of each dimension for the object a.
  \ : Means the left division, which means X = (A^(-1))*B which is the same as AX = B 
      considering that X, A and B are matrices
#}

matrix_a=[(epsilon(1,1:23))', ones(size((epsilon(1,1:23))'))];
matrix_b=(sigma(1,1:23))';
solution_matrix = matrix_a\matrix_b;
#y_fit = solution_matrix(1)*x+solution_matrix(2); 

#In our case the Young's Modulus is the first value of solution_matrix;
E = solution_matrix(1);

#The percent elongation A [%]
#{
For practical reasons we won't use the representation of the elongation in percents
in performing calculations
#}
A = (max(Delta_L)+L_0 - L_0) / L_0;
A_percent = A*100;

#The yield limit sigma_y [MPa]
sigma_y = 374.52; # being the 23rd value

#Percent reduction of the area Z [%]
#{
For practical reasons we won't use the representation of the elongation in percents
in performing calculations
We know that d_u = 5.5mm the diameter in the failure section
#}
d_u = 5.5;
S_u = (pi*(d_u)^2) / 4;
Z = (S_u - S) / S;
Z_percent = Z*100;










