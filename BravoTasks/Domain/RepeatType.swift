//
//  RepeatType.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 25.06.2026.
//

enum RepeatType: Hashable, Identifiable {
    case never
    case daily
    case weekdays
    case weekends
    case weekly
    case monthly
    case yearly
    case everyNDays(Int)
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .never:
            return "Никогда"
        case .weekdays:
            return "По будням"
        case .weekends:
            return "По выходным"
        case .daily:
            return "Ежедневно"
        case .weekly:
            return "Еженедельно"
        case .monthly:
            return "Ежемесячно"
        case .yearly:
            return "Ежегодно"
        case let .everyNDays(n):
            return "Раз в \(n) дней"
        }
    }
    
    func transformation() -> (RepeatOption, Int) {
        switch self {
        case .never:
            return (.never, 0)
        case .weekdays:
            return (.weekdays, 0)
        case .weekends:
            return (.weekends, 0)
        case .daily:
            return (.daily, 0)
        case .weekly:
            return (.weekly, 0)
        case .monthly:
            return (.monthly, 0)
        case .yearly:
            return (.yearly, 0)
        case let .everyNDays(countDay):
            return (.custom, countDay)
        }
    }
}
