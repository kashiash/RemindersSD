//
//  ContentView.swift
//  RemindersSD
//
//  Created by Jacek Kosinski U on 22/06/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "apple.logo")
                .font(.system(size: 55))
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.system(size: 55))
                .fontWeight(.bold)
//                .foregroundStyle(
//                    .fluid(
//                        colors: [.red,.green,.blue],
//                        glow: .init(radius:50, opacity: 0.3)
//                    )
//                )
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
