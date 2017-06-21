% % nie moglem znaleŸæ solar i tego drugiego, znalazlem cos takiego  glass_dataset           - Glass chemical dataset.- ogólnie s¹ to wlasnie
% dataesty do klasyfikacji. wiecej info help glass_dataset

clear all;
load glass_dataset;
ilosc_podzialow = 12;


%mieszanie danych 

nowa_kolejnosc = randperm(size(glassInputs,2));
input = glassInputs(:,nowa_kolejnosc);
target = glassTargets(:,nowa_kolejnosc);
podzial = {};

n = floor(size(glassInputs,2)/ilosc_podzialow); %%%MUSI BYC CALKOWITE
step = n;
start = 1;

for i=1:ilosc_podzialow
    podzial{1,i} = input(:,start:n);
    podzial{2,i} = target(:,start:n);
    start = start + step;
    n = n + step;
end

%%%w cellach mamy podzial komorek gotowy do cross validation
    
