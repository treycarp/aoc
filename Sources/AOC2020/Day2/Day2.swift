//
//  Day2.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/1/20.
//

import Foundation

public class Day2: Day {
    
    public override func part1() -> String {
        let strings = Input().strings(name: "Day2Input.txt", year: "2020")
        let validPasswords: [Password] = strings.compactMap {
            let individualStrings = $0.split(separator: " ")
            let minMax = individualStrings[0].split(separator: "-")
            let min = Int(minMax.first!)
            let max = Int(minMax.last!)
            let requiredCharacter = individualStrings[1].replacingOccurrences(of: ":", with: "")
            let password = Password(min: min!,
                                    max: max!,
                                    requiredCharacter: requiredCharacter,
                                    password: String(individualStrings[2]))
            if password.part1Valid() {
                return password
            }
            return nil
        }
        
        return "Valid passwords: \(validPasswords.count)"
    }
    
    public override func part2() -> String {
        let strings = Input().strings(name: "Day2Input.txt", year: "2020")
        let validPasswords: [Password] = strings.compactMap {
            let individualStrings = $0.split(separator: " ")
            let minMax = individualStrings[0].split(separator: "-")
            let min = Int(minMax.first!)
            let max = Int(minMax.last!)
            let requiredCharacter = individualStrings[1].replacingOccurrences(of: ":", with: "")
            let password = Password(min: min!,
                                    max: max!,
                                    requiredCharacter: requiredCharacter,
                                    password: String(individualStrings[2]))
            if password.part2Valid() {
                return password
            }
            return nil
        }
        
        return "Valid passwords: \(validPasswords.count)"
    }
}

struct Password {
    let min: Int
    let max: Int
    let requiredCharacter: String
    let password: String
    
    func part1Valid() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^([^\(requiredCharacter)]*\(requiredCharacter)[^\(requiredCharacter)]*){\(min),\(max)}$")
        return regex.matches(password)
    }
    
    func part2Valid() -> Bool {
        let characters = password.map { String($0) }
        let firstMatch = characters[min-1] == requiredCharacter
        let secondMatch = characters[max-1] == requiredCharacter
        
        return (firstMatch || secondMatch) && !(firstMatch && secondMatch)
    }
}

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
