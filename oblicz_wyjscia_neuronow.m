function [ wyjscia_neuronow ] = oblicz_wyjscia_neuronow(net, wejscie_uczace, wyjscie_uczace, ilosc_neuronow )
wyjscia_neuronow = {};
f_1 = net.layers{1}.transferFcn;
f_1 = str2func(f_1);
f_2 = net.layers{2}.transferFcn;
f_2 = str2func(f_2);
for k=1:size(wejscie_uczace,2)
    input_layer = [];
    bias = net.b{1};
    input = net.IW{1};
    for i=1:ilosc_neuronow
        b = bias(i,1);
        tmp = 0;
        for j=1:size(wejscie_uczace,1)
            tmp = tmp + wejscie_uczace(j,k)*input(i,j);
        end
        input_layer(i) = b+tmp;
    end
    bias = net.b{2};
    input = net.LW{2};
    output_layer = [];
    for i=1:size(wyjscie_uczace,1)
        b = bias(i,1);
        tmp = 0;
        for j=1:ilosc_neuronow
            tmp = tmp + input_layer(j)*input(i,j);
        end
        output_layer(i) = b + tmp;
    end
 wyjscia_neuronow{1,k} = f_1(input_layer);
 wyjscia_neuronow{2,k} = f_2(output_layer);
end


end

