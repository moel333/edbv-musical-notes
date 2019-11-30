function result = separate_notes(image, bottom_value)
    image_grey = rgb2gray((image{1,1}));
    image_binary = imbinarize(image_grey);
    img = imcomplement(image_binary);
    
    proj = sum(img, 1);
    frag_list = {};
    
    
    %bar(proj);
    %disp(proj);
    
    frag_end = 0;
    
    %SETTINGS
    cut_width = 13;
    cut_margin = (-2);
    
    cut_full_note_margin = (-2);
    
    idx = cut_width + cut_margin;
    while (find_next_note(img, proj, idx, cut_width, cut_margin, bottom_value) ~= (-1))
        next_note_idx = find_next_note(img, proj, idx, cut_width, cut_margin, bottom_value);
        extract_frag = image{1,1}(1:size(image{1,1}, 1),    max(next_note_idx - cut_width + cut_margin, 1):min(next_note_idx+cut_width+cut_margin, size(image{1,1}, 2)),   1:3);
        frag_list{end + 1} = extract_frag;
        
        idx =  next_note_idx + cut_width + cut_margin;
    end
    result = frag_list;
end