//
//  Day14.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/13/20.
//

import Foundation

public class Day14: Day {
    public override func part1() -> String {
        let lines = Input().strings(name: "Day14Input.txt", year: "2020")
        var mem : [String: String] = [:]
        var mask = ""
        for line in lines {
            if line.prefix(4) == "mask" {
                mask = String(line.dropFirst(7))
                continue
            }
                
            let strings = line.split(separator: "=")
            let address = String(strings[0].dropFirst(4).dropLast(2))
            var value = (String(Int(strings[1].dropFirst())!, radix: 2).leftPadding(toLength: mask.count, withPad: "0"))
            
            for (index, character) in mask.enumerated() {
                guard character != "X" else { continue }
                var chars = Array(value)
                chars[index] = character
                value = String(chars)
            }
            
            mem[address] = value
        }
        
        let sum = mem.reduce(0) {
            return $0 + Int($1.value, radix: 2)!
        }
        return "Answer: \(sum)"
    }
    
    public override func part2() -> String {
        let lines = Input().strings(name: "Day14Input.txt", year: "2020")
        var mem : [String: String] = [:]
        var mask = ""
        for line in lines {
            if line.prefix(4) == "mask" {
                mask = String(line.dropFirst(7))
                continue
            }
                
            let strings = line.split(separator: "=")
            let value = String(strings[1].dropFirst())
            var addressValue = (String(Int(String(strings[0].dropFirst(4).dropLast(2)))!, radix: 2).leftPadding(toLength: mask.count, withPad: "0"))
            for (index, character) in mask.enumerated() {
                guard character != "0" else { continue }
                addressValue = changeCharacterAt(index: index, string: addressValue, newChar: character)
            }
            
            // Determine number of X's make combos
            let xCount = addressValue.components(separatedBy:"X").count - 1
            let combos = ["0", "1"].replacementPermute(sampleSize: xCount)!
            
            // loop through combos and apply bit
            for combo in combos {
                var maskedAddress = addressValue
                for (_, char) in combo.enumerated() {
                    maskedAddress = changeCharacterAt(index: maskedAddress.indexOf(char: "X")!, string: maskedAddress, newChar: char)
                }
                // add to mem
                mem[maskedAddress] = value
            }
        }
        let sum = mem.reduce(0) {
            return $0 + Int($1.value)!
        }
        return "Answer: \(sum)"
    }
    
    private func changeCharacterAt(index: Int, string: String, newChar: Character) -> String {
        var chars = Array(string)
        chars[index] = newChar
        return String(chars)
    }
}


