//
//  PassGenUI.swift
//  sectool
//
//  Created by Sylvan Martin on 12/25/21.
//

import Foundation

class PasswordGenerationUI: ApplicationUI {
    
    func printUsage() {
        // TODO: Actually write this
    }
    
    func run(withArguments arguments: [String]) throws {
        // TODO: Maybe actually parse the input
        
        let passwordGenerator = PasswordGenerator()
        
        let password = try passwordGenerator.generatePassword()
        
        print(password)
    }
    
}
