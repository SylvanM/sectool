//
//  OSStatus+Error.swift
//  sectool
//
//  Created by Sylvan Martin on 12/25/21.
//

import Foundation

/**
 * This extension is used only so that we can throw an `OSStatus` as an error, even though it is just an `Int32`
 */
extension OSStatus: Error {

}
