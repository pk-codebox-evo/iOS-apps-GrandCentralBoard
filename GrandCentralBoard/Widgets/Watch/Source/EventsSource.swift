//
//  EventsSource.swift
//  GrandCentralBoard
//
//  Created by Michał Laskowski on 12.04.2016.
//  Copyright © 2016 Oktawian Chojnacki. All rights reserved.
//

import GCBCore

final class EventsSource: Asynchronous {
    typealias ResultType = Result<[Event]>
    let sourceType: SourceType = .Momentary

    let interval: NSTimeInterval
    let dataProvider: CalendarDataProviding

    init(dataProvider: CalendarDataProviding, refreshInterval: NSTimeInterval = 60) {
        self.interval = refreshInterval
        self.dataProvider = dataProvider
    }

    func read(closure: (ResultType) -> Void) {
        dataProvider.fetchEventsForCalendar { result in
            switch result {
            case .Success(let events): closure(.Success(events))
            case .Failure(let error): closure(.Failure(error))
            }
        }
    }
}
