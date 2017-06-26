function [ h ] = getH( errorTable)
 [bandwidth,density,xmesh,cdf] = kde(errorTable,128,0,10);
  h = bandwidth;
end

