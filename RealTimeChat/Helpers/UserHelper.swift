//
//  UserHelper.swift
//  RealTimeChat
//
//  Created by Miyo Alpízar on 14/09/20.
//  Copyright © 2020 Miyo Alpízar. All rights reserved.
//

import Firebase
import CodableFirebase

class  UserHelper {
    
    private static let _shared = UserHelper()
    
    public static var shared: UserHelper {
        return _shared
    }
    
    public func IsUserIn() -> Bool {
        return CurrentUser() != nil
    }
    
    public func CurrentUser() -> AppUser? {
        logOut()
        if let user = Auth.auth().currentUser {
            let u = AppUser(uid: user.uid,email: user.email ?? "No Email", name: user.displayName ?? "No name", lastName: "", phoneNumber: "")
            return u
        }
        return nil
    }
    
    public func registerUser(email: String,
                             name: String,
                             lastName: String,
                             phone: String,
                             pwd: String,
                             completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: pwd) { (result, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let result = result else {
                completion(.failure(NSError(domain: "Error on Firebase", code: -1, userInfo: nil)))
                return
            }
            self.addUser(user: AppUser(uid: result.user.uid, email: email, name: name, lastName: lastName, phoneNumber: phone)) { (res) in
                switch res {
                case .success(_):
                    completion(.success(result.user.uid))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func addUser(user: AppUser, completion: @escaping(Result<Bool, Error>) -> Void) {
        let docData = try! FirestoreEncoder().encode(user)
        DatabaseHelper.shared.database.child(DatabaseHelper.shared.users).child(user.uid).setValue(docData) { (error, ref) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    public func login(email: String, pwd: String, completion: @escaping(Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pwd) { (result, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let result = result {
                print(result)
                completion(.success(true))
                return
            }
            completion(.success(false))
        }
    }
    
    public func logOut() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("already logged out")
        }
    }
    
    public func sendEmailToRecoveryPassword(with email: String, completion: @escaping(Result<Bool, Error>)  -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                completion(.failure(error))
            }else {
                completion(.success(true))
            }
        }
    }
}



