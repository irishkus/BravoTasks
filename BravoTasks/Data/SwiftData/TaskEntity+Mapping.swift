//
//  TaskEntity+Mapping.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 23.07.2026.
//

import Foundation

private enum StoredRepeatType: String {
    case never
    case daily
    case weekly
    case weekdays
    case weekends
    case monthly
    case yearly
    case everyNDays
}

// MARK: - TaskItem → SwiftData

extension TaskEntity {

    convenience init(task: TaskItem) {
        let repeatData = task.repeatType.storageValue

        self.init(
            id: task.id,
            title: task.title,
            taskDescription: task.description,
            date: task.date,
            priorityRawValue: task.priority.rawValue,
            isCompleted: task.isCompleted,
            isRemind: task.isRemind,
            repeatTypeRawValue: repeatData.type,
            repeatInterval: repeatData.interval
        )
    }

    func update(from task: TaskItem) {
        let repeatData = task.repeatType.storageValue

        title = task.title
        taskDescription = task.description
        date = task.date
        priorityRawValue = task.priority.rawValue
        isCompleted = task.isCompleted
        repeatTypeRawValue = repeatData.type
        repeatInterval = repeatData.interval
        updatedAt = .now
    }
}

// MARK: - SwiftData → TaskItem

extension TaskEntity {

    func toTaskItem() -> TaskItem {
        TaskItem(
            id: id,
            title: title,
            description: taskDescription,
            date: date,
            priority: AppTaskPriority(
                rawValue: priorityRawValue
            ) ?? .medium,
            isCompleted: isCompleted,
            isRemind: isRemind,
            repeatType: RepeatType.fromStorage(
                type: repeatTypeRawValue,
                interval: repeatInterval
            )
        )
    }
}

// MARK: - RepeatType mapping

private extension RepeatType {

    var storageValue: (type: String, interval: Int?) {
        switch self {
        case .never:
            return (StoredRepeatType.never.rawValue, nil)

        case .daily:
            return (StoredRepeatType.daily.rawValue, nil)

        case .weekly:
            return (StoredRepeatType.weekly.rawValue, nil)
            
        case .weekdays:
            return (StoredRepeatType.weekdays.rawValue, nil)
            
        case .weekends:
            return (StoredRepeatType.weekends.rawValue, nil)

        case .monthly:
            return (StoredRepeatType.monthly.rawValue, nil)
            
        case .yearly:
            return (StoredRepeatType.yearly.rawValue, nil)
        case let .everyNDays(days):
            return (
                StoredRepeatType.everyNDays.rawValue,
                max(days, 1)
            )
        }
    }

    static func fromStorage(
        type: String,
        interval: Int?
    ) -> RepeatType {
        guard let storedType = StoredRepeatType(rawValue: type) else {
            return .never
        }

        switch storedType {
        case .never:
            return .never

        case .daily:
            return .daily

        case .weekly:
            return .weekly
        
        case .weekends:
            return .weekends
        
        case .weekdays:
            return .weekdays

        case .monthly:
            return .monthly
            
        case .yearly:
            return .yearly

        case .everyNDays:
            return .everyNDays(
                max(interval ?? 1, 1)
            )
        }
    }
}
