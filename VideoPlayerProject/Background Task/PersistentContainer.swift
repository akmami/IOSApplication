//
//  PersistentContainer.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-03.
//

import CoreData


class PersistentContainer: NSPersistentContainer {

    func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
        let context = backgroundContext ?? viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
}
