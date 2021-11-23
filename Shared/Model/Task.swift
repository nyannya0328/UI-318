//
//  Task.swift
//  UI-318 (iOS)
//
//  Created by nyannyan0328 on 2021/09/30.
//

import SwiftUI

struct Task: Identifiable {
    
    var id = UUID().uuidString
    var title : String
    var time : Date = Date()
    
}
struct TaskMetaData : Identifiable{
    
    var id = UUID().uuidString
    var task : [Task]
    var taskDate : Date
    
}
func getSampleData(offset : Int)->Date{
    
    let calender = Calendar.current
    
    let date = calender.date(byAdding: .day, value: offset, to: Date())
    
    
    return date ?? Date()
}

var tasks : [TaskMetaData] = [

TaskMetaData(task: [
    
    Task(title: "Talk to PAPA"),
    Task(title: "I love papa"),
    Task(title: "By daughter"),

], taskDate: getSampleData(offset: 1)),

TaskMetaData(task: [
    
    Task(title: "Talk to PAPA"),
    Task(title: "I love papa"),
    Task(title: "Allwasy happy"),

], taskDate: getSampleData(offset: -22)),

TaskMetaData(task: [
    
    Task(title: "Talk to PAPA"),
    Task(title: "I love papa"),
    Task(title: "Allwasy happy"),

], taskDate: getSampleData(offset: -10))

]
