# POSTÊP PRAC
# Olaf 20.06
Wiêc tak: przygotowa³em 5 datasetów (info o nich przez help nazwa) - najpierw pomieszalem kolejnoœæ a nastêpnie stworzy³em tablice cellów z podzielonymi kolejno wartoœciami - s¹ gotowe do u¿ycia w krzy¿owej walidacji. W ka¿dej kolumnie pierwszy wiersz to wejœcie, drugi - wyjœcie. Iloœæ podzia³ów mo¿na dostosowaæ.


Przepisa³em ten kod w c# iiii.....no troche bieda. S¹ tam funkcje z dupy, wgl nie wiem co mamy obliczaæ (jest jakieœ sigma). Plus jest jakis blad przy pobieraniu wartoœci (chyba 108 linijka) - mo¿liwe ze sie waln¹³em w indeksach bo matlab indeksuje od 1 tablice. Porównaj to z kodem, postaraj sie znaleŸæ b³¹d i nei wiem co z tymi funkcjami Validate XD

Pytanie - jak mamy wyczarowaæ 4 algorytmy obliczania h? wyslal nam 1 kod, który nie dziala (narazie)

Dzisiaj ju¿ raczej nic nie zrobie, jutro sie pewnie odezwe na fb. 
Edytuj ten plik jak coœ zrobisz!


--------------

# Notatki Tomka
Ogólnie najpierw o materia³ach :
1 mail zawiera³ 1 pdf (za³ó¿my ¿e nazwê go A) - tam znajduje siê opisana metoda uczenia entropi - mamy j¹ zaimplementowaæ
2 mail zawiera³ 2 pdf(B i C)  i kod Ÿród³owy - chodzi o to ¿e w algorytmie etropi znajduje siê taki parametr h który siê wylicza za pomoc¹ ró¿nych metod (w tych dwóch pdf- h okreœlane jest mianem signa - niech ciebie to nie zmyli). te dwa pdf ( B i C)maj¹ nam pomóc zrozumieæ o co kaman z tym h - a do³¹czony kod Ÿród³owy ma nam pomóc w implementacji wszystkich 4 metod obliczania h

Do zrobienia(ogólnie mamy mieæ 5 zbiorów danych : iris ,wine, iosphere, sonar, PIMA INDIANS DIABETES - czy jakoœ tak lub jakieœ inne):
1. zaimplementowaæ metodê uczenia entropii
2. zaimplementowaæ 4 algorytmy liczenia h 
3. teraz zaczyna siê jazda. ogólnie mamy sieæ feedforward (musimy dobraæ liczbê neuronów ukrytych  - pêtla itp) - mamy dobraæ najlepszy algorytm h - tzn.  dla jednego  wybranego zestawu testujemy ka¿d¹ metodê obliczania h i wybieramy jedn¹ najlepsz¹ metodê h  - dane mamy testowaæ za pomoc¹ Cross validation (np. dzielimy na 10 czêœci i 9 z nich to ucz¹ce a 1 testowe i przechodzimy 10 razy - kojarzysz ? by³o to do drugiego kolowkium )
4. maj¹c najlepszy algorytm h  testujemy cross validation dla ka¿dego z tych zestawów 5-6 zestawów danych i oceniamy klasyfikacjê 
5. nastêpnie mamy  porównaæ z inn¹ sieci¹ np. rbf i grnn - mamy kilka oceniæ typów sieci - najlepiej >=2 bo jak mówilem ¿e mo¿e nam siê udaæ tylko z jedn¹ to mega nie zadowlony by³ ale jebaæ. 
6. i teraz najlepsze : ZROBIÆ SPRAWOZDANIE I PREZENTACJÊ. prezentacja to takie wybiórcze huje muje, a prezentacja zawiera ca³oœciowy raport co zrobiliœmy i czemu tak a nie inaczej .

-------------


# Linki
1.
[back propagation](https://mattmazur.com/2015/03/17/a-step-by-step-backpropagation-example/)
2. [bayesian](http://crsouza.com/2009/11/18/neural-network-learning-by-the-levenberg-marquardt-algorithm-with-bayesian-regularization-part-1/)