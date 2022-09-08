//
//  OSLog+Extension.swift
//  MyLib
//
//  Created by Matej Malesevic on 24.03.22.
//

import Foundation
import os.log

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier ?? "ch.malesevic.MyLib"
    
    static var api = OSLog(subsystem: subsystem, category: "api")
    static var data = OSLog(subsystem: subsystem, category: "data")
}
