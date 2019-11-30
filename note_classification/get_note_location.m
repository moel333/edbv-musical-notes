function blob_loc = get_note_location(vector_hor, note_line_distance, note_stem_thickness, line_points)
    %note_line_thickness is needed when note is not inside the 5 note lines
    %for adding distances
    
    % go over vector_hor until you find a spot where spots of exactly
    % note_line_distance are higher than note_stem_thickness
    blob_loc = zeros(2, 1);
    spot_length = 0;
    for i = 1 : length(vector_hor)
        if (vector_hor(i) > note_stem_thickness)
            if (ismember(i, line_points) && (spot_length == 0))
                spot_length = 0;
            else
                spot_length = spot_length + 1;
            end
        else
            spot_length = 0;
        end
        if (spot_length == note_line_distance)
            blob_loc(2) = i;
            blob_loc(1) = i - spot_length;
            break;
        end
    end
end

