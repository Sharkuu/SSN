function [ delta ] = back_prop_input(waga,waga_out,neuron_number,n,numer_cechy,delta,wejscie)

waga_out = waga_out(neuron_number);
d = delta(neuron_number, n);
waga = waga(neuron_number,numer_cechy);
v = wejscie(numer_cechy,n);
u = v*waga;
delta = d*waga_out*d_tansig(u)*v;



end

