clear all;
load ionosphere;
ilosc_podzialow = 10;
ilosc_neuronow = [6];
X = X';
Y = Y';
X = X(:,1:350);
Y = Y(:,1:350);
index_Y_g = find(ismember(Y, 'g'));
index_Y_b = find(ismember(Y, 'b'));
newY = zeros(1,size(X,2));
newY(1,index_Y_g) = 1;
newY(1,index_Y_b) = 0;
Y = newY;
class_G_num = size(index_Y_g,2);
class_B_num = size(index_Y_b,2);
% % % G == 1 b== 0 za³o¿enia
class_G_input = X(:,index_Y_g);
class_B_input = X(:,index_Y_b);
class_G_output = Y(:,index_Y_g);
class_B_output= Y(:,index_Y_b);

each_G_num = floor(class_G_num/ilosc_podzialow);
each_B_num = floor(class_B_num/ilosc_podzialow);

kb=1;
kg=1;

for i=1:ilosc_podzialow
    tmp = class_G_input(:,kg:kg+each_G_num-1);
    tmp = [tmp class_B_input(:,kb:kb+each_B_num-1);];
    tmp2 = class_G_output(:,kg:kg+each_G_num-1);
    tmp2 = [tmp2 class_B_output(:,kb:kb+each_B_num-1);];
    podzial{1,i} = tmp;
    podzial{2,i} = tmp2;
    kg = kg + each_G_num;
    kb = kb + each_B_num;
    
end
clear class_* each_* tmp* newY kb kg index_* i Description
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

         confusion_matrix_ucz = confusion_matrix_iono(uczWynik,wyjscie_uczace);
         confusion_matrix_test = confusion_matrix_iono(testWynik,wyjscie_testujace);
         tabConfUcz = [tabConfUcz confusion_matrix_ucz];
         tabConfTest = [tabConfTest confusion_matrix_test];
    end
    tabConfUczGlob = [tabConfUczGlob {tabConfUcz}];
    tabConfTestGlob=[tabConfTestGlob {tabConfTest}];
end

