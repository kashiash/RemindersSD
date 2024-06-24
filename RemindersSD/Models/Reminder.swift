//
//  Reminder.swift
//  RemindersSD
//
//  Created by Jacek Kosinski U on 24/06/2024.
//

import Foundation
import SwiftData

@Model
class Reminder {
    var title: String
    var notes: String?
    var isCompleted: Bool
    var reminderDate: Date?
    var reminderTime: Date?

    var list: MyList?

    init(title: String, notes: String? = nil, isCompleted: Bool, reminderDate: Date? = nil, reminderTime: Date? = nil, list: MyList? = nil) {
        self.title = title
        self.notes = notes
        self.isCompleted = isCompleted
        self.reminderDate = reminderDate
        self.reminderTime = reminderTime
        self.list = list
    }
}
