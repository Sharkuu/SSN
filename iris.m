clear all;
load iris_dataset;
ilosc_podzialow = 10;


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
    
