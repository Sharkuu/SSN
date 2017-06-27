function net = uaktualnij_wagi( net,entropy, wsp_uczenia )
%%%>hidden layer
layer = net.IW{1};
for i=1:size(layer,1)
    for j=1:size(layer,2)
        layer(i,j) = layer(i,j) -wsp_uczenia*entropy{1}(i,j);
    end
end
net.IW{1} = layer;
%%%output layer
layer = net.LW{2};
for i=1:size(layer,1)
    for j=1:size(layer,2)
        layer(i,j) = layer(i,j) -wsp_uczenia*entropy{2}(i,j);
    end
end
net.LW{2} = layer;
% % % % % % % % % % % % % % % % % % % 

end

