function [ wyjscia_neuronow ] = oblicz_wyjscia_neuronow_iono(net, wejscie_uczace, ilosc_neuronow )
wyjscia_neuronow = {};
f_1 = net.layers{1}.transferFcn;
f_1 = str2func(f_1);
input_layer = [];
bias = net.b{1};
input = net.IW{1};
for k=1:size(wejscie_uczace,2)
    for i=1:ilosc_neuronow
        b = bias(i,1);
        tmp = 0;
        for j=1:(size(wejscie_uczace,1)-1)
            tmp = tmp + wejscie_uczace(j,k)*input(i,j);
        end
        input_layer(i) = b+tmp;
    end
 wyjscia_neuronow{1,k} = f_1(input_layer);

end


end

