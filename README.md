# POSTĘP PRAC

TODO
* sprawdzic metode oblicz_wyjscia_neuronow czy dobrze oblicza wyjscia z neuronow ukrytych - w wynikach jest cały czas 1 1 1 1 1 MOŻLIWE że wylicza za duże wartości, przez co tansig jest == 1 później
* back_prop_output_edited2 jest zrobiony zgodnie (chyba) z https://mattmazur.com/2015/03/17/a-step-by-step-backpropagation-example/ delta rule - tylko że wtedy delta dla warsty ukrytej jest jedna wiec nie jestem pewny czy to dobre...no i entropia jest taka sama, ale moze tak ma byc, zobacz/pomyśl.

* back_prop_input - trzeba poprawić, jeśli trzymać się https://mattmazur.com/2015/03/17/a-step-by-step-backpropagation-example/  to będzie prostsze niż napisane. Ale trzeba zoabczyć czym to sie rozni od wykladow Kowalskiego.

* W pdf jest że uaktualniamy wszystkie wagi na końcu (wiec nie zmienimy ze po kazdej iteracji). Prześledzić uaktualnianie wag - ale to akurat powinno być ok.


JA WYJEŻDŻAM W WEEKEND I NIE MA MNIE PRZEZ TYDZIEŃ. PRZYPOMINAM CI ŻEBYŚ SIE WZIĄŁ DO ROBOTY, BO JUŻ JEST SIERPIEŃ PRAWIE, ODPOCZYNKU BYŁO WYSTARCZAJĄCO.












----------------------------------------
# Tomek 27.06

*  funkcja getH - wstawiasz tylko tablice bledow

*  plik kde.m - nim sie nie przejmuj - potrzebny do liczenia h

*  funkcja getHStatistics
		pobiera tablice bledow, h, liczbe ukrytych neuronow, numer mieszania cv - patrz np. irisGRNN.m - tam jest cala CV
		learningIteration - zakladajac ze zwieszkaszmy licznik uczenia sieci - przy okazji sprawdzania tego warunku stopu
		w sumie tyle wartosci by pliki sie nie nadpisywaly tylko tworzyly osobno
		proponuje te funkcje stosowac raz na jakis czas np. cv%2 && leartningIteration%10 czy coś w tym stylu 
		
* jeśli się nie dodał to stwórz sobie katalog charts    do niego sa zapisywane te wykresy. jak nie ma katalogu to sie sra- sam sobie nie stworzyłem

* funkcja f_out_h - wzor sprawdzajacy czy dane h w miare dobrze radzi sobie z bledem - takie policzenie  histogramu recznie. 
	funkcja wykorzystywana tylko w getHStatistics
	
-----------------------------------------------------------------------------------------
# Pytania do doktora Kowalskiego
--------------
# Olaf
* Wzór 5 - propagacja czego, suma po sumie, czy zwraca to co mi sie wydaje
* Czy K jest ok
* Czy uaktualnianie wag jest ok
* co przy 3 wyjsciach (czy sumowac błędy)
* czy brac sam błąd tj oczekiwana - odpowiedz czy może średniokwadratowy 

# Tomek
* jak działa algorytm 
* czy mozna h liczyc z innego wzoru
* jak obliczane jest Q
* jak liczyc/traktowac S 
* jak wybiera sie at
* czy Q to tablica
--------------

# Tomek
* algorytm h


-------------

# Olaf 25.06
* dalej nie wiem dokladnie jak wykorzystac wzor 5 (co propagować, dlaczego tam jest suma sumy?) wiec chyba dopiero jutro sie spytam

* porządek kodu - osobna funkcja do liczenia estymatora, osobna do uaktualniania wag( jeśli dobrze rozumiem to co zwróci wzór 5)

* przygotowałem prezentacje confusion matrix dla wszystkich datasetów

* poprawione dzielenie danych - kazda grupa posiada taką samą ilość od danej klasy

# Tomek 25.06
* pracuje nad algorytmem h - jeśli nic z tego nie wyjdzie do południa to jebać. 

* Co do sieci neuronowej . z tego co pamiętam mówil że mamy przetestować zachowanie dla różnej liczby neuronów ukrytych i dla różnych funkcji warstwy ukrytej

# Olaf 23.06

STAN NA 20:09


* Wszystko jest edytowane w iris - potem bedziemy sklejac w funkcje. Dodałem tworzenie sieci i zapełnianie wag/biasów randomowo - wg. można było chyba to odpuścić, bo one sie chyba same randomują....ale teraz jest 100% pewności XD ofc niezależnie od ilośsci warstw

* Narazie dla jednej iteracji (zakomentowana petla for po epokach) wyliczam błędy dla wejścia - irys ma 3 outputy więc je zsuumowałem. Mam nadzieje ze tak można XD

* Później miejsce na wyliczenie h

* Estymator - z tego jak rozumiem ten wzór to jego wartość jest od konkretnego błędu, dlatego mamy 2x pętla for - jedna zeby wyliczał tą funkcje dla każdego błędu, a druga bo jest we wzorze.

* Potrzebne obliczanie kernela - nie widze tam nigdzie x poza f(x) a w innym miejscu jest tam e(n) wiec wydaje mi sie że to to (zerknij/pomyśl)

