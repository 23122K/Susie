import CoreData
import Foundation

class CoreDataManager {
    let persistentContiner: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        persistentContiner.viewContext
    }
    
    func persist() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
        }
    }
    
    
    func delete<T: NSManagedObject>(_ objects: [T]) {
        for object in objects {
            viewContext.delete(object)
        }
        self.persist()
    }
    
    //MARK: Init
    private init() {
        persistentContiner = NSPersistentContainer(name: "Susie")
        persistentContiner.loadPersistentStores{ (dsc, err) in
            if let err = err { fatalError(err.localizedDescription) }
        }
    }
}
