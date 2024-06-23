## Zapisywanie  listy w bazie danych



Będziemy kontynuować pracę nad naszym klonem przypomnień z użyciem frameworka **Swift Data**. Więc kontynuujmy. W poprzednim wideo skonfigurowaliśmy bardzo podstawowy interfejs. Jak widać po prawej stronie, mamy ekran **My List**, który zawiera kilka zakodowanych na stałe przypomnień lub list. Mogę również otworzyć tę ładną stronę, która umożliwia dodanie nowej listy. Obecnie nie dodaje ona niczego, ma widok selektora, który jest selektorem koloru i tym podobne. Wygląda to naprawdę ładnie, ale nie robi zbyt wiele. Nie zapisuje do bazy danych. Więc musimy to rozgryźć, jak możemy zapisać informacje przy użyciu **Swift Data** do rzeczywistej bazy danych.

Aby to zrobić, pierwszą rzeczą, którą musimy zrobić, jest zacząć myśleć o modelach, które będziemy tworzyć. Zamierzam stworzyć nowy model. Musimy tworzyć modele, ponieważ te elementy będą tymi, które faktycznie będą zapisywane do bazy danych. Nazwę go **My List**. Nie mogę nazwać go **List**, chociaż chciałbym, ponieważ w **SwiftUI** już istnieje coś o nazwie **List**. Więc po prostu nazwę go **My List**. I to będzie model używany przez **Swift Data**. Najpierw zaimportuję **Swift Data** i stworzę klasę o nazwie **My List** oraz dodam makro modelu, które jest dostępne tylko dla klasy. Jeśli spróbujesz dodać makro modelu do struktury, nie zadziała to.

Dodam również, że model może mieć nazwę, jak lista może mieć nazwę, na przykład "groceries", oraz jakiś kolor z nią związany. W poprzedniej wersji **Xcode** mogłem używać typów transformowalnych, które faktycznie zapisują typ w bazie danych, co było całkiem fajne. Niestety, obecnie nie działa to. Zamiast zapisywać typ transformowalny, zapiszę kod koloru, kod hex dla tego koloru. Kiedy **Apple** naprawi te problemy, zaktualizuję wideo i faktycznie użyjemy typów transformowalnych.

Stwórzmy konstruktor lub inicjalizator. Świetnie. Teraz mamy **My List**. Ma nazwę, ma kod koloru.

```swift
@Model
class MyList {
    var name: String
    var colorsCode: String
    init(name: String, colorsCode: String) {
        self.name = name
        self.colorsCode = colorsCode
    }
}
```





 Aby działać z naszą aplikacją, warto poświęcić trochę czasu na podglądy lub testowy kontener, który jest dostępny tylko w podglądach.

Teraz, jeśli spojrzę na `MyListScreen`, mogę dodać tutaj kontener modelu. Kontener modelu jest wymagany, jeśli używasz **Swift Data**. Ale chcę dostarczyć kontener modelu, który już ma dodane jakieś listy, jak przypomnienia, zakupy, rozrywkę. Najpierw zaimportuję `Swift Data`. Jak dostarczę jakiś kontener podglądu? Dodam nowy plik w grupie `PreviewContent` i nazwę go `Preview Container`. Zasoby i kod z grupy `Preview Content` są uzywane tylko w podglądach i nie bedą dołaczone Będzie on dostępny tylko w podglądach. Jedynym celem dodania kontenera podglądu jest dostarczenie danych testowych podczas pracy z podglądami.

Powiem **Swift Data**, var **previewContainer**, który będzie zwracał **ModelContainer**. Wszystko wewnątrz będzie na głównym aktorze, w przeciwnym razie nie będziemy mogli uzyskać dostępu do kontekstu. Stworzymy kontener, który będzie próbował **ModelContainer**. W konfiguracji przekażemy typ modelu, który właśnie stworzyliśmy. Mamy tylko jeden typ modelu, więc przekażemy **MyList.self**. W konfiguracji można zobaczyć, że możemy określić, czy dane są przechowywane w pamięci. Przekażę true, ponieważ pracuję z podglądami i nie chcę zapisywać danych do bazy danych. Jeśli mogą być przechowywane w pamięci, to również jest w porządku. Następnie zwrócimy kontener.

Używam wymuszonego **try** z wykrzyknikiem. To nie jest duży problem, ponieważ kontener podglądu będzie używany tylko do podglądów. Jeśli wystąpi problem z konfiguracją kontenera modelu, podglądy faktycznie się zawieszą.

```swift
let container  = try! ModelContainer(for: MyList.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
```

Stwórzmy przykładowe dane. Widać, że stworzyłem osobną strukturę o nazwie **SampleData**. Ma ona właściwość statyczną o nazwie **myList** i zwraca tablicę dwóch zakodowanych na stałe list. Jedna to przypomnienia, a druga to backlog. 

