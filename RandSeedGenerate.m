 function AtomNamePositionMatrixSeed = RandSeedGenerate(StructureNumber,AtomNumber, AtomName, CenterPoint, k_max, k_min,BondMin)
 %AtomNamePositionMatrixSeed Format follow the [Name, X, Y, Z]
 %AtomNamePositionMatrixSeed = RandSeedGenerate(10,2, {['Mi'], ['Au']}, 1, 2, 1)
 %step 1: generate the random atoms(use m = rand(AtomNumber,3)*k+10.6032;)
 %AtomName is designed for the mutiple choice
 AtomNamePositionMatrixSeed = zeros(StructureNumber*AtomNumber,5);
 Times = 0;
 for i = 1 : StructureNumber
    
     while (1)
        k = k_min+rand(1,3)*(k_max-k_min);
        k1 = k(1); k2 = k(2); k3 = k(3);
        m = zeros(AtomNumber,3);
        m(:,1) = rand(AtomNumber,1)*k1+CenterPoint; % 10.6031 is a center position, because the bcc condition
        m(:,2) = rand(AtomNumber,1)*k2+CenterPoint;
        m(:,3) = rand(AtomNumber,1)*k3+CenterPoint;
        %m = rand(AtomNumber,3)*8.7937/20*AtomNumber+10.6032; %FCC arrangement results 
        %m = rand(AtomNumber,3)*8.7937/+10.6032;
        tic
        last = structure_fit(m,AtomNumber,BondMin,inf); %Check bad structures
        t2=toc;
        sum(last(2,:));
        if sum(last(2,:)) == 0
            break
        end
    end

        for j = 1 : AtomNumber 
            AtomNamePositionMatrixSeed(j+AtomNumber*Times,:) = [j, 1, m(j,:)]; % Position
        end
    Times = Times +1;
 end
end