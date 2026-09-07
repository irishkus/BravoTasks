//
//  TasksScrollView.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 02.06.2026.
//

import SwiftUI
import SwiftData

struct TasksScrollView: View {

    @Environment(\.modelContext)
    private var modelContext

    var body: some View {
        TasksContentView(
            repository: SwiftDataTaskRepository(
                modelContext: modelContext
            )
        )
    }
}

private struct TasksContentView: View {

    @StateObject private var viewModel: TasksViewModel

    private let today = "На сегодня"
    private let daily = "Ежедневно"

    init(repository: TaskRepositoryProtocol) {
        _viewModel = StateObject(
            wrappedValue: TasksViewModel(
                repository: repository
            )
        )
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                ProgressCardView(
                    numberOfCompletedTasks:
                        viewModel.numberOfCompletedTasks,
                    numberOfTasksToday:
                        viewModel.numberOfTasksToday
                )
                .padding(.horizontal, 20)
                .padding(.top, 12)

                sectionHeader(
                    title: today,
                    count: viewModel.nonDailyTasks.count
                )
                .padding(.top, 12)

                tasksSection(
                    tasks: viewModel.nonDailyTasks
                )

                sectionHeader(
                    title: daily,
                    count: viewModel.dailyTasks.count
                )

                if viewModel.dailyTasks.isEmpty {
                    EmptyDailyTask()
                        .padding(.horizontal, 20)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.createTask(
                                repeatType: .daily
                            )
                        }
                } else {
                    tasksSection(
                        tasks: viewModel.dailyTasks
                    )
                }

                Spacer(minLength: 60)
            }

            addButton
        }
        .task {
            viewModel.loadTasks()
        }
        .fullScreenCover(
            isPresented: $viewModel.isEditorPresented
        ) {
            editorView
        }
        .alert(
            "Ошибка",
            isPresented: errorAlertBinding
        ) {
            Button("ОК", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
}

private extension TasksContentView {

    @ViewBuilder
    var editorView: some View {
        NavigationStack {
            if viewModel.isEditingTask {
                TaskEditorView(
                    task: $viewModel.selectedTask,
                    onSave: { _ in
                        viewModel.saveSelectedTask()
                    },
                    onDelete: { _ in
                        viewModel.deleteSelectedTask()
                    }
                )
            } else {
                TaskEditorView(
                    task: $viewModel.selectedTask,
                    onSave: { _ in
                        viewModel.saveSelectedTask()
                    }
                )
            }
        }
    }
}

private extension TasksContentView {

    var addButton: some View {
        Button {
            viewModel.createTask()
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 24, weight: .medium))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background {
                    LinearGradient(
                        colors: [
                            Color.buttonPurple,
                            Color.buttonPurpleDark
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }
                .clipShape(Circle())
                .shadow(
                    color: Color.buttonPurpleDark.opacity(0.30),
                    radius: 12,
                    x: 0,
                    y: 6
                )
        }
        .padding(.trailing, 20)
        .padding(.bottom, 10)
    }
}

private extension TasksContentView {

    func sectionHeader(
        title: String,
        count: Int
    ) -> some View {
        HStack(spacing: 12) {
            Text(title)
                .font(.title2)
                .bold()
                .padding(.top, 4)
                .padding(.bottom, 2)

            if count > 0 {
                Text("\(count)")
                    .font(.system(size: 14, weight: .bold))
                    .frame(width: 24, height: 24)
                    .background(Color.badgeLightGray)
                    .clipShape(Circle())
                    .offset(y: 2)
            }

            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

private extension TasksContentView {

    func tasksSection(
        tasks: [TaskItem]
    ) -> some View {
        LazyVStack(spacing: 12) {
            ForEach(tasks) { task in
                taskRow(task)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.editTask(task)
                    }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
        .padding(.bottom, 12)
    }
}

private extension TasksContentView {

    func completionBinding(
        for task: TaskItem
    ) -> Binding<Bool> {
        Binding(
            get: {
                viewModel.tasks.first(
                    where: { $0.id == task.id }
                )?.isCompleted ?? task.isCompleted
            },
            set: { newValue in
                viewModel.setCompleted(
                    newValue,
                    for: task.id
                )
            }
        )
    }

    func taskRow(
        _ task: TaskItem
    ) -> some View {
        HStack {
            CheckboxView(
                isSelected: completionBinding(for: task)
            )

            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.callout)
                    .bold()
                    .padding(.vertical, 2)

                Text(
                    DateFormatterHelper.time(
                        from: task.date
                    )
                )
                .font(.footnote)
                .foregroundStyle(.secondary)
                .bold()
                .padding(.bottom, 2)
            }

            Spacer()

            Text(task.priority.title)
                .font(.caption)
                .foregroundStyle(task.priority.textColor)
                .padding(7)
                .background {
                    Capsule()
                        .fill(
                            task.priority
                                .backgroundColor
                                .opacity(0.15)
                        )
                }

            HStack(spacing: 4) {
                ForEach(
                    0..<task.priority.circlesCount,
                    id: \.self
                ) { _ in
                    Circle()
                        .fill(task.priority.textColor)
                        .frame(width: 8, height: 8)
                }
            }
            .frame(
                width: 40,
                height: 8,
                alignment: .leading
            )
        }
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(
                    color: .black.opacity(0.12),
                    radius: 12,
                    x: 0,
                    y: 6
                )
        }
    }
}

private extension TasksContentView {

    var errorAlertBinding: Binding<Bool> {
        Binding(
            get: {
                viewModel.errorMessage != nil
            },
            set: { isPresented in
                if !isPresented {
                    viewModel.errorMessage = nil
                }
            }
        )
    }
}


#Preview {
    TasksScrollView()
        .modelContainer(
            for: TaskEntity.self,
            inMemory: true
        )
}
