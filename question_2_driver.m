function output = question_2_driver()
% reconstructs a 3D points from 2D points

% get 2D points
[res1, res2] = question_1_driver;
Opoints3D = load('Project2DataFiles\mocapPoints3D.mat').pts3D;
% create matrix 3x39
points3D = zeros(3,39);

% reconstruct 3D points from 2D points
for i = 1:39
    points3D(1:3,i) = triang(res1(i,1:3), res2(i,1:3));
end

% compute percent error for each corresponding 3D point
mse = zeros(1,39);

for i = 1:39
    distance = norm(points3D(1:3,i) - Opoints3D(1:3,i));
    actual_distance = norm(points3D(1:3,i));

    mse(1,i) = (distance/actual_distance)*100;

end
 output = mse;

end
