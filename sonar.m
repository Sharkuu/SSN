clear all;


%%%zmienone dane - R to 1 , M = 0

addpath('./datasets');
load sonar_data;
ilosc_podzialow = 10;
sonar_data =   sonar_data';
target = sonar_data(61,:);
input = sonar_data(1:60,:);



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