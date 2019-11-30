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