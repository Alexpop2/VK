//
//  DatabaseService.swift
//  VK
//
//  Created by Рабочий on 01/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseService: DatabaseServiceInput {
    func loadToken() -> String? {
        let realm = try! Realm()
        let postEntities = realm.objects(PostEntity.self)
        var postEntitiesArray = [PostEntity]()
        for entity in postEntities { //map
            postEntitiesArray.append(entity)
        }
        return postEntitiesArray[0].token
    }
    
    func add(token: String) {
        let realm = try! Realm()
        try! realm.write {
            realm.create(PostEntity.self, value: [token])
        }
    }
    
    func deleteToken() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}
