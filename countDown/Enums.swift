//
//  Enums.swift
//  countDown
//
//  Created by Mahmut MERCAN on 18.01.2021.
//

import Foundation
import UIKit

enum workTimeSchedule: String, CaseIterable {
    case fiveSeconds
    case tenSeconds
    case thirtySeconds
    case oneMinute
    case fiveMinutes
    case tenMinutes
    case thirtyMinutes
    case oneHour
    
    var workTimeText: String {
        switch self {
        case .fiveSeconds:
            return "5sn"
        case .tenSeconds:
            return "10sn"
        case .thirtySeconds:
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
        case .fiveSeconds:
            return 5
        case .tenSeconds:
            return 10
        case .thirtySeconds:
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

enum restPeriodTimeSchedule: String, CaseIterable {
    case fiveSeconds
    case tenSeconds
    case thirtySeconds
    case oneMinute
    case twoMinutes
    case threeMinutes
    case fiveMinutes
    case tenMinutes
    case thirtyMinutes
    
    var restPeriodTimeText: String {
        switch self {
        case .fiveSeconds:
            return "5 sn"
        case .tenSeconds:
            return "10 sn"
        case .thirtySeconds:
            return "30 sn"
        case .oneMinute:
            return "1 dk"
        case .twoMinutes:
            return "2 dk"
        case .threeMinutes:
            return "3 dk"
        case .fiveMinutes:
            return "5 dk"
        case .tenMinutes:
            return "10 dk"
        case .thirtyMinutes:
            return "30 dk"
        }
    }
    
    var restPeriodTimeToSeconds: Int {
        switch self {
        case .fiveSeconds:
            return 5
        case .tenSeconds:
            return 10
        case .thirtySeconds:
            return 30
        case .oneMinute:
            return 60
        case .twoMinutes:
            return 2*60
        case .threeMinutes:
            return 3*60
        case .fiveMinutes:
            return 5*60
        case .tenMinutes:
            return 10*60
        case .thirtyMinutes:
            return 30*60
        }
    }
}

enum roundSchedule: String, CaseIterable {
    case onetime
    case twice
    case threeTimes
    case fourTimes
    case fiveTimes
    case tenTimes
    case fifteenTimes
    case twentyTimes
    case fiftyTimes
    
    var roundTimesText: String {
        switch self {
        case .onetime:
            return "1 Round"
        case .twice:
            return "2 Round"
        case .threeTimes:
            return "3 Round"
        case .fourTimes:
            return "4 Round"
        case .fiveTimes:
            return "5 Round"
        case .tenTimes:
            return "10 Round"
        case .fifteenTimes:
            return "15 Round"
        case .twentyTimes:
            return "20 Round"
        case .fiftyTimes:
            return "50 Round"
        }
    }
    
    var roundTimes: Int {
        switch self {
        case .onetime:
            return 1
        case .twice:
            return 2
        case .threeTimes:
            return 3
        case .fourTimes:
            return 4
        case .fiveTimes:
            return 5
        case .tenTimes:
            return 10
        case .fifteenTimes:
            return 15
        case .twentyTimes:
            return 20
        case .fiftyTimes:
            return 50
        }
    }
}

extension UIColor {
    convenience init(rgb: UInt) {
       self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }
}


