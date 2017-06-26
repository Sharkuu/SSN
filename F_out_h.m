function [ value ] = F_out_h(argTab,h )
howMany = size(argTab,2);
value = [];
    for i=1:howMany
        
        sum=0;
        firstPart = 1/(howMany*sqrt(2*pi)*h);
        
        for j=1:howMany
            sum = sum + exp(-((argTab(i) - argTab(j))^2) /(2*(h^2)) );
        end
        
        all = firstPart * sum;
        value = [value all];
        
    end
    
end

