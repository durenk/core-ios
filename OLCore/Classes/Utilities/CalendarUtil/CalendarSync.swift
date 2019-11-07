//
//  CalendarSync.swift
//  Alamofire
//
//  Created by NICKO PRASETIO on 06/11/19.
//

import Foundation
import EventKit
import EventKitUI

open class CalendarSync{
    
    public static func syncToPhone(
        eventCalendar: EventCalendar,
        completion: @escaping (_ isSuccess: Bool) -> Void
    ) {
        let eventStore: EKEventStore = EKEventStore()
        eventStore.requestAccess(to: .event) { (granted, error) in
            if granted && error == nil {
                let event: EKEvent = EKEvent(eventStore: eventStore)
                event.title = eventCalendar.title
                event.startDate = eventCalendar.startDate
                event.endDate = eventCalendar.endDate
                event.location = eventCalendar.location
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                    completion(true)
                } catch {
                    completion(false)
                }
            }
        }
    }

    public static func syncToCalendarDetails(
        eventCalendar: EventCalendar,
        completion: @escaping (_ eventViewController: EKEventEditViewController) -> Void
    ) {
        let eventStore: EKEventStore = EKEventStore()
        eventStore.requestAccess(to: .event) { (granted, error) in
            if granted && error == nil {
                let event: EKEvent = EKEvent(eventStore: eventStore)
                event.title = eventCalendar.title
                event.startDate = eventCalendar.startDate
                event.endDate = eventCalendar.endDate
                event.location = eventCalendar.location
                event.calendar = eventStore.defaultCalendarForNewEvents
                let eventViewController: EKEventEditViewController = EKEventEditViewController()
                eventViewController.event = event
                eventViewController.eventStore = eventStore
                do {
                    try eventStore.save(event, span: .thisEvent)
                    completion(eventViewController)
                } catch {
                    completion(eventViewController)
                }
            }
        }
    }
}
