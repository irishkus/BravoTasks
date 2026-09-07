//
//  DateSelectionView.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 25.06.2026.
//

import SwiftUI

struct DateSelectionView: View {
    @Binding var selectedDate: Date
    @State private var isCalendarPresented = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Дата")
                .font(.subheadline)
                .foregroundStyle(.primary.opacity(0.8))

            Button {
                isCalendarPresented = true
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "calendar")
                        .font(.system(size: 25, weight: .medium))
                        .foregroundStyle(Color.bravoBasicPurple)

                    Text(formattedDate)
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
            .buttonStyle(.plain)
        }
        .padding(.top, 14)
        .sheet(isPresented: $isCalendarPresented) {
            CalendarView(selectedDate: $selectedDate)
                .presentationDetents([.medium])
        }
    }

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM, EEEE"

        return formatter.string(from: selectedDate)
    }
}

struct CalendarView: View {
    @Binding var selectedDate: Date
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        DatePicker(
            "Выберите дату",
            selection: $selectedDate,
            displayedComponents: .date
        )
        .datePickerStyle(.graphical)
        .environment(\.locale, Locale(identifier: "ru_RU"))
        .padding()
        .onChange(of: selectedDate) { _, _ in
            dismiss()
        }
    }
}
