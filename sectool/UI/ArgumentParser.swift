//
//  ArgumentParser.swift
//  sectool
//
//  Created by Sylvan Martin on 12/26/21.
//

import Foundation

/**
 * A class for parsing the argments passed through the command line
 */
class ArgumentParser {
    
    // MARK: - Properties
    
    @inlinable static var arguments: [String] {
        CommandLine.arguments
    }
    
    // MARK: - Structures
    
    /**
     * A flag for a paremeter, which may or may not have an expansion
     */
    struct ArgumentFlag: Hashable {
        
        /**
         * The "abbreviated" flag
         */
        var shortFlag: String
        
        /**
         * The expansion of the same flag
         */
        var expansion: String?
        
        /**
         * Creates an argument flag with given flag strings
         */
        init(_ shortFlag: String, expansion: String? = nil) {
            self.shortFlag = shortFlag
            self.expansion = expansion
        }
        
    }
    
    
    
    // MARK: - Methods
    
    /**
     * Returns the application interface to be completed, or throws a `ParseError` if no operation is found
     */
    static func getOperationInterface() throws -> ApplicationUI {
        if arguments.count < 2 {
            throw ParseError.noOperationFound
        }
        
        if let operation = UserInterface.SecToolOperation(rawValue: arguments[1]) {
            switch operation {
            case .passwordGeneration:
                return PasswordGenerationUI()
            }
        }
        
        throw ParseError.invalidOperation(arguments[1])
    }
    
    /**
     * Returns whether or not a certain flag exists.
     *
     * **Note:** This method does *not* check for misuse of the flag
     */
    static func flagExists(_ flag: ArgumentFlag) -> Bool {
        var exists = arguments.contains(flag.shortFlag)
        
        if let expandedFlag = flag.expansion {
            exists = exists || arguments.contains(expandedFlag)
        }
        
        return exists
    }
    
    /**
     * Returns the parameter with the associated flag, or throws `ParseError.noParameterForFlag` or `ParseError.noFlagFound`
     */
    static func getParameter(for flag: ArgumentFlag) throws -> String {
        if !flagExists(flag) {
            throw ParseError.noFlagFound(flag.expansion ?? flag.shortFlag)
        }
        
        // get the index of the flag
        
        let flagIndex = (arguments.firstIndex(of: flag.expansion ?? flag.shortFlag) ?? arguments.firstIndex(of: flag.shortFlag))!
        
        if !arguments.indices.contains(flagIndex + 1) {
            throw ParseError.noParameterFound(forFlag: flag)
        }
        
        return arguments[flagIndex + 1]
        
    }
    
    /**
     * Returns the
     */
    
    // MARK: - Errors
    
    /**
     * A user error that can occur when parsing
     */
    enum ParseError: Error {
        case noOperationFound
        case invalidOperation(String)
        case noFlagFound(String)
        case noParameterFound(forFlag: ArgumentFlag)
    }
    
}
