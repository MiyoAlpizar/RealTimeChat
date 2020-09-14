//
//  UserHelper.swift
//  RealTimeChat
//
//  Created by Miyo Alpízar on 14/09/20.
//  Copyright © 2020 Miyo Alpízar. All rights reserved.
//

import Firebase

class  UserHelper {
    
    private static let _shared = UserHelper()
    
    public static var shared: UserHelper {
        return _shared
    }
    
    public func IsUserIn() -> Bool {
        return CurrentUser() != nil
    }
    
    public func CurrentUser() -> AppUser? {
        if let user = Auth.auth().currentUser {
            let u = AppUser(email: user.email ?? "No Email", name: user.displayName ?? "No name")
            return u
        }
        return nil
    }
}



