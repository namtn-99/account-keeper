//
//  LAContext+.swift
//  AccountKeeper
//
//  Created by NamTrinh on 27/06/2023.
//

import Foundation

import LocalAuthentication

extension LAContext {
    enum BiometricType: String {
        case none
        case touchID
        case faceID
    }
    
    var biometricType: BiometricType {
        let authenticationContext = LAContext()
        _ = authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        switch (authenticationContext.biometryType){
        case .faceID:
            return .faceID
        case .touchID:
            return .touchID
        default:
            return .none
        }
    }
    
    var isPremissionBiometric: Bool {
        let context = LAContext()
        var error: NSError?
        
        let permissions = context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        )
        return permissions
    }
}
