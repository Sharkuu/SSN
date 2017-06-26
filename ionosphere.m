clear all;
load ionosphere;
ilosc_podzialow =10;
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
% % % G == 1 b== 0 za�o�enia
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
% clear class_* each_* tmp* newY kb kg index_* i Description
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
net.layers{2}.transferFcn = 'logsig';



% % % UCZENIE

% for e=1:5
    odpowiedz = (net(wejscie_uczace));
%     blad miedzy wartoscia oczekiwana a otrzyman� (zaokr�gli�em j� ju� teraz)
    blad = sqrt((wyjscie_uczace - odpowiedz).^2); %sredniakwadratowa bledu
    wyjscia = oblicz_wyjscia_neuronow_iono(net,wejscie_uczace,ilosc_neuronow);
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

% N=N-1;


% % % % % % % % PROPAGACJA WZ�R 5(narazie hardcoded wartosci)
entropy = {};
entropy{1} = []; %pierwsza warstwa ukryta
entropy{2} = []; % 
% % % % % % % % % % % % % % % % % % % % %         
% % % % warstwa hidden->out
wsp_przed = 1/(N*N*h*h);
% kk = back_prop_output(net, 1, blad,wyjscia,1);
% kkk=net.LW;
delta = [];
for k=1:ilosc_neuronow
    entropia = 0;
    for n=1:N
        for l=1:N
            entropia = entropia + (((1/h)*K((blad(n)-blad(l))/h))/estymator(n))* (blad(n) - blad(l)) * (back_prop_output(net, n, blad,wyjscia,k)*wyjscia{n}(k) - back_prop_output(net, l, blad,wyjscia,k)*wyjscia{n}(k)); 
        end
        delta(k,n) = back_prop_output(net, n, blad,wyjscia,k);
    end
    entropy{2} = [entropy{2} wsp_przed*entropia];
    
end


% % % % % % % % % % % % % % % % 
% % % % % % warstwa input->hidden
% for k=1:size(wejscie_uczace,1)-
for k=1:ilosc_neuronow
    for j=1:size(wejscie_uczace,1)-1
    entropia = 0;
    for n=1:N
        for l=1:N
            entropia = entropia + (((1/h)*K((blad(n)-blad(l))/h))/estymator(n))* (blad(n) - blad(l)) * (back_prop_input(net, k, n, j,delta,wejscie_uczace) - back_prop_input(net, k, l, j,delta,wejscie_uczace)); 
        end
    end
    entropy{1} = [entropy{1} wsp_przed*entropia];
    end
end

% % % % % % % % % % % % % % % 
%    ZMIANA WAG
% % % % % % % % % % % % % % %  
wsp_uczenia = 3; %do ustalenia
% 
% net = uaktualnij_wagi(net,entropy,wsp_uczenia);
% 
%     
%     
%     
% % end
% 
% 
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%     % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % GDY SIEC JEST NAUCZONA
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % NARAZIE HARDCODED
% test_wejsciowe = [];
% test_wyjsciowe = [];
% for i=2:ilosc_podzialow
% test_wejsciowe = [test_wejsciowe podzial{1,i}];
% test_wyjsciowe = [test_wyjsciowe podzial{2,i}];
% end
% odp = round(net(test_wejsciowe));
% % odp = test_wyjsciowe;
% % % % % % % GDY MAMY JU� WYNIKI - CONFUSION MATRIX
% confusion_matrix = confusion_matrix_iono(odp, test_wyjsciowe);