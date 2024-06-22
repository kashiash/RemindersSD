//
//  MyListsScreen.swift
//  RemindersSD
//
//  Created by Jacek Kosinski U on 22/06/2024.
//

import SwiftUI

struct MyListsScreen: View {

    @State private var isPresented = false
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
            .sheet(isPresented: $isPresented) {
                NavigationStack{
                    AddMyListScreen()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MyListsScreen()
    }
}
