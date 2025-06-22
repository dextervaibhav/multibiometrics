function [ fitness ] = Fitness_BSSR1( pt,fitness,r1,r2,r3,r4,populationsize,totalcols)
        
    
    for i=1:populationsize
        f1=0;
        f2=0;
        f3=0;
        f4=0;
        tmp = pt{i};
        
        
        for j =1:totalcols
                    
            f1=f1+ max(tmp(1,j),r1(1,j))*abs(tmp(1,j)-r1(1,j));
            f2=f2+ max(tmp(1,j),r2(1,j))*abs(tmp(1,j)-r2(1,j));
            f3=f3+ max(tmp(1,j),r3(1,j))*abs(tmp(1,j)-r3(1,j));
            f4=f4+ max(tmp(1,j),r4(1,j))*abs(tmp(1,j)-r4(1,j));
        end
        x = [f1,f2,f3,f4];
        fitness{i} = x;
    end


end

