//
//  TasksViewModel.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 05.08.2026.
//

import Foundation
import Combine

final class TasksViewModel: ObservableObject {

    enum EditorMode {
        case create
        case edit
    }

    @Published private(set) var tasks: [TaskItem] = []
    @Published var selectedTask: TaskItem
    @Published var isEditorPresented = false
    @Published private(set) var editorMode: EditorMode = .create
    @Published var errorMessage: String?

    private let repository: TaskRepositoryProtocol

    init(repository: TaskRepositoryProtocol) {
        self.repository = repository

        self.selectedTask = TaskItem(
            title: "",
            date: .now,
            priority: .medium,
            isCompleted: false,
            isRemind: false,
            repeatType: .never
        )
    }

    // MARK: - Секции

    var dailyTasks: [TaskItem] {
        tasks.filter { $0.repeatType == .daily }
    }

    var nonDailyTasks: [TaskItem] {
        tasks.filter { $0.repeatType != .daily }
    }

    // MARK: - Статистика

    var numberOfTasksToday: Int {
        tasks.count
    }

    var numberOfCompletedTasks: Int {
        tasks.filter(\.isCompleted).count
    }

    var isEditingTask: Bool {
        editorMode == .edit
    }

    // MARK: - Загрузка

    func loadTasks() {
        do {
            tasks = try repository.fetchTasks(for: .now)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Открытие редактора

    func createTask(repeatType: RepeatType = .never) {
        selectedTask = TaskItem(
            title: "",
            date: .now,
            priority: .medium,
            isCompleted: false,
            isRemind: false,
            repeatType: repeatType
        )

        editorMode = .create
        isEditorPresented = true
    }

    func editTask(_ task: TaskItem) {
        selectedTask = task
        editorMode = .edit
        isEditorPresented = true
    }

    // MARK: - Изменение данных

    func saveSelectedTask() {
        do {
            try repository.save(selectedTask)
            loadTasks()
            isEditorPresented = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func deleteSelectedTask() {
        guard isEditingTask else {
            return
        }

        do {
            try repository.delete(selectedTask)
            loadTasks()
            isEditorPresented = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func setCompleted(
        _ isCompleted: Bool,
        for taskID: UUID
    ) {
        guard let index = tasks.firstIndex(
            where: { $0.id == taskID }
        ) else {
            return
        }

        let previousValue = tasks[index].isCompleted
        tasks[index].isCompleted = isCompleted

        do {
            try repository.save(tasks[index])
        } catch {
            // Откатываем UI, если сохранить не получилось
            tasks[index].isCompleted = previousValue
            errorMessage = error.localizedDescription
        }
    }
}
