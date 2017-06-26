function [ value ] = d_logsig( x )

f = str2func('logsig');
value = f(x)*(1-f(x));

end

