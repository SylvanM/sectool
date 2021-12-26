//
//  UI+PasswordGeneration.swift
//  sectool
//
//  Created by Sylvan Martin on 12/25/21.
//

import Foundation

extension UserInterface {
    
    /**
     * Runs the password generation operation
     */
    static func runPasswordGeneration(arguments: [String]) throws {
        
        // TODO: Maybe actually parse the input
        
        let passwordGenerator = PasswordGenerator()
        
        let password = try passwordGenerator.generatePassword()
        
        print(password)
        
    }
    
}
