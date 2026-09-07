//
//  TimeSelectionView.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 25.06.2026.
//

import SwiftUI

struct TimeSelectionView: View {
    @Binding var selectedDate: Date
    @State private var isTimePickerPresented = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Время")
                .font(.subheadline)
                .foregroundStyle(.primary.opacity(0.8))

            Button {
                isTimePickerPresented = true
            } label: {
                HStack(spacing: 16) {
                    Image(systemName: "clock")
                        .font(.system(size: 25, weight: .medium))
                        .foregroundStyle(Color.bravoBasicPurple)

                    Text(formattedTime)
                        .font(.subheadline)
                        .foregroundStyle(.primary)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 20)
                .frame(height: 52)
                .background {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color(.systemBackground))
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                }
                .shadow(
                    color: Color.black.opacity(0.06),
                    radius: 8,
                    x: 0,
                    y: 3
                )
            }
            .buttonStyle(.plain)
        }
        .padding(.top, 12)
        .sheet(isPresented: $isTimePickerPresented) {
            TimePickerSheet(selectedTime: $selectedDate)
                .presentationDetents([.height(280)])
        }
    }

    private var formattedTime: String {
        selectedDate.formatted(
            .dateTime
                .hour(.twoDigits(amPM: .omitted))
                .minute(.twoDigits)
                .locale(Locale(identifier: "ru_RU"))
        )
    }
}

struct TimePickerSheet: View {
    @Binding var selectedTime: Date
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text("Выберите время")
                .font(.headline)

            DatePicker(
                "",
                selection: $selectedTime,
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
            .environment(\.locale, Locale(identifier: "ru_RU"))

            Button("Готово") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
