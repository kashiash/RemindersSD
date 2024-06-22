## Budowanie podstawowego interfejsu użytkownika dla aplikacji Przypomnienia



W tej serii będziemy budować klon aplikacji **Apple's Reminders** przy użyciu **SwiftUI** i **SwiftData**. Już wcześniej stworzyłem serię na temat budowy klonu aplikacji Reminders przy użyciu **SwiftUI** i **CoreData**, ale teraz **SwiftData** jest przyszłością przechowywania danych na urządzeniu, więc podejmiemy się tego samego zadania przy użyciu **SwiftData**.

To jest końcowy produkt i zajmie nam kilka filmów, aby do niego dojść. To jest seria. Ostatecznie tam dotrzemy, ale teraz patrzysz na końcowy produkt. Możesz zobaczyć, że mam aplikację Reminders. Mam możliwość wyszukiwania, różne sekcje dla dzisiejszego harmonogramu, zakończone, wszystkie i różne rodzaje list. Mogę dodać nową listę, jeśli chcę, lub sprawdzić niektóre listy, na przykład: "Hej, to moja podróż do Wielkiej Brytanii. Muszę wynająć samochód." Mogę dodać nowe przypomnienie, na przykład "Zjedz ciasto". Dziwne przypomnienie, ale można to zrobić. Możesz także edytować przypomnienie, dodać notatki, na przykład "Ciasto bez cukru". Nie, nie zamierzam jeść ciasta bez cukru, ale wiesz, o co mi chodzi. Możesz wybrać datę, godzinę i tak dalej, a następnie przypisać to. Całkiem fajne. Wszystkie te funkcje są dostępne.

Jeśli oznaczę coś jako zakończone, to zajmie chwilę, ponieważ daje ci możliwość cofnięcia, a następnie oznacza to jako zakończone. Możesz zobaczyć, że mam zakończone zadania. Wynajem samochodu jest zakończony i kupienie mleka jest zakończone. Świetnie. Mogę dodać nową listę, na przykład tworzę nową listę dla zabawy i przypisuję jej inny kolor. Mogę zapisać tę konkretną listę. Mogę także wyszukiwać. Jeśli szukam wynajmu samochodu, mogę wyszukać wynajem samochodu. Jeśli szukam ciasta, to też znajdzie ciasto. Oprócz tego, tak jak w rzeczywistej aplikacji Reminders, mogę przejść do różnych sekcji, takich jak "Dzisiaj", "Harmonogram", "Zakończone" lub "Wszystkie". Możemy robić wszystkie te rzeczy i będziemy budować to przy użyciu **SwiftData**.



A teraz wróćmy do naszego klonu Reminders i **SwiftData**. Zaczynamy. Już stworzyłem projekt o nazwie **Reminders Clone**. Wybiorę coś z iPhone'ów, na przykład iPhone 15 Pro. Na razie nie napisaliśmy żadnej linii kodu w naszym projekcie **Reminders Clone**. To jest cały domyślny kod. Chcę uporządkować mój kod w wygodny sposób, więc każdy ekran będzie reprezentowany przez coś, co nazwę ekranem. Utwórzmy nasz pierwszy ekran, który będzie moim ekranem list. Nazwę go **MyListScreen**.

**MyListScreen** będzie wyświetlał listę grup wg jakich będziemy grupować nasze zadania. Skupiamy się teraz na tej części. Górna część ekranu zawiera wszystkie statystyki, ale na razie skupiamy się tylko na tej dolnej części.  Możemy powiedzieć, że styl listy będzie zwykły. Teraz mogę przejść przez każdy z tych elementów. To jest zakodowana lista. Nie martw się, zmienimy to i będziemy używać rzeczywistego **SwiftData**, zapisując do bazy danych SQLite. Na razie po prostu zaczynamy. Potrzebujemy wyświetlić ikonę i nazwę dla tej konkretnej listy. Użyję **HStack**. Dla ikony użyję **line.3.horizontal.circle.fill**. Możesz zobaczyć ikonę. Jest w czarnym kolorze. Możesz ją zmienić, jeśli chcesz. Po prostu wyświetlę **MyList**. Wygląda całkiem dobrze.

```swift
import SwiftUI

struct MyListsScreen: View {

    let myLists = ["Służbowe", "Zakupy", "Rozrywka"]
    var body: some View {
        NavigationStack {
            List {
                ForEach(myLists, id: \.self) { list in
                    HStack{
                        Image(systemName: "line.3.horizontal.circle.fill")
                            .foregroundColor(.black)
                        Text(list)
                    }
                }

                Button(action: {
                  //  showAddListModal.toggle()
                },label: {
                    Text("Add List")
                        .foregroundStyle(.blue)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                })
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("My Lists")
        }
    }
}

#Preview {
    NavigationStack {
        MyListsScreen()
    }
}
```



