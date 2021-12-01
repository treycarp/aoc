//
//  Day1.swift
//  AOC2021
//
//  Created by Trey Carpenter on 12/1/21.
//

import Foundation

public class Day1: Day {
    
    public override func part1() -> String {
        let numbers = Input().numbers(name: "Day1Input.txt", year: "2021")
        
        var depthIncreasing = 0
        var previousDepth = 0
        for depth in numbers {
            if previousDepth != 0 && depth > previousDepth {
                depthIncreasing += 1
            }
            previousDepth = depth
        }
        return "\(depthIncreasing)"
    }
    
    public override func part2() -> String {
        var numbers = Input().numbers(name: "Day1Input.txt", year: "2021")
        
        var depthIncreasing = 0
        var previousDepthsSum = 0
        
        while numbers.count > 2 {
            let sum = numbers[0] + numbers[1] + numbers[2]
            if previousDepthsSum != 0 && sum > previousDepthsSum {
                depthIncreasing += 1
            }
            numbers.removeFirst()
            
            previousDepthsSum = sum
        }
        
        return "\(depthIncreasing)"
    }
}
