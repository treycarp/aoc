//
//  Day2.swift
//  AOC
//
//  Created by Trey Carpenter on 11/25/21.
//

import Foundation

public class Day2: Day {
    public override func part1() -> String {
        let lines = Input().strings(name: "Day2Input.txt", year: "2018")
        var twoCount = 0
        var threeCount = 0
        
        lines.forEach { line in
            var containsTwo = false
            var containsThree = false
            
            line.forEach { char in
                if line.count(of: char) == 3 {
                    containsThree = true
                } else if line.count(of: char) == 2 {
                    containsTwo = true
                }
            }
            
            if containsTwo {
                twoCount += 1
            }
            
            if containsThree {
                threeCount += 1
            }
        }
        return "\(twoCount * threeCount)"
    }
    
    public override func part2() -> String {
        let lines = Input().strings(name: "Day2Input.txt", year: "2018")
        for line in lines {
            for nextLine in lines {
                guard nextLine != line else { continue }
                let difference = zip(line, nextLine).filter{ $0 != $1 }
                if difference.count == 1 {
                    return line.replacingOccurrences(of: String(difference.first!.0), with: "")
                }
            }
        }
        return "Not found"
    }
}

extension String {
    func count(of needle: Character) -> Int {
        return reduce(0) {
            $1 == needle ? $0 + 1 : $0
        }
    }
}
