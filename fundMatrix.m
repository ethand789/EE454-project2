function funM = fundMatrix()
% Compute the 3x3 fundamental matrix F 
% between the two views using the camera calibration information given.  

cam1 = load("Project2DataFiles\Parameters_V1.mat").Parameters;
cam2 = load("Project2DataFiles\Parameters_V2.mat").Parameters;

im = imread('Project2DataFiles\im1corrected.jpg');
im2 = imread('Project2DataFiles\im2corrected.jpg');

% let cam1 = leftcam, and cam2 = rightcam

% compute location of rightcam in leftcam coordinate sys. 
% get Pmat of leftcam 
Pc1 = zeros(4);
Pc1(1:3,1:4) = cam1.Pmat;
Pc1(4,4) = 1;

% get position of rightcam
cam2_pos = zeros(1,4);
cam2_pos(1,1:3) = cam2.position;
cam2_pos(1,4) = 1;

% compute location cam2_c1
cam2_c1 = Pc1 * cam2_pos';
% cam1_c2 = cam2.Pmat * cam1_pos';

% getting matrix S from cam2_c1
S = zeros(3);
S(1,2) = -cam2_c1(3);
S(1,3) = cam2_c1(2);
S(2,3) = -cam2_c1(1);

S(2,1) = cam2_c1(3);
S(3,1) = -cam2_c1(2);
S(3,2) = cam2_c1(1);

% getting rotation matrix R
R = cam2.Rmat * cam1.Rmat';

% computing E = R * S
Emat = R*S;

% computing fundamental matrix funM

% getting Kr and Kl matrices
Kr = cam2.Kmat;
Kl = cam1.Kmat;

% pre multiply Emat with (Kr^-1)^T 
F = inv(Kr)' * Emat;

% post multiply Emat with Kl^-1

F = F * inv(Kl);

funM = F;

% sanity check 3.4
[res1,res2] = question_1_driver;
    x1=res1(1,1:10);
    y1=res1(2,1:10);
    x2=res2(1,1:10);
    y2=res2(2,1:10);

colors =  'bgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmyk';
%overlay epipolar lines on im2
L = F * [x1 ; y1; ones(size(x1))];
[nr,nc,nb] = size(im2);
figure(2); clf; imagesc(im2); axis image;
hold on; plot(x2,y2,'*'); hold off
for i=1:length(L)
    a = L(1,i); b = L(2,i); c=L(3,i);
    if (abs(a) > (abs(b)))
       ylo=0; yhi=nr; 
       xlo = (-b * ylo - c) / a;
       xhi = (-b * yhi - c) / a;
       hold on
       h=plot([xlo; xhi],[ylo; yhi]);
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    else
       xlo=0; xhi=nc; 
       ylo = (-a * xlo - c) / b;
       yhi = (-a * xhi - c) / b;
       hold on
       h=plot([xlo; xhi],[ylo; yhi],'b');
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    end
end


%overlay epipolar lines on im1
L = ([x2 ; y2; ones(size(x2))]' * F)' ;
[nr,nc,nb] = size(im);
figure(1); clf; imagesc(im); axis image;
hold on; plot(x1,y1,'*'); hold off
for i=1:length(L)
    a = L(1,i); b = L(2,i); c=L(3,i);
    if (abs(a) > (abs(b)))
       ylo=0; yhi=nr; 
       xlo = (-b * ylo - c) / a;
       xhi = (-b * yhi - c) / a;
       hold on
       h=plot([xlo; xhi],[ylo; yhi],'b');
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    else
       xlo=0; xhi=nc; 
       ylo = (-a * xlo - c) / b;
       yhi = (-a * xhi - c) / b;
       hold on
       h=plot([xlo; xhi],[ylo; yhi],'b');
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    end
end



end

