function [ delta ] = back_prop_output_edited(waga, n, blad,wyjscie,k)
error = blad(n);
v = wyjscie{n};
u = 0;
%tak suma ma tak wygl¹daæ? chyba nie bo delta wychodzi taka sama wtedy (?)
for i=1:size(v,1)
    u = u + v(i)*waga(i);
end
delta = error * d_tansig(u);




end

