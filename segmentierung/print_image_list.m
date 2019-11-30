function print_image_list(image_list, figure_id)
    figure(figure_id);
    
    for jj=1:size(image_list, 2)
        subplot(1, size(image_list, 2), jj);
        imshow(image_list{1,jj});
    end
end