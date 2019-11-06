//
//  CalendarSync.swift
//  Alamofire
//
//  Created by NICKO PRASETIO on 06/11/19.
//

import Foundation
import EventKit

open class CalendarSync{
    public init() {}
    
    open func syncToPhone(title: String,
                          location:  String,
                          startDate: Date,
                          endDate: Date,
                          desc: String){
        let eventStore : EKEventStore = EKEventStore()
        eventStore.requestAccess(to: .event) { (granted, error) in
            if (granted) && (error == nil) {
                let event:EKEvent = EKEvent(eventStore: eventStore)
                event.title = String(format: "%@ - %@", desc, title)
                event.startDate = startDate
                event.location = location
                event.endDate = endDate
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }
}
