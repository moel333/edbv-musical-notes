function [ staff_lines ] = find_stafflines( bin_image )
% STAFF LINE IDENTIFICATION 
%   Inputs, binary image
%   Outputs, positions and cluster of the staff lines
    
    % Erosion of horizontal lines 
    se_line = strel('line', length(bin_image)*0.005, 0);
    bin_image_se = imerode(bin_image, se_line);

    % Plot the horizontal projection
    plot(sum(bin_image_se,2), fliplr(1:size(bin_image_se,1)));
    
    % Find locations using Horizontal projection
    [pks, locs] = findpeaks(sum(bin_image_se,2));

    % Remove all unrelevant peaks based on threshold
    tresh = pks > max(pks)/4;
    locs = locs .* tresh;
    pks = pks .* tresh;
    
    
    pks_tresh = pks(pks~=0);
    locs_tresh = locs(locs~=0);
    staff_lines = [];
    
    % Classification of stafflines clusters
   
      staff_lines = locs_tresh;
     if mod(length(staff_lines), 5) ~= 0   
        % Remove shortest line until the systems consist of 5 lines
        while mod(length(staff_lines), 5) ~= 0
            index = find(pks_tresh == min(pks_tresh));
            pks_tresh(index) = [];
            staff_lines(index) = [];
            
            pks_tresh = pks_tresh(pks_tresh~=0);
            staff_lines = staff_lines(staff_lines~=0);
        end
  
    end
end



