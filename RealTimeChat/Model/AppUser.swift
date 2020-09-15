//
//  AppUser.swift
//  RealTimeChat
//
//  Created by Miyo Alpízar on 14/09/20.
//  Copyright © 2020 Miyo Alpízar. All rights reserved.
//

import Foundation

struct AppUser: Codable {
    var uid: String
    var email: String
    var name: String
    var lastName: String
    var phoneNumber: String
}
