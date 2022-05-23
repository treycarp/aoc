//
//  Day14.swift
//  AOC2021
//
//  Created by Trey Carpenter on 12/20/21.
//

import Foundation

public class Day14: Day {
    public override func part1() -> String {
        let lines = Input().strings(name: "Day14Input.txt", year: "2021")
        var element = lines.first!.map { String($0) }
        var rules = [String: String]()
        for rule in lines.dropFirst() {
            let code = String(rule.split(separator: " ")[0])
            let addition = String(rule.split(separator: " ")[2])
            rules[code] = addition
        }
        
        for step in 1...10 {
            var newElement = element
            for pairIndex in 0...element.count - 2 {
                let pair = element[pairIndex] + element[pairIndex + 1]
                newElement.insert(rules[pair]!, at: pairIndex + 1 * pairIndex + 1)
            }
            element = newElement
            print("Step \(step): \(element.count)")
        }
        let frequent = mostFrequent(array: element)
        let least = leastFrequent(array: element)
        return "Most frequent = \(frequent!.value), \(frequent!.count) times\nLeast frequent = \(least!.value), \(least!.count) times\nSum: \(((frequent!.count) - (least!.count)))"
    }
    
    private func mostFrequent(array: [String]) -> (value: String, count: Int)? {
        var counts = [String: Int]()

        array.forEach { counts[$0] = (counts[$0] ?? 0) + 1 }

        if let (value, count) = counts.max(by: {$0.1 < $1.1}) {
            return (value, count)
        }

        // array was empty
        return nil
    }
    
    private func leastFrequent(array: [String]) -> (value: String, count: Int)? {
        var counts = [String: Int]()

        array.forEach { counts[$0] = (counts[$0] ?? 0) + 1 }

        if let (value, count) = counts.min(by: {$0.1 < $1.1}) {
            return (value, count)
        }

        // array was empty
        return nil
    }
    
    public override func part2() -> String {
        let lines = Input().strings(name: "Day14Input.txt", year: "2021")
        var element = lines.first!.map { String($0) }
        var rules = [String: String]()
        for rule in lines.dropFirst() {
            let code = String(rule.split(separator: " ")[0])
            let addition = String(rule.split(separator: " ")[2])
            rules[code] = addition
        }
        
        for step in 1...40 {
            var newElement = element
            for pairIndex in 0...element.count - 2 {
                let pair = element[pairIndex] + element[pairIndex + 1]
                newElement.insert(rules[pair]!, at: pairIndex + 1 * pairIndex + 1)
            }
            element = newElement
            print("Step \(step): \(element.count)")
        }
        let frequent = mostFrequent(array: element)
        let least = leastFrequent(array: element)
        return "Most frequent = \(frequent!.value), \(frequent!.count) times\nLeast frequent = \(least!.value), \(least!.count) times\nSum: \(((frequent!.count) - (least!.count)))"
    }
}