```swift
struct SampleData {
    static var myLists: [MyList] {
        return [MyList(name: "Reminders",colorsCode: "#2ecc71"), MyList(name: "Backlog",colorsCode: "#9b59b6")]
    }
}

```

Musimy jeszcze przejść przez tę listę i dodać te elementy do bazy danych. Powiem **SampleData.myList**, a następnie używając **container.mainContext.insert**, wstawimy **myList**. Oznacza to, że jeśli użyję kontenera podglądu, automatycznie powinienem otrzymać te dwie listy, ponieważ je wstawiam.



```swift
//
//  PreviewContainer.swift
//  RemindersSD
//
//  Created by Jacek Kosinski U on 23/06/2024.
//
import Foundation
import SwiftData

@MainActor
var previewContainer: ModelContainer = {

  let container  = try! ModelContainer(for: MyList.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))

    for myList in SampleData.myLists {
        container.mainContext.insert(myList)
    }

    return container
}()

struct SampleData {
    static var myLists: [MyList] {
        return [MyList(name: "Reminders",colorsCode: "#2ecc71"), MyList(name: "Backlog",colorsCode: "#9b59b6")]
    }
}

```

Wracamy do ekranu **My List**. Dla podglądów powinniśmy być w stanie ustawić tutaj **modelContainer** i przekazać **previewContainer**. **PreviewContainer** jest oznaczony jako **MainActor**, więc jest dostępny tylko na głównym aktorze. W podglądzie możemy również powiedzieć **MainActor**, aby podgląd działał na głównym aktorze.

```swift
#Preview { @MainActor in
    NavigationStack {
        MyListsScreen()
    }
    .modelContainer(previewContainer)
}
```

Teraz wiemy, że kiedy dostarczamy kontener podglądu do naszej aplikacji, ten kontener zawiera również dwa elementy. Oznacza to, że mogę spróbować pobrać te elementy i wyświetlić je zamiast tej zakodowanej na stałe tablicy **myList**. 

Zamieńmy sztywna deklarację na zapytanie oznaczone adnotacją Query

```swift
    @Query private var myLists: [MyList]
 //   let myLists = ["Służbowe", "Zakupy", "Rozrywka"]
```

w prowadzmy drobne poprawki w pętli forEach gdzie juz nie potrzebujemy wskazywać identyfikatora, bo nasz klasa juz go ma. i w polu tekstowym poprawmy ze wyswietlamy name z obiektu list.

```swift
                ForEach(myLists) { list in
                    HStack{
                        Image(systemName: "line.3.horizontal.circle.fill")
                            .foregroundColor(.black)
                        Text(list.name)
                    }
                }
```

Widać, że te dwa elementy pochodzą teraz z naszego kontenera podglądu. To całkiem fajne. Następną rzeczą, którą chcemy zrobić, jest faktyczne dodanie **myList** do ekranu lub do bazy danych. Widać, że w funkcji **done** nie robimy nic. Zróbmy coś. Jeśli stworzę instancję **myList**, potrzebujemy nazwy i kodu koloru. Nazwa jest łatwa, ponieważ pochodzi z pola tekstowego, które możemy po prostu uzyskać przez **listName**. Kod koloru pochodzi z koloru. Nie ma domyślnej opcji, aby powiedzieć, że ten kolor, który jest typu **Color**, daje nam kod koloru. Musimy coś z tym zrobić.

Musimy również wstrzyknąć tutaj **modelContainer** dla naszego kontenera podglądu. Powiedzmy **previewContainer**, który jest dostępny tylko na głównym aktorze. Będziemy musieli użyć **mainActor**.

Problem jest taki, że mamy wybrany kolor, ale jest on typu **Color**. Jeśli przejdę do definicji **Color**, widać, że to struktura, która jest zgodna z **Hashable**, **CustomStringConvertible**, **Sendable**, ale to struktura. Musimy przekształcić ten kolor jakoś w kod hex. Jak to zrobić? Udało mi się poprosić **ChatGPT** o napisanie kodu, który pozwoli nam przekształcić kolor w hex. Dodam nową grupę o nazwie **Extensions**, nowy plik, i będzie to rozszerzenie na **Color**. **Color+Extensions**. Dodam rozszerzenie do **Color**, ale najpierw zaimportuję **SwiftUI**, ponieważ tam znajduje się **Color**. Powiem **extension Color** i teraz mogę zaimplementować funkcję **toHex**. Funkcja **toHex** będzie odpowiedzialna za przekształcenie koloru w hex. Użyjmy jej.

