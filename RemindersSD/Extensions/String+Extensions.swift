//
//  String+Extensions.swift
//  RemindersSD
//
//  Created by Jacek Kosinski U on 25/06/2024.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
