function [ delta ] = back_prop_input(net,neuron_number,n,numer_cechy,delta,wejscie)

waga_out = net.LW{2}(neuron_number);
d = delta(neuron_number, n);
waga = net.IW{1}(neuron_number,numer_cechy);%input number to ktory element wektora wejsciowego
v = wejscie(numer_cechy,n);
u = v*waga;
delta = d*waga_out*d_logsig(u);



end

