//
//  EmptyTodayTaskView.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 07.09.2026.
//

import SwiftUI
import SwiftData

struct EmptyTodayTaskView: View {
    let onCreateTask: () -> Void
    let onCreateDailyTask: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            Image("emptyList")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
            Text("Пока нет задач")
                .font(.headline)
                .bold()
                .padding(.bottom, 2)
            Text("Добавьте первую задачу на сегодня \nили создайте ежедневную привычку")
                .padding(.bottom, 12)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.secondary)
                .font(.system(size: 13, weight: .medium))
            addTaskButton
            addDailyTaskButton
        }
        .background {
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemBackground))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .stroke(
                    Color.gray.opacity(0.15),
                    lineWidth: 1
                )
        }
        .shadow(
            color: Color.black.opacity(0.06),
            radius: 8,
            x: 0,
            y: 3
        )
    }
    
    private var addTaskButton: some View {
        Button {
            onCreateTask()
        } label: {
            HStack {
                Image(systemName: "plus")
                Text("Добавить задачу")
                    .font(.default)
                    .bold()
            }
        }
        .font(.system(size: 17, weight: .medium))
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 48)
        .background(
            Color.bravoBasicPurple
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 14)
        )
        .padding(.bottom, 6)
        .padding(.horizontal, 40)
    }
    
    private var addDailyTaskButton: some View {
        Button(role: .destructive) {
            onCreateDailyTask()
        } label: {
            HStack(spacing: 10) {
                Image(systemName: "arrow.trianglehead.clockwise.rotate.90")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.bravoBasicPurple)

                Text("Добавить ежедневную привычку")
                    .font(.system(size: 15, weight: .semibold))
            }
            .foregroundColor(.bravoBasicPurple)
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        Color.bravoBasicPurple,
                        lineWidth: 1
                    )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    EmptyTodayTaskView {
        print("Задача добавлена")
    } onCreateDailyTask: {
        print("Задача ежедневная добавлена")
    }

}
