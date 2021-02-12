% Weighted Radical Mean

disp('WQAM r^s:- ');
fc = csvread('p.csv');
fc1 = csvread('q.csv');
fc2 = csvread('r.csv');
fc3 = csvread('s.csv');
check = csvread('t.csv');

for i=1:517
    for j=1:517
        fc(i,j)= 6^fc(i,j);
        fc1(i,j)= 6^fc1(i,j);
        fc2(i,j)= 6^fc2(i,j);
        fc3(i,j)= 6^fc3(i,j);
    end
end

fc= fc*0.25;
fc1= fc1*0.25;
fc2= fc2*0.25;
fc3= fc3*0.25;


mat= zeros(517,517);

for i=1:517
    for j=1:517
       tmp = fc(i,j)+fc1(i,j)+fc2(i,j)+fc3(i,j);
       mat(i,j)= log(tmp)/log(6);
    end
end

v = zeros(517,1);
ss = zeros(517,1);
for i=1:517
    
    [val,idx] = max(mat(i,:));
    v(i,1)=idx;
    ss(i,1)=val;
end
   
cnt = 0;
thr = 0;
for i=1:517
    if v(i,1)==check(i,1)
        cnt=cnt+1;
    end
    if v(i,1)~=check(i,1)
        thr=thr+ss(i,1);
    end
        
end

thr = thr/(517-cnt);
% disp(thr);

imposterscoreexceedingthreshold_count = 0;

for i=1:517
    if v(i,1)~=check(i,1)
        if ss(i,1)>thr
            imposterscoreexceedingthreshold_count=imposterscoreexceedingthreshold_count+1;
        end
    end
end
        

fprintf('FAR: %f\n',(imposterscoreexceedingthreshold_count/517)*100);


% disp(cnt);

fprintf('GAR: %f\n',(cnt/517)*100);





