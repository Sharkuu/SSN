function [ delta ] = back_prop_output(waga, n, blad,wyjscie,i)
error = blad(n);
waga = waga(i);
v = wyjscie{n}(i);
u = v*waga;
delta = error * d_tansig(u);


end