Na podglądzie użyję również **NavigationStack**. Następnie możemy dodać przycisk do dodania nowej listy. Nazwę go **AddList**. Nie chcemy separatora dla naszego przycisku, więc mogę go ukryć. Jeśli chcesz, możesz go użyć. Teraz mamy przycisk **AddList**. Kolejną rzeczą, którą chcemy zrobić, to po kliknięciu tego przycisku chcemy wyświetlić model, aby móc dodać listę. Jeśli kliknę **AddList**, to jest model, nad którym pracujemy. Wygląda to skomplikowanie, ale nie martw się. Ten kontroler, który widzisz, już stworzyłem. Nazywa się **ColorPickerView**. Możemy go zaimportować i zacząć używać. Jeśli chcesz nauczyć się, jak stworzyć ten kontroler, postaram się dodać link do filmu na YouTube, gdzie możesz zobaczyć, jak go dodać.

Teraz utworzymy nowy ekran, który nazwiemy **AddMyListScreen**. To jest miejsce, gdzie użytkownik doda nową listę. Zastępuję tekst **VStack**. Tworzymy ogólną strukturę. Nie stworzyliśmy jeszcze modelu dla **SwiftData** i nie zainicjowaliśmy naszego kontenera modelu ani kontekstu modelu. Na razie staramy się stworzyć bardzo podstawowy interfejs. Mamy nasz pierwszy element. Możemy zmienić kolor, jeśli nie podoba nam się ten. Następnie potrzebujemy pola tekstowego, gdzie użytkownik może wpisać nazwę nowej listy. Dodaję zmienną stanu **listName**. Dodaję pole tekstowe.



```swift
struct AddMyListScreen: View {
    @State private var listName: String = ""
    var body: some View {
        VStack {
            Image(systemName: "line.3.horizontal.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            TextField("List name", text: $listName)
                .textFieldStyle(.roundedBorder)
                .padding([.leading,.trailing],44)
        }
    }
}
```

Wygląda całkiem dobrze. Następnie potrzebujemy **ColorPickerView**. Ten kontroler pozwala wybrać kolor. Już go zaimplementowałem w jednym z filmów na YouTube. Skopiuję kod i wkleję go tutaj. 



**ColorPickerView** jest zależny od koloru, który jest dwukierunkowo przekazywany mieędzy widokami tzw **bindingiem**. Oznacza to, że kiedy wybierzesz kolor, zostanie on przekazany do rodzica. Wszystkie kolory są wymienine w deklaracji: . 

```swift
let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple]
```

Przechodzimy przez pętlę i tworzymy **ZStack** z tymi kolorami. Kiedy wybierzesz kolor, przypisuje się on do zmiennej stanu. Sposób użycia jest prosty. Tworzę zmienną stanu **color** i ustawiam ją na niebieski. Następnie używam **ColorPickerView** i przekazuję kolor jako **binding**. Oznacza to, że kiedy wybierzesz kolor, zmienna stanu w **AddMyListScreen** zostanie zaktualizowana. 



```swift
struct AddMyListScreen: View {
    @State private var listName: String = ""
    @State private var color:Color = .blue
     var body: some View {
        VStack {
            Image(systemName: "line.3.horizontal.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            TextField("List name", text: $listName)
                .textFieldStyle(.roundedBorder)
                .padding([.leading,.trailing],44)
            ColorPickerView(selectedColor: $color)
        }
    }
}

#Preview {
    AddMyListScreen()
}
```

Chcemy, aby kolor obrazu zmieniał się zgodnie z wybranym kolorem. Zamiast używać domyślnego koloru, używamy wybranego koloru. Wygląda dobrze. Następnie dodajemy pasek narzędzi, który pozwoli nam zamknąć model lub zapisać nową listę do bazy danych. Owijam to w **NavigationStack**. Dodaję tytuł nawigacji **New List**. Używam **inline display mode**, aby tytuł był mniejszy. Dodajmy na zamknieciu VStack{}

```swift
        .navigationTitle("New list")
        .navigationBarTitleDisplayMode(.inline)
```

Dodaję następnie pasek narzędzi z dwoma przyciskami: jednym do zamknięcia modelu i drugim do zapisania listy. 

```swift
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    // Zapis adanych
                    dismiss()
                }
            }
        }
```

Aby zamknąć model, używam wartości środowiskowej **dismiss**, który musze zadeklarować na początku widoku:

```swift
    @Environment(\.dismiss) private var dismiss
```

Kiedy klikniemy przycisk `Done`, chcemy zapisać dane.

Wracamy do widoku MyListScreen.

 Aby przejść do tego widoku, musimy kliknąć **AddList** w **MyListScreen**. Dodaję zmienną stanu **isPresented**. Kiedy kliknę **AddList**, ustawiam **isPresented** na **true**. Używam **sheet** do wyświetlenia **AddMyListScreen**. Oznacza to, że kiedy kliknę **AddList**, lista zostanie wyświetlona. 

Na razie lista nie ma tytułu. Możemy owinąć to w **NavigationStack**. 

```swift
            .sheet(isPresented: $isPresented) {
                NavigationStack{
                    AddMyListScreen()
                }
            }
```

W następnym filmie nauczymy się, jak zapisać listę przy użyciu **SwiftData** do bazy danych i wyświetlić wszystkie listy na ekranie. Dziękuję i do zobaczenia w następnym filmie. Cześć!

