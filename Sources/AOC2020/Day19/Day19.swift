//
//  Day19.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/20/20.
//

import Foundation

public class Day19: Day {
    
    var rules: [Int: Rule] = [:]
    
    
    public override func part1() -> String {
        let lines = Input().strings(name: "Day19Input.txt", year: "2020")
        rules = getRules(lines)
        let inputs: [String] = getInputs(lines)
        
        let validationRegex = "^" + buildRegex(0) + "$"
        let regex = try! NSRegularExpression(pattern: validationRegex)
        let valid = inputs.filter {
            regex.matches($0)
        }
        return "Answer: \(valid.count)"
    }
    
    public override func part2() -> String {
        let lines = Input().strings(name: "Day19Input.txt", year: "2020")
        rules = getRules(lines)
        rules[8] = .or([42], [42, 8])
        rules[11] = .or([42, 31], [42, 11, 31])
        let inputs: [String] = getInputs(lines)
        
        let validationRegex = "^" + buildRegex(0, part2: true) + "$"
        let regex = try! NSRegularExpression(pattern: validationRegex)
        let valid = inputs.filter {
            regex.matches($0)
        }
        return "Answer: \(valid.count)"
    }
    
    private func buildRegex(_ rule: Int, part2: Bool = false) -> String {
        if rule == 8 && part2 {
            return buildRegex(42, part2: part2) + "+"
        }
        
        if rule == 11 && part2 {
            let rule42 = buildRegex(42, part2: part2)
            let rule31 = buildRegex(31, part2: part2)
            
            var possibilities = Array<String>()
            for count in 1 ... 10 {
                let first = Array(repeating: rule42, count: count).joined()
                let second = Array(repeating: rule31, count: count).joined()
                possibilities.append(first + second)
            }
            let options = possibilities.joined(separator: "|")
            return "(\(options))"
        }
        
        guard let r = rules[rule] else { return "" }
        switch r {
        case .literal(let character): return "\(character)"
        case .or(let first, let second):
            if second != nil {
                let firstPart = first.map { buildRegex($0, part2: part2) }.joined()
                let secondPart = second!.map { buildRegex($0, part2: part2) }.joined()
                return "(\(firstPart)|\(secondPart))"
            } else {
                return first.map { buildRegex($0, part2: part2) }.joined()
            }
        }
    }
    
    private func getRules(_ lines: [String]) -> [Int: Rule] {
        var tempRules = [Int: Rule]()
        for line in lines {
            guard Int(String(line.first!)) != nil else {
                break
            }
            let parts = line.split(separator: ":")
            let ruleNumber = Int(parts[0])!
            let ruleString = parts[1].trimmingCharacters(in: .whitespaces)
            
            let rule: Rule
            if ruleString.hasPrefix("\"") {
                rule = .literal(Array(ruleString)[1])
            } else {
                let indivRules = ruleString.split(separator: "|")
                let ints = indivRules.map { $0.split(separator: " ").map { int -> Int in
                    Int(int)!
                }}
                if ints.count == 1 {
                    rule = .or(ints[0], nil)
                } else {
                    rule = .or(ints[0], ints[1])
                }
            }
            
            tempRules[ruleNumber] = rule
        }
        
        return tempRules
    }
    
    private func getInputs(_ lines: [String]) -> [String] {
        return lines.compactMap{
            guard $0 != "" else { return nil }
            if Int(String($0.first!)) == nil {
                return $0
            } else {
                return nil
            }
        }
    }
}

enum Rule {
    case literal(Character)
    case or([Int], [Int]?)
}