* No i 'wylicza sie' ten estymator - jak pamietam on mowil ze to bylby wykres ze na osi x jest e a na y jest ten estymator - ma to mniej wiecej sens bo f(e) produkuje wektor.

* Zmiana wag - no to chyba na jutro, bo nie za bardzo kminie jak by to zrobić ( te pochodne troche..yhhh XD)

* Ogólnie w kodzie są komentarze przy wątpliwościach i w jakis wazniejszych miejscach.

* Postaraj się zająć tym wyliczaniem h  - ja też zaraz będę patrzył. Chyba trzeba to porównywać z tymi algorytmami na kartach/zapisaki bo kurwa nie wiem co czym jest XD. Poś poucinałem z poprzedniej wersji. Ew. może najpierw przerobić kod c# na samą sigme a potem na matlab? Nie wiem, jeśli od razu w matlabie to trzeba porówywać z tym jego kodem (fajnie ze jakas dokumentacja jest ;/)

Jak coś to pisz. Dzisiaj będę siedział jakoś do 22-23, jutro pewnie od 12, 16-17:30 mnie nie bedzie w domu a potem mysle od 18 do nocy moge nadupcac. Ogólnie zajebiscie by było jakby dzisiaj/ jutro do 15 był ten algorytm z h






# Olaf 21.06
Dodałem brakujące datasety - musialem troche pozmieniac implementacje, w sonarze podmienione wartości klas z charó (R,M) na int (1,0)



# Olaf 20.06
Więc tak: przygotowałem 5 datasetów (info o nich przez help nazwa) - najpierw pomieszalem kolejność a następnie stworzyłem tablice cellów z podzielonymi kolejno wartościami - są gotowe do użycia w krzyżowej walidacji. W każdej kolumnie pierwszy wiersz to wejście, drugi - wyjście. Ilość podziałów można dostosować.


Przepisałem ten kod w c# iiii.....no troche bieda. Są tam funkcje z dupy, wgl nie wiem co mamy obliczać (jest jakieś sigma). Plus jest jakis blad przy pobieraniu wartości (chyba 108 linijka) - możliwe ze sie walnąłem w indeksach bo matlab indeksuje od 1 tablice. Porównaj to z kodem, postaraj sie znaleźć błąd i nei wiem co z tymi funkcjami Validate XD

Pytanie - jak mamy wyczarować 4 algorytmy obliczania h? wyslal nam 1 kod, który nie dziala (narazie)

Dzisiaj już raczej nic nie zrobie, jutro sie pewnie odezwe na fb. 
Edytuj ten plik jak coś zrobisz!


--------------

# Notatki Tomka
Ogólnie najpierw o materiałach :
1 mail zawierał 1 pdf (załóżmy że nazwę go A) - tam znajduje się opisana metoda uczenia entropi - mamy ją zaimplementować
2 mail zawierał 2 pdf(B i C)  i kod źródłowy - chodzi o to że w algorytmie etropi znajduje się taki parametr h który się wylicza za pomocą różnych metod (w tych dwóch pdf- h określane jest mianem signa - niech ciebie to nie zmyli). te dwa pdf ( B i C)mają nam pomóc zrozumieć o co kaman z tym h - a dołączony kod źródłowy ma nam pomóc w implementacji wszystkich 4 metod obliczania h
WAŻNE IOIOIOIO - ROBIMY WŁASNĄ FUNKCJĘ TRAIN - NIE IMPLEMENTUJEMY SIECI FEEDFORWARD
Do zrobienia(ogólnie mamy mieć 5 zbiorów danych : iris ,wine, iosphere, sonar, PIMA INDIANS DIABETES - czy jakoś tak lub jakieś inne):
1. zaimplementować metodę uczenia entropii
2. zaimplementować 4 algorytmy liczenia h 
3. teraz zaczyna się jazda. ogólnie mamy sieć feedforward (musimy dobrać liczbę neuronów ukrytych  - pętla itp) - mamy dobrać najlepszy algorytm h - tzn.  dla jednego  wybranego zestawu testujemy każdą metodę obliczania h i wybieramy jedną najlepszą metodę h  - dane mamy testować za pomocą Cross validation (np. dzielimy na 10 części i 9 z nich to uczące a 1 testowe i przechodzimy 10 razy - kojarzysz ? było to do drugiego kolowkium )
4. mając najlepszy algorytm h  testujemy cross validation dla każdego z tych zestawów 5-6 zestawów danych i oceniamy klasyfikację 
5. następnie mamy  porównać z inną siecią np. rbf i grnn - mamy kilka ocenić typów sieci - najlepiej >=2 bo jak mówilem że może nam się udać tylko z jedną to mega nie zadowlony był ale jebać. 
6. i teraz najlepsze : ZROBIĆ SPRAWOZDANIE I PREZENTACJĘ. prezentacja to takie wybiórcze huje muje, a prezentacja zawiera całościowy raport co zrobiliśmy i czemu tak a nie inaczej .

-------------


# Linki
1.

[back propagation](https://mattmazur.com/2015/03/17/a-step-by-step-backpropagation-example/)


2. 

[bayesian](http://crsouza.com/2009/11/18/neural-network-learning-by-the-levenberg-marquardt-algorithm-with-bayesian-regularization-part-1/)


3.

[dodawanie wlasnego uczenia](https://www.mathworks.com/matlabcentral/answers/56137-how-to-use-a-custom-transfer-function-in-neural-net-training)

