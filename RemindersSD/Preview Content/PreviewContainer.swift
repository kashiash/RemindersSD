//
//  PreviewContainer.swift
//  RemindersSD
//
//  Created by Jacek Kosinski U on 23/06/2024.
//

import Foundation
import SwiftData

@MainActor
var previewContainer: ModelContainer = {

  let container  = try! ModelContainer(for: MyList.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))

    for myList in SampleData.myLists {
        container.mainContext.insert(myList)
        myList.reminders = SampleData.Reminders
    }

    return container
}()

struct SampleData {
    static var myLists: [MyList] {
        return [MyList(name: "Reminders2",colorsCode: "#2ecc71"), MyList(name: "Backlog",colorsCode: "#9b59b6")]
    }

    static var Reminders: [Reminder] {
        return [Reminder(title:"Reminder 1"),Reminder(title:"Reminder 2"),Reminder(title:"Reminder 3"),Reminder(title:"Reminder 4")]
    }
}
