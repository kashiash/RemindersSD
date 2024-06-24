//
//  MyListDetailScreen.swift
//  RemindersSD
//
//  Created by Jacek Kosinski U on 24/06/2024.
//

import SwiftUI
import SwiftData


struct MyListDetailScreen: View {
    @State  var myList: MyList

    @State private var title: String = ""
    @State private var isSheetPresented = false

    var body: some View {
        VStack {
            List(myList.reminders) { reminder in
                Text(reminder.title)
            }
            Spacer()
            Button(action: {
                isSheetPresented.toggle()
            }, label :{
                HStack{
                    Image(systemName: "plus.circle.fill")
                    Text("New reminder")
                }
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .navigationTitle(myList.name)
       // .navigationBarTitleDisplayMode(.inline)
        .alert("New reminder", isPresented: $isSheetPresented) {
            TextField("",text: $title)
            Button("Cancel",role: .cancel) {}
            Button("Done") {
                saveReminder()
            }
        }
    }

    func saveReminder() {
        let reminder = Reminder(title: title)
        myList.reminders.append(reminder)
        title = ""
    }
}

struct MyListDetailScreenContainer: View {
    @Query private var myLists: [MyList]

    var body: some View {
        MyListDetailScreen(myList: myLists[0])
    }
}

#Preview { @MainActor in
    NavigationStack{
        MyListDetailScreenContainer()
    }
        .modelContainer(previewContainer)
}
