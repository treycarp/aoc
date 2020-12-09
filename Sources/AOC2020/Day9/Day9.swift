//
//  Day9.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/9/20.
//

import Foundation

public class Day9: Day {
    public override func part1() -> String {
        let preamble = 25
        var index = preamble
        let numbers = Input().numbers(name: "Day9Input.txt", year: "2020")
                
        while index < numbers.count {
            var found = false
            for (firstIndex, num1) in numbers[(index - preamble)..<(index)].enumerated() {
                guard !found else { break }
                for (secondIndex, num2) in numbers[(index - preamble)..<(index)].enumerated() {
                    guard firstIndex != secondIndex else { continue }
                    
                    if num1 + num2 == numbers[index] {
                        found = true
                        break
                    }
                }
            }
            
            if !found {
                break
            } else {
                index += 1
            }
        }
        
        return "Answer: \(numbers[index])"
    }
    
    public override func part2() -> String {
        let numbers = Input().numbers(name: "Day9Input.txt", year: "2020")
        let target = 776203571
        
        for (index, _) in numbers.enumerated() {
            var innerIndex = index
            while innerIndex < numbers.count {
                let sum = numbers[index..<innerIndex].reduce(0) { $0 + $1 }
                if sum == target {
                    return "Answer: \(numbers[index..<innerIndex].min()! + numbers[index..<innerIndex].max()!)"
                } else if sum > target {
                    break
                }
                innerIndex += 1
            }
        }
        
        return "Not found"
    }
}
