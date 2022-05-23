//
//  Day11.swift
//  AOC
//
//  Created by Trey Carpenter on 12/17/21.
//

import Foundation

public class Day11: Day {
    
    var grid = [[Int]]()
    
    public override func part1() -> String {
        grid = Input().digits(name: "Day11Input.txt", year: "2021")
        var flashes = 0
        for step in 1...100 {
            incrementGrid()
            
            var noNines = false
            while !noNines {
                noNines = true
                for x in 0..<grid.count {
                    for y in 0..<grid.count {
                        if grid[y][x] > 9 {
                            noNines = false
                            // increment top left
                            if y > 0 && x > 0 && grid[y - 1][x - 1] > 0 {
                                grid[y - 1][x - 1] += 1
                            }
                            
                            // increment top
                            if y > 0 && grid[y - 1][x] > 0 {
                                grid[y - 1][x] += 1
                            }
                            
                            // increment top right
                            if y > 0 && x < grid.count - 1 && grid[y - 1][x + 1] > 0 {
                                grid[y - 1][x + 1] += 1
                            }
                            
                            // left
                            if x > 0 && grid[y][x - 1] > 0 {
                                grid[y][x - 1] += 1
                            }
                            
                            // right
                            if x < grid.count - 1 && grid[y][x + 1] > 0 {
                                grid[y][x + 1] += 1
                            }
                            
                            // bottom left
                            if y < grid.count - 1 && x > 0 && grid[y + 1][x - 1] > 0 {
                                grid[y + 1][x - 1] += 1
                            }
                            
                            // bottom
                            if y < grid.count - 1 && grid[y + 1][x] > 0 {
                                grid[y + 1][x] += 1
                            }
                            
                            // bottom right
                            if y < grid.count - 1 && x < grid.count - 1 && grid[y + 1][x + 1] > 0 {
                                grid[y + 1][x + 1] += 1
                            }
                            
                            grid[y][x] = 0
                            flashes += 1
                        }
                    }
                }
            }
            print("After step \(step):")
            printGrid()
        }
        
        return "\(flashes)"
    }
    
    public override func part2() -> String {
        grid = Input().digits(name: "Day11Input.txt", year: "2021")
        var flashes = 0
        for step in 1...100000000 {
            incrementGrid()
            
            var noNines = false
            while !noNines {
                noNines = true
                for x in 0..<grid.count {
                    for y in 0..<grid.count {
                        if grid[y][x] > 9 {
                            noNines = false
                            // increment top left
                            if y > 0 && x > 0 && grid[y - 1][x - 1] > 0 {
                                grid[y - 1][x - 1] += 1
                            }
                            
                            // increment top
                            if y > 0 && grid[y - 1][x] > 0 {
                                grid[y - 1][x] += 1
                            }
                            
                            // increment top right
                            if y > 0 && x < grid.count - 1 && grid[y - 1][x + 1] > 0 {
                                grid[y - 1][x + 1] += 1
                            }
                            
                            // left
                            if x > 0 && grid[y][x - 1] > 0 {
                                grid[y][x - 1] += 1
                            }
                            
                            // right
                            if x < grid.count - 1 && grid[y][x + 1] > 0 {
                                grid[y][x + 1] += 1
                            }
                            
                            // bottom left
                            if y < grid.count - 1 && x > 0 && grid[y + 1][x - 1] > 0 {
                                grid[y + 1][x - 1] += 1
                            }
                            
                            // bottom
                            if y < grid.count - 1 && grid[y + 1][x] > 0 {
                                grid[y + 1][x] += 1
                            }
                            
                            // bottom right
                            if y < grid.count - 1 && x < grid.count - 1 && grid[y + 1][x + 1] > 0 {
                                grid[y + 1][x + 1] += 1
                            }
                            
                            grid[y][x] = 0
                            flashes += 1
                        }
                    }
                }
            }
            if grid.allSatisfy({ row in
                row.allSatisfy { cell in
                    cell == 0
                }
            }) {
                return "Step: \(step)"
            }
            print("After step \(step):")
            printGrid()
        }
        return ""
    }
    
    private func printGrid() {
        for y in 0..<grid.count {
            print(grid[y].map{ String($0) }.joined(separator: " "))
        }
    }
    
    private func incrementGrid() {
        for x in 0..<grid.count {
            for y in 0..<grid.count {
                grid[y][x] += 1
            }
        }
    }
}
