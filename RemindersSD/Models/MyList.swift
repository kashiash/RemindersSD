//
//  MyList.swift
//  RemindersSD
//
//  Created by Jacek Kosinski U on 23/06/2024.
//

import Foundation
import SwiftData

@Model
class MyList {
    var name: String
    var colorsCode: String
    @Relationship(deleteRule: .cascade)
    var reminders: [Reminder] = []
    init(name: String, colorsCode: String) {
        self.name = name
        self.colorsCode = colorsCode
    }
}
