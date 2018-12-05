//
//  Task.swift
//  IOS Task Manager
//
//  Created by Miranda Jessie on 11/28/18.
//  Copyright © 2018 Miranda Jessie. All rights reserved.
//

import Foundation

let calendar = Calendar(identifier: .gregorian)
let dueDate = calendar.date(byAdding: .day, value: 7, to: Date())!

//Task data model
class Task { //Each task needs at least a name, description, completed, and priority
    
    //Priority
    enum Priority: String {
        case priority = " ‼️ "
        case notPriority = "  "
    }
    
    //Marks if the task is complete or not
    enum Completion {
        case complete
        //Adds due date if task is incomplete
        case incomplete(dueDate: Date)
    }
    //Properties
    let taskName: String
    let taskDetails: String
    let priority: Priority
    var completion: Completion
    
    init(taskName: String, taskDetails: String, priority: Priority) {
        self.taskName = taskName
        self.taskDetails = taskDetails
        self.priority = priority
        self.completion = .incomplete(dueDate: dueDate)
    }
}
