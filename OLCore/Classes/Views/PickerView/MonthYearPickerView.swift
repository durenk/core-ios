//  Created by Ben Dodson on 15/04/2015.
//  Modified by Jiayang Miao on 24/10/2016 to support Swift 3
//  Modified by David Luque on 24/01/2018 to get default date
//  Modified by Aldo Lazuardi on 25/09/2019 to add Minimum, Maximum Year, Input default date

import UIKit

open class MonthYearPickerView: UIPickerView {
    var minimumDate = Date()
    var maximumDate = Date()
    var defaultDate = Date() {
        didSet {
            goToDefaultDate()
        }
    }
    var months: [String] = []
    var years: [Int] = []
    var locale: Locale = Locale(identifier: DateLocale.indonesian)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonSetup()
    }
    
    public init(frame: CGRect, minimumDate: Date = Date(), maximumDate: Date = Date()) {
        super.init(frame: frame)
        self.minimumDate = minimumDate
        self.maximumDate = maximumDate
        self.commonSetup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonSetup()
    }
    
    func commonSetup() {
        var years: [Int] = []
        if years.count == 0 {
            guard let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian) else { return }
            let minimumYear = calendar.component(.year, from: minimumDate)
            let maximumYear = calendar.component(.year, from: maximumDate)
            for year in minimumYear...maximumYear {
                years.append(year)
            }
        }
        self.years = years
        
        var months: [String] = []
        var month = 0
        let formatter = DateFormatter()
        formatter.locale = self.locale
        for _ in 1...12 {
            months.append(formatter.monthSymbols[month].capitalized)
            month += 1
        }
        self.months = months
        
        self.delegate = self
        self.dataSource = self
        self.goToDefaultDate()
    }
    
    func goToDefaultDate() {
        resetMonth()
        resetYear()
    }
    
    func resetMonth() {
        guard let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian) else { return }
        let currentMonth = calendar.component(.month, from: defaultDate)
        self.selectRow(currentMonth - 1, inComponent: 0, animated: true)
    }
    
    func resetYear() {
        guard let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian) else { return }
        let currentYear = calendar.component(.year, from: defaultDate)
        self.selectRow(years.firstIndex(where: { $0 == currentYear }) ?? 0, inComponent: 1, animated: true)
    }
    
}

extension MonthYearPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return months[row]
        case 1:
            return "\(years[row])"
        default:
            return nil
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return months.count
        case 1:
            return years.count
        default:
            return 0
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let month = self.selectedRow(inComponent: 0)+1
        let year = years[self.selectedRow(inComponent: 1)]
        let calendar = Calendar.current
        var dateComponents: DateComponents = calendar.dateComponents([.hour, .minute, .second], from: Date())
        dateComponents.day = 1
        dateComponents.month = month
        dateComponents.year = year
        let currentPeriod = calendar.date(from: dateComponents) ?? Date()
        if currentPeriod.formatInPeriodValue() < minimumDate.formatInPeriodValue() || currentPeriod.formatInPeriodValue() > maximumDate.formatInPeriodValue() {
            component == 0 ? resetMonth() : resetYear()
            return
        }
        self.defaultDate = currentPeriod
    }
}
