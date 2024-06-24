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
    var body: some View {
        VStack {
            List(myList.reminders) { reminder in
                Text(reminder.title)
            }
        }
        .navigationTitle(myList.name)
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
