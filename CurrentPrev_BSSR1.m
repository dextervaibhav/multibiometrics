function [cp] = CurrentPrev_BSSR1(cp,current,prev)

     if current(1,1)<prev(1,1) & current(1,2)<prev(1,2)& current(1,3)<prev(1,3)&current(1,4)<prev(1,4)
         cp=1;
     end

end