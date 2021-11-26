//
//  Day17.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/17/20.
//

import Foundation

public class Day17: Day {

    public override func part1() -> String {
        return "Answer: \(doTurns(for: .three))"
    }
    
    public override func part2() -> String {
        let start = DispatchTime.now() // <<<<<<<<<< Start time
        let answer = doTurns(for: .four)
        let end = DispatchTime.now()   // <<<<<<<<<<   end time

        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
        let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests

        print("Time to evaluate: \(timeInterval) seconds")
        return "Answer: \(answer)"
    }
    
    private func doTurns(for dimension: Dimensions) -> Int {
        var grid = parseInput()
        
        for turn in 1...6 {
            expandGrid(grid: &grid, for: dimension)
            let gridCopy = grid
            for (coordinate, state) in gridCopy {
                let activeNeighbors = countActiveNeighbors(coordinate: coordinate, grid: gridCopy, for: dimension)
                
                if state == DimensionState.active && activeNeighbors != 2 && activeNeighbors != 3 {
                    grid[coordinate] = .inactive
                } else if activeNeighbors == 3 {
                    grid[coordinate] = .active
                }
            }
            print("Completed turn: \(turn)")
        }
        
        let active = grid.filter {
            $0.value == .active
        }
        
        return active.count
    }
    
    private func expandGrid(grid: inout [Coordinate<Int, Int, Int, Int>: DimensionState], for dimensions: Dimensions) {
        var x = (0,0)
        var y = (0,0)
        var z = (0,0)
        var w = (0,0)
        
        for (coordinate, _) in grid {
            x = (min(coordinate.values.0, x.0), max(coordinate.values.0, x.1))
            y = (min(coordinate.values.1, y.0), max(coordinate.values.1, y.1))
            z = (min(coordinate.values.2, z.0), max(coordinate.values.2, z.1))
            w = (min(coordinate.values.3, w.0), max(coordinate.values.3, w.1))
        }
        
        x = (x.0 - 1, x.1 + 1)
        y = (y.0 - 1, y.1 + 1)
        z = (z.0 - 1, z.1 + 1)
        w = (w.0 - 1, w.1 + 1)
        
        for xIndex in x.0...x.1 {
            for yIndex in y.0...y.1 {
                for zIndex in z.0...z.1 {
                    if dimensions == .three {
                        if grid[Coordinate(values: (T: xIndex, U: yIndex, V: zIndex, W: 0))] == nil {
                            grid[Coordinate(values: (T: xIndex, U: yIndex, V: zIndex, W: 0))] = .inactive
                        }
                    } else {
                        for wIndex in w.0...w.1 {
                            if grid[Coordinate(values: (T: xIndex, U: yIndex, V: zIndex, W: wIndex))] == nil {
                                grid[Coordinate(values: (T: xIndex, U: yIndex, V: zIndex, W: wIndex))] = .inactive
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func countActiveNeighbors(coordinate: Coordinate<Int, Int, Int, Int>, grid: [Coordinate<Int, Int, Int, Int>: DimensionState], for dimensions: Dimensions) -> Int {
        var activeCount = 0
        
        for x in -1...1 {
            for y in -1...1 {
                for z in -1...1 {
                    if dimensions == .three {
                        if  x == 0 && y == 0 && z == 0  {
                            continue
                        }
                        
                        if grid[Coordinate(values: (T: coordinate.values.0 + x, U: coordinate.values.1 + y, V: coordinate.values.2 + z, W: 0))] == .active {
                            activeCount += 1
                        }
                    } else {
                        for w in -1...1 {
                            if  x == 0 && y == 0 && z == 0 && w == 0 {
                                continue
                            }
                            
                            if grid[Coordinate(values: (T: coordinate.values.0 + x, U: coordinate.values.1 + y, V: coordinate.values.2 + z, W: coordinate.values.3 + w))] == .active {
                                activeCount += 1
                            }
                        }
                    }
                }
            }
        }
        
        return activeCount
    }
    
    private func parseInput() -> [Coordinate<Int, Int, Int, Int>: DimensionState] {
        let lines = Input().arrayOfCharacterLines(name: "Day17Input.txt", year: "2020")
        var grid: [Coordinate<Int, Int, Int, Int>: DimensionState] = [:]
        for (row, line) in lines.enumerated() {
            for (column, spot) in line.enumerated() {
                grid[Coordinate(values: (T: column, U: row, V: 0, W: 0))] = DimensionState(rawValue: spot)
            }
        }
        
        return grid
    }
}

enum DimensionState: String {
    case inactive = "."
    case active = "#"
}

enum Dimensions {
    case three
    case four
}

struct Coordinate<T: Hashable, U: Hashable, V: Hashable, W: Hashable> : Hashable {
    let values: (T, U, V, W)
    
    func hash(into hasher: inout Hasher) {
        let (x,y,z,w) = values
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
        hasher.combine(w)
    }
    
    static func ==<T: Hashable, U:Hashable>(lhs: Coordinate<T,U,V,W>, rhs: Coordinate<T,U,V,W>) -> Bool {
        return lhs.values == rhs.values
    }
}
