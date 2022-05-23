//
//  Day10.swift
//  AOC
//
//  Created by Trey Carpenter on 12/17/21.
//

import Foundation

public class Day10: Day {
    public override func part1() -> String {
        let lines = Input().arrayOfCharacterLines(name: "Day10Input.txt", year: "2021")
        var score = 0
        
        for line in lines {
            var openingStack = [String]()
            var corrupt = false
            for char in line {
                guard corrupt == false else { continue }
                if isOpening(char: char) {
                    openingStack.insert(char, at: 0)
                } else { // must be closing
                    if !isMatch(opener: openingStack[0], char: char) {
                        score += calcScore(char: char)
                        corrupt = true
                    } else {
                        openingStack.remove(at: 0)
                    }
                }
            }
        }
        return "\(score)"
    }
    
    public override func part2() -> String {
        let lines = Input().arrayOfCharacterLines(name: "Day10Input.txt", year: "2021")
        var scores = [Int]()
        for line in lines {
            var openingStack = [String]()
            var corrupt = false
            for char in line {
                guard corrupt == false else { continue }
                if isOpening(char: char) {
                    openingStack.insert(char, at: 0)
                } else { // must be closing
                    if !isMatch(opener: openingStack[0], char: char) {
                        corrupt = true
                    } else {
                        openingStack.remove(at: 0)
                    }
                }
            }
            
            if !corrupt {
                scores.append(calcScore(closing: openingStack.map { getCloser(char: $0) }))
            }
        }
        return "\(scores.sorted()[(scores.count / 2)])"
    }
    
    private func getCloser(char: String) -> String {
        switch char {
        case "<": return ">"
        case "(": return ")"
        case "{": return "}"
        case "[": return "]"
        default: return ""
        }
    }
    
    private func calcScore(closing: [String]) -> Int {
        var score = 0
        for char in closing {
            score *= 5
            switch char {
            case ")": score += 1
            case "]": score += 2
            case "}": score += 3
            case ">": score += 4
            default: break
            }
        }
        return score
    }
    
    private func calcScore(char: String) -> Int {
        switch char {
        case ">": return 25137
        case ")": return 3
        case "]": return 57
        case "}": return 1197
        default: return 0
        }
    }
    
    private func isMatch(opener: String, char: String) -> Bool {
        switch opener {
        case "<": return char == ">"
        case "(": return char == ")"
        case "{": return char == "}"
        case "[": return char == "]"
        default: return false
        }
    }
    
    private func isOpening(char: String) -> Bool {
        char == "<" || char == "(" || char == "[" || char == "{"
    }
}
