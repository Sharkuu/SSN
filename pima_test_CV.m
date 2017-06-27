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


net = feedforwardnet(ilosc_neuronow);
%%%narazie na sztywno ustalam ze zbioryuczace to 1 celle
% wejscie_uczace = podzial{1,1};
% wyjscie_uczace = podzial{2,1};
tabConfUczGlob = {};
    
tabConfTestGlob={};
for step=1:10
        wejscie_uczace = [];
        wyjscie_uczace = [];

        for i=1:ilosc_podzialow

            if  i ~= step
                wejscie_uczace = [wejscie_uczace podzial{1,i}];
                wyjscie_uczace = [wyjscie_uczace podzial{2,i}];

            end

        end
        
        wejscie_testujace = podzial{1,step};
        wyjscie_testujace = podzial{2,step};
        
net = configure(net, wejscie_uczace, wyjscie_uczace);
net.IW{1,1} = rand(ilosc_neuronow(1),size(wejscie_uczace,1));
net.b{1} =rand(ilosc_neuronow(1),1);
net.LW{2} =rand(size(wyjscie_uczace,1),ilosc_neuronow(1));
net.b{2} = rand(size(wyjscie_uczace,1),1);
net.layers{2}.transferFcn = 'tansig';


% % % UCZENIE


% for e=1:5
    odpowiedz = (net(wejscie_uczace));
%     blad miedzy wartoscia oczekiwana a otrzyman� (zaokr�gli�em j� ju� teraz)
    blad = sqrt((wyjscie_uczace - odpowiedz).^2); %sredniakwadratowa bledu
    wyjscia = oblicz_wyjscia_neuronow(net,wejscie_uczace,ilosc_neuronow);
%     blad2 = wyjscie_uczace - odpowiedz;
%     MIEJSCE NA WYLICZENIE h
% % % % % % % % % % % % % % % % % % % % % % % % %   

% wzor z wikipedi,niech bedzie dopoki nie skminie o co chodzi ztym z kodu
% wzory na K w wikipedi zgadzaly sie z tym pdf wiec jest szansa ze to
% bedzie podobne cos

h = getH(blad);
% % % % % % % % % % % % % % % % % % % % % % % % % 

%     obliczanie estymatora f(e(n)) od kazdego bledu (chyba tak to ma byc
%     bo wystepuje e(n)
% blad=sort(blad);
    N = size(wejscie_uczace,2);
estymator = f_estymator(N,h,blad);
%      plot((blad(1,:)),estymator(1,:));
%      plot(sort(blad(2,:)),estymator(2,:));
%      plot(sort(blad(3,:)),estymator(3,:));


% 
% % % % % % % % PROPAGACJA WZ�R 5(narazie hardcoded wartosci)
entropy = {};
entropy{1} = []; %pierwsza warstwa ukryta
entropy{2} = []; % 
% % % % % % % % % % % % % % % % % % % % %         
% % % % warstwa out
wsp_przed = 1/(N*N*h*h);
delta = [];
waga= net.LW{2};
for neuron_num=1:ilosc_neuronow
    entropia = 0;
    for n=1:N
        for l=1:N
            entropia = entropia + (((1/h)*K((blad(n)-blad(l))/h))/estymator(n))* (blad(n) - blad(l)) * (back_prop_output(waga(neuron_num), n, blad,wyjscia,neuron_num)*wyjscia{n}(neuron_num) - back_prop_output(waga(neuron_num), l, blad,wyjscia,neuron_num)*wyjscia{l}(neuron_num)); 
        end
        delta(neuron_num,n) = back_prop_output(waga(neuron_num), n, blad,wyjscia,neuron_num);
    end
    entropy{2} = [entropy{2} wsp_przed*entropia];
    
end

entropy_hidden = [];
% % % % % % % % % % % % % % % % 
% % % % % % warstwa hidden
waga_out = net.LW{2};
waga = net.IW{1};
for numer_cechy=1:size(wejscie_uczace,1)  
    for neuron_num=1:ilosc_neuronow
    entropia = 0;
    for n=1:N
        for l=1:N
            entropia = entropia + (((1/h)*K((blad(n)-blad(l))/h))/estymator(n))* (blad(n) - blad(l)) * (back_prop_input(waga(neuron_num,numer_cechy),waga_out(neuron_num), neuron_num, n, numer_cechy,delta,wejscie_uczace) - back_prop_input(waga(neuron_num,numer_cechy),waga_out(neuron_num), neuron_num, l, numer_cechy,delta,wejscie_uczace)); 
        end
    end
    entropy_hidden(neuron_num,numer_cechy) = wsp_przed*entropia;
    end
end
entropy{1} = entropy_hidden;
% 
% 
% % % % % % % % % % % % % % % % 
% %    ZMIANA WAG
% % % % % % % % % % % % % % % %  
wsp_uczenia = 2; %do ustalenia
% 
net = uaktualnij_wagi(net,entropy,wsp_uczenia);
% 
%     
%     
%     
% end
% 
% 
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%     % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % GDY SIEC JEST NAUCZONA
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% NARAZIE HARDCODED
% test_wejsciowe = podzial{1,1};
% test_wyjsciowe = podzial{2,1};
% for i=2:ilosc_podzialow
% test_wejsciowe = [test_wejsciowe podzial{1,i}];
% test_wyjsciowe = [test_wyjsciowe podzial{2,i}];
% end

uczWynik = net(wejscie_uczace);
testWynik  = net(wejscie_testujace); 

% % % % % % % GDY MAMY JU� WYNIKI - CONFUSION MATRIX
confusion_matrix_ucz = confusion_matrix_pima(uczWynik,wyjscie_uczace);
confusion_matrix_test = confusion_matrix_pima(testWynik,wyjscie_testujace);
         tabConfUczGlob{step} = confusion_matrix_ucz;
         tabConfTestGlob{step} = confusion_matrix_test;
    end