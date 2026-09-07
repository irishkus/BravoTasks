//
//  RepetitionOptionsView.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 25.06.2026.
//

import SwiftUI

struct RepetitionOptionsView: View {
    @Binding var repeatType: RepeatType

    @State private var selectedOption: RepeatOption
    @State private var customDays: Int

    @Environment(\.dismiss) private var dismiss

    init(repeatType: Binding<RepeatType>) {
        _repeatType = repeatType

        switch repeatType.wrappedValue {
        case .never:
            _selectedOption = State(initialValue: .never)
            _customDays = State(initialValue: 0)

        case .daily:
            _selectedOption = State(initialValue: .daily)
            _customDays = State(initialValue: 0)

        case .weekly:
            _selectedOption = State(initialValue: .weekly)
            _customDays = State(initialValue: 0)

        case .monthly:
            _selectedOption = State(initialValue: .monthly)
            _customDays = State(initialValue: 0)
            
        case .yearly:
            _selectedOption = State(initialValue: .yearly)
            _customDays = State(initialValue: 0)
            
        case .weekdays:
            _selectedOption = State(initialValue: .weekdays)
            _customDays = State(initialValue: 0)
            
        case .weekends:
            _selectedOption = State(initialValue: .weekends)
            _customDays = State(initialValue: 0)

        case .everyNDays(let days):
            _selectedOption = State(initialValue: .custom)
            _customDays = State(initialValue: days)
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Повторение")
                .font(.headline)

            Picker("Повторение", selection: $selectedOption) {
                ForEach(RepeatOption.allCases) { option in
                    Text(option.transformation(customDays: customDays).title)
                        .tag(option)
                }
            }
            .pickerStyle(.wheel)

            if selectedOption == .custom {
                Stepper(
                    "Каждые \(customDays) дней",
                    value: $customDays,
                    in: 2...365
                )
                .padding(.horizontal)
            }

            Button("Готово") {
                saveSelection()
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onAppear {
            print("RepetitionOptionsView появился")
        }
        .onDisappear {
            print("RepetitionOptionsView закрылся")
        }
    }

    private func saveSelection() {
        switch selectedOption {
        case .never:
            repeatType = .never

        case .daily:
            repeatType = .daily

        case .weekly:
            repeatType = .weekly

        case .monthly:
            repeatType = .monthly
            
        case .yearly:
            repeatType = .yearly
            
        case .weekdays:
            repeatType = .weekdays
            
        case .weekends:
            repeatType = .weekends

        case .custom:
            repeatType = .everyNDays(customDays)
        }
    }
}
