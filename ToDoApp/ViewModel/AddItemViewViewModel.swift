//
//  AddItemViewViewModel.swift
//  ToDoApp
//
//  Created by Himanshu Karamchandani on 22/08/23.
//

import Foundation

class ToDoItemViewModel: ObservableObject {
    @Published var toDoData: [ToDoModel] = [] {
        didSet {
            saveItems()
            
        }
    }
    @Published var topPriorityData: [ToDoModel] = []
    @Published var mediumPriorityData: [ToDoModel] = []
    @Published var lowPriorityData: [ToDoModel] = []
    
    init() {
        
        getItems()
        sortDataByPriority()
    }
    
    func sortDataByPriority() {
        topPriorityData = getItemsByPriority(priority: "TOP")
        mediumPriorityData = getItemsByPriority(priority: "MEDIUM")
        lowPriorityData = getItemsByPriority(priority: "LOW")
    }
    
    func addItem(toDoText: String ,priority: String, dueDate: Date) {
        toDoData.append(
            ToDoModel(
                toDoText: toDoText,
                toDoPriority: priority,
                toDoDuedate: dueDate,
                isCompleted: false,
                createdOn: Date()
            )
        )
    }
    func getItems() {
        guard let data = UserDefaults.standard.data(forKey: "todo_data") else {
            return
        }
            guard let savedItems = try? JSONDecoder().decode([ToDoModel].self, from: data) else {
            return
        }
        self.toDoData = savedItems
    }
    func deleteItems(IndexSet: IndexSet, priority :String) {
        switch priority {
        case "TOP":
            topPriorityData.remove(atOffsets: IndexSet)
        case "MEDIUM":
            mediumPriorityData.remove(atOffsets: IndexSet)
        case "LOW" :
            lowPriorityData.remove(atOffsets: IndexSet)
        default:
            return
        }
        toDoData = topPriorityData + mediumPriorityData + lowPriorityData
    
        
    }
    func moveItems(IndexSet: IndexSet,Int: Int, priority :String) {
        
        
        switch priority {
        case "TOP":
            topPriorityData.move(fromOffsets: IndexSet, toOffset: Int)
        case "MEDIUM":
            mediumPriorityData.move(fromOffsets: IndexSet, toOffset: Int)
        case "LOW" :
            lowPriorityData.move(fromOffsets: IndexSet, toOffset: Int)
        default:
            return
        }
        toDoData = topPriorityData + mediumPriorityData + lowPriorityData
    }
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(toDoData) {
            UserDefaults.standard.set(encodedData, forKey: "todo_data")
        }
        sortDataByPriority()
    }
    func getItemsByPriority(priority :String) -> [ToDoModel] {
        return toDoData.filter { ToDoModel in
            ToDoModel.toDoPriority == priority
        }
    }

    func updateCompletionState(item: ToDoModel) {
        let index = toDoData.firstIndex { toDoData in
            toDoData.id == item.id
           
        }
        toDoData[index ?? 0].updateCompletionStatus()
        
        saveItems()
        
//        var currentData = toDoData.filter { ToDoModel in
//            ToDoModel.id == item.id
//        }
//        currentData[0].updateCompletionStatus()
    }
}
