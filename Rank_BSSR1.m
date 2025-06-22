function [ rank ] = Rank_BSSR1( rank,fitness,populationsize )
    for i=1:populationsize
        cnt =0;
        for j=1:populationsize
            if i~=j
                if fitness{j}(1,1)<fitness{i}(1,1) & fitness{j}(1,2)<fitness{i}(1,2) & fitness{j}(1,3)<fitness{i}(1,3) &fitness{j}(1,4)<fitness{i}(1,4)
                    cnt=cnt+1;
                end
            end
        end
        rank{i} = cnt+1;
    end


end

