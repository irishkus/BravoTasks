//
//  TaskEditorView.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 08.06.2026.
//

import SwiftUI

struct TaskEditorView: View {
    
    @Binding var task: TaskItem
    @State private var showRepetitionOptions = false
    
    let onSave: (TaskItem) -> Void
    let onDelete: ((TaskItem) -> Void)?
    
    @Environment(\.dismiss) private var dismiss
    
    private var canSave: Bool {
        !task.title
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .isEmpty
    }
    
    init(
            task: Binding<TaskItem>,
            onSave: @escaping (TaskItem) -> Void,
            onDelete: ((TaskItem) -> Void)? = nil
        ) {
            self._task = task
            self.onSave = onSave
            self.onDelete = onDelete

            print("TaskEditorView init")
        }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    print($task)
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.primary)
                        .frame(width: 20, height: 44)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                
                Spacer()
                
                Text(onDelete == nil ? "Новая задача" : "Редактировать задачу")
                    .font(.headline)
                
                Spacer()
                
                Color.clear
                    .frame(width: 20, height: 44)
            }
            .padding(.top, 12)
            
            Text("Название задачи")
                .font(.subheadline)
                .foregroundColor(.primary.opacity(0.8))
            
            TextField("Введите название задачи", text: $task.title)
                .font(.system(size: 16, design: .rounded))
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                }
                .padding(.bottom, 10)
            
            Text("Заметки (необязательно)")
                .font(.subheadline)
                .foregroundColor(.primary.opacity(0.8))
            
            TextEditor(text: $task.description)
                .frame(height: 50)
                .font(.system(size: 16, design: .rounded))
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                }
            
            DateSelectionView(selectedDate: $task.date)
            
            TimeSelectionView(selectedDate: $task.date)
            
            PrioritySelectionView(selectedPriority: $task.priority)
            
            RepeatSelectionView(selectedType: $task.repeatType, showRepetitionOptions: $showRepetitionOptions) {
                showRepetitionOptions = true
            }
            
            HStack {
                CheckboxView(isSelected: $task.isRemind)
                Text("Напоминать")
                    .font(.system(size: 16, design: .rounded))
                    
            }
            .padding(.top, 10)
            .padding(.bottom, 10)
            .onTapGesture {
                task.isRemind.toggle()
            }
            
            Spacer()
            
            VStack(spacing: 10) {
                saveButton
                if let _ = onDelete {
                    deleteButton
                }
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal)
        .sheet(isPresented: $showRepetitionOptions) {
            RepetitionOptionsView(
                repeatType: $task.repeatType
            )
            .presentationDetents([.medium])
        }
        .onChange(of: showRepetitionOptions) { oldValue, newValue in
            print("showRepetitionOptions:", oldValue, "→", newValue)
        }
    }
    
    
    private var saveButton: some View {
            Button {
                saveTask()
            } label: {
                Text("Сохранить задачу")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(
                        Color.bravoBasicPurple
                    )
                    .clipShape(
                        RoundedRectangle(cornerRadius: 14)
                    )
            }
            .buttonStyle(.plain)
            .disabled(!canSave)
        }

        private var deleteButton: some View {
            Button(role: .destructive) {
                onDelete?(task)
                dismiss()
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "trash")
                        .font(.system(size: 17, weight: .medium))

                    Text("Удалить задачу")
                        .font(.system(size: 15, weight: .semibold))
                }
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(.white)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            Color.purple.opacity(0.18),
                            lineWidth: 1
                        )
                }
            }
            .buttonStyle(.plain)
        }
    
    private func saveTask() {
        guard canSave else { return }
        
        onSave(task)
        dismiss()
        
    }
}

#Preview {
    @Previewable @State var task = TaskItem(
        title: "",
        date: Date(),
        priority: .medium,
        isCompleted: false,
        isRemind: false,
        repeatType: .never
    )

    TaskEditorView(
        task: $task,
        onSave: { updatedTask in
            print("Задача добавлена")
        },
        onDelete: { deletedTask in
            print("Задача удалена")
        }
    )
}
