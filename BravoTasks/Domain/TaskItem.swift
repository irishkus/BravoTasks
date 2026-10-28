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
    var scheduledAt: Date?  // На когда запланировано
    var completedAt: Date?  // Когда выполнено фактически
    var priority: AppTaskPriority
    var isCompleted: Bool
    var isRemind: Bool
    var repeatType: RepeatType

    init(
        id: UUID = UUID(),
        title: String,
        description: String = "",
        scheduledAt: Date?,
        completedAt: Date?,
        priority: AppTaskPriority,
        isCompleted: Bool,
        isRemind: Bool,
        repeatType: RepeatType
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.completedAt = completedAt
        self.scheduledAt = scheduledAt
        self.priority = priority
        self.isCompleted = isCompleted
        self.isRemind = isRemind
        self.repeatType = repeatType
    }
}
