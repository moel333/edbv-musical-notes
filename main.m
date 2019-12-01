function main
    [filename, path] = uigetfile(fullfile(pwd,'*.jpg')) ;
    image = imread(fullfile(path, filename));
    
    original_image = image;
    
    if ~ismatrix(image)
        image = rgb2gray(image);
    end
    
    
    % find angle at which the image was taken
    %angle = horizonFFT(image, 0.1);
    %angle = mod(45+angle,90)-45;
    % uses this angle to straighten the image
    %res = imrotate_white(image, -angle);
    % convert image to black and white values
    bin_image =1-imbinarize(image, 0.9);

    imshow(bin_image);

    staff_lines = find_stafflines(bin_image);

    if ~isempty(staff_lines)


        % Identify positions to split into subimages for each row block
        split_pos = get_split_positions(bin_image, staff_lines);
        % Split into subimages
        sub_imgs = split_images(original_image, split_pos);
    end
    
    test_img = sub_imgs{1,5};
    %print_image_list(sub_imgs,22);
    
    takt_list = decompose(test_img, 1);
    
    % TODO FIX: THIS ONLY WORKS WITH THIS IMAGE AS 900 is an arbitrary
    % threshold
    image_grayy = rgb2gray(test_img);
    image_binn = imbinarize(image_grayy);
    image_binn = ~image_binn;
    vector_hor = sum(image_binn, 2);
    
    line_points = find(vector_hor > 900);
    
    for ii=1:size(takt_list, 2)
        % inside a takt
        image_list = takt_list{1,ii};
        for jj=1:size(image_list, 2)
            % inside a single note
            note = note_classification_main(image_list{1, jj}, line_points);
            % row index of note start in image
            fst = note(1);
            % row index of note end in image
            snd = note(2);
            % 1 = whole, 2 = half
            speed = note(3);
            fst
            snd
            speed
            line_points
            img = image_list{1, jj};
            img(fst:snd, :, 1) = 150;
            figure(jj)
            imshow(img);
        end
    end
end
