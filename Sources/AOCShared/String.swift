//
//  String.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/14/20.
//

import Foundation

public extension String {
    func leftPadding(toLength: Int, withPad character: Character) -> String {
        let newLength = self.count
        if newLength < toLength {
            return String(repeatElement(character, count: toLength - newLength)) + self
        } else {
            return self.substring(from: index(self.startIndex, offsetBy: newLength - toLength))
        }
    }
    
    func indexOf(char: Character) -> Int? {
        return firstIndex(of: char)?.utf16Offset(in: self)
    }
    
    func leftPadded(with padding: Character, toAtLeast width: Int) -> String {
        return count >= width ? self
            : String(repeating: padding, count: width - count) + self
    }
}
