function [p , v] = solarsystem(p , v, mass, stop_time)
% SOLARSYSTEM Solve the gravitational dynamics of n bodies.
%
% SOLARSYSTEM(p, v, mass, stop_time) receives the initial position, initial
% velocity, and mass, and simulate for stop_time seconds. The inputs p and
% v are N-by-2 matrices where the Nth row refers to the Nth celestial
% body. The two columns are the X and Y values of position and velocity,
% respectively. The input mass is an N-by-1 vector where the Nth item is
% the mass of the Nth celestial body.
%
% [p, v] = SOLARSYSTEM(...) returns the final position and final velocity
% of each object in the same format as the input. This will be used during
% marking to test the accuracy of your program.
%
% SOLARSYSTEM(..., hide_animation) is an optional flag to indicate whether
% the graphical animation may be hidden. This is an advanced feature for
% students who are aiming for a high level of achievement. During marking,
% when the computation speed of your program is being tested, it will be
% run with the hide_animation flag set to true. This allows your program to
% skip the drawing steps and run more quickly. 
%


% Below is example code showing how to read the initial position and
% velocity into the same notation as the assignment sheet, to help you get
% started on the two-body simulation:

% How to pull values out of p and v:

p1 = p(1,:); % planet 1 position vector
p2 = p(2,:); % planet 2 position vector

v1 = v(1,:); % planet 1 velocity vector
v2 = v(2,:); % planet 2 velocity vector

m1 = mass(1); % planet 1 mass
m2 = mass(2); % planet 2 mass

% DeltaT Values
%DeltaT = 1;
%DeltaT = 10;
DeltaT = 100;
%DeltaT = 1000;
%DeltaT = 10000;

%Timer
Time = 0;

G = 6.673e-11; % Co-Efficient of Gravity

%Establishing the Graph

figure();
e1 = plot(p1(1),p1(2),'o--');
hold all;
e2 = plot(p2(1),p2(2),'o--');
axis equal;
ylabel(' Distance from the sun')
xlabel('Distance from the sun')
ylim([-2e11 2e11]);
xlim([-2e11 2e11]);

counter = 0;
% Write your code here
while Time < stop_time  %A while loop to calculate the physics behind the star system
    x1 = p2 - p1;  
    x2 = p1 - p2;
    F1 = G * (m1 * m2) / (norm(x1)^3)* x1; 
    F2 = G * (m1 * m2) / (norm(x2)^3)* x2; 
    a1 = 1/m1*(F1);  
    a2 = 1/m2*(F2);
    v1 = v1 + a1*DeltaT; 
    p1 = p1 + v1*DeltaT;
    v2 = v2 + a2*DeltaT;
    p2 = p2 + v2*DeltaT;
    counter = counter +1;
    if counter >=10      %A Counter designed to speed up the efficency of the program
        set(e1,'xdata',p1(1),'ydata',p1(2));
        set(e2,'xdata',p2(1),'ydata',p2(2));
        drawnow limitrate;
        counter = 0;
    end
    Time = Time + DeltaT;
end
% How to pack the results back into the return values
p = [p1; p2];
v = [v1; v2];

end
