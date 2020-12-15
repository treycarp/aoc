//
//  Day15.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/15/20.
//

import Foundation

public class Day15: Day {
    public override func part1() -> String {
        return "Answer: \(calc(for: 2020))"
    }
    
    public override func part2() -> String {
        return "Answer: \(calc(for: 30000000))"
    }
    
    private func calc(for number: Int) -> Int {
        var start = [0,14,1,3,7,9]
        var previouslySeen = [0: 0, 14: 1, 1: 2, 3:3, 7:4]
        
        for index in start.count - 1..<number - 1 {
            if let lastIndex = previouslySeen[start[index]] {
                start.append((index + 1) - (lastIndex + 1))
            } else {
                start.append(0)
            }
            
            previouslySeen[start[index]] = index
        }
        
        return start.last!
    }
}
