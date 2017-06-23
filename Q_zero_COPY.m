function [ wynik ] = Q_zero( liczba_rekordow,liczba_klas,liczba_cech )
% test.LiczbaRekordow to teraz liczba_rekordow
% train.Klasy.Count to teraz liczba_klas
% train.LiczbaCech to teraz liczba_cech
% WSZYSTKIE ABOVE DALEM JAKO ARGU (?)
wynik = 0; %??????????
MAX_PROBA = 10;
ACTION_NUMBER = 6;
epsilon = 0.005;
BOX_COUNT = liczba_rekordow;
ACTIONS = [-1, -0.1, -0.01, 0.01, 0.1, 1];
gamma = 0.95;
alpha = 0.01;
% lambdaq = 0.7
sc_min = ones(liczba_klas,liczba_cech);  %%%%%%% chyba to trzeba (?)
sigma = ones(liczba_klas,liczba_cech);

% //funkcja wartoœci akcji (wype³nione zerami)
%             double[, , ,] Q = new double[BOX_COUNT, l_klas, l_cech, ACTION_NUMBER];
Q = zeros(BOX_COUNT, liczba_klas, liczba_cech, ACTION_NUMBER);
%             //sygna³ wzmocnienia (wype³nione zerami)
%             double[, ,] r = new double[l_klas, l_cech, ACTION_NUMBER];
r = zeros(liczba_klas, liczba_cech, ACTION_NUMBER);
%             //(wype³nione zerami)
%             double[, ,] delta = new double[l_klas, l_cech, ACTION_NUMBER];
delta = zeros(liczba_klas, liczba_cech, ACTION_NUMBER);

%             double[,] SSE = new double[l_klas, l_cech];
SSE = zeros(liczba_klas,liczba_cech);
%             double[,] SSE_old = new double[l_klas, l_cech];
SSE_old = zeros(liczba_klas,liczba_cech);

% double SSE_min = Test(); // Validate(test);    % WTF CO TO JEST ZA
% FUNKCJA, NIGDZIE JEJ NIE MA
SSE_min = 4; %NIE WIEM CO TU MA BYC

l_iteracji_sc = 10;
SSE_sc_vec_init = [];

for i=1:l_iteracji_sc
    for j=1:liczba_klas
        for k=1:liczba_cech
            sigma(j,k) = i + 1 ; 
        end
    end 
%     SSE_sc_vec_init[i] = Test(); // Validate(test); % ?????????????????
SSE_sc_vec_init(i) = 1; %znowu nei wiem co tu ma byc
end

wart = SSE_sc_vec_init(1);

ind_wart = 0;

for i=2:l_iteracji_sc
    if (SSE_sc_vec_init(i) < wart)
        wart = SSE_sc_vec_init(i);
        ind_wart = i;
    end
end



sc_START = zeros(liczba_klas,liczba_cech);

for i=1:liczba_klas
    for j=1:liczba_cech
        sc_START(i,j) = ind_wart +1;
        sigma(i,j) = sc_START(i,j);
    end
end

nextbox = Get_box_pnn1s(SSE_min, liczba_rekordow);
box = nextbox;
BOX_START = nextbox;
krok = 1;

SSE_test = zeros(MAX_PROBA, liczba_klas, liczba_cech);
sc_ = zeros(MAX_PROBA, liczba_klas, liczba_cech);
r_ = zeros(MAX_PROBA, liczba_klas, liczba_cech, ACTION_NUMBER);    
sc_old = zeros(liczba_klas, liczba_cech);
i_app_action = zeros(liczba_klas, liczba_cech);
akcje_zach = [];
steps = 0;
while (krok <MAX_PROBA)
    box_old = box;
    box = nextbox;
    
    for i=1:liczba_klas
        for j=1:liczba_cech
            max_Q = Q(box,i,j,1);
            for n=2:ACTION_NUMBER
                if Q(box,i,j,n) > max_Q
                    max_Q = Q(box,i,j,n);
                end
            end
            ind_akcje_zach = 1;
            for n=1:ACTION_NUMBER
                if Q(box,i,j,n) == max_Q
                    akcje_zach(ind_akcje_zach) = ACTIONS(n);
                    ind_akcje_zach = ind_akcje_zach+1;
                end
            end
            rand = randi([1 99],1)/100;
            indeks_aplikowanej_akcji = -1;
            if rand > epsilon
                app_action = akcje_zach(randi([1 ind_akcje_zach],1));
            else
                app_action = ACTIONS(randi([1 ACTION_NUMBER],1));
            end
            
            for n=1:ACTION_NUMBER
                if ACTIONS(n) == app_action
                    indeks_aplikowanej_akcji = n;
                    break
                end
            end
            i_app_action(i,j) = indeks_aplikowanej_akcji;
            sc_old(i,j) = sigma(i,j);
            sigma(i,j) = sigma(i,j) + app_action;
            if sigma(i,j)<=0
                if sc_old(i,j) == 0
                    sigma(i,j) = sc_START(i,j);
                else
                    sigma(i,j) = sc_old(i,j);
                end
            end
            
            SSE_old(i,j) = SSE(i,j);
            
%             SSE[i, j] = Train();// Validate(train); %%% ?????????!?!?!?!?
%               SSE_test[krok, i, j] = Test(); // Validate(test);
            SSE(i, j) = 5;
            SSE_test(krok,i,j) = 4;
            
            nextbox =  Get_box_pnn1s(SSE(i,j), liczba_rekordow);
            
            if krok ~=1
                r(i,j,i_app_action(i,j)) = SSE_old(i,j) - SSE(i,j);
            else
                r(i, j, i_app_action(i, j)) = 0;
            end
            if SSE(i,j) <SSE_min
                SSE_min = SSE(i,j);
                sc_min(i,j) = sigma(i,j);
            end
            max_Q = Q(nextbox,i,j,1);
            
            for n=2:ACTION_NUMBER
                if Q(box,i,j,n)>max_Q
                    max_Q = Q(box,i,j,n);
                end
            end
            delta(i,j,i_app_action(i,j)) = r(i,j,i_app_action(i,j)) + gamma * max_Q - Q(box,i,j,i_app_action(i,j));
        end
    end
    for i=1:ilosc_klas
        for j=1:ilosc_cech
            sc_(krok,i,j) = sigma(i,j);
            for n=1:ACTION_NUMBER
                r_(krok,i,j,n) = r(i,j,n);
            end
        end
    end
    krok = krok +1;
    for i=1:ilosc_klas
        for j=1:ilosc_cech
            Q(box,i,j,i_app_action(i,j)) = Q(box,i,j,i_app_action(i,j)) + alpha * delta(i,j,i_app_action(i,j));
        end
    end
    
    steps = steps +1;
end
testErrorVect = SSE_test(1,1,1);
for k=1:MAX_PROBA
    for i=1:ilosc_klas
        for j=1:ilosc_cech
            if SSE_test(k,i,j) < testErrorVect
                testErrorVect = SSE_test(k,i,j);
            end
        end
    end
end
end

        


           