//
//  Task.swift
//  GoodToDoList
//
//  Created by Елена Воронцова on 20.11.2024.
//

import Foundation

enum Priority: Int {
    case hight
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
