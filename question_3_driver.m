function [out] = question_3_driver()
%click on 1 point on eahc image and a 3d coordinate representinf the
%location will be returned.

%get input coordinates
image = imread('Project2DataFiles\im1corrected.jpg');
imshow(image);     % display image
in1 = ginput(1);

image = imread('Project2DataFiles\im2corrected.jpg');
imshow(image);     % display image
in2 = ginput(1);

Pu1=[0;0;1];
Pu1(1)=in1(1);
Pu1(2)=in1(2);

Pu2=[0;0;1];
Pu2(1)=in2(1);
Pu2(2)=in2(2);

res=triang(Pu1,Pu2);
out=round(res,6);


end