clear all;
load iris_dataset;
ilosc_podzialow = 10;
ilosc_neuronow = [6];
ilosc_epok = 100;
%mieszanie danych 
input = irisInputs;
target = irisTargets;
each_class_num = (size(input,2)/ilosc_podzialow)/size(target,1);

podzial = {};

% n = floor(size(irisInputs,2)/ilosc_podzialow); %%%MUSI BYC CALKOWITE
k = 1;
for i=1:ilosc_podzialow
    tmp = input(:,k:k+each_class_num-1);
    tmp = [tmp input(:,50+k:49+k+each_class_num)];
    tmp = [tmp input(:,100+k:99+k+each_class_num)];
    tmp2 = target(:,k:k+each_class_num-1);
    tmp2 = [tmp2 target(:,50+k:49+k+each_class_num)];
    tmp2 = [tmp2 target(:,100+k:99+k+each_class_num)];
    podzial{1,i} = tmp;
    podzial{2,i} = tmp2;
    k = k + each_class_num;
end
clear each_* iris* k tmp tmp2 i
%%%w cellach mamy podzial komorek gotowy do cross validation
   


tabConfUczGlob = [];
    
tabConfTestGlob=[];
    
    
for sc=0.1:0.2:2
    tabConfUcz = [];
    tabConfTest=[];

    for step=1:10
        wejscie_uczace = [];
        wyjscie_uczace = [];
        wejscie_uczace = podzial{1,1};
        wyjscie_uczace = podzial{2,1};
        for i=1:ilosc_podzialow

            if  i ~= step
                wejscie_uczace = [wejscie_uczace podzial{1,i}];
                wyjscie_uczace = [wyjscie_uczace podzial{2,i}];

            end

        end
        % wejscie_uczace = cell2mat(wejscie_uczace);
        % wyjscie_uczace = cell2mat(wyjscie_uczace);

        wejscie_testujace = podzial{1,step};
        wyjscie_testujace = podzial{2,step};

        net = newgrnn(wejscie_uczace,wyjscie_uczace,sc);

         uczWynik = net(wejscie_uczace);
         testWynik  = net(wejscie_testujace); 
         uczWynik = round(uczWynik);
         testWynik = round(testWynik);

         confusion_matrix_ucz = confusion_matrix_iris(uczWynik,wyjscie_uczace);
         confusion_matrix_test = confusion_matrix_iris(testWynik,wyjscie_testujace);
         tabConfUcz = [tabConfUcz confusion_matrix_ucz];
         tabConfTest = [tabConfTest confusion_matrix_test];
    end
    tabConfUczGlob = [tabConfUczGlob {tabConfUcz}];
    tabConfTestGlob=[tabConfTestGlob {tabConfTest}];
end

