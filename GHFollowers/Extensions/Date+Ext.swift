//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Noalino on 11/01/2024.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().year())
    }
}
