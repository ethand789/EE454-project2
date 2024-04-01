function funM = fundMatrix()
% Compute the 3x3 fundamental matrix F 
% between the two views using the camera calibration information given.  

cam1 = load("Project2DataFiles\Parameters_V1.mat").Parameters;
cam2 = load("Project2DataFiles\Parameters_V2.mat").Parameters;

% let cam2 = leftcam, and cam1 = rightcam

% compute location of rightcam in leftcam coordinate sys. 
% get Pmat of leftcam 
Pc2 = zeros(4);
Pc2(1:3,1:4) = cam2.Pmat;
Pc2(4,4) = 1;

% get position of rightcam
cam1_pos = zeros(1,4);
cam1_pos(1,1:3) = cam1.position;
cam1_pos(1,4) = 1;

% compute location cam2_c1
cam1_c2 = Pc2 * cam1_pos';

% getting matrix S from cam2_c1
S = zeros(3);
S(1,2) = -cam1_c2(3);
S(1,3) = cam1_c2(2);
S(2,3) = -cam1_c2(1);

S(2,1) = cam1_c2(3);
S(3,1) = -cam1_c2(2);
S(3,2) = cam1_c2(1);

% getting rotation matrix R
R = cam2.Rmat * cam1.Rmat';

% computing E = R * S
Emat = R*S;

% computing fundamental matrix funM

% getting Kr and Kl matrices
Kr = cam1.Kmat;
Kl = cam2.Kmat;

% pre multiply Emat with (Kr^-1)^T 
F = (inv(Kr))' * Emat;

% post multiply Emat with Kl^-1

F = F * inv(Kl);

funM = F;





end

