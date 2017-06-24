clear all;
load iris_dataset;
ilosc_podzialow = 10;
ilosc_neuronow = [6];
ilosc_epok = 100;
%mieszanie danych 

nowa_kolejnosc = randperm(size(irisInputs,2));
input = irisInputs(:,nowa_kolejnosc);
target = irisTargets(:,nowa_kolejnosc);
podzial = {};

n = floor(size(irisInputs,2)/ilosc_podzialow); %%%MUSI BYC CALKOWITE
step = n;
start = 1;

for i=1:ilosc_podzialow
    podzial{1,i} = input(:,start:n);
    podzial{2,i} = target(:,start:n);
    start = start + step;
    n = n + step;
end

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
    odpowiedz = round(net(wejscie_uczace));
%     blad miedzy wartoscia oczekiwana a otrzyman¹ (zaokr¹gli³em j¹ ju¿ teraz)
    blad = wyjscie_uczace - odpowiedz;
%     jeœli mamy tak jak w irysie 3 wyjscie to sumujemy kolumny - CHYBA
%     MOZNA XD
    if size(blad,2)>1
        blad = sum(blad);
    end
    
%     MIEJSCE NA WYLICZENIE h
% % % % % % % % % % % % % % % % % % % % % % % % %     
h = 1;

% % % % % % % % % % % % % % % % % % % % % % % % % 


%     obliczanie estymatora f(e(n)) od kazdego bledu (chyba tak to ma byc
%     bo wystepuje e(n)

    N = size(wejscie_uczace,2);
%     cz³on przed sumowaniem
    przed = 1/N*h;
    estymator = [];
    for i=1:N
        tmp = 0;
        for j=1:N
%             OBLICZNIE KERNELA - CHYBA TAK TO ROZUMIEM ZE X W ROWNANIU DLA
%             K JEST e(n)  - do zapytania ew.
            K = (1/sqrt(2*pi))*exp((-1/2)*(blad(j)^2));
            tmp = tmp + (K*(blad(i) - blad(j))/h);
        end
        estymator(i) = przed * tmp;
    end
    
%    ZMIANA WAG
% % % % % % % % % % % % % % %  



% % % % % % % % % % % % % % % % % % % 

    
    
    
% end



% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
    
