//
//  ToDoModel.swift
//  ToDoApp
//
//  Created by Himanshu Karamchandani on 21/08/23.
//

import Foundation

struct ToDoModel: Identifiable, Codable {
    var id: String = UUID().uuidString
    let toDoText: String
    let toDoPriority: String
    let toDoDuedate: Date
    var isCompleted: Bool
    let createdOn: Date
    
    init(toDoText: String, toDoPriority: String, toDoDuedate: Date, isCompleted: Bool, createdOn: Date) {
        self.toDoText = toDoText
        self.toDoPriority = toDoPriority
        self.toDoDuedate = toDoDuedate
        self.isCompleted = isCompleted
        self.createdOn = createdOn
    }
    
    mutating func updateCompletionStatus() {
        self.isCompleted = !self.isCompleted
    }
}
