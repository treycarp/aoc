//
//  Day1.swift
//  AOC
//
//  Created by Trey Carpenter on 11/30/20.
//

import Foundation

public class Day1 : Day {
    
    public override func part1() -> String {
        let numbers = Input().numbers(name: "Day1Input.txt", year: "2020")
        return "\(numbers)"
    }
    
    public override func part2() -> String {
        return "Part 2!"
    }
}
