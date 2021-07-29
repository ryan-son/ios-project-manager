//
//  TaskCoreDataStack.swift
//  ProjectManager
//
//  Created by Ryan-Son on 2021/07/29.
//

import CoreData

struct TaskCoreDataStack {

    static let persistentContainerName = "ProjectManager"
    static let shared = TaskCoreDataStack()

    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: TaskCoreDataStack.persistentContainerName)
        container.loadPersistentStores { (_, error) in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

            if let error = error as NSError? {
                print(error)
            }
        }
        return container
    }()

    private init() { }

    func saveContext() {
        let context = persistentContainer.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                print(error)
            }
        }
    }

    func parse(_ jsonData: Data) -> Bool {
        do {
            let managedObjectContext = persistentContainer.viewContext
            let decoder = JSONDecoder()
            _ = try decoder.decode([Task].self, from: jsonData)
            try managedObjectContext.save()

            return true
        } catch {
            print(error)
            return false
        }
    }

    func fetchTasks() -> [Task] {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Task>(entityName: Task.entityName)

        do {
            let tasks = try managedObjectContext.fetch(fetchRequest)
            return tasks
        } catch let error {
            print(error)
            return []
        }
    }
}