```swift
import Foundation
import SwiftUI

extension Color {
    
    func toHex() -> String? {
        let uic = UIColor(self)
        guard let components = uic.cgColor.components, components.count >= 3 else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if a != Float(1.0) {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
    init(hex: String) {
            // Remove '#' if exists
            var cleanedHex = hex
            if hex.hasPrefix("#") {
                cleanedHex = String(hex.dropFirst())
            }
            
            // Convert hex to RGB
            var rgb: UInt64 = 0
            Scanner(string: cleanedHex).scanHexInt64(&rgb)
            
            let red = Double((rgb & 0xFF0000) >> 16) / 255.0
            let green = Double((rgb & 0x00FF00) >> 8) / 255.0
            let blue = Double(rgb & 0x0000FF) / 255.0
            
            self.init(red: red, green: green, blue: blue)
        }
    
}
```

Jeśli chcesz więcej szczegółów na temat tej funkcji, możesz wkleić ten kod do **ChatGPT** i dowiedzieć się więcej. W zasadzie wyodrębnia ona wartości RGB i tworzy odpowiedni ciąg hex. Wracamy i próbujemy uzyskać hex. Powiem **hex**, a następnie **color.toHex**, co zwróci nam opcjonalny ciąg, więc możemy go rozpakować. Teraz powinienem być w stanie przekazać hex. Na koniec powiem **context**, do którego nie mamy dostępu. Przejdźmy na górę i uzyskajmy dostęp do kontekstu, który będzie **modelContext**, prywatna zmienna **context**. Wracamy tutaj i powiemy **context.insert myList**. Po wstawieniu możemy zamknąć okno.

```swift
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    // Zapis adanych
                    guard let colorhex = color.toHex() else {
                        return
                    }
                    let myList = MyList(name: listName, colorsCode: colorhex)
                    context.insert(myList)
                    dismiss()
                }
            }
```

Wracamy do ekranu **My List** i próbujemy dodać nową listę. Mamy backlog, mamy przypomnienia. Dodajmy coś, powiedzmy **groceries**. **Groceries**, zielony kolor, i powiedzmy **done**. **Groceries** zostało dodane. Ale jedna rzecz, którą można zauważyć, to że to nie jest zielony kolor. To jest czarny. Musimy to naprawić.

Problem polega na tym, że kiedy wyświetlamy te elementy, nie mówimy obrazowi, że styl pierwszego planu będzie pochodził z **myList.color**. Mamy coś takiego jak **myList.colorCode**. Oznacza to, że mamy kod koloru i musimy go przekształcić w rzeczywisty kolor. Pokażę wam, że ten kod pochodzi z bloga **Marco Edinger**. To naprawdę dobry post o przekształcaniu hex w kolor i z powrotem w **SwiftUI**. Dostarczył on kod. Dodam link do tego artykułu. To naprawdę dobry artykuł, warto go przeczytać. Możemy użyć tego kodu, aby przekształcić kolor w hex z powrotem w rzeczywisty kolor. To jest dokładnie to, co chcemy zrobić. Wracamy do rozszerzeń koloru i dodajemy to.

Jeśli przekażemy ciąg hex, zainicjuje to nowy kolor. Wracamy i możemy to zrobić tutaj. Powiemy **foregroundStyle**, a tutaj powiemy, że kolor powinien być z hex, prawdopodobnie **hex myList.colorCode**. Przekazujemy kod koloru, a następnie otrzymujemy kolor. Widać, że już działa, ponieważ backlog jest fioletowy, a to jest zielony. Dodajmy jeszcze jeden. Nazwijmy go **entertainment**. Dodajmy to. Teraz widzisz czerwony kolor. Wygląda na to, że wszystko działa. Wszystko jest teraz zapisywane do bazy danych. Przez bazę danych rozumiem bazę danych w pamięci. Ale jeśli uruchomisz to na rzeczywistym urządzeniu, zapisze to do rzeczywistego urządzenia. Ale nie uruchamiaj teraz, ponieważ nie skończyliśmy pracy nad klonem aplikacji przypomnień.

Przechodzimy do pliku aplikacji, który jest twoim plikiem **App**. Zamiast używać **ContentView**, możemy usunąć **ContentView**. Nie będziemy go używać. Usuńmy go. Nasz ekran główny nazywa się **MyListScreen**. Używamy **NavigationStack**. Będziemy używać **modelContainer**. Nie naprawdę **modelContainer** per se. Nie będziemy używać kontenera podglądu, ponieważ to jest prawdziwa aplikacja. Powiemy po prostu **MyList.self**. To powinno wystarczyć do uruchomienia na rzeczywistym urządzeniu.

Uruchommy to. Kiedy zapisuje informacje, zapisze je do rzeczywistej bazy danych. Powiedzmy **reminders**. Uruchommy to ponownie. **Reminders**, **groceries**. Mamy oba. Widać, że są zapisywane do rzeczywistej bazy danych.

W tym wideo nauczyliście się, jak zapisywać dane do rzeczywistej bazy danych przy użyciu **Swift Data**. Nauczyliście się również, jak wyświetlać je na ekranie. Mam nadzieję, że się podobało. W następnym wideo będziemy kontynuować pracę nad klonem aplikacji przypomnień. Dzięki za oglądanie.




