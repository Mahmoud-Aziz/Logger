//
//  Context.swift
//  Logger
//
//  Created by Mahmoud Aziz on 04/01/2022.
//

import Foundation

struct Context: Codable {
    var file: String?
    let function: String?
    let line: Int?
    let date: String?
    let input: String?
    let level: LogLevel?
    var description: String {
        guard let file = file, let function = function, let line = line, let date = date, let item = input, let level = level else { return "" }
        return "\(level.prefix ?? ""), date: \(date), file: \((file as NSString).lastPathComponent), line: \(line), function: \(function) => description: \(item)"
    }
}
