# POST�P PRAC
# Olaf 20.06
Wi�c tak: przygotowa�em 5 dataset�w (info o nich przez help nazwa) - najpierw pomieszalem kolejno�� a nast�pnie stworzy�em tablice cell�w z podzielonymi kolejno warto�ciami - s� gotowe do u�ycia w krzy�owej walidacji. W ka�dej kolumnie pierwszy wiersz to wej�cie, drugi - wyj�cie. Ilo�� podzia��w mo�na dostosowa�.


Przepisa�em ten kod w c# iiii.....no troche bieda. S� tam funkcje z dupy, wgl nie wiem co mamy oblicza� (jest jakie� sigma). Plus jest jakis blad przy pobieraniu warto�ci (chyba 108 linijka) - mo�liwe ze sie waln��em w indeksach bo matlab indeksuje od 1 tablice. Por�wnaj to z kodem, postaraj sie znale�� b��d i nei wiem co z tymi funkcjami Validate XD

Pytanie - jak mamy wyczarowa� 4 algorytmy obliczania h? wyslal nam 1 kod, kt�ry nie dziala (narazie)

Dzisiaj ju� raczej nic nie zrobie, jutro sie pewnie odezwe na fb. 
Edytuj ten plik jak co� zrobisz!


--------------

# Notatki Tomka
Og�lnie najpierw o materia�ach :
1 mail zawiera� 1 pdf (za��my �e nazw� go A) - tam znajduje si� opisana metoda uczenia entropi - mamy j� zaimplementowa�
2 mail zawiera� 2 pdf(B i C)  i kod �r�d�owy - chodzi o to �e w algorytmie etropi znajduje si� taki parametr h kt�ry si� wylicza za pomoc� r�nych metod (w tych dw�ch pdf- h okre�lane jest mianem signa - niech ciebie to nie zmyli). te dwa pdf ( B i C)maj� nam pom�c zrozumie� o co kaman z tym h - a do��czony kod �r�d�owy ma nam pom�c w implementacji wszystkich 4 metod obliczania h

Do zrobienia(og�lnie mamy mie� 5 zbior�w danych : iris ,wine, iosphere, sonar, PIMA INDIANS DIABETES - czy jako� tak lub jakie� inne):
1. zaimplementowa� metod� uczenia entropii
2. zaimplementowa� 4 algorytmy liczenia h 
3. teraz zaczyna si� jazda. og�lnie mamy sie� feedforward (musimy dobra� liczb� neuron�w ukrytych  - p�tla itp) - mamy dobra� najlepszy algorytm h - tzn.  dla jednego  wybranego zestawu testujemy ka�d� metod� obliczania h i wybieramy jedn� najlepsz� metod� h  - dane mamy testowa� za pomoc� Cross validation (np. dzielimy na 10 cz�ci i 9 z nich to ucz�ce a 1 testowe i przechodzimy 10 razy - kojarzysz ? by�o to do drugiego kolowkium )
4. maj�c najlepszy algorytm h  testujemy cross validation dla ka�dego z tych zestaw�w 5-6 zestaw�w danych i oceniamy klasyfikacj� 
5. nast�pnie mamy  por�wna� z inn� sieci� np. rbf i grnn - mamy kilka oceni� typ�w sieci - najlepiej >=2 bo jak m�wilem �e mo�e nam si� uda� tylko z jedn� to mega nie zadowlony by� ale jeba�. 
6. i teraz najlepsze : ZROBI� SPRAWOZDANIE I PREZENTACJ�. prezentacja to takie wybi�rcze huje muje, a prezentacja zawiera ca�o�ciowy raport co zrobili�my i czemu tak a nie inaczej .

-------------


# Linki
1.
[back propagation](https://mattmazur.com/2015/03/17/a-step-by-step-backpropagation-example/)

2. [bayesian](http://crsouza.com/2009/11/18/neural-network-learning-by-the-levenberg-marquardt-algorithm-with-bayesian-regularization-part-1/)