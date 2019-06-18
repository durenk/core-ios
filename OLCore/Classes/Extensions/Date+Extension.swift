//
//  Date+Extension.swift
//  OLCore
//
//  Created by DENZA on 08/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public extension Date {
    public func formatInMonth() -> String {
        return formatIn(format: DateFormat.Month)
    }

    public func formatInFullDate() -> String {
        return formatIn(format: DateFormat.Date)
    }
    
    public func formatInDay() -> String {
        return formatIn(format: DateFormat.Day)
    }

    public func formatInDayWithMonth() -> String {
        return formatIn(format: DateFormat.DayWithMonth)
    }

    public func formatInPeriodDisplay() -> String {
        return formatIn(format: DateFormat.PeriodDisplay)
    }

    public func formatInPeriodValue() -> Int {
        return Int(formatIn(format: DateFormat.PeriodValue)) ?? DefaultValue.EmptyInt
    }

    public func formatInPeriodDB() -> String {
        return formatIn(format: DateFormat.PeriodDB)
    }

    public func formatInDBDate() -> String {
        return formatIn(format: DateFormat.DBDate)
    }

    public func formatIn(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Language.Bahasa)
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    public func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        return end - start
    }

    public func getNextMonth(_ numberOfMonths: Int = 1) -> Date {
        return Calendar.current.date(byAdding: .month, value: numberOfMonths, to: self) ?? self
    }

    public func getNextMonth(_ numberOfMonths: Int = 1) -> Int64 {
        return Int64(getNextMonth(numberOfMonths).timeIntervalSince1970)
    }

    public func getPreviousMonth(_ numberOfMonths: Int = 1) -> Date {
        return Calendar.current.date(byAdding: .month, value: numberOfMonths * -1, to: self) ?? self
    }

    public func getPreviousMonth(_ numberOfMonths: Int = 1) -> Int64 {
        return Int64(getPreviousMonth(numberOfMonths).timeIntervalSince1970)
    }

    public func getNextDay(_ numberOfDays: Int = 1) -> Date {
        return Calendar.current.date(byAdding: .day, value: numberOfDays, to: self) ?? self
    }

    public func getNextDay(_ numberOfDays: Int = 1) -> Int64 {
        return Int64(getNextDay(numberOfDays).timeIntervalSince1970)
    }

    public func getPreviousDay(_ numberOfDays: Int = 1) -> Date {
        return Calendar.current.date(byAdding: .day, value: numberOfDays * -1, to: self) ?? self
    }

    public func getPreviousDay(_ numberOfDays: Int = 1) -> Int64 {
        return Int64(getPreviousDay(numberOfDays).timeIntervalSince1970)
    }

    public func getNextSecond(_ numberOfSeconds: Int = 1) -> Date {
        return Calendar.current.date(byAdding: .second, value: numberOfSeconds, to: self) ?? self
    }

    public func getNextSecond(_ numberOfSeconds: Int = 1) -> Int64 {
        return Int64(getNextSecond(numberOfSeconds).timeIntervalSince1970)
    }

    public func getFirstDayOfTheMonthInUnixTimestamp() -> Int64 {
        let date = Date()
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: date)
        let startOfMonth = Calendar.current.date(from: comp)!
        return startOfMonth.toUnixTimestamp()
    }

    public static func currentUnixTimestamp() -> Int64 {
        return Int64(Date().timeIntervalSince1970)
    }

    public func toUnixTimestamp() -> Int64 {
        return Int64(self.timeIntervalSince1970)
    }

    public static func fromUnixTimestamp(_ unixTimestamp: Int64) -> Date {
        return Date(timeIntervalSince1970: Double(unixTimestamp))
    }

    public func getTime(interval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: interval)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = DateFormat.Time
        let strDate = dateFormatter.string(from: date)
        return strDate
    }

    public func removeTime() -> Date {
        return self.formatInFullDate().formatInFullDateToDate()
    }

    public static func currentDate() -> Date {
        return Date().removeTime()
    }

    public static func currentDate() -> Int64 {
        return Int64(currentDate().timeIntervalSince1970)
    }

    public func displayRange(until: Date) -> String {
        let calendar = Calendar.current
        let startYear = calendar.component(.year, from: self)
        let endYear = calendar.component(.year, from: until)
        let fullFormat = DateFormatter()
        fullFormat.locale = Locale(identifier: Language.Bahasa)
        fullFormat.dateFormat = DateFormat.Date
        if startYear == endYear {
            let periodFormat = DateFormatter()
            periodFormat.locale = Locale(identifier: Language.Bahasa)
            periodFormat.dateFormat = DateFormat.DayWithMonth
            return "\(periodFormat.string(from: self)) \(Separator.RangePeriod) \(fullFormat.string(from: until))"
        }
        return "\(fullFormat.string(from: self)) \(Separator.RangePeriod) \(fullFormat.string(from: until))"
    }

    public func getHumanDate(interval: TimeInterval, todayText: String, yesterdayText: String) -> String {
        let calendar = Calendar.current
        let date = Date(timeIntervalSince1970: interval)
        if calendar.isDateInYesterday(date) {
            return yesterdayText
        }
        if calendar.isDateInToday(date) {
            return todayText
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = DateFormat.Date
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
