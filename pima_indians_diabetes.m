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
wejscie_uczace = podzial{1,1};
wyjscie_uczace = podzial{2,1};
net = configure(net, wejscie_uczace, wyjscie_uczace);
net.IW{1,1} = rand(ilosc_neuronow(1),size(wejscie_uczace,1));
net.b{1} =rand(ilosc_neuronow(1),1);
net.LW{2} =rand(size(wyjscie_uczace,1),ilosc_neuronow(1));
net.b{2} = rand(size(wyjscie_uczace,1),1);



% % % UCZENIE

% for e=1:5
    odpowiedz = (net(wejscie_uczace));
%     blad miedzy wartoscia oczekiwana a otrzyman� (zaokr�gli�em j� ju� teraz)
    blad = sqrt((wyjscie_uczace - odpowiedz).^2); %sredniokwadratowa bledu
%     blad2 = wyjscie_uczace - odpowiedz;
%     MIEJSCE NA WYLICZENIE h
% % % % % % % % % % % % % % % % % % % % % % % % %   

% wzor z wikipedi,niech bedzie dopoki nie skminie o co chodzi ztym z kodu
% wzory na K w wikipedi zgadzaly sie z tym pdf wiec jest szansa ze to
% bedzie podobne cos

h = std(blad)*(4/3/size(blad,2))^(1/5);
% % % % % % % % % % % % % % % % % % % % % % % % % 

%     obliczanie estymatora f(e(n)) od kazdego bledu (chyba tak to ma byc
%     bo wystepuje e(n)
% blad=sort(blad);
    N = size(wejscie_uczace,2);
estymator = f_estymator(N,h,blad);
     plot((blad(1,:)),estymator(1,:));
%      plot(sort(blad(2,:)),estymator(2,:));
%      plot(sort(blad(3,:)),estymator(3,:));




% % % % % % % % PROPAGACJA WZ�R 5(narazie hardcoded wartosci)
entropy = {};
entropy{1} = ones(6,8); %pierwsza warstwa ukryta
entropy{2} = ones(1,6); % 
% % % % % % % % % % % % % % % % % % % % %         
entropia = {};
% % % % warstwa hidden->out
wsp_przed = 1/(N*N*h*h);


tmp = 0;
for n=1:N
    for l=1:N
        tmp = tmp + (((1/h)*K((blad(n)-blad(l))/h))/estymator(n))* (blad(n) - blad(l));  %* noo i tu nie wiem co XD
    end
end


% % % % % % % % % % % % % % % 
%    ZMIANA WAG
% % % % % % % % % % % % % % %  
wsp_uczenia = 3; %do ustalenia

net = uaktualnij_wagi(net,entropy,wsp_uczenia);

    
    
    
% end



% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% GDY SIEC JEST NAUCZONA

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% NARAZIE HARDCODED
test_wejsciowe = [];
test_wyjsciowe = [];
for i=2:ilosc_podzialow
test_wejsciowe = [test_wejsciowe podzial{1,i}];
test_wyjsciowe = [test_wyjsciowe podzial{2,i}];
end
% odp = round(net(test_wejsciowe));
odp = test_wyjsciowe;
% % % % % % GDY MAMY JU� WYNIKI - CONFUSION MATRIX
confusion_matrix = confusion_matrix_pima(odp, test_wyjsciowe);