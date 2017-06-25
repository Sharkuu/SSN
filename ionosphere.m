clear all;
load ionosphere;
ilosc_podzialow = 12;
ilosc_neuronow = [6];
X = X';
Y = Y';

%mieszanie danych 
index_Y_g = find(ismember(Y, 'g'));
index_Y_b = find(ismember(Y, 'b'));

newY = zeros(1,size(X,2));
newY(1,index_Y_g) = 1;
newY(1,index_Y_b) = 0;
Y = newY;
% % % ZMIENIAMY �E OUTPUT: G == 1, B==0
nowa_kolejnosc = randperm(size(X,2));
input = X(:,nowa_kolejnosc);
target = Y(:,nowa_kolejnosc);
podzial = {};

n = floor(size(X,2)/ilosc_podzialow); %%%MUSI BYC CALKOWITE
step = n;
start = 1;

for i=1:ilosc_podzialow
    podzial{1,i} = input(:,start:n);
    podzial{2,i} = target(:,start:n);
    start = start + step;
    n = n + step;
end

%%%w cellach mamy podzial komorek gotowy do cross validation
    

net = feedforwardnet(ilosc_neuronow);
%%%narazie na sztywno ustalam ze zbioryuczace to 1 celle
wejscie_uczace = podzial{1,1};
wyjscie_uczace = podzial{2,1};
net = configure(net, wejscie_uczace, wyjscie_uczace);
net.IW{1,1} = rand(ilosc_neuronow(1),size(wejscie_uczace,1)-1);
net.b{1} =rand(ilosc_neuronow(1),1);
net.LW{2} =rand(size(wyjscie_uczace,1),ilosc_neuronow(1));
net.b{2} = rand(size(wyjscie_uczace,1),1);



% % % UCZENIE

for e=1:5
    odpowiedz = (net(wejscie_uczace));
%     blad miedzy wartoscia oczekiwana a otrzyman� (zaokr�gli�em j� ju� teraz)
    blad = wyjscie_uczace - odpowiedz;
    
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
%     cz�on przed sumowaniem
    przed = 1/N*h;
    estymator = [];
    for k=1:size(blad,1)
        for i=1:N
            tmp = 0;
            for j=1:N                
                tmp = tmp + K((blad(k,i) - blad(k,j))/h);
            end
            estymator(k,i) = przed * tmp;
        end
    end
     plot((blad(1,:)),estymator(1,:));
%      plot(sort(blad(2,:)),estymator(2,:));
%      plot(sort(blad(3,:)),estymator(3,:));




% % % % % % % % PROPAGACJA WZ�R 5(narazie na pa�e wartosci)
entropy = {};
entropy{1} = ones(6,33); %pierwsza warstwa ukryta
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

%%%input->hidden layer
layer = net.IW{1};
for i=1:size(layer,1)
    for j=1:size(layer,2)
        layer(i,j) = layer(i,j) -wsp_uczenia*entropy{1}(i,j);
    end
end
net.IW{1} = layer;
%%%hidden->output layer
layer = net.LW{2};
for i=1:size(layer,1)
    for j=1:size(layer,2)
        layer(i,j) = layer(i,j) -wsp_uczenia*entropy{2}(i,j);
    end
end
net.LW{2} = layer;
% % % % % % % % % % % % % % % % % % % 

    
    
    
end



% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
    

