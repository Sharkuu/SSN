clear all;
load ionosphere;
ilosc_podzialow = 12;

X = X';
Y = Y';

%mieszanie danych 
index_Y_g = find(ismember(Y, 'g'));
index_Y_b = find(ismember(Y, 'b'));

newY = zeros(1,size(X,2));
newY(1,index_Y_g) = 1;
newY(1,index_Y_b) = 0;
Y = newY;
% % % ZMIENIAMY ¯E OUTPUT: G == 1, B==0
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
    
