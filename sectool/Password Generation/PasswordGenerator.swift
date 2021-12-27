//
//  PasswordGenerator.swift
//  sectool
//
//  Created by Sylvan Martin on 12/25/21.
//

import Foundation
import Security

/**
 * An object used for generating secure random passwords using Apple's routines
 */
class PasswordGenerator {
    
    // MARK: - Properties
    
    /**
     * The set of characters to be allowed in the passwords generated
     */
    var allowableCharacterSet: CharacterSet
    
    // MARK: Static Properties
    
    /**
     * The standard characters one might expect to see in a password
     *
     * I literally just went along each row of my keyboard to type this
     */
    public static let defaultCharacterSet = CharacterSet(charactersIn: "~!@#$%^&*()_+`1234567890-=QWERTYUIOP{}|qwertyuiop[]\\ASDFGHJKL:\"asdfghjkl;'ZXCVBNM<>?zxcvbnm,./ ")
    
    public static let defaultPasswordLength = 16
    
    // MARK: - Initializers
    
    /**
     * Creates a `PasswordGenerator` that generates characters from an allowable character set
     */
    init(allowing allowedCharacters: CharacterSet = defaultCharacterSet) {
        self.allowableCharacterSet = allowedCharacters
    }
    
    // MARK: - Methods
    
    /**
     * Generates a random string of allowable characters using Apple's secure random number generator
     *
     * As of right now, this implementation is **not secure at all** and is just a temporary implementation
     *
     * - Parameter length: The amount of characters to be in the password, by default 12
     *
     * - Returns: A random string
     */
    func generatePassword(ofLength length: Int = defaultPasswordLength) throws -> String {
        
        // We have some random data, now convert that to a valid string
        
        // TODO: Make this actually secure
        
        // keep generating random characters until
        // This feels very unelegant, but apparently it's called rejection sampling and it's cool
        
        var characters = [Character](repeating: "0", count: length)
        
        for i in 0..<characters.count {
            
            var unicodeValue: UnicodeScalar
            
            repeat {
                
                var randomData = [UInt8](repeating: 0, count: 1)
                
                let result = SecRandomCopyBytes(kSecRandomDefault, randomData.count, &randomData)
                
                if result != errSecSuccess {
                    throw result
                }
            
                unicodeValue = UnicodeScalar(randomData[0])
                
            } while !allowableCharacterSet.contains( unicodeValue )
            
            characters[i] = Character(unicodeValue)
        }
        
        return String(characters)
        
    }
    
}
