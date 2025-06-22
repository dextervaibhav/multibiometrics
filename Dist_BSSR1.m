function [found_individual second_position third_position]= Dist_BSSR1(found_individual,second_position,third_position,res,finalpopulation,finalfitness)

    ftnsum = cell(1,size(finalpopulation,2));
    for i=1:size(finalpopulation,2)
        ftnsum{i} = 1000000000;
    end
    
    for i=1:size(finalpopulation,2)
        for j=1:size(res,2)
            tmp = res(1,j);
            if i==tmp
                ftnsum{i}= sum(finalfitness{i});
            end
        end
    end
    
    mnftns = 1000000000;
    
    for i=1:size(finalpopulation,2)
        if ftnsum{i}<mnftns
            mnftns = ftnsum{i};
        end
    end
    
    tmp = 0;
    for i=1:size(finalpopulation,2)
        if ftnsum{i}==mnftns
            tmp = i;
            break;
        end
    end
    
    arr = finalpopulation{tmp};
    arr = unique(arr);
    arr = sort(arr,'descend');
    
    found_individual = find(finalpopulation{tmp}==arr(1,1));
    second_position = find(finalpopulation{tmp}==arr(1,2));
    third_position = find(finalpopulation{tmp}==arr(1,3));
    
    found_individual = found_individual(1,1);
    second_position = second_position(1,1);
    third_position = third_position(1,1);
    
    
end
