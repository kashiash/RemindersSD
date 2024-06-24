//
//  MyListsScreen.swift
//  RemindersSD
//
//  Created by Jacek Kosinski U on 22/06/2024.
//

import SwiftUI
import SwiftData

struct MyListsScreen: View {

    @State private var isPresented = false
    @Query private var myLists: [MyList]
 //   let myLists = ["Służbowe", "Zakupy", "Rozrywka"]

    var body: some View {
        NavigationStack {
            List {
                ForEach(myLists) { list in
                    NavigationLink {
                        MyListDetailScreen()
                    } label: {
                        HStack{
                            Image(systemName: "line.3.horizontal.circle.fill")
                                .foregroundColor(Color(hex: list.colorsCode))
                            Text(list.name)
                        }
                    }
                }

                Button(action: {
                 isPresented.toggle()
                },label: {
                    Text("Add List")
                        .foregroundStyle(.blue)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                })
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("My Lists")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isPresented) {
                NavigationStack{
                    AddMyListScreen()
                }
            }
        }
    }
}

#Preview { @MainActor in
    NavigationStack {
        MyListsScreen()
    }
    .modelContainer(previewContainer)
}
