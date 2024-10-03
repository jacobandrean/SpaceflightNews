//
//  KeychainManager.swift
//  SpaceFlightNews
//
//  Created by Jacob Andrean on 02/10/24.
//

import Foundation
import Security

@propertyWrapper
struct KeychainStored<Value: Codable> {
    private let key: String
    
    var wrappedValue: Value? {
        get {
            return load()
        }
        set {
            if let newValue = newValue {
                save(value: newValue)
            } else {
                delete()
            }
        }
    }
    
    init(wrappedValue: Value? = nil, key: String) {
        self.key = key
        self.wrappedValue = wrappedValue
    }
    
    private func save(value: Value) {
        do {
            let data = try JSONEncoder().encode(value) // Encode the value to Data
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]
            
            // Delete any existing item
            SecItemDelete(query as CFDictionary)
            // Add the new item
            SecItemAdd(query as CFDictionary, nil)
        } catch {
            print("Error saving value to Keychain: \(error)")
        }
    }
    
    private func load() -> Value? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status == errSecSuccess, let data = dataTypeRef as? Data else { return nil }
        
        do {
            return try JSONDecoder().decode(Value.self, from: data) // Decode the Data back to Value
        } catch {
            print("Error loading value from Keychain: \(error)")
            return nil
        }
    }
    
    private func delete() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}
