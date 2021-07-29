//
//  Task+CoreDataClass.swift
//  ProjectManager
//
//  Created by Ryan-Son on 2021/07/29.
//
//

import Foundation
import CoreData

@objc(Task)
public final class Task: NSManagedObject, Codable {

    static let entityName = "Task"

    enum State: String, Codable {
        case todo, doing, done
    }

    enum CodingKeys: String, CodingKey {
        case id, title, body, dueDate, state
    }

    public convenience init(from decoder: Decoder) throws {
        let managedObjectContext = TaskCoreDataStack.shared.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: Task.entityName, in: managedObjectContext) else {
            print("Failed to retrieve managed object context.")
            throw PMError.decodingFailed
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.body = try container.decode(String.self, forKey: .body)
        self.dueDate = try container.decode(Date.self, forKey: .dueDate)
        self.state = try container.decode(String.self, forKey: .state)

        try managedObjectContext.save()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(body, forKey: .body)
        try container.encode(dueDate, forKey: .dueDate)
        try container.encode(state, forKey: .state)
    }
}
