//
//  Enums.swift
//  countDown
//
//  Created by Mahmut MERCAN on 18.01.2021.
//

import Foundation
import UIKit

//enum Seconds: Int, CaseIterable {
//    case secondsTime0, secondsTime1, secondsTime2, secondsTime3
//    static let allValues = [1, 5, 10, 30, 59, 5*60] as [Any]
//}
//
//enum WorkTime: Int, CaseIterable {
//    case workTime0, workTime1, workTime2, workTime3
//    static let allValues = [1, 5, 10, 30, 59, 5*60] as [Any]
//}

enum workTimeSchedule: String, CaseIterable {
    case fiveSecond
    case tenSecond
    case thirtySecond
    case oneMinute
    case fiveMinutes
    case tenMinutes
    case thirtyMinutes
    case oneHour
    
    var workTimeText: String {
        switch self {
        case .fiveSecond:
            return "5sn"
        case .tenSecond:
            return "10sn"
        case .thirtySecond:
            return "30sn"
        case .oneMinute:
            return "1dk"
        case .fiveMinutes:
            return "5dk"
        case .tenMinutes:
            return "10dk"
        case .thirtyMinutes:
            return "30dk"
        case .oneHour:
            return "1 saat"
        }
    }
    
    var workTimeToSeconds: Int {
        switch self {
        case .fiveSecond:
            return 5
        case .tenSecond:
            return 10
        case .thirtySecond:
            return 30
        case .oneMinute:
            return 60
        case .fiveMinutes:
            return 5*60
        case .tenMinutes:
            return 10*60
        case .thirtyMinutes:
            return 30*60
        case .oneHour:
            return 60*60
        }
    }
}
