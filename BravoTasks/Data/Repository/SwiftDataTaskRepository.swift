//
//  SwiftDataTaskRepository.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 23.07.2026.
//

import Foundation
import SwiftData

@MainActor
final class SwiftDataTaskRepository: TaskRepositoryProtocol {

    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    // MARK: - Fetch

    func fetchAll() throws -> [TaskItem] {
        let descriptor = FetchDescriptor<TaskEntity>(
            sortBy: [
                SortDescriptor(
                    \TaskEntity.date,
                    order: .forward
                ),
                SortDescriptor(
                    \TaskEntity.createdAt,
                    order: .forward
                )
            ]
        )

        return try modelContext
            .fetch(descriptor)
            .map { $0.toTaskItem() }
    }
    
    func fetchTasks(for date: Date) throws -> [TaskItem] {
        let calendar = Calendar.current

        let startOfDay = calendar.startOfDay(for: date)

        guard let endOfDay = calendar.date(
            byAdding: .day,
            value: 1,
            to: startOfDay
        ) else {
            return []
        }

        let descriptor = FetchDescriptor<TaskEntity>(
            predicate: #Predicate<TaskEntity> { entity in
                entity.date >= startOfDay &&
                entity.date < endOfDay
            },
            sortBy: [
                SortDescriptor(\TaskEntity.date)
            ]
        )

        return try modelContext
            .fetch(descriptor)
            .map { $0.toTaskItem() }
    }

    // MARK: - Insert

    func insert(_ task: TaskItem) throws {
        guard try findEntity(id: task.id) == nil else {
            throw TaskRepositoryError.taskAlreadyExists(task.id)
        }

        let entity = TaskEntity(task: task)

        modelContext.insert(entity)

        try commitChanges()
    }

    // MARK: - Update

    func update(_ task: TaskItem) throws {
        guard let entity = try findEntity(id: task.id) else {
            throw TaskRepositoryError.taskNotFound(task.id)
        }

        entity.update(from: task)

        try commitChanges()
    }

    // MARK: - Delete

    func delete(_ task: TaskItem) throws {
        guard let entity = try findEntity(id: task.id) else {
            throw TaskRepositoryError.taskNotFound(task.id)
        }

        modelContext.delete(entity)

        try commitChanges()
    }

    // MARK: - Upsert

    func save(_ task: TaskItem) throws {
        if let entity = try findEntity(id: task.id) {
            entity.update(from: task)
        } else {
            modelContext.insert(
                TaskEntity(task: task)
            )
        }

        try commitChanges()
    }

    // MARK: - Private

    private func findEntity(id: UUID) throws -> TaskEntity? {
        let taskID = id

        var descriptor = FetchDescriptor<TaskEntity>(
            predicate: #Predicate<TaskEntity> { entity in
                entity.id == taskID
            }
        )

        descriptor.fetchLimit = 1

        return try modelContext.fetch(descriptor).first
    }

    private func commitChanges() throws {
        guard modelContext.hasChanges else {
            return
        }

        try modelContext.save()
    }
}
