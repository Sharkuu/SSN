clear all;
load wine_dataset;
ilosc_podzialow = 12;


%mieszanie danych 

nowa_kolejnosc = randperm(size(wineInputs,2));
input = wineInputs(:,nowa_kolejnosc);
target = wineTargets(:,nowa_kolejnosc);
podzial = {};

n = floor(size(wineInputs,2)/ilosc_podzialow); %%%MUSI BYC CALKOWITE
step = n;
start = 1;

for i=1:ilosc_podzialow
    podzial{1,i} = input(:,start:n);
    podzial{2,i} = target(:,start:n);
    start = start + step;
    n = n + step;
end

%%%w cellach mamy podzial komorek gotowy do cross validation
    
