//
//  Day11.swift
//  AOC
//
//  Created by Trey Carpenter on 12/12/19.
//

import Foundation

struct Pair<T: Hashable, U: Hashable> : Hashable {
    let values: (T, U)
    
    func hash(into hasher: inout Hasher) {
        let (x,y) = values
        hasher.combine(x)
        hasher.combine(y)
    }
    
    static func ==<T: Hashable, U:Hashable>(lhs: Pair<T,U>, rhs: Pair<T,U>) -> Bool {
        return lhs.values == rhs.values
    }
}

enum Direction {
    case up
    case down
    case left
    case right
}

public class Day11: Day {
    
    var robotLocation: (Int,Int) = (0,0)
    var grid = [Pair<Int, Int>: Int]()
    var robotDirection: Direction = .up
    
    func move(direction: Direction) {
        switch robotDirection {
        case .up:
            if direction == .left {
                robotLocation = (robotLocation.0 - 1, robotLocation.1)
                robotDirection = .left
            } else {
                robotLocation = (robotLocation.0 + 1, robotLocation.1)
                robotDirection = .right
            }
        case .down:
            if direction == .left {
                robotLocation = (robotLocation.0 + 1, robotLocation.1)
                robotDirection = .right
            } else {
                robotLocation = (robotLocation.0 - 1, robotLocation.1)
                robotDirection = .left
            }
        case .left:
            if direction == .left {
                robotLocation = (robotLocation.0, robotLocation.1 - 1)
                robotDirection = .down
            } else {
                robotLocation = (robotLocation.0, robotLocation.1 + 1)
                robotDirection = .up
            }
        case .right:
            if direction == .left {
                robotLocation = (robotLocation.0, robotLocation.1 + 1)
                robotDirection = .up
            } else {
                robotLocation = (robotLocation.0, robotLocation.1 - 1)
                robotDirection = .down
            }
        }
    }
    
    func doTheThing() {
        var memory: [Int] = []
        memory.reserveCapacity(Int(INT32_MAX))
        memory = Array(repeating: Int(0), count: Int(INT32_MAX))
        let input = Input().numbersCsv(name: "Day11Input.txt")
        for (index, element) in input.enumerated() {
            memory[index] = Int(element)
        }
        
        grid[Pair(values:(T:0,U:0))] = 1
        let intcode = Intcode(memory: memory)
        
        while !intcode.halted {
            if grid[Pair(values:(T: robotLocation.0, U: robotLocation.1))] == nil {
                grid[Pair(values:(T: robotLocation.0, U: robotLocation.1))] = 0
            }
            intcode.io = grid[Pair(values:(T: robotLocation.0, U: robotLocation.1))]
            intcode.runUntilNextOutput()
            guard !intcode.halted else { break }
            //Ready to output
            intcode.runComputer()
            // color to paint
            grid[Pair(values:(T: robotLocation.0, U: robotLocation.1))] = intcode.io
            intcode.runUntilNextOutput()
            // Ready to output
            intcode.runComputer()
            let direction = intcode.io!
            switch direction {
            case 0: //left
                move(direction: .left)
            case 1: //right
                move(direction: .right)
            default:
                break
            }
            
        }
    }
    
    public override func part1() -> String {
        
        //doTheThing()
        return "Total number painted: \(grid.count)"
    }
    
    public override func part2() -> String {
        
        doTheThing()
        var maxX = 0
        var minX = 0
        var maxY = 0
        var minY = 0
        for (key, _) in grid {
            maxX = max(key.values.0, maxX)
            minX = min(key.values.0, minX)
            maxY = max(key.values.1, maxY)
            minY = min(key.values.1, minY)
        }
        
        print("\(minX)\n\(maxX)\n\(minY)\n\(maxY)")
        
        var resultArray = Array(repeating: Array(repeating: " ", count: 50), count: 10)
        //I feel like hardcoding this will come back to bite me, but for now, it works.
        for (key, value) in grid {
            resultArray[key.values.1+5][key.values.0] = value == 1 ? "*" : " "
        }
        
        resultArray.reversed().forEach {
            var result = ""
            $0.forEach {
                result += $0
            }
            print(result)
        }
        return ""
    }
}
