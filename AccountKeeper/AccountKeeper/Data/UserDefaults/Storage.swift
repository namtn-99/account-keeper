//
//  Storage.swift
//  AccountKeeper
//
//  Created by NamTrinh on 18/06/2023.
//

import Foundation

@propertyWrapper
struct Storage<T: Codable> {
    struct Wrapper<T>: Codable where T: Codable {
        let wrapper: T
    }
    
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.value(forKey: key) as? Data  else {
                return defaultValue
            }
            let value = try? JSONDecoder().decode(Wrapper<T>.self, from: data)
            return value?.wrapper ?? defaultValue
        }
        set {
            do {
                let data = try JSONEncoder().encode(Wrapper(wrapper: newValue))
                UserDefaults.standard.set(data, forKey: key)
            } catch {
                print(error)
            }
        }
    }
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
