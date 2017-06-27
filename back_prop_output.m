function [ delta ] = back_prop_output(waga, n, blad,wyjscie,i)
error = blad(n);
v = wyjscie{n}(i);
u = v*waga;
% delta = error * d_tansig(u);
delta = error * 1-(u.*u);


end

