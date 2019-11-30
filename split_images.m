function [ out_im ] = split_images( in_im, split_pos )
% SPLIT IMAGES 
%   Inputs, binary image and location of staff lines
%   Outputs, subimages 

    out_im = [];
    for i=1:length(split_pos)-1
        out_im{i} = in_im(split_pos(i):split_pos(i+1),1:(size(in_im, 2)),1:3);
    end
end

