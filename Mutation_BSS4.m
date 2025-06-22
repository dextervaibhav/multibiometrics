function [o1] = Mutation_BSS4(o1,mutationpoints)
        
        for i=1:2:size(mutationpoints,2)
            o1(1,mutationpoints(1,i)) = 1-o1(1,mutationpoints(1,i));
        end

end