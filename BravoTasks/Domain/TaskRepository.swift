//
//  TaskRepository.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 23.07.2026.
//

import Foundation
import SwiftData

@MainActor
protocol TaskRepositoryProtocol {

    /// Получить все задачи.
    func fetchAll() throws -> [TaskItem]
    
    /// Получить все задачи за конкретный день
    func fetchTasks(for date: Date) throws -> [TaskItem]

    /// Добавить новую задачу.
    func insert(_ task: TaskItem) throws

    /// Обновить существующую задачу.
    func update(_ task: TaskItem) throws

    /// Удалить задачу.
    func delete(_ task: TaskItem) throws

    /// Добавить новую или обновить существующую.
    func save(_ task: TaskItem) throws
}
