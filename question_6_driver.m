function SED = question_6_driver(F)
%UNTITLED Summary of this function goes here

im1 = imread('Project2DataFiles\im1corrected.jpg');
im2 = imread('Project2DataFiles\im2corrected.jpg');

[im1points, im2points] = question_1_driver;

sqgd = zeros(1,78);

for i = 1:39
    % get epipolar lines on the image
    im2Epi = F * im1points(1:3,i);
    point = im2points(1:3,i);
    % compute squared geometric distance
    numerator1 = (im2Epi(1)*point(1)) + (im2Epi(2)*point(2)) + im2Epi(3);
    denominator1 = im2Epi(1)^2 + im2Epi(2)^2;

    sqgd(1,i) = numerator1^2/denominator1;

end

% repeat for 2nd image
for i = 40:78
    o = i - 39;
    im1Epi = im2points(1:3,o)' * F;
    point = im1points(1:3,o);
    numerator2 = (im1Epi(1)*point(1)) + (im1Epi(2)*point(2)) + im1Epi(3);
    denominator2 = im1Epi(1)^2 + im1Epi(2)^2;

    sqgd(1,i) = numerator2^2/denominator2;
end

SED = mean(sqgd);

end

