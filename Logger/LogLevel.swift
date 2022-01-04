//
//  LogLevel.swift
//  Logger
//
//  Created by Mahmoud Aziz on 04/01/2022.
//

import Foundation

enum LogLevel: Codable {
    case info
    case warning
    case error
    
     var prefix: String {
        switch self {
        case .info: return "INFO ℹ️"
        case .warning: return "WARNING ⚠️"
        case .error: return "ERROR ❌"
        }
    }
}
