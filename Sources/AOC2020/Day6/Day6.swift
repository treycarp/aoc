//
//  Day6.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/6/20.
//

import Foundation

public class Day6: Day {
    public override func part1() -> String {
        let groups = Input().stringsByBlankLine(name: "Day6Input.txt", year: "2020")
        let sum = groups.reduce(0) {
            let set = Set($1.replacingOccurrences(of: " ", with: "").map { tempString in String(tempString) })
            return $0 + set.count
        }
        return "Sum: \(sum)"
    }
    
    public override func part2() -> String {
        let groups = Input().stringsByBlankLine(name: "Day6Input.txt", year: "2020")
        let sum = groups.reduce(0) {
            let answers = $1.split(separator: " ")
            let commonElements = answers.reduce(Set(answers.first!)) { (result, list)  in
                result.intersection(list)
            }
            return commonElements.count + $0
        }
        
        return "Sum: \(sum)"
    }
}
