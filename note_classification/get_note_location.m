function blob_loc = get_note_location(bin_img, vector_hor, note_line_distance, note_stem_thickness, line_points)
    %note_line_thickness is needed when note is not inside the 5 note lines
    %for adding distances
    
    % go over vector_hor until you find a spot where spots of exactly
    % note_line_distance are higher than note_stem_thickness
    blob_loc = zeros(2, 1);
    note_head_width = get_note_head_width(note_line_distance);
    spot_length = 0;
    note_line_dist_low = note_line_distance - ceil(note_line_distance*0.1);
    note_line_dist_high = note_line_distance + ceil(note_line_distance*0.1);
    
    for i = 1 : length(vector_hor)
        if (vector_hor(i) > note_stem_thickness)
            if (ismember(i, line_points) && (spot_length == 0))
                spot_length = 0;
            elseif (spot_length < note_line_distance)
                spot_length = spot_length + 1;
            end
        else
            spot_length = 0;
        end
        if ((spot_length>=note_line_dist_low) && (spot_length<=note_line_dist_high))
            loc_1 = i - spot_length;
            loc_2 = i;
            if (is_correct_width(bin_img(loc_1:loc_2, :), note_head_width, spot_length))
                blob_loc(2) = i;
                blob_loc(1) = i - spot_length;
                break;
            end
        end
    end
end

function is_correct_width = is_correct_width(img_slice, note_head_width, note_head_height)
    spot_length = 0;
    vector_ver = sum(img_slice, 1);
    cutoff = min(vector_ver);
    is_correct_width = 0;
    
    for i = 1 : length(vector_ver)
        cur_value = vector_ver(i);
        if (cur_value > cutoff)
            spot_length = spot_length + 1;
        elseif ((spot_length >= note_head_height) && (spot_length <= note_head_width))
            % note must be of some thickness somewhere in the middle
            index = i - ceil(spot_length/2);
            if (vector_ver(index) > (note_head_height*0.9))
                is_correct_width = 1;
                return;
            end
            
        else
            spot_length = 0;
        end
    end
    

end
