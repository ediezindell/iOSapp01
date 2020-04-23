import UIKit
import CoreData

class DataController: NSObject {
    var persistentContainer: NSPersistentContainer!

    init(completionClosure: @escaping () -> ()) {
        persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completionClosure()
        }
    }
    

    // 以下もっと追加していくよー

}
