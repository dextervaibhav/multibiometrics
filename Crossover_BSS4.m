function [o1,o2] = Crossover_BSS4(o1,o2,p1,p2,totalcols,crossoverpoint)
        
        for i=1:crossoverpoint
            o1(1,i)=p1(1,i);
            o2(1,i)=p2(1,i);
        end
        
        for i=crossoverpoint+1:totalcols
            o1(1,i)=p2(1,i);
            o2(1,i)=p1(1,i);
        end
        
        
        

end