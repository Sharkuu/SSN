% % nie moglem znaleŸæ solar i tego drugiego, znalazlem cos takiego
% cancer_dataset          - Breast cancer dataset. - ogólnie s¹ to wlasnie
% dataesty do klasyfikacji. wiecej info help cancer_dataset

clear all;
load cancer_dataset;
ilosc_podzialow = 12;


%mieszanie danych 

nowa_kolejnosc = randperm(size(cancerInputs,2));
input = cancerInputs(:,nowa_kolejnosc);
target = cancerTargets(:,nowa_kolejnosc);
podzial = {};

n = floor(size(cancerInputs,2)/ilosc_podzialow); %%%MUSI BYC CALKOWITE
step = n;
start = 1;

for i=1:ilosc_podzialow
    podzial{1,i} = input(:,start:n);
    podzial{2,i} = target(:,start:n);
    start = start + step;
    n = n + step;
end

%%%w cellach mamy podzial komorek gotowy do cross validation
    
