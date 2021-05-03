//
//  Optional.swift
//  cov-stats
//
//  Created by Antonio Duarte on 2/2/18.
//  Copyright © 2018 Jungle Devs. All rights reserved.
//

import Foundation

extension Optional {
    func convertNilToNull() -> Any {
        return self == nil ? NSNull() : self!
    }
}
