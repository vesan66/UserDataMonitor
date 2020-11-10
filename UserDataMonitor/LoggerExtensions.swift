//
//  LoggerExtensions.swift
//  UserDataMonitor
//
//  Created by Dirk Scheidt on 07.10.20.
//

import Foundation
import os.log

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// Logs the view cycles like viewDidLoad.
    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")
    
    /// Log data informations like returnvalues or entryvalues.
    static let data = Logger(subsystem: subsystem, category: "data")
    
    /// Normal. Daily use.
    static let log = Logger(subsystem: subsystem, category: "normal")
    
    /// Function start
    static let funcStart = Logger(subsystem: subsystem, category: "function start")
}
