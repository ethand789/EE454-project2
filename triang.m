function point3D = triang(Pu1,Pu2)
% takes two 2D points and returns a recovered 3D point by
% performing triangulation.

% get camera parameters
cam1 = load("Project2DataFiles\Parameters_V1.mat").Parameters;
cam2 = load("Project2DataFiles\Parameters_V2.mat").Parameters;

% get matrix t1 and t2
t1 = cam1.Pmat(1:3,4);
t2 = cam2.Pmat(1:3,4);

% get location c1 and c2
Rmat1 = cam1.Rmat';
Rmat2 = cam2.Rmat';
c1 = -Rmat1 * t1;
c2 = -Rmat2 * t2;

%compute vector v1 and v2
v1 = cam1.Rmat' * (cam1.Kmat / Pu1);
v1 = v1/norm(v1);

v2 = cam2.Rmat' * (cam2.Kmat / Pu2);
v2 = v2/norm(v2);

% get viewing ray 1 and 2
viewRay1 = [c1, v1];
viewRay2 = [c2, v2];

% compute cross product of v1 and v2
v1xv2 = cross(v1, v2);

% get unit vector v3
v3 = v1xv2/norm(v1xv2);
v3 = v1xv2;

% define variables a, b and d
syms a b d

% define the equation av1 + dv3 - bv2 = c2 - c1
c3 = c2 - c1;
eqn = a*v1 + d*v3 - b*v2 == c3;

% solve the equation for a, b and d
sol = solve(eqn, [a, b, d]);

% extract the solutions
a_sol = sol.a;
b_sol = sol.b;
d_sol = sol.d;

% get points p1 and p2
p1 = c1 + a_sol*v1;
p2 = c2 + b_sol*v2;

% get midpoint point3D
point3D = (p1 + p2)/2;


end
