//
//  RealmService.swift
//  AccountKeeper
//
//  Created by NamTrinh on 18/06/2023.
//

import Foundation
import Realm
import RealmSwift

class RealmService {
    static let shared = RealmService()
    
    private let configuration: Realm.Configuration
    
    private init() {
        self.configuration = Realm.Configuration(encryptionKey: KeychainManager.getKey(), schemaVersion: 1)
    }
    
    func fetchAll<Element: RealmFetchable>(_ type: Element.Type) -> Results<Element> {
        let realm = try! Realm(configuration: configuration)
        let result = realm.objects(type)
        return result
    }
    
    func insert<T: Object>(item: T) {
        let realm = try! Realm(configuration: configuration)
        realm.writeAsync(item) { (realm, item) in
            guard let item = item else { return }
            realm.add(item)
        }
    }
    
    func update<T: Object>(item: T) {
        let realm = try! Realm(configuration: configuration)
        realm.writeAsync(item) { (realm, item) in
            guard let item = item else { return }
            realm.add(item, update: .modified)
        }
    }
    
    func delete<T: Object>(item: T) {
        let realm = try! Realm(configuration: configuration)
        realm.writeAsync(item) { (realm, item) in
            guard let item = item else {
                return
            }
            realm.delete(item)
        }
    }
}

class Person: Object {
    @Persisted var name: String
    
    init(name: String) {
        self.name = name
    }
    
    
}
class Imple {
    func maina() {
        let realm = try! Realm()
        let person = Person(name: "A")
        try! realm.write({
            realm.add(person)
        })
        
        @ThreadSafe var personRef = person
        
        DispatchQueue(label: "background").async {
            let realm = try! Realm()
            try! realm.write {
                guard let person = personRef else {
                    return
                }
                
                person.name = "B"
            }
        }
    }
}
