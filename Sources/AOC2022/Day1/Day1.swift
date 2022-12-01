//
//  Day1.swift
//  Advent of Code
//
//  Created by Trey Carpenter on 12/1/22.
//

import Foundation

public class Day1: Day {
    public override func part1() -> String {
        let lines = Input().sumByBlankLine(name: "Day1Input.txt", year: "2022")
        
        return "\(lines.max() ?? 0)"
    }
    
    public override func part2() -> String {
        let lines = Input().sumByBlankLine(name: "Day1Input.txt", year: "2022")
        return "\(lines.sorted().dropFirst(lines.count - 3).reduce(0, +))"
    }
}
