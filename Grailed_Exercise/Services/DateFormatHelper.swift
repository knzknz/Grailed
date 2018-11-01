//
//  DateFormatterHelper.swift
//  Grailed_Exercise
//
//  Created by C4Q on 11/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

func formatDate(from str: String) -> String {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withFullDate,
                               .withDashSeparatorInDate,
                               .withColonSeparatorInTime,
                               .withTime]
    let formattedDate = formatter.date(from: str)!
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "MMMM dd,yyyy"
    let dateStr = dateFormatterPrint.string(from: formattedDate)
    return dateStr
}
