//
//  UserInterface.swift
//  sectool
//
//  Created by Sylvan Martin on 12/25/21.
//

import Foundation
import AppKit

class UserInterface {
    
    /**
     * Transfers control of the program to the appropriate `sectool` operation
     */
    static func run() throws {
        
        let toolUI = try ArgumentParser.getOperationInterface()
        
        do {
            try toolUI.run()
        } catch {
            
            if error is SecToolGeneralError {
                throw error
            }
            
            // TODO: Do tool specific error handling
            
            toolUI.printUsage()
            
        }
        
    }
    
    // MARK: Enumerations
    
    /**
     * An operation that can be performed by `sectool`, with the string used by the user to call it
     */
    enum SecToolOperation: String, CaseIterable {
        case passwordGeneration = "genpass"
    }
    
    /**
     * An error that could be made by the user
     */
    class SecToolGeneralError: Error {
        
        /**
         * The type of error
         */
        var errorType: UserErrorType
        
        /**
         * A breif message to acompany the error before a usage statement is printed
         */
        var message: String?
        
        /**
         * Creates a user error with a brief message
         */
        init(_ type: UserErrorType, message: String? = nil) {
            self.errorType = type
            self.message = message
        }
        
        /**
         * The type of error this could be
         */
        enum UserErrorType {
            case invalidOperationError
            
            case passwordGenerationError
        }
        
    }
    
}


