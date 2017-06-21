clear all;

load pima-indians-diabetes-data;
ilosc_podzialow = 10;


data = pima_indians_diabetes_data';
target = data(9,:);
input = data(1:8,:);

nowa_kolejnosc = randperm(size(input,2));
input = input(:,nowa_kolejnosc);
target = target(:,nowa_kolejnosc);
podzial = {};

n = floor(size(input,2)/ilosc_podzialow); %%%MUSI BYC CALKOWITE
step = n;
start = 1;

for i=1:ilosc_podzialow
    podzial{1,i} = input(:,start:n);
    podzial{2,i} = target(:,start:n);
    start = start + step;
    n = n + step;
end