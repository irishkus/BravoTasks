//
//  TaskEntity.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 23.07.2026.
//

import Foundation
import SwiftData

@Model
final class TaskEntity {

    @Attribute(.unique)
    var id: UUID

    var title: String
    var taskDescription: String
    var date: Date

    var priorityRawValue: String

    var isCompleted: Bool
    var isRemind: Bool

    var repeatTypeRawValue: String
    var repeatInterval: Int?

    var createdAt: Date
    var updatedAt: Date

    init(
        id: UUID,
        title: String,
        taskDescription: String,
        date: Date,
        priorityRawValue: String,
        isCompleted: Bool,
        isRemind: Bool,
        repeatTypeRawValue: String,
        repeatInterval: Int?,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.title = title
        self.taskDescription = taskDescription
        self.date = date
        self.priorityRawValue = priorityRawValue
        self.isCompleted = isCompleted
        self.isRemind = isRemind
        self.repeatTypeRawValue = repeatTypeRawValue
        self.repeatInterval = repeatInterval
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
