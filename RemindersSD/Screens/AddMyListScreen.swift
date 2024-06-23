//
//  AddMyListScreen.swift
//  RemindersSD
//
//  Created by Jacek Kosinski U on 22/06/2024.
//

import SwiftUI

struct AddMyListScreen: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @State private var listName: String = ""
    @State private var color:Color = .blue
     var body: some View {
        VStack {
            Image(systemName: "line.3.horizontal.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(color)
            TextField("List name", text: $listName)
                .textFieldStyle(.roundedBorder)
                .padding([.leading,.trailing],44)
            ColorPickerView(selectedColor: $color)
        }
        .navigationTitle("New list")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
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
        }
    }
}

#Preview { @MainActor in
    NavigationStack{
        AddMyListScreen()
    }.modelContainer(previewContainer)
}
