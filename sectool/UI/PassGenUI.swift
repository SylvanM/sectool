//
//  PassGenUI.swift
//  sectool
//
//  Created by Sylvan Martin on 12/25/21.
//

import Foundation

class PasswordGenerationUI: ApplicationUI {
    
    
    
    
    
    // MARK: Methods
    
    func printUsage() {
        // TODO: Actually write this
    }
    
    func run() throws {
        
        var excludedCharacterSet: CharacterSet
        var onlyAllowedCharacterSet: CharacterSet
        
        var length: Int
        
        do {
            excludedCharacterSet = CharacterSet(charactersIn: try ArgumentParser.getParameter(for: .excludedCharsFlag))
        } catch ArgumentParser.ParseError.noFlagFound {
            excludedCharacterSet = .empty
        }
    
        do {
            onlyAllowedCharacterSet = CharacterSet(charactersIn: try ArgumentParser.getParameter(for: .allowedCharsFlag))
        } catch ArgumentParser.ParseError.noFlagFound {
            onlyAllowedCharacterSet = PasswordGenerator.defaultCharacterSet
        }
        
        // We want a shorthand where the user can just type "sectool genpass <L>" to generate a password of length L
        if ArgumentParser.arguments.indices.contains(2), let lengthNumber = Int(ArgumentParser.arguments[2]) {
            length = lengthNumber
        } else {
            do {
                let lengthString = try ArgumentParser.getParameter(for: .lengthFlag)
            
                if let lengthNumber = Int(lengthString) {
                    length = lengthNumber
                } else {
                    print("Sorry, but \"\(lengthString)\" was not recognized as a valid password length.")
                    return
                }
            } catch ArgumentParser.ParseError.noFlagFound {
                length = PasswordGenerator.defaultPasswordLength
            }
        }
 
        if ArgumentParser.flagExists(.alphanumFlag) {
            onlyAllowedCharacterSet.formIntersection(.alphanumerics)
        }
        
        if ArgumentParser.flagExists(.noSpacesFlag) {
            excludedCharacterSet.insert( Character(" ").unicodeScalars.first! )
        }
        
        onlyAllowedCharacterSet.subtract(excludedCharacterSet)
        
        let passwordGenerator = PasswordGenerator(allowing: onlyAllowedCharacterSet)
        
        print(try passwordGenerator.generatePassword(ofLength: length))
        
    }
    
}

fileprivate extension ArgumentParser.ArgumentFlag {
    
    /**
     * Indicates that the password should contain no spaces
     */
    static let noSpacesFlag = ArgumentParser.ArgumentFlag("-ns", expansion: "--nospaces")
    
    /**
     * The flag for the characters that should be excluded
     */
    static let excludedCharsFlag = ArgumentParser.ArgumentFlag("-x", expansion: "--excluding")
    
    /**
     * The flag for the characters that are allowed
     */
    static let allowedCharsFlag = ArgumentParser.ArgumentFlag("-c", expansion: "--only")
    
    /**
     * The flag indicating that the user only wants alphanumeric characters
     */
    static let alphanumFlag = ArgumentParser.ArgumentFlag("-a", expansion: "--alphanum")
    
    /**
     * The flag for the length of the password
     */
    static let lengthFlag = ArgumentParser.ArgumentFlag("-l", expansion: "--length")
    
}
