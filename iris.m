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



% % % % % % % % % % % % TU BÊDZIE POWSTAWA£ SZKIELET - POZNIEJ ZROBIE Z
% TEGO CA£¥ OSOBN¥ FUNKCJE ZWRACAJ¥C¥ SIEÆ


net = feedforwardnet(ilosc_neuronow);
%%%narazie na sztywno ustalam ze zbioryuczace to 1 celle
wejscie_uczace = podzial{1,1};
wyjscie_uczace = podzial{2,1};
net = configure(net, wejscie_uczace, wyjscie_uczace);
net.IW{1,1} = rand(ilosc_neuronow(1),size(wejscie_uczace,1));
net.b{1} =rand(ilosc_neuronow(1),1);
net.LW{2} =rand(size(wyjscie_uczace,1),ilosc_neuronow(1));
net.b{2} = rand(size(wyjscie_uczace,1),1);
% for i=1:size(ilosc_neuronow,2)-1
%     net.LW{i+1,i} = rand(ilosc_neuronow(i+1),ilosc_neuronow(i))
%     net.b{i+1} = rand(ilosc_neuronow(i+1),1);
% end
% net.LW{size(wejscie_uczace,1),size(ilosc_neuronow,2)} = rand(size(wyjscie_uczace,1),ilosc_neuronow(size(ilosc_neuronow,2)));        
% net.b{size(ilosc_neuronow,2)+1} = rand(size(wyjscie_uczace,1),1);   
%%%%%niby sie wszystko zawsze wypelnia randomowo, ale zrobilem to jeszcze
%%%%%raz


% % % UCZENIE

% for e=1:ilosc_epok
    odpowiedz = (net(wejscie_uczace));
%     blad miedzy wartoscia oczekiwana a otrzyman¹ (zaokr¹gli³em j¹ ju¿ teraz)
    blad = wyjscie_uczace - odpowiedz;
%     jeœli mamy tak jak w irysie 3 wyjscie to sumujemy kolumny - CHYBA
%     MOZNA XD bo jak nie to nie wiem jak sie uporac z tym
    if size(blad,2)>1
        blad = sum(blad);
    end
    
%     MIEJSCE NA WYLICZENIE h
% % % % % % % % % % % % % % % % % % % % % % % % %     
h = std(blad)*(4/3/size(blad,2))^(1/5);

% % % % % % % % % % % % % % % % % % % % % % % % % 


%     obliczanie estymatora f(e(n)) od kazdego bledu (chyba tak to ma byc
%     bo wystepuje e(n)
%     blad = sort(blad);
    N = size(wejscie_uczace,2);
%     cz³on przed sumowaniem
    estymator = f_estymator(N,h,blad);
     plot((blad(1,:)),estymator(1,:));
%      plot(sort(blad(2,:)),estymator(2,:));
%      plot(sort(blad(3,:)),estymator(3,:));

    
    
% % % % % % % % % % % % % % % %   WARTOŒCI WSZYSTKICH ENURONOW DLA
% WSZYSTKICH DANYCH WEJSCIOWYCH UCZACYCH
% % % % ZWRACA CELLE - NA GORZE WYJSCIE WARSWY UKRYTEJ, NA DOLE WARSTWY
% OUTPUTOWEJ(nie wiem czy to dobrze, ¿e sie rozni od net(wejscie_uczace)
% wyjscia_neuronow = oblicz_wyjscia_neuronow(net, wejscie_uczace, wyjscie_uczace,ilosc_neuronow);
% % % % % % % % % % % % % % NIEPOTRZBENE TO CO WYZEJ



% % % % % % % % PROPAGACJA WZÓR 5(narazie na pa³e wartosci)
entropy = {};
entropy{1} = ones(6,4); %pierwsza warstwa ukryta
entropy{2} = ones(3,6); % 
% % % % % % % % % % % % % % % % % % % % %         
entropia = {};
% % % % warstwa hidden->out
wsp_przed = 1/(N*N*h*h);


tmp = 0;
for n=1:N
    for l=1:N
        tmp = tmp + (((1/h)*K((blad(n)-blad(l))/h))/estymator(n))* (blad(n) - blad(l)); %* noo i tu nie wiem co XD
    end
end


% % % % % % % % % % % % % % % 
%    ZMIANA WAG
% % % % % % % % % % % % % % %  
wsp_uczenia = 3; %do ustalenia

net = uaktualnij_wagi(net,entropy,wsp_uczenia);
% % % % % % % % % % % % % % % % % % % 

    
    
    
% end
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
% % % % % % GDY MAMY JU¯ WYNIKI - CONFUSION MATRIX
confusion_matrix = confusion_matrix_iris(odp,test_wyjsciowe);
     
