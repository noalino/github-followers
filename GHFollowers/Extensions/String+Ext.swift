//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Noalino on 11/01/2024.
//

import Foundation

extension String {

    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.timeZone = .current

        return dateFormatter.date(from: self)
    }

    func convertToDisplayFormat() -> String {
        guard let date = convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
