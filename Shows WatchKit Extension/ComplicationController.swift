//
//  ComplicationController.swift
//  Shows WatchKit Extension
//
//  Created by karthi on 2/11/17.
//  Copyright © 2017 tringapps. All rights reserved.
//

import ClockKit

struct Show {
    var name: String
    var shortName: String?
    var genre: String
    var startDate: NSDate
    var length: TimeInterval
}

let hour: TimeInterval = 60 * 60
let shows = [
    Show(name: "Rush Hour", shortName: "Rush Hour", genre: "Action", startDate: NSDate(timeIntervalSinceNow: 0), length: hour ),
    Show(name: "Spectre", shortName: nil, genre: "Drama", startDate: NSDate(timeIntervalSinceNow: hour ), length: hour),
    Show(name: "Die Hard", shortName: "Action", genre: "Documentary", startDate: NSDate(timeIntervalSinceNow: hour * 2), length: hour),
    Show(name: "Rambo", shortName: nil, genre: "Action", startDate: NSDate(timeIntervalSinceNow: hour * 3), length: hour)
]
class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        let date = NSDate(timeIntervalSinceNow: hour * 3)
        handler(date as Date)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        let show = shows[0]
        let template = CLKComplicationTemplateModularLargeStandardBody()
        
        template.headerTextProvider = CLKTimeIntervalTextProvider(start: show.startDate as Date, end: NSDate(timeInterval: show.length, since: show.startDate as Date) as Date)
        template.body1TextProvider = CLKSimpleTextProvider(text: show.name, shortText: show.shortName)
        template.body2TextProvider = CLKSimpleTextProvider(text: show.genre, shortText: nil)
        
        let entry = CLKComplicationTimelineEntry(date: NSDate(timeInterval: hour * -0.25, since: show.startDate as Date) as Date, complicationTemplate: template)
        handler(entry)
        // Call the handler with the current timeline entry
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        
        handler(nil)
        // Call the handler with the timeline entries prior to the given date
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        
            // Call the handler with the timeline entries after to the given date
            
            var entries: [CLKComplicationTimelineEntry] = []
            
            for show in shows
            {
                if entries.count < limit && show.startDate.timeIntervalSince(date as Date) > 0
                {
                    let template = CLKComplicationTemplateModularLargeStandardBody()
                    
                    template.headerTextProvider = CLKTimeIntervalTextProvider(start: show.startDate as Date, end: NSDate(timeInterval: show.length, since: show.startDate as Date) as Date)
                    template.body1TextProvider = CLKSimpleTextProvider(text: show.name, shortText: show.shortName)
                    template.body2TextProvider = CLKSimpleTextProvider(text: show.genre, shortText: nil)
                    
                    let entry = CLKComplicationTimelineEntry(date: NSDate(timeInterval: hour * -0.25, since: show.startDate as Date) as Date, complicationTemplate: template)
                    entries.append(entry)
                }
            }
            
            handler(entries)
        
        // Call the handler with the timeline entries after to the given date
      
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        let template = CLKComplicationTemplateModularLargeStandardBody()
        
        template.headerTextProvider = CLKTimeIntervalTextProvider(start: NSDate() as Date, end: NSDate(timeIntervalSinceNow: 60 * 60 * 0.05) as Date)
        template.body1TextProvider = CLKSimpleTextProvider(text: "Show Name", shortText: "Name")
        template.body2TextProvider = CLKSimpleTextProvider(text: "Show Genre", shortText: nil)
        
        handler(template)
        // This method will be called once per supported complication, and the results will be cached
       
    }
    
}
