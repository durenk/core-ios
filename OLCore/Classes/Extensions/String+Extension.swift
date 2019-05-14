//
//  String+Extension.swift
//  OLCore
//
//  Created by DENZA on 08/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

import Foundation
import SafariServices

extension String {
    static let numberFormatter = NumberFormatter()

    public var doubleValue: Double {
        String.numberFormatter.decimalSeparator = Separator.DecimalEN
        if let result =  String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = Separator.DecimalID
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }

    public var floatValue: Float {
        String.numberFormatter.decimalSeparator = Separator.DecimalEN
        if let result =  String.numberFormatter.number(from: self) {
            return result.floatValue
        } else {
            String.numberFormatter.decimalSeparator = Separator.DecimalID
            if let result = String.numberFormatter.number(from: self) {
                return result.floatValue
            }
        }
        return 0
    }

    public var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }

    public func makeACall() {
        guard let number = URL(string: "tel://" + self) else { return }
        UIApplication.shared.open(number)
    }

    public func withThousandSeparator() -> String {
        return Formatter.thousandSeparator.string(for: Int(self.digits)) ?? DefaultValue.EmptyString
    }

    public func toDate(format: String) -> Date {
        let dateFormatter = DateHelper.dateFormatter
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self) ?? Date()
    }

    public func isValidURL() -> Bool {
        if let url = NSURL(string: self) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }

    public func openURL(sender: UIViewController, delegate: SFSafariViewControllerDelegate? = nil) {
        if isValidURL() {
            if let url = URL(string: self) {
                let safariVC = SFSafariViewController(url: url)
                safariVC.delegate = delegate
                sender.present(safariVC, animated: true, completion: nil)
            }
        }
    }

    public func openDeeplink() -> Bool {
        if isValidURL() {
            if let url = URL(string: self),
                UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    return true
                } else {
                    UIApplication.shared.openURL(url)
                    return true
                }
            }
        }
        return false
    }

    public func formatDBDateStringToFullDateString() -> String {
        let dateFormatter = DateHelper.dateFormatter
        dateFormatter.dateFormat = DateFormat.DBDate
        guard let date = dateFormatter.date(from: self) else {
            return DefaultValue.EmptyString
        }
        dateFormatter.dateFormat = DateFormat.Date
        return dateFormatter.string(from: date)
    }

    public func formatInFullDateToDate() -> Date {
        return self.toDate(format: DateFormat.Date)
    }

    public func formatInPeriodValueToDate() -> Date {
        return self.toDate(format: DateFormat.PeriodValue)
    }

    public func formatInPeriodDBToDate() -> Date {
        return self.toDate(format: DateFormat.PeriodDB)
    }

    public func isValid(regexRule: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regexRule).evaluate(with: self)
    }

    public func toAccessibilityFormat() -> String {
        return self.replacingOccurrences(
            of: Separator.Whitespace,
            with: Separator.AccessibilityId
        ).lowercased()
    }
}
