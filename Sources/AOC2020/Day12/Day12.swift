//
//  Day12.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/12/20.
//

import Foundation

public class Day12: Day {
    public override func part1() -> String {
        let lines = Input().strings(name: "Day12Input.txt", year: "2020")
        var pos = (0, 0)
        var currentDirection = Direction.east
        
        lines.forEach {
            let instruction = Direction(rawValue: String($0.prefix(1)))!
            let distance = Int($0.dropFirst())!
            
            switch instruction {
            case .north, .south, .east, .west:
                pos = moveDirection(direction: instruction, positions: distance, position: pos)
            case .left, .right:
                currentDirection = changeDirection(rotation: distance, originalDirection: currentDirection, rotationDirection: instruction)
            default:
                pos = moveDirection(direction: currentDirection, positions: distance, position: pos)
            }
            print("Instruction: \($0), position after move: \(pos), currentDirection: \(currentDirection)")
        }
        
        return "final position: \(pos.0 + pos.1)"
    }
    
    public override func part2() -> String {
        let lines = Input().strings(name: "Day12Input.txt", year: "2020")
        var pos: (Int, Int) = (0, 0)
        var waypointPos: (Int, Int) = (10, -1)
        
        lines.forEach {
            let instruction = Direction(rawValue: String($0.prefix(1)))!
            let distance = Int($0.dropFirst())!
            
            switch instruction {
            case .north, .south, .east, .west:
                waypointPos = moveDirection(direction: instruction, positions: distance, position: waypointPos)
            case .left:
                let radians = deg2rad(Double(distance))
                waypointPos = rotatePoint(point: waypointPos, radians: -radians)
            case .right:
                let radians = deg2rad(Double(distance))
                waypointPos = rotatePoint(point: waypointPos, radians: radians)
            case .forward:
                pos = (pos.0 + waypointPos.0 * distance, pos.1 + waypointPos.1 * distance)
            }
            print("Instruction: \($0), position after move: \(pos), waypoint pos: \(waypointPos)")
        }
        
        return "final position: \(pos.0 + pos.1)"
    }
    
    private func rotatePoint(point: (Int, Int), radians: Double) -> (Int, Int) {
        let xPrime = Double(point.0) * cos(Double(radians)) - Double(point.1) * sin(Double(radians))
        let yPrime = Double(point.0) * sin(Double(radians)) + Double(point.1) * cos(Double(radians))
        return (Int(round(xPrime)), Int(round(yPrime)))
    }
    
    private func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    private func changeDirection(rotation: Int, originalDirection: Direction, rotationDirection: Direction) -> Direction {
        switch originalDirection {
        case .north:
            switch rotationDirection {
            case .right:
                switch rotation {
                case 90: return .east
                case 180: return .south
                case 270: return .west
                case 360: return .north
                default: return originalDirection
                }
            case .left:
                switch rotation {
                case 90: return .west
                case 180: return .south
                case 270: return .east
                case 360: return .north
                default: return originalDirection
                }
            default:
                return originalDirection
            }
        case .east:
            switch rotationDirection {
            case .right:
                switch rotation {
                case 90: return .south
                case 180: return .west
                case 270: return .north
                case 360: return .east
                default: return originalDirection
                }
            case .left:
                switch rotation {
                case 90: return .north
                case 180: return .west
                case 270: return .south
                case 360: return .east
                default: return originalDirection
                }
            default:
                return originalDirection
            }
        case .south:
            switch rotationDirection {
            case .right:
                switch rotation {
                case 90: return .west
                case 180: return .north
                case 270: return .east
                case 360: return .south
                default: return originalDirection
                }
            case .left:
                switch rotation {
                case 90: return .east
                case 180: return .north
                case 270: return .west
                case 360: return .south
                default: return originalDirection
                }
            default:
                return originalDirection
            }
        case .west:
            switch rotationDirection {
            case .right:
                switch rotation {
                case 90: return .north
                case 180: return .east
                case 270: return .south
                case 360: return .west
                default: return originalDirection
                }
            case .left:
                switch rotation {
                case 90: return .south
                case 180: return .east
                case 270: return .north
                case 360: return .west
                default: return originalDirection
                }
            default:
                return originalDirection
            }
        default:
            return originalDirection
        }
    }
    
    private func moveDirection(direction: Direction, positions: Int, position: (Int, Int)) -> (Int, Int) {
        var pos = position
        switch direction {
            case .north: pos = (pos.0, pos.1 - positions)
            case .south: pos = (pos.0, pos.1 + positions)
            case .east: pos = (pos.0 + positions, pos.1)
            case .west: pos = (pos.0 - positions, pos.1)
        default:
            break
        }
        
        return pos
    }
    
    private enum Direction: String {
        case north = "N"
        case south = "S"
        case east = "E"
        case west = "W"
        case left = "L"
        case right = "R"
        case forward = "F"
    }
}
