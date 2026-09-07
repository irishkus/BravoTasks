//
//  RepeatOption.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 25.06.2026.
//

enum RepeatOption: CaseIterable, Hashable, Identifiable {
    case never
    case daily
    case weekdays
    case weekends
    case weekly
    case monthly
    case yearly
    case custom
    
    var id: Self { self }
    
    func transformation(customDays: Int) -> RepeatType {
        switch self {
        case .never:
            return .never
        case .weekdays:
            return .weekdays
        case .weekends:
            return .weekends
        case .daily:
            return .daily
        case .weekly:
            return .weekly
        case .monthly:
            return .monthly
        case .yearly:
            return .yearly
        case .custom:
            return .everyNDays(customDays)
        }
    }
}
