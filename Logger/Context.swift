//
//  Context.swift
//  Logger
//
//  Created by Mahmoud Aziz on 04/01/2022.
//

import Foundation

struct Context: Codable {
    var file: String
    let function: String
    let line: Int
    let date: String
    let item: String
    let level: LogLevel
    var description: String {
        return "\(level.prefix), date: \(date), file: \((file as NSString).lastPathComponent), line: \(line), function: \(function) => description: \(item)"
    }
}
