//
//  DateDecodingStrategy.swift
//  cov-stats
//
//  Created by Ígor Yamamoto on 01/04/19.
//  Copyright © 2019 Jungle Devs. All rights reserved.
//

import Foundation

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}

extension JSONDecoder.DateDecodingStrategy {
    static var iso: JSONDecoder.DateDecodingStrategy {
        return JSONDecoder.DateDecodingStrategy.custom { decoder -> Date in
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)
            let rfc3339Formatter = ISO8601DateFormatter([.withInternetDateTime]) // e.g. 2016-06-13T16:00:00+00:00
            let fullDateFormatter = ISO8601DateFormatter([.withFullDate]) // e.g. 2016-06-13
            guard let date = rfc3339Formatter.date(from: string) ?? fullDateFormatter.date(from: string) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
            }
            return date
        }
    }
}
