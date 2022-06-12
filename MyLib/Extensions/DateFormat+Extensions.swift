//
//  DateFormat+Extensions.swift
//  MyLib
//
//  Created by Matej Malesevic on 29.05.22.
//

import Foundation

extension DateFormatter {
    static var yearFormatter: DateFormatter {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            return dateFormatter
        }
    }
}
