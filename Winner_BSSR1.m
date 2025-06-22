function [ winner1,winner2 ] = Winner_BSSR1( fitness,idx1,idx2,winner1,winner2 )
    tf =1;
   
    if fitness{idx1}(1,1)<fitness{idx2}(1,1) & fitness{idx1}(1,2)<fitness{idx2}(1,2) & fitness{idx1}(1,3)<fitness{idx2}(1,3) & fitness{idx1}(1,4)<fitness{idx2}(1,4)
            winner1=1;
            tf =0;
            
    end
    
    if tf==1
        winner2 = 1;
    end
    

end

