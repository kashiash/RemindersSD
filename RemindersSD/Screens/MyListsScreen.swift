//
//  MyListsScreen.swift
//  RemindersSD
//
//  Created by Jacek Kosinski U on 22/06/2024.
//

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
