function [found_individual second_position third_position]= Freq_BSSR1(found_individual,second_position,third_position,res,finalpopulation)
    populationcopy = cell(1,size(res,2));
    for i=1:size(res,2)
        populationcopy{i} = finalpopulation{res(1,i)};
    end
    position = zeros(1,3);
    pvalues = zeros(1,3);
    resres = [];
    for i=1:size(res,2)
        tmp  =0;
        [tmp,resres(end+1)] = max(populationcopy{i});
    end
    
    uresres = unique(resres);
    map = cell(1,size(uresres,2)); 
    
    for i=1:size(uresres,2)
        map{uresres(1,i)} = 0;
    end
    
    
    for i=1:size(resres,2)
        map{resres(1,i)} = map{resres(1,i)}+1;
    end
    
    
    mxfreq =0;
    for i=1:size(uresres,2)
        if mxfreq<map{uresres(1,i)}
            mxfreq = map{uresres(1,i)};
        end
    end
    
    for i=1:size(uresres,2)
        if mxfreq==map{uresres(1,i)}
            found_individual = uresres(1,i);
            break;
        end
    end
    
    tmp1  =0;
    cnt = 0;
    for i=1:size(res,2)
        val = 0;
        ind = 0;
        [val,ind] = max(populationcopy{i});
        if ind==found_individual
            tmp1= tmp1+val;
            cnt=cnt+1;
        end
    end
    
    tmp1 = tmp1/cnt;
    %fprintf('%d %d\n',found_individual,tmp1);
    position(1,1) = found_individual;
    pvalues(1,1) = tmp1;
    
    for i=1:size(res,2)
        populationcopy{i}(1,resres(1,i))=0;
    end
    
    
    resres1 = [];
    for i=1:size(res,2)
        tmp  =0;
        [tmp,resres1(end+1)] = max(populationcopy{i});
    end
    
    uresres1 = unique(resres1);
    map1 = cell(1,size(uresres1,2)); 
    
    for i=1:size(uresres1,2)
        map1{uresres1(1,i)} = 0;
    end
    
    
    for i=1:size(resres1,2)
        map1{resres1(1,i)} = map1{resres1(1,i)}+1;
    end
    
    
    mxfreq1 =0;
    for i=1:size(uresres1,2)
        if mxfreq1<map1{uresres1(1,i)}
            mxfreq1 = map1{uresres1(1,i)};
        end
    end
    second_position = 0;
    for i=1:size(uresres1,2)
        if mxfreq1==map1{uresres1(1,i)}
            second_position = uresres1(1,i);
            break;
        end
    end
    
    tmp1  =0;
    cnt = 0;
    for i=1:size(res,2)
        val = 0;
        ind = 0;
        [val,ind] = max(populationcopy{i});
        if ind==second_position
            tmp1= tmp1+val;
            cnt=cnt+1;
        end
    end
    
    tmp1 = tmp1/cnt;
    %fprintf('%d %d\n',second_position,tmp1);
    position(1,2) = second_position;
    pvalues(1,2) = tmp1;
    for i=1:size(res,2)
        populationcopy{i}(1,resres1(1,i))=0;
    end
    
    resres2 = [];
    for i=1:size(res,2)
        tmp  =0;
        [tmp,resres2(end+1)] = max(populationcopy{i});
    end
    
    uresres2 = unique(resres2);
    map2 = cell(1,size(uresres2,2)); 
    
    for i=1:size(uresres2,2)
        map2{uresres2(1,i)} = 0;
    end
    
    
    for i=1:size(resres2,2)
        map2{resres2(1,i)} = map2{resres2(1,i)}+1;
    end
    
    
    mxfreq2 =0;
    for i=1:size(uresres2,2)
        if mxfreq2<map2{uresres2(1,i)}
            mxfreq2 = map2{uresres2(1,i)};
        end
    end
    third_position=0;
    for i=1:size(uresres2,2)
        if mxfreq2==map2{uresres2(1,i)}
            third_position = uresres2(1,i);
            break;
        end
    end
    
    tmp1  =0;
    cnt = 0;
    for i=1:size(res,2)
        val = 0;
        ind = 0;
        [val,ind] = max(populationcopy{i});
        if ind==third_position
            tmp1= tmp1+val;
            cnt=cnt+1;
        end
    end
    
    tmp1 = tmp1/cnt;
    
    
    position(1,3) = third_position;
    pvalues(1,3) = tmp1;
    

end