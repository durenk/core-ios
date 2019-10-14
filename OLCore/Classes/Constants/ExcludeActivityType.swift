//
//  ExcludeActivityType.swift
//  DLRadioButton
//
//  Created by Mac User on 14/10/19.
//

import UIKit

public struct ExcludeActivityType {
    public static func defaultExcludeActivityTypes() -> [UIActivity.ActivityType] {
        return [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo
        ]
    }
}
