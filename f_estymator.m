function [ estymator ] = f_estymator( N, h, blad )
przed = 1/(N*h);
    estymator = [];
    for k=1:size(blad,1 )
        for i=1:N
            tmp = 0;
            for j=1:N                
                tmp = tmp + K((blad(k,i) - blad(k,j))/h);
            end
            estymator(k,i) = przed * tmp;
        end
    end

end

