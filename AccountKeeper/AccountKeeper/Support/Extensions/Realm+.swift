//
//  Realm+.swift
//  AccountKeeper
//
//  Created by NamTrinh on 22/06/2023.
//

import Foundation
import Realm
import RealmSwift

extension Realm {
    func writeAsync<T: ThreadConfined>(_ passedObject: T,
                                       errorHandle: @escaping ((_ error: Swift.Error) -> Void) = { _ in return },
                                       block: @escaping ((Realm, T?) -> Void)) {
        let objectRef = ThreadSafeReference(to: passedObject)
        let configuration = self.configuration
        DispatchQueue(label: "background", autoreleaseFrequency: .workItem).async {
            do {
                let realm = try Realm(configuration: configuration)
                try realm.write {
                    let object = realm.resolve(objectRef)
                    block(realm, object)
                }
            } catch {
                errorHandle(error)
            }
        }
    }
}
