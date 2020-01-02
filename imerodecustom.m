function [result] = imerodecustom(mat,line)
%IMERODECUSTOM erodes image with an object
%   Detailed explanation goes here

line=getnhood(line);
m=floor(size(line,1)/2);
n=floor(size(line,2)/2);
pad=padarray(mat,[m n],1);
result=false(size(mat));
for i=1:size(pad,1)-(2*m)
    for j=1:size(pad,2)-(2*n)
        Temp=pad(i:i+(2*m),j:j+(2*n));
        result(i,j)=min(min(Temp-line));
    end
end
result=~result;
end

