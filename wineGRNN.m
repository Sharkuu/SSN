clear all;
load wine_dataset;
ilosc_podzialow = 10;
ilosc_neuronow = 6;
% SKRACAM DANE O 8 ZEBY SIE DALO LADNIE PODZIELIC DO CV
input = wineInputs(:,1:170);
target = wineTargets(:,1:170);
%mieszanie danych 
class_1_num = 59;
class_2_num = 71;
class_3_num = 40;

each_1_num = floor(class_1_num/ilosc_podzialow);
each_2_num = floor(class_2_num/ilosc_podzialow);
each_3_num = floor(class_3_num/ilosc_podzialow);
podzial = {};

% n = floor(size(wineInputs,2)/ilosc_podzialow); %%%MUSI BYC CALKOWITE

class_1_num = 59;
class_2_num = 130;
k1 = 1;
k2 = 1;
k3 = 1;
for i=1:ilosc_podzialow
    tmp = input(:,k1:k1+each_1_num-1);
    tmp = [tmp input(:,class_1_num+k2:class_1_num-1+k2+each_2_num)];
    tmp = [tmp input(:,class_2_num+k3:class_2_num-1+k3+each_3_num)];
    tmp2 = target(:,k1:k1+each_1_num-1);
    tmp2 = [tmp2 target(:,class_1_num+k2:class_1_num-1+k2+each_2_num)];
    tmp2 = [tmp2 target(:,class_2_num+k3:class_2_num-1+k3+each_3_num)];
    podzial{1,i} = tmp;
    podzial{2,i} = tmp2;
    k1 = k1 + each_1_num;
    k2 = k2 + each_2_num;
    k3 = k3 + each_3_num;
    
end
clear class_* each_* i k1 k2 k3 tmp tmp2 wine*

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

         confusion_matrix_ucz = confusion_matrix_wine(uczWynik,wyjscie_uczace);
         confusion_matrix_test = confusion_matrix_wine(testWynik,wyjscie_testujace);
         tabConfUcz = [tabConfUcz confusion_matrix_ucz];
         tabConfTest = [tabConfTest confusion_matrix_test];
    end
    tabConfUczGlob = [tabConfUczGlob {tabConfUcz}];
    tabConfTestGlob=[tabConfTestGlob {tabConfTest}];
end
