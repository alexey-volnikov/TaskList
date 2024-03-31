//
//  DataStore.swift
//  TaskList
//
//  Created by Алексей Вольников on 31.03.2024.
//

import CoreData

final class DataStore {
    static let shared = DataStore() 
    
    internal lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskList")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private init() {} 
    
    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Core Data Delete Data
    func deleteTask(_ task: ToDoTask) {
        let context = persistentContainer.viewContext
        context.delete(task)
        saveContext()
    }
}
