//
//  DateFormatterHelper.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 08.06.2026.
//

import Foundation

enum DateFormatterHelper {
    static func time(from date: Date) -> String {
        timeFormatter.string(from: date)
    }

    static func dayAndWeekday(from date: Date) -> String {
        dayAndWeekdayFormatter.string(from: date)
    }

    static func fullDate(from date: Date) -> String {
        fullDateFormatter.string(from: date)
    }

    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "HH:mm"
        return formatter
    }()

    private static let dayAndWeekdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM, EEEE"
        return formatter
    }()

    private static let fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM yyyy"
        return formatter
    }()

}
