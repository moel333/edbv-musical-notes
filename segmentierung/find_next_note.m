function result = find_next_note(img, proj, current_idx, cut_width, cut_margin, bottom_value)

    for ii=current_idx:size(proj, 2) - 5
        
        %// Half/Quarter etc.
        if (proj(ii) >= (30 - bottom_value))
            empty_space = true;
            cnt1 = 0;
                for jj=max(1,ii-6):min(ii, size(proj, 2))
                    if(proj(jj) >= bottom_value + 5)
                        cnt1 = cnt1 + 1
                    end
                end
                if(cnt1 >= 5)
                    empty_space = false;
                end
                    
                cnt2 = 0;
                for jj=max(1,ii):min(ii+6, size(proj, 2))
                    if(proj(jj) >= bottom_value + 5)
                        cnt2 = cnt2 + 1
                    end
                end
                if(cnt2 >= 5)
                    empty_space = false;
                end
                if(empty_space == false)
                    result = ii;
                    return;
                end
        end
        
        %// Full Notes
        if (proj(ii) >= 10 + bottom_value && ii > 15)
            is_full_note = false;
            second_line = -1;
            for jj=(ii-10):(ii-1)
                if(abs(proj(ii) - proj(jj)) < 3)
                    second_line = jj;
                end
            end
            
            if(second_line ~= -1)
                for jj = second_line:ii
                    if(proj(jj) <= proj(ii)-4 && proj(jj) > 6)
                        is_full_note = true;
                    end
                end
            end
            
            if(is_full_note == true)
                for jj = ii - cut_width+cut_margin:ii+cut_width+cut_margin
                    if (proj(jj) >= 24)
                        is_full_note = false;
                    end
                end
            end
            
            if(is_full_note == true)
                result = ii;
                return;
            end
        end
    end
    result = -1;
end