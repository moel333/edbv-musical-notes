function has_clutter = has_clutter(vector_hor, note_stem_thickness, line_points, note_location)
    has_clutter = false;
    for i = 1 : length(vector_hor)
        if (vector_hor(i) > note_stem_thickness)
            if ((~(ismember(i, line_points))) && ~(i>note_location(1)&&(i<note_location(2))))
                has_clutter = true;
                break;
            end
        end
    end
end

