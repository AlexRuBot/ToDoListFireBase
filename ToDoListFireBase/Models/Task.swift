//
//  Tasks.swift
//  ToDoListFireBase
//
//  Created by Саша Гужавин on 01.08.2021.
//

import Foundation
import Firebase

struct Task {
    let title: String
    let userId: String
    let ref: DatabaseReference?
    var completed: Bool = false
    
    init(title:String, userId: String) {
        self.title = title
        self.userId = userId
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        title = snapshotValue["title"] as! String
        userId = snapshotValue["userId"] as! String
        ref = snapshot.ref
        completed = snapshotValue["completed"] as! Bool
    }
}
