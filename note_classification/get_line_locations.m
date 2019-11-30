function line_locations = get_line_locations(line_points)
    % this can be used with the real note lines too
    line_locations = zeros(5, 2);
    a = 1;
    index = 1;
    current = -1;
    while ((index <= length(line_points)) && (a <= 5))
        line_locations(a, 1) = line_points(index);
        line_locations(a, 2) = line_points(index);
        current              = line_points(index);
        index = index + 1;
        while ((index <= size(line_points, 1)) && (current+1 == line_points(index)))
            % next entry is part of the same note line
            line_locations(a, 2) = line_points(index);
            current = line_points(index); 
            index = index +1;
        end
        a = a + 1;
    end
end