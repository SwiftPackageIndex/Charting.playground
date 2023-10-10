import Foundation


extension Calendar {
    public func lastDayOfMonth(of date: Date = .now) -> Date? {
        guard let nextFirst = Calendar.current.nextDate(after: date, matching: .init(day: 1), matchingPolicy: .strict)
        else { return nil }
        return Calendar.current.date(byAdding: .day, value: -1, to: nextFirst)
    }

    public func lastDayOfPreviousMonth(of date: Date = .now) -> Date? {
        guard let lastDayOfMonth = lastDayOfMonth(of: date) else { return nil }
        return Calendar.current.date(byAdding: .month, value: -1, to: lastDayOfMonth)
    }

    public func yearlyLastDaysOfMonth(from start: Date, to end: Date = .now) -> [Date] {
        var current: Date = end
        var dates = [Date]()
        while current >= start {
            defer {
                current = Calendar.current.date(byAdding: .year, value: -1, to: current)!
            }
            dates.append(Calendar.current.lastDayOfMonth(of: current)!)
        }
        return dates.reversed()
    }

    public func yearlyLastDaysOfPreviousMonth(from start: Date, to end: Date = .now) -> [Date] {
        var current: Date = end
        var dates = [Date]()
        while current >= start {
            defer {
                current = Calendar.current.date(byAdding: .year, value: -1, to: current)!
            }
            dates.append(Calendar.current.lastDayOfPreviousMonth(of: current)!)
        }
        return dates.reversed()
    }

    public func plausibleParameters(from start: Date, to end: Date = .now) -> [Plausible.Parameters] {
        yearlyLastDaysOfPreviousMonth(from: start, to: end)
            .map {
                .init(period: .twelveMonths, date: $0)
            }
    }
}

