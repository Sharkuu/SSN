clear all;
addpath('./datasets');
load pima-indians-diabetes-data;
ilosc_podzialow = 10;
ilosc_neuronow = 6;

data = pima_indians_diabetes_data';
target = data(9,1:760);
input = data(1:8,1:760);
index_out_1 = find(target==1);
index_out_0 = find(target== 0);

input_class_1 = input(:,index_out_1);
input_class_0 = input(:,index_out_0);
output_class_1 = target(:,index_out_1);
output_class_0 = target(:,index_out_0);

class_1_num=size(input_class_1,2);
class_0_num=size(input_class_0,2);
podzial = {};

each_1_num = floor(class_1_num/ilosc_podzialow);
each_0_num = floor(class_0_num/ilosc_podzialow);

k0=1;
k1=1;

for i=1:ilosc_podzialow
    tmp = input_class_1(:,k1:k1+each_1_num-1);
    tmp = [tmp input_class_0(:,k0:k0+each_0_num-1);];
    tmp2 = output_class_1(:,k1:k1+each_1_num-1);
    tmp2 = [tmp2 output_class_0(:,k0:k0+each_0_num-1);];
    podzial{1,i} = tmp;
    podzial{2,i} = tmp2;
    k1 = k1 + each_1_num;
    k0 = k0 + each_0_num;
    
end

clear k1 k0  tmp tmp2 output_class_0 output_class_1 input_class_0 input_class_1 index_out_1 index_out_0 each_0_num each_1_num class_1_num class_0_num i data




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
        
        wejscie_testujace = podzial{1,step};
        wyjscie_testujace = podzial{2,step};

        net = newgrnn(wejscie_uczace,wyjscie_uczace,sc);

         uczWynik = net(wejscie_uczace);
         testWynik  = net(wejscie_testujace); 
         uczWynik = round(uczWynik);
         testWynik = round(testWynik);

         confusion_matrix_ucz = confusion_matrix_pima(uczWynik,wyjscie_uczace);
         confusion_matrix_test = confusion_matrix_pima(testWynik,wyjscie_testujace);
         tabConfUcz = [tabConfUcz confusion_matrix_ucz];
         tabConfTest = [tabConfTest confusion_matrix_test];
    end
    tabConfUczGlob = [tabConfUczGlob {tabConfUcz}];
    tabConfTestGlob=[tabConfTestGlob {tabConfTest}];
end
