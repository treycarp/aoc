//
//  Day10.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/10/20.
//

import Foundation

public class Day10: Day {
    public override func part1() -> String {
        var numbers = Input().numbers(name: "Day10Input.txt", year: "2020").sorted()
        numbers.append(numbers.max()! + 3)
        
        var ones = 1
        var threes = 0
        for (index, number) in numbers.enumerated() {
            guard index < numbers.count - 1 else { continue }
            let difference = numbers[index + 1] - number
            if difference == 3 {
                threes += 1
            } else if difference == 1 {
                ones += 1
            }
        }
        return "Answer: \(threes * ones)"
    }
    
    public override func part2() -> String {
        var numbers = Input().numbers(name: "Day10Input.txt", year: "2020").sorted()
        numbers.append(numbers.max()! + 3)
        // starting point
        var uniquePaths: [Int: Int] = [0: 1]
        
        for number in numbers {
            var currentPaths: [Int: Int] = [:]
            for (key, value) in uniquePaths {
                if number - key <= 3 {
                    currentPaths[number, default: 0] += value
                    currentPaths[key, default: 0] += value
                }
            }
            
            uniquePaths = currentPaths
        }
        
        return "Answer: \(uniquePaths[numbers.max()!]!)"
    }
    
}
