function [ wynik ] = confusion_matrix_sonar( odp, test_wyjsciowe )
wynik = {'wynik\dane','KL1','KL0';'KL1', 0 ,0 ;'KL0', 0 ,0 ;'inne', 0,0;}   ;


 for i=1:size(test_wyjsciowe,2)
     if odp(:,i) == test_wyjsciowe(:,i)
         if odp(:,i) == 1
             wynik{2,2} = wynik{2,2}+1;
         elseif odp(:,i) == 0
             wynik{3,3} = wynik{3,3}+1;
         end
     else
         if test_wyjsciowe(:,i) == 1
             if odp(:,i) == 0
                 wynik{3,2} = wynik{3,2}+1;
             else
                 wynik{4,2} = wynik{4,2}+1;
             end
         elseif test_wyjsciowe(:,i) == 0
             if odp(:,i) == 1
                 wynik{2,3} = wynik{2,3}+1;
             else
                 wynik{4,3} = wynik{4,3}+1;
             
             end
         end
     end
 end
         
     



end

