modalities = input('ENTER THE NUMBER OF MODALITIES IN MULTIBIOMETRICS: ');
file = cell(1,modalities+1);
disp('----------------ENTER THE PROBEFILE IN THE LAST--------------');

for i=1:modalities+1
    if i<=modalities
        fprintf('ENTER THE NAME OF FILE %d\n',i);
    end
    if i==modalities+1
        fprintf('ENTER THE NAME OF PROBE FILE\n');
    end
    x = input('-> ','s');
    
    file{i} = x;
end
winsize = input('ENTER THE WINDOW SIZE: ');
choicestrat = input('ENTER 1 FOR FREQUENCY BASED SOLUTION AND 2 FOR DISTANCED BASED SOLUTION: ');
paretofile = input('ENTER THE FULL PATH OF PARETOSET DATA FILE (.dat format): ','s'); 
conpointfile =  input('ENTER THE FULL PATH OF CONVERGENCEPOINT DATA FILE (.dat format): ','s');

if modalities==4
    
    disp('-------------------------------------------------------------------------');
    disp('-----------------PROCESSING BSSR1 DATASET ON NSGA2-----------------------');
    disp('-------------------------------------------------------------------------');
end
if modalities==5
    disp('-------------------------------------------------------------------------');
    disp('------------------PROCESSING BSS4 DATASET ON NSGA2-----------------------');
    disp('-------------------------------------------------------------------------');
end
    
    
row_counter = 1;
accuracy_incrementer = 0;
combinedpopulationsize = 200;
populationsize = 100;


topfirstposition = 0;
topsecondposition = 0;
topthirdposition = 0;
if modalities==4
    file1 = csvread(file{1});
    file2 = csvread(file{2});
    file3 = csvread(file{3});
    file4 = csvread(file{4});
    check = csvread(file{5});
end

if modalities==5
    file1 = csvread(file{1});
    file2 = csvread(file{2});
    file3 = csvread(file{3});
    file4 = csvread(file{4});
    file5 = csvread(file{5});
    check = csvread(file{6});
end

totalrows = size(file1,1);
totalcols = size(file1,2);

convergencepoint = zeros(totalrows,1);

