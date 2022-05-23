//
//  Day6.swift
//  AOC2021
//
//  Created by Trey Carpenter on 12/7/21.
//

import Foundation

public class Day6: Day {
    public override func part1() -> String {
        let lanternfish = Input().numbersCsv(name: "Day6Input.txt", year: "2021")
        return perform(for: 80, with: lanternfish)
    }
    
    public override func part2() -> String {
        let lanternfish = Input().numbersCsv(name: "Day6Input.txt", year: "2021")
        return perform(for: 256, with: lanternfish)
    }
    
    private func perform(for days: Int, with lanternFish: [Int]) -> String {
        var fishCounts = Array(repeating: 0, count: 9)
        for fish in lanternFish {
            fishCounts[fish] += 1
        }
        
        for _ in 1...days {
            var tempArray = fishCounts
            var newFishCount = 0
            for index in 0..<tempArray.count {
                if index == 0 {
                    tempArray[8] = fishCounts[index]
                    newFishCount = fishCounts[index]
                } else {
                    tempArray[index - 1] = fishCounts[index]
                }
            }
            tempArray[6] += newFishCount
            fishCounts = tempArray
        }
        return "\(fishCounts.reduce(0, +))"
    }
}

struct LanternFish {
    
}
