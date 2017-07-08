//
//  CoreDataHandler.swift
//  SpotifyTag
//
//  Created by Guilherme Carvalho on 25/06/2017.
//  Copyright © 2017 gboxx. All rights reserved.
//

import Foundation
import Sync

class CoreDataHandler {
    
    var dataStack:DataStack
    
    // Dependency injection for testing
    init(dataStack: DataStack) {
        self.dataStack = dataStack
    }
    
    internal func getEntity<T>(entity:String) -> [T] where T: NSManagedObject {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let entities = (try! self.dataStack.mainContext.fetch(request)) as! [T]
        return entities
    }
    
    internal func replaceEntities<T>(json:[[String:Any]], name:String,
                             completionHandler: (([T]?) -> ())? = nil //Optional completion handler passing saved objects
        ) where T: NSManagedObject
    {
        self.dataStack.sync(json, inEntityNamed: name) { (error) in
            if error != nil {
                print(error!)
            }
        
            if completionHandler != nil {
                let e = self.getEntity(entity: name) as? [T]
                completionHandler!(e)
            }
            
        }
    }
    
    internal func appendEntities<T>(json:[[String:Any]], name:String,
                                 completionHandler: (([T]?) -> ())? = nil //Optional completion handler passing saved objects
        ) where T: NSManagedObject
    {
        var appJson = json;
        if let oldents = self.getEntity(entity: name) as? [T] {
            for entity in oldents {
                appJson.append(entity.export())
            }
        }
        
        
        self.dataStack.sync(appJson, inEntityNamed: name) { (error) in
            if error != nil {
                print(error!)
            }
            
            if completionHandler != nil {
                let e = self.getEntity(entity: name) as? [T]
                completionHandler!(e)
            }
            
        }
    }
    
}