while row_counter<=totalrows
    
    if modalities==4
        r1 = zeros(1,totalcols);
        r2 = zeros(1,totalcols);
        r3 = zeros(1,totalcols);
        r4 = zeros(1,totalcols);
    end
    
    if modalities==5
        r1 = zeros(1,totalcols);
        r2 = zeros(1,totalcols);
        r3 = zeros(1,totalcols);
        r4 = zeros(1,totalcols);
        r5 = zeros(1,totalcols);
    end
    
    if modalities==4
        for i=1:totalcols
            r1(1,i) = file1(row_counter,i);
            r2(1,i) = file2(row_counter,i);
            r3(1,i) = file3(row_counter,i);
            r4(1,i) = file4(row_counter,i);
        end
    end
    
    if modalities==5
        for i=1:totalcols
            r1(1,i) = file1(row_counter,i);
            r2(1,i) = file2(row_counter,i);
            r3(1,i) = file3(row_counter,i);
            r4(1,i) = file4(row_counter,i);
            r5(1,i) = file5(row_counter,i);
        end
    end
    
    pt = cell(1,populationsize);
    if modalities ==4    
        pt{1} = r1;
        pt{2} = r2;
        pt{3} = r3;
        pt{4} = r4;
       
    end
    
    if modalities ==5
        pt{1} = r1;
        pt{2} = r2;
        pt{3} = r3;
        pt{4} = r4;
        pt{5}=  r5;
    end
    if modalities==4
        for i=5:populationsize
                r = rand(1,totalcols);
                pt{i} = r;
        end
    end
    if modalities==5
        for i=6:populationsize
                r = rand(1,totalcols);
                pt{i} = r;
        end
    end
    
    fitness = cell(1,populationsize);
    
    if modalities==4
        [fitness] = Fitness_BSSR1(pt,fitness,r1,r2,r3,r4,populationsize,totalcols); 
    end
    
    if modalities==5
        [fitness] = Fitness_BSS4(pt,fitness,r1,r2,r3,r4,r5,populationsize,totalcols);
    end
        
    
    rank = cell(1,populationsize);
    
    if modalities==4
        [rank]= Rank_BSSR1(rank,fitness,populationsize);
    end
    if modalities==5
        [rank]= Rank_BSS4(rank,fitness,populationsize);
    end
        
    
    qt = cell(1,populationsize);
    sizeofqt=0;
    tournamentvector = [];
    temp1 = randperm(populationsize);
    for i=1:populationsize
        tournamentvector(end+1) = temp1(1,i);
    end
    temp2 = randperm(populationsize);
    for i=1:populationsize
        tournamentvector(end+1) = temp2(1,i);
    end

    vecpointer = 1;
    
    while sizeofqt<populationsize
        idx1 = tournamentvector(1,vecpointer);
        vecpointer=vecpointer+1;
        idx2 = tournamentvector(1,vecpointer);
        vecpointer=vecpointer+1;
        
        winner1=0;
        winner2=0;
        if modalities==4
            [winner1,winner2] = Winner_BSSR1(fitness,idx1,idx2,winner1,winner2);
        end
        if modalities==5
            [winner1,winner2] = Winner_BSS4(fitness,idx1,idx2,winner1,winner2);
        end
            
        p1=[];
        if winner1==1
            p1=pt{idx1};
        end
        if winner1==0
            p1=pt{idx2};
        end
        
        
        idx1 = tournamentvector(1,vecpointer);
        vecpointer=vecpointer+1;
        idx2 = tournamentvector(1,vecpointer);
        vecpointer=vecpointer+1;
        
        winner1=0;
        winner2=0;
        if modalities==4
            [winner1,winner2] = Winner_BSSR1(fitness,idx1,idx2,winner1,winner2);
        end
        
        if modalities==5
            [winner1,winner2] = Winner_BSS4(fitness,idx1,idx2,winner1,winner2);
        end
            
        
        p2=[];
        if winner1==1
            p2=pt{idx1};
        end
        if winner1==0
            p2=pt{idx2};
        end
        
        
        crossoverpoint = randi([1,totalcols],1,1);
        
        o1 = zeros(1,totalcols);
        o2 = zeros(1,totalcols);
        
        if modalities==4
            [o1,o2] =  Crossover_BSSR1(o1,o2,p1,p2,totalcols,crossoverpoint); 
        end
        if modalities==5
            [o1,o2] =  Crossover_BSS4(o1,o2,p1,p2,totalcols,crossoverpoint);
        end
        
        zerone = rand(1,totalcols);
        mutationpoints =[];
        
        for i=1:size(zerone,2)
            if zerone(1,i)<0.01
                mutationpoints(end+1)=i;
            end
        end
                
        if mod(size(mutationpoints,2),2)==1
            mutationpoints= mutationpoints(2:end);
        end
        if modalities==4
            [o1] = Mutation_BSSR1(o1,mutationpoints);
        end
        if modalities==5
            [o1] = Mutation_BSS4(o1,mutationpoints);
        end
        
        zerone = rand(1,totalcols);
        mutationpoints =[];
        
        for i=1:size(zerone,2)
            if zerone(1,i)<0.01
                mutationpoints(end+1)=i;
            end
        end
        
        if mod(size(mutationpoints,2),2)==1
            mutationpoints= mutationpoints(2:end);
        end
        if modalities==4
            [o2] = Mutation_BSSR1(o2, mutationpoints);
        end
        if modalities==5
            [o2] = Mutation_BSS4(o2, mutationpoints);
        end
        
          
        
        sizeofqt = sizeofqt+1;
        qt{sizeofqt}=o1;
        
        sizeofqt = sizeofqt+1;
        qt{sizeofqt}=o2;
        
         
    end
    
    
    gen = 1;
    saturationcounter =0;
    if modalities==4
        v1prev = [0,0,0,0];
        v2prev = [0,0,0,0];
    end

    if modalities==5
        v1prev = [0,0,0,0,0];
        v2prev = [0,0,0,0,0];
    end
    if modalities==4
        graph1 = [];
        graph2 = [];
        graph3 = [];
        graph4 = [];
    end
    if modalities==5
        graph1 = [];
        graph2 = [];
        graph3 = [];
        graph4 = [];
        graph5 = [];
    end

        
        
    while gen<=100000
        
        
        concatpopulation = cell(1,combinedpopulationsize);

        for i=1:populationsize
            concatpopulation{i}= pt{i};
        end
        for i=1:populationsize
            concatpopulation{populationsize+i} = qt{i};
        end

        fitnesscat = cell(1,combinedpopulationsize);
        if modalities==4
            [fitnesscat] = Fitness_BSSR1(concatpopulation,fitnesscat,r1,r2,r3,r4,combinedpopulationsize,totalcols);
        end
        
        if modalities==5
            [fitnesscat] = Fitness_BSS4(concatpopulation,fitnesscat,r1,r2,r3,r4,r5,combinedpopulationsize,totalcols);
        end
        
        rankcat = cell(1,combinedpopulationsize);
        
        if modalities==4
            [rankcat] = Rank_BSSR1(rankcat,fitnesscat,combinedpopulationsize);
        end
        
        if modalities==5
            [rankcat] = Rank_BSS4(rankcat,fitnesscat,combinedpopulationsize);
        end
        

        srank = [];

        for i=1:size(rankcat,2)
            srank(end+1) = rankcat{i};
        end

        usrank = unique(srank);
        usrank = sort(usrank);



        cdist = cell(1,combinedpopulationsize);

        for i=1:combinedpopulationsize
            cdist{i} = 0;
        end
        pt1 = cell(1,populationsize);
        newselectedpopulation =[];

        frontbreak = [];
        found = 0;

        for i=1:size(usrank,2)
            tmpfront = [];
            for j=1:combinedpopulationsize
                if rankcat{j}==usrank(1,i)
                    tmpfront(end+1)= j;
                end
            end
            if size(newselectedpopulation,2)+size(tmpfront,2)<=populationsize
                for j=1:size(tmpfront,2)
                    newselectedpopulation(end+1) = tmpfront(1,j);
                end
            end
            if size(newselectedpopulation,2)+size(tmpfront,2)>populationsize & found ==0

                for j=1:size(tmpfront,2)
                    frontbreak(end+1) = tmpfront(1,j);
                end
                found = 1;
            end

            if size(tmpfront,2)==1
                cdist{tmpfront(1,1)} = 10000000;
                continue
            end

            if size(tmpfront,2)==2
                cdist{tmpfront(1,1)}=10000000;
                cdist{tmpfront(1,2)}=10000000;

                continue
            end
            if modalities==4
                [cdist] = Crowd_BSSR1(cdist,fitnesscat,tmpfront);
            end
            if modalities==5
                [cdist] = Crowd_BSS4(cdist,fitnesscat,tmpfront);
            end
                
        end

        if size(newselectedpopulation,2)<populationsize
            distance =[];
            for i=1:size(frontbreak,2)
                distance(end+1) = cdist{frontbreak(1,i)};
            end
                
                
            usdistance = unique(distance);
            usdistance = sort(usdistance,'descend');

            for i=1:size(usdistance,2)
                for j=1:size(frontbreak,2)
                    if cdist{frontbreak(1,j)} == usdistance(1,i)
                        newselectedpopulation(end+1)=frontbreak(1,j);
                        if size(newselectedpopulation,2)==populationsize
                            break
                        end
                    end
                end
                if size(newselectedpopulation,2)==populationsize
                    break
                end
            end

        end


        for i=1:populationsize
            pt1{i}= concatpopulation{newselectedpopulation(1,i)};
        end


        qt1 = cell(1,populationsize);

        sizeofqt1 = 0;

        tournamentvector = [];
        temp1 = randperm(populationsize);
        for i=1:populationsize
            tournamentvector(end+1) = temp1(1,i);
        end
        temp2 = randperm(populationsize);
        for i=1:populationsize
            tournamentvector(end+1) = temp2(1,i);
        end

        vecpointer = 1;
        
        while sizeofqt1<populationsize
            rand1 = tournamentvector(1,vecpointer);
            vecpointer=vecpointer+1;
            rand2 = tournamentvector(1,vecpointer);
            vecpointer=vecpointer+1;

            winner1 = -1;
            winner2 = -1;
            if rankcat{newselectedpopulation(1,rand1)}<rankcat{newselectedpopulation(1,rand2)}
                winner1=1;
                winner2=0;
            end

            if rankcat{newselectedpopulation(1,rand2)}<rankcat{newselectedpopulation(1,rand1)}
                winner1=0;
                winner2=1;
            end

            if rankcat{newselectedpopulation(1,rand1)}==rankcat{newselectedpopulation(1,rand2)}

                if cdist{newselectedpopulation(1,rand1)}>=cdist{newselectedpopulation(1,rand2)}
                    winner1=1;
                    winner2=0;
                end
                if cdist{newselectedpopulation(1,rand2)}>cdist{newselectedpopulation(1,rand1)}
                    winner1=0;
                    winner2=1;
                end

            end
            p1=[];

            if winner1==1 & winner2==0
                p1=concatpopulation{newselectedpopulation(1,rand1)};
            end
            if winner1==0 & winner2==1
                p1=concatpopulation{newselectedpopulation(1,rand2)};
            end


            rand1 = tournamentvector(1,vecpointer);
            vecpointer=vecpointer+1;
            rand2 = tournamentvector(1,vecpointer);
            vecpointer=vecpointer+1;

            winner1 = -1;
            winner2 = -1;
            if rankcat{newselectedpopulation(1,rand1)}<rankcat{newselectedpopulation(1,rand2)}
                winner1=1;
                winner2=0;
            end

            if rankcat{newselectedpopulation(1,rand2)}<rankcat{newselectedpopulation(1,rand1)}
                winner1=0;
                winner2=1;
            end

            if rankcat{newselectedpopulation(1,rand1)}==rankcat{newselectedpopulation(1,rand2)}
                if cdist{newselectedpopulation(1,rand1)}>=cdist{newselectedpopulation(1,rand2)}
                    winner1=1;
                    winner2=0;
                end
                if cdist{newselectedpopulation(1,rand2)}>cdist{newselectedpopulation(1,rand1)}
                    winner1=0;
                    winner2=1;
                end
            end
            
            p2=[];

            if winner1==1 & winner2==0
                p2=concatpopulation{newselectedpopulation(1,rand1)};
            end
            if winner1==0 & winner2==1
                p2=concatpopulation{newselectedpopulation(1,rand2)};
            end
            
            crossoverpoint = randi([1,totalcols],1,1);

            o1 = zeros(1,totalcols);
            o2 = zeros(1,totalcols);
            
            if modalities==4
                [o1,o2] = Crossover_BSSR1(o1,o2,p1,p2,totalcols,crossoverpoint);
            end
            if modalities==5
                [o1,o2] = Crossover_BSS4(o1,o2,p1,p2,totalcols,crossoverpoint);
            end
                
            zerone = rand(1,totalcols);
            mutationpoints =[];

            for i=1:size(zerone,2)
                if zerone(1,i)<0.01
                    mutationpoints(end+1)=i;
                end
            end
            

            if mod(size(mutationpoints,2),2)==1
                mutationpoints= mutationpoints(2:end);
            end
            
            if modalities==4
                [o1] = Mutation_BSSR1(o1,mutationpoints);
            end
            
            if modalities==5
                [o1] = Mutation_BSS4(o1,mutationpoints);
            end
            
            zerone = rand(1,totalcols);
            mutationpoints =[];

            for i=1:size(zerone,2)
                if zerone(1,i)<0.01
                    mutationpoints(end+1)=i;
                end
            end
           
            if mod(size(mutationpoints,2),2)==1
                mutationpoints= mutationpoints(2:end);
            end
            
            if modalities==4
                [o2] = Mutation_BSSR1(o2,mutationpoints);
            end
            if modalities==5
                [o2] = Mutation_BSSR1(o2,mutationpoints);
            end
            
            sizeofqt1 = sizeofqt1+1;
            qt1{sizeofqt1}=o1;

            sizeofqt1 = sizeofqt1+1;
            qt1{sizeofqt1}=o2;

        end

        
        prevparentfitness = cell(1,populationsize);
        if modalities==4
            [prevparentfitness] = Fitness_BSSR1(pt,prevparentfitness,r1,r2,r3,r4,populationsize,totalcols);
        end
        
        if modalities==5
            [prevparentfitness] = Fitness_BSS4(pt,prevparentfitness,r1,r2,r3,r4,r5,populationsize,totalcols);
        end
        
        currentparentfitness = cell(1,populationsize);
        if modalities==4
            [currentparentfitness] = Fitness_BSSR1(pt1,currentparentfitness,r1,r2,r3,r4,populationsize,totalcols);
        end
        
        if modalities==5
            [currentparentfitness] = Fitness_BSS4(pt1,currentparentfitness,r1,r2,r3,r4,r5,populationsize,totalcols);
        end
        
        if modalities==4
            v1cur=[0,0,0,0];
        end
        
        if modalities==5
            v1cur=[0,0,0,0,0];
        end
        
        for i=1:populationsize
            tf = 1;
            cp = 0;
            if modalities==4
                [cp] = CurrentPrev_BSSR1(cp,currentparentfitness{i},prevparentfitness{i});
            end
            if modalities==5
                [cp] = CurrentPrev_BSS4(cp,currentparentfitness{i},prevparentfitness{i});
            end
                
            if cp==1
                pt{i} = pt1{i};
                tf = 0;
                v1cur=v1cur+currentparentfitness{i};
            end
           
            if tf==1
                v1cur=v1cur+prevparentfitness{i};
            end
        end

        prevchildfitness = cell(1,populationsize);
        if modalities==4
            [prevchildfitness] = Fitness_BSSR1(qt,prevchildfitness,r1,r2,r3,r4,populationsize,totalcols);
        end
        
        if modalities==5
            [prevchildfitness] = Fitness_BSS4(qt,prevchildfitness,r1,r2,r3,r4,r5,populationsize,totalcols);
        end
        
        currentchildfitness = cell(1,populationsize);
        if modalities==4
            [currentchildfitness] = Fitness_BSSR1(qt1,currentchildfitness,r1,r2,r3,r4,populationsize,totalcols);
        end
        if modalities==5
            [currentchildfitness] = Fitness_BSS4(qt1,currentchildfitness,r1,r2,r3,r4,r5,populationsize,totalcols);
        end
        
        if modalities==4
            v2cur=[0,0,0,0];
        end
        if modalities==5
            v2cur=[0,0,0,0,0];
        end
        
        for i=1:populationsize
            tf = 1;
            cp = 0;
            if modalities==4
                [cp] = CurrentPrev_BSSR1(cp,currentchildfitness{i},prevchildfitness{i});
            end
            if modalities==5
                [cp] = CurrentPrev_BSS4(cp,currentchildfitness{i},prevchildfitness{i});
            end
            
            if cp==1
                qt{i} = qt1{i};
                tf =0;
                v2cur = v2cur+currentchildfitness{i};
            end
            if tf==1
                v2cur = v2cur+prevchildfitness{i};
            end
        end

        cnd1 = 0;
        
        if sum(abs(v1cur-v1prev))<=sum(v1cur)*0.01
            cnd1=1;
        end
        
        cnd2 = 0;
        if sum(abs(v2cur-v2prev))<=sum(v2cur)*0.01
            cnd2=1;
        end

        if cnd1==1 & cnd2==1 & saturationcounter>=winsize
            convergencepoint(row_counter,1) = gen;
            break;
        end
        if cnd1==1 & cnd2==1
            saturationcounter=saturationcounter+1;
        end
        if cnd1~=1 | cnd2~=1
            saturationcounter=0;
        end

        v1prev = v1cur;
        v2prev = v2cur;
        if modalities==4
            graph1(end+1)= v1cur(1,1);
            graph2(end+1)= v1cur(1,2);
            graph3(end+1)= v1cur(1,3);
            graph4(end+1)= v1cur(1,4);
        end
        if modalities==5
            graph1(end+1)= v1cur(1,1);
            graph2(end+1)= v1cur(1,2);
            graph3(end+1)= v1cur(1,3);
            graph4(end+1)= v1cur(1,4);
            graph5(end+1)= v1cur(1,5);
        end
        gen=gen+1;

    end
    
    
    finalpopulation = cell(1,combinedpopulationsize);
    
    for i=1:populationsize
        finalpopulation{i}= pt{i};
    end

    for i=1:populationsize
        finalpopulation{populationsize+i} = qt{i};
    end
    
    finalfitness = cell(1,combinedpopulationsize);
    if modalities ==4
        [finalfitness] = Fitness_BSSR1(finalpopulation,finalfitness,r1,r2,r3,r4,combinedpopulationsize,totalcols);
    end
    if modalities ==5
        [finalfitness] = Fitness_BSS4(finalpopulation,finalfitness,r1,r2,r3,r4,r5,combinedpopulationsize,totalcols);
    end
    
    finalrank = cell(1,combinedpopulationsize);
    
    if modalities==4
        [finalrank] = Rank_BSSR1(finalrank,finalfitness,combinedpopulationsize);
    end
    
    if modalities==5
        [finalrank] = Rank_BSS4(finalrank,finalfitness,combinedpopulationsize);
    end
    
    
    res = [];
        
    for i=1:combinedpopulationsize
        if finalrank{i}==1
            res(end+1) = i;
        end
    end
    
    paretoset = zeros(size(res,2)+1,totalcols);
    for i=1:size(res,2)
        tmp = finalpopulation{res(1,i)};
        for j=1:totalcols
            paretoset(i,j) = tmp(1,j);
        end
    end
    
    for j=1:totalcols
        paretoset(size(res,2)+1,j) = 1000000000;
    end
   
    dlmwrite(paretofile,paretoset,'-append');
        
   
    found_individual = 0;
    second_position = 0;
    third_position = 0;
    if modalities==4 & choicestrat==1
        [found_individual second_position third_position] = Freq_BSSR1(found_individual,second_position,third_position,res,finalpopulation);
    end
    if modalities==4 & choicestrat==2
        [found_individual second_position third_position] = Dist_BSSR1(found_individual,second_position,third_position,res,finalpopulation,finalfitness);
    end
    if modalities==4 & choicestrat==3
        [found_individual second_position third_position] = Mid_BSSR1(found_individual,second_position,third_position,res,finalpopulation,finalfitness);
    end
    
    if modalities==5 & choicestrat==1
        [found_individual second_position third_position] = Freq_BSS4(found_individual,second_position,third_position,res,finalpopulation);
    end
    if modalities==5 & choicestrat==2
        [found_individual second_position third_position] = Dist_BSS4(found_individual,second_position,third_position,res,finalpopulation,finalfitness);
    end
    
    
      
     
     
    original_individual = check(row_counter,1);
   
    if original_individual==found_individual
        accuracy_incrementer=accuracy_incrementer+1;
        topfirstposition = topfirstposition+1;
    end
    
    if original_individual==found_individual | original_individual==second_position
        topsecondposition = topsecondposition+1;
    end
    
    if original_individual==found_individual | original_individual==second_position | original_individual==third_position
        topthirdposition = topthirdposition+1;
    end
    
        
    
    disp('------------------------------------------------------------');
    fprintf('found_individual        ->%d\n',found_individual);
    fprintf('original_invividual     ->%d\n',original_individual);
    fprintf('convergence_point      ->%d\n',convergencepoint(row_counter,1));
    fprintf('row ->%d accuracy       ->%d\n',row_counter,accuracy_incrementer);
    disp('------------------------------------------------------------');
    row_counter=row_counter+1;
  
end


csvwrite(conpointfile,convergencepoint);
accuracy = (accuracy_incrementer/totalrows)*100;
disp('------accuracy----------');
disp(accuracy);
disp('------------------------');

accuracy = (topsecondposition/totalrows)*100;
disp('------accuracy topsecond----------');
disp(accuracy);
disp('------------------------');

accuracy = (topthirdposition/totalrows)*100;
disp('------accuracy topthird----------');
disp(accuracy);
disp('------------------------');