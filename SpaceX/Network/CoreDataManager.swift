//
//  DataManager.swift
//  SpaceX
//
//  Created by Abbut john on 16/06/2021.
//

import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SpaceX")
        container.loadPersistentStores(completionHandler: { _, error in
            _ = error.map { fatalError("Unresolved error \($0)") }
        })
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func backgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    
    // MARK: - Static Calls

    static func saveRocket(id: String, image: UIImage) {
        
        let mainContext = CoreDataManager.shared.mainContext
        let entity =
            NSEntityDescription.entity(forEntityName: "RocketImage",
                                       in: mainContext)!
        let rocketImageInfo = NSManagedObject(entity: entity,
                                              insertInto: mainContext)
        rocketImageInfo.setValue(id, forKeyPath: "id")
        rocketImageInfo.setValue(image.jpegData(compressionQuality: 1), forKeyPath: "image")
        do {
            try mainContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    static func loadImage(withId : String) -> [RocketImage]{
        let mainContext = CoreDataManager.shared.mainContext
        let fetchRequest: NSFetchRequest<RocketImage> = RocketImage.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", withId)
        do {
            let result = try mainContext.fetch(fetchRequest)
            return result
        }
        catch {
            debugPrint(error)
        }
        return []
    }
    
    static func IsImageExistInDb(withId : String) -> Bool{
        let mainContext = CoreDataManager.shared.mainContext
        let fetchRequest: NSFetchRequest<RocketImage> = RocketImage.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", withId)
        do {
            let result = try mainContext.fetch(fetchRequest)
            return result.count > 0 ? true : false
        }
        catch {
            debugPrint(error)
        }
        return false
    }    
}
