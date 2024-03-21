//
//  LoggerExtension.swift
//  Socialcademy
//
//  Created by Ancel Dev account on 21/3/24.
//

import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// Logs the view cycles like a view that appeared.
    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")
    
    /// All logs related to tracking and analytics.
    static let statistics = Logger(subsystem: subsystem, category: "statistics")
}
