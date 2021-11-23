//
//  Date + DataFormatter.swift
//  VK_Nikita
//
//  Created by Никита Троян on 04.11.2021.
//

import UIKit

extension DateFormatter {
  static let yyyyMMdd: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}

extension Date {
    init?(yyyyMMdd: String) {
        guard let date = DateFormatter.yyyyMMdd.date(from: yyyyMMdd) else { return nil }
        self.init(timeInterval: 0, since: date)
    }

    init(dateLiteralString yyyyMMdd: String) {
        let date = DateFormatter.yyyyMMdd.date(from: yyyyMMdd)!
        self.init(timeInterval: 0, since: date)
    }
}
