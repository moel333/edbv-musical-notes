image = imread('test2.jpg');
% find angle at which the image was taken
angle = horizonFFT(image, 0.1);
angle = mod(45+angle,90)-45;
% uses this angle to straighten the image
res = imrotate_white(image, -angle);
% convert image to black and white values
BW = imbinarize(res, 0.9);

imshow(BW);

function angle = horizonFFT(image, precision)
maxsize = max(size(image));
T = fftshift(fft2(image, maxsize, maxsize));
T = log(abs(T)+1);

center = ceil((maxsize+1)/2);
evenS = mod(maxsize+1, 2);
T = (rot90(T(center:end, 1+evenS:center), 1) + T(center:end, center:end));
T = T(2:end, 2:end);

angles = floor(90/precision);
score = zeros(angles, 1);
maxDist = maxsize/2-1;
for angle = 0:angles-1
    [y,x] = pol2cart(deg2rad(angle*precision), 0:maxDist-1); % all [x,y]
    for i = 1:maxDist
        score(angle+1) = score(angle+1) + T(round(y(i)+1), round(x(i)+1));
    end
end
[~, position] = max(score);
angle = (position-1)*precision;
end

function rotated_image = imrotate_white(image, rot_angle_degree)
    RA = imref2d(size(image));    
    tform = affine2d([cosd(rot_angle_degree)    -sind(rot_angle_degree)     0; ...
                      sind(rot_angle_degree)     cosd(rot_angle_degree)     0; ...
                      0                          0                          1]);
      Rout = images.spatialref.internal.applyGeometricTransformToSpatialRef(RA,tform);
      Rout.ImageSize = RA.ImageSize;
      xTrans = mean(Rout.XWorldLimits) - mean(RA.XWorldLimits);
      yTrans = mean(Rout.YWorldLimits) - mean(RA.YWorldLimits);
      Rout.XWorldLimits = RA.XWorldLimits+xTrans;
      Rout.YWorldLimits = RA.YWorldLimits+yTrans;
      rotated_image = imwarp(image, tform, 'OutputView', Rout, 'interp', 'cubic', 'fillvalues', 255);
  end