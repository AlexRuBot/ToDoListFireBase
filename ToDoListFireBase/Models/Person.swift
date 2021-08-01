//
//  User.swift
//  ToDoListFireBase
//
//  Created by Саша Гужавин on 01.08.2021.
//

import Foundation
import Firebase

struct Person {
    
    let uid: String
    let email: String
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email!
    }
}
