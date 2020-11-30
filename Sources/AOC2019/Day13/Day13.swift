//
//  Day13.swift
//  AOC
//
//  Created by Trey Carpenter on 12/14/19.
//

import Foundation
import AOCShared

enum TileType: Int {
    
    case empty
    case wall
    case block
    case paddle
    case ball
    case unknown
}

public class Day13: Day {
    
    var grid = [Pair<Int, Int>: TileType]()
    var score = 0
    
    fileprivate func runIntcode(_ memory: [Int]) {
        let intcode = Intcode(memory: memory)
        var x = -1
        var y = -1
        var tripIndex = -1
        while !intcode.halted {
            tripIndex+=1
            intcode.io = 0
            intcode.runUntilNextOutput()
            
            guard !intcode.halted else { break }
            
            intcode.runComputer()
            switch tripIndex % 3 {
            case 0:
                x = intcode.io!
            case 1:
                y = intcode.io!
            case 2:
                if x == -1 && y == 0 {
                    score = intcode.io!
                } else {
                    let pair = Pair(values: (T: x, U: y))
                    grid[pair] = TileType(rawValue: intcode.io!)
                    tripIndex = -1
                }
            default:
                break
            }
            
            
        }
    }
    
    func ballPosition() -> Pair<Int, Int>? {
        for (key, value) in grid {
            
            if value == .ball {
                return key
            }
        }
        
        return nil
    }
    
    func paddlePosition() -> Pair<Int, Int>? {
        for (key, value) in grid {
            
            if value == .paddle {
                return key
            }
        }
        
        return nil
    }
    
    public override func part1() -> String {
        
        var memory: [Int] = []
        memory.reserveCapacity(Int(INT32_MAX))
        memory = Array(repeating: Int(0), count: Int(INT32_MAX))
        let input = Input().numbersCsv(name: "Day13Input.txt", year: "2019")
        for (index, element) in input.enumerated() {
            memory[index] = Int(element)
        }

        runIntcode(memory)

        var blockCount = 0
        
        let xMin = grid.keys.map { $0.values.0 }.min()
        let xMax = grid.keys.map { $0.values.0 }.max()
        
        let yMin = grid.keys.map { $0.values.1 }.min()
        let yMax = grid.keys.map { $0.values.1 }.max()

        for (coord, tileType) in grid {
            print("Current coord: \(coord.values.0), \(coord.values.1)")
            if tileType == .block {
                blockCount += 1
            }
        }

        return "Total # of blocks: \(blockCount)"
        //return ""
    }
    
    func printGrid() {
        
       // var gridArray = 
    }
    
    public override func part2() -> String {
//        var memory: [Int] = []
//        memory.reserveCapacity(Int(INT32_MAX))
//        memory = Array(repeating: Int(0), count: Int(INT32_MAX))
//        let input = Input().numbersCsv(name: "Day13Input.txt")
//        for (index, element) in input.enumerated() {
//            memory[index] = Int(element)
//        }
//        memory[0] = 2
//        var ballPosition: Pair<Int, Int> = Pair(values: (T: -1, U: -1))
//        var paddlePosition: Pair<Int, Int> = Pair(values: (T: -1, U: -1))
//        var leftWallX = 0
//        var rightWallX = 0
//        var joystickCommand = 0
//        let intcode = Intcode(memory: memory)
//        var x = -1
//        var y = -1
//        var tripIndex = -1
//        while !intcode.halted {
//            tripIndex+=1
//            intcode.io = joystickCommand
//            intcode.runUntilNextOutput()
//
//            guard !intcode.halted else { break }
//
//            intcode.runComputer()
//            switch tripIndex % 3 {
//            case 0:
//                x = intcode.io!
//            case 1:
//                y = intcode.io!
//            case 2:
//                if x == -1 && y == 0 {
//                    score = intcode.io!
//                    print("New score: \(score)")
//                } else {
//                    let pair = Pair(values: (T: x, U: y))
//                    let tileType = TileType(rawValue: intcode.io!)
//                    grid[pair] = tileType
//                    tripIndex = -1
//                    if tileType == .wall {
//                        leftWallX = min(pair.values.0, leftWallX)
//                        rightWallX = max(pair.values.0, rightWallX)
//                    }
//                    else if tileType == .ball {
//                        if ballPosition.values.1 > pair.values.1 {
//                            // ball is moving down.
//                            // figure out which way ball is moving horizontally
//                            if ballPosition.values.0 > pair.values.0 {
//                                //ball is moving left
//                                //move paddle left
//                            }
//                        }
//                    }
//                }
//            default:
//                break
//            }
//        }
        return ""
    }
}
