//
//  Day2.swift
//  AOC2021
//
//  Created by Trey Carpenter on 12/2/21.
//

import Foundation

public class Day2: Day {
    
    public override func part1() -> String {
        
        var pos: (Int, Int) = (0, 0)
        let commands = Input().strings(name: "Day2Input.txt", year: "2021")
        
        for command in commands {
            let parts = command.split(separator: " ")
            
            switch parts[0] {
            case "forward":
                pos = (pos.0 + Int(parts[1])!, pos.1)
            case "down":
                pos = (pos.0, pos.1 + Int(parts[1])!)
            case "up":
                pos = (pos.0, pos.1 - Int(parts[1])!)
            default: break
            }
        }
        
        return "Answer: \(pos.0 * pos.1)"
    }
    
    public override func part2() -> String {
        var pos: (Int, Int, Int) = (0, 0, 0)
        let commands = Input().strings(name: "Day2Input.txt", year: "2021")
        
        for command in commands {
            let parts = command.split(separator: " ")
            
            switch parts[0] {
            case "forward":
                pos = (pos.0 + Int(parts[1])!, pos.1 + (pos.2 * Int(parts[1])!), pos.2)
            case "down":
                pos = (pos.0, pos.1, pos.2  + Int(parts[1])!)
            case "up":
                pos = (pos.0, pos.1, pos.2 - Int(parts[1])!)
            default: break
            }
        }
        
        return "Answer: \(pos.0 * pos.1)"
    }
}
