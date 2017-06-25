function [ wynik ] = confusion_matrix_iris( odp, test_wyjsciowe )
wynik = {'wynik\dane','K1','K2','K3';'K1', 0 ,0 ,0 ;'K2', 0 ,0 ,0 ;'K3', 0 ,0 ,0 ;'inne', 0,0,0;}   ;

 for i=1:size(test_wyjsciowe,2)
     if odp(:,i) == test_wyjsciowe(:,i)
         if odp(:,i) == [1 0 0]'
             wynik{2,2} = wynik{2,2}+1;
         elseif odp(:,i) == [0 1 0]'
             wynik{3,3} = wynik{3,3}+1;
         elseif odp(:,i) == [0 0 1]'
             wynik{4,4} = wynik{4,4}+1;
         end
     else
         if test_wyjsciowe(:,i) == [1 0 0]'
             if odp(:,i) == [0 1 0]'
                 wynik{3,2} = wynik{3,2}+1;
             elseif odp(:,i) == [0 0 1]'
                 wynik{4,2} = wynik{4,2}+1;
             else
                 wynik{5,2} = wynik{5,2}+1;
             end
         elseif test_wyjsciowe(:,i) == [0 1 0]'
             if odp(:,i) == [1 0 0]'
                 wynik{2,3} = wynik{2,3}+1;
             elseif odp(:,i) == [0 0 1]'
                 wynik{4,3} = wynik{4,3}+1;
             else
                 wynik{5,3} = wynik{5,3}+1;
             end
         elseif test_wyjsciowe(:,i) == [0 0 1]'
             if odp(:,i) == [1 0 0]'
                 wynik{2,4} = wynik{2,4}+1;
             elseif odp(:,i) == [0 1 0]'
                 wynik{3,4} = wynik{3,4}+1;
             else
                 wynik{5,3} = wynik{5,3}+1;
             end
         end
     end
 end
         


end

