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
        var answer = -1
        numbers.forEach { x in
            numbers.forEach { y in
                if x + y == 2020 {
                    answer = x * y
                }
            }
        }
        return "\(answer)"
    }
    
    public override func part2() -> String {
        let numbers = Input().numbers(name: "Day1Input.txt", year: "2020")
        var answer = -1
        numbers.forEach { x in
            numbers.forEach { y in
                numbers.forEach { z in
                    if x + y + z == 2020 {
                        answer = x * y * z
                    }
                }
            }
        }
        return "\(answer)"
    }
}
