function [ delta ] = back_prop_output_edited2(waga, n, blad,wyjscie,i,odpowiedz)

% https://mattmazur.com/2015/03/17/a-step-by-step-backpropagation-example/
%  tam jest jakos dziwnie, ze nie zalezy od tego co wchodzi jeesli dobrze
%  to rozumiem (domno¿one jest w pêtli wywo³uj¹cej)
error = blad(n);
delta = error * d_tansig(odpowiedz);
% delta = error * 1-(u.*u);


end

