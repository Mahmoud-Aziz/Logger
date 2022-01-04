//
//  Base.swift
//  Logger
//
//  Created by Mahmoud Aziz on 04/01/2022.
//

import Foundation
import UIKit

class Logger: UIViewController {
  
    //MARK: - Public Helpers
    var logs: [Context]? = [] {
        didSet {
            guard let logs = logs else { return }
            UserDefaults.standard.setEncodablesAsArrayOfDictionaries(logs, for: "logs")
        }
    }
    
    ///Customized Print function for logging
    func print<T>(logLevel: LogLevel, _ input: T..., separator: String = " ", terminator: String = "\n", function: String = #function, file: String = #file, line: Int = #line) {
        let message = input.map { "\($0)" }.joined(separator: separator)
        let level = level(logLevel: logLevel)
        let date = date()
        let context = Context(file: file, function: function, line: line, date: date, item: message, level: logLevel)
        logs?.append(context)
        print(level: level, context: context, separator: separator, terminator: terminator, function: function, file: file, line: line)
    }
    
    //MARK: - Private Helpers
    private func print(level: String, context: Context, separator: String = " ", terminator: String = "\n", function: String = #function, file: String = #file, line: Int = #line) {
    #if DEBUG
        Swift.print("\(level) \(context.description)", terminator: terminator)
    #endif
    }
    
    private func level(logLevel: LogLevel) -> String {
        let levelPrefix = "\(logLevel.prefix)"
        return levelPrefix + " |"
    }
    
    private func date() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: Date())
    }
}
   

