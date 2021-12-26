//
//  main.swift
//  sectool
//
//  Created by Sylvan Martin on 12/25/21.
//

import Foundation

do {
    try UserInterface.run(arguments: CommandLine.arguments)
} catch {

    if let generalError = error as? UserInterface.SecToolGeneralError {

        if let message = generalError.message { print(message) }

        switch generalError.errorType {
        case .invalidOperationError:
            // TODO: Print possible operations, and their usages
            print("TODO: List possible operations")
        case .passwordGenerationError:
            // TODO: Print password usage
            print("TODO: Print password usage")
        }

    } else {
        print("An unknown error occured.")
    }

}
