function [ delta ] = back_prop_input(waga_all,waga,waga_out,neuron_number,n,numer_cechy,dd,wejscie)

d = dd(neuron_number, n);

v = wejscie(numer_cechy,n);
v_all = wejscie(:,n);
u = 0;
% for i=1:size(v_all,1)
%     u = u + v_all(i)*waga_all(neuron_number,i);
% end
u = v*waga;
delta = d*waga_out*d_tansig(u)*v;
% delta = d*waga_out*1-(u.*u)*v;



end

