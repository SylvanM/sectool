//
//  ApplicationUI.swift
//  sectool
//
//  Created by Sylvan Martin on 12/26/21.
//

import Foundation

/**
 * The UI for a particular operation of `sectool`
 */
protocol ApplicationUI {
    
    /**
     * Prints the usage for this application
     */
    func printUsage()
    
    /**
     * Runs this specific tool
     */
    func run(withArguments arguments: [String]) throws
    
}
