//
//  TaskItem.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 31.05.2026.
//

import Foundation

struct TaskItem: Identifiable, Equatable {

    let id: UUID

    var title: String
    var description: String
    var date: Date
    var priority: AppTaskPriority
    var isCompleted: Bool
    var isRemind: Bool
    var repeatType: RepeatType

    init(
        id: UUID = UUID(),
        title: String,
        description: String = "",
        date: Date,
        priority: AppTaskPriority,
        isCompleted: Bool,
        isRemind: Bool,
        repeatType: RepeatType
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.date = date
        self.priority = priority
        self.isCompleted = isCompleted
        self.isRemind = isRemind
        self.repeatType = repeatType
    }
}
