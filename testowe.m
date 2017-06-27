clear all
ilosc_neuronow = 2;
wejscie_uczace = [1 2 3; 1 2 3; 1 2 3];
wyjscie_uczace = [1 1 0];
net = feedforwardnet(ilosc_neuronow);
%%%narazie na sztywno ustalam ze zbioryuczace to 1 celle
% wejscie_uczace = podzial{1,1};
% wyjscie_uczace = podzial{2,1};

net = configure(net, wejscie_uczace, wyjscie_uczace);
net.IW{1,1} = rand(ilosc_neuronow(1),size(wejscie_uczace,1));
net.b{1} =rand(ilosc_neuronow(1),1);
net.LW{2} =rand(size(wyjscie_uczace,1),ilosc_neuronow(1));
net.b{2} = rand(size(wyjscie_uczace,1),1);
net.layers{2}.transferFcn = 'tansig';


odpowiedz = (net(wejscie_uczace));

wyjscia = oblicz_wyjscia_neuronow(net,wejscie_uczace,ilosc_neuronow);
iw = net.iw;
lw=net.lw;
b = net.b;