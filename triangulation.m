function point3D = triangulation(Pu1,Pu2)
% takes two 2D points and returns a recovered 3D point by
% performing triangulation.

% get camera parameters
cam1 = load("Project2DataFiles\Parameters_V1.mat").Parameters;
cam2 = load("Project2DataFiles\Parameters_V2.mat").Parameters;
 
%construct S matrix
S1=eye(4);
for i=1:3
    S1(i,4)=-cam1.position(i);
end

%construct R matrix
R1=zeros(4);
R1(4,4) = 1;
R1(1:3,1:3)=cam1.Rmat;

% partitioned matrix R|t (3x4)
matrix1 = R1 * S1;
part_m1 = matrix1(1:3, 1:4);

% get matrix t
t1 = part_m1(1:3,4);

% get location c1
c1 = -cam1.Rmat' * t1;

%compute vector v1
v1 = cam1.Rmat' * inv(cam1.Kmat) * Pu1;
v1 = v1/norm(v1);

% get viewing ray 1
viewRay1 = [c1, v1];

%construct S matrix
S2=eye(4);
for i=1:3
    S2(i,4)=-cam2.position(i);
end

%construct R matrix
R2=zeros(4);
R2(4,4) = 1;
R2(1:3,1:3)=cam2.Rmat;

% partitioned matrix R|t (3x4)
matrix2 = R2 * S2;
part_m2 = matrix2(1:3, 1:4);

% get matrix t
t2 = part_m2(1:3,4);

% get location c1
c2 = -cam2.Rmat' * t2;

%compute vector v1
v2 = cam2.Rmat' * inv(cam2.Kmat) * Pu2;
v2 = v2/norm(v2);

% get viewing ray 2
viewRay2 = [c2, v2];

% compute cross product of v1 and v2
v1xv2 = cross(viewRay1, viewRay2);

% get unit vector v3
v3 = v1xv2/norm(v1xv2);

% define variables a, b and d
syms a b d

% define the equation av1 + dv3 - bv2 = c2 - c1
eqn = a*v1 + d*v3 - b*v2 == c2 - c1;

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