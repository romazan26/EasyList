//
//  CoreDataManager.swift
//  EasyList
//
//  Created by Роман on 13.01.2025.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let instance = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "EasyList")
        container.loadPersistentStores { descption, error in
            if let error = error{
                print("Error looading core data\(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        }catch let error {
            print("Save data erroe \(error.localizedDescription)")
        }
        
    }
}
