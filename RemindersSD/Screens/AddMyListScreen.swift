//
//  AddMyListScreen.swift
//  RemindersSD
//
//  Created by Jacek Kosinski U on 22/06/2024.
//

import SwiftUI

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

#Preview {
    AddMyListScreen()
}
