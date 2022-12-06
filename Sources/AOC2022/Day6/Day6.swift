//
//  Day6.swift
//
//  Created on 12/6/22.
//  
//

import Foundation

public class Day6: Day {

    public override func part1() -> String {
        let input = Input().arrayOfCharacterLines(name: "Day6Input.txt", year: "2022").first!
        var marker = 0
        for (index, letter) in input.enumerated() {
            guard index < input.count - 4 else { continue }
            let range = input[index...index+4]
            var foundMarker = true
            for letter in range {
                if range.joined().components(separatedBy: letter).count > 2 {
                    foundMarker = false
                }
            }
            if foundMarker && marker == 0 {
                marker = index + 4
            }
        }
        return "\(marker)"
    }

    public override func part2() -> String {
        let input = Input().arrayOfCharacterLines(name: "Day6Input.txt", year: "2022").first!
        var marker = 0
        for (index, _) in input.enumerated() {
            guard index < input.count - 14 else { continue }
            let range = input[index..<index + 14]
            var foundMarker = true
            for letter in range {
                if range.joined().components(separatedBy: letter).count > 2 {
                    foundMarker = false
                }
            }
            if foundMarker && marker == 0 {
                marker = index + 14
            }
        }
        return "\(marker)"
    }
}
