//
//  DateComponentsExtension.swift
//  VTComponents-iOS
//
//  Created by Robin Rajasekaran on 30/01/20.
//

import Foundation

public extension DateComponents {
    static let allComponentsSet: Set<Calendar.Component> = [.era, .year, .month, .day, .hour, .minute, .second, .weekday, .weekdayOrdinal, .quarter, .weekOfMonth, .weekOfYear, .yearForWeekOfYear, .nanosecond, .calendar, .timeZone]
}
