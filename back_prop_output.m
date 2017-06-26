function [ delta ] = back_prop_output(net, n, blad,wyjscie,i)
error = blad(n);
waga = net.LW{2}(i);
v = wyjscie{n}(i);
u = v*waga;
delta = error * d_logsig(u);


end

