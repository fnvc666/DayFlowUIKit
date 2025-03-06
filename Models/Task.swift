//
//  Task.swift
//  ToDoListWithDesign
//
//
import Foundation

struct Task: Codable {
    let id: UUID
    var date: Date
    var name: String
    var additionalInfo: String
    var tasktype: String
    var isCompleted: Bool
    var emoji: String
    
    init(date: Date,
        name: String,
        additionalInfo: String,
        tasktype: String,
        isCompleted: Bool,
        emoji: String)
        {
            self.id = UUID()
            self.date = date
            self.name = name
            self.additionalInfo = additionalInfo
            self.tasktype = tasktype
            self.isCompleted = isCompleted
            self.emoji = emoji
        }
}
