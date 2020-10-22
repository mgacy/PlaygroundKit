//
//  Logger.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 10/7/20.
//  Copyright © 2020 Mathew Gacy. All rights reserved.
//

public struct Logger: LoggingType {
    public typealias Formatter = (String, String, String, Int) -> String

    public static var formatter: Formatter = { "\($2):\($3) - \($0)" } // "function:line - message"
    //public static var formatter: Formatter = { "\($1).\($2):\($3) - \($0)" } // "file.function:line - message"

    //public init() {}

    // MARK: LoggingType

    public static func verbose(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        print(Logger.formatter(message, file, function, line))
    }

    public static func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        print(Logger.formatter(message, file, function, line))
    }

    public static func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        print(Logger.formatter(message, file, function, line))
    }

    public static func warning(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        print(Logger.formatter(message, file, function, line))
    }

    public static func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        print(Logger.formatter(message, file, function, line))
    }
}

//public let log = Logger.self
