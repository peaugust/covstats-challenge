//
//  User.swift
//  cov-stats
//
//  Created by Antonio Duarte on 2/2/18.
//  Copyright © 2018 Jungle Devs. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int
    let email: String
    let firstName: String
    let lastName: String
}
