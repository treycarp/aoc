//
//  Day13.swift
//  AOC2021
//
//  Created by Trey Carpenter on 12/20/21.
//

import Foundation

public class Day13: Day {
    
    var grid = [[String]]()
    var folds = [String]()
    
    public override func part1() -> String {
        buildGrid()
        let firstFold = folds.first!
        if firstFold.contains("y=") {
            foldHorizontal(position: Int(String(firstFold.split(separator: "=")[1]))!)
        } else {
            foldVertical(position: Int(String(firstFold.split(separator: "=")[1]))!)
        }
        return "\(grid.map { $0.filter { string in string == "#"}}.map { row in row.count}.reduce(0, +))"
    }
    
    public override func part2() -> String {
        buildGrid()
        for fold in folds {
            if fold.contains("y=") {
                foldHorizontal(position: Int(String(fold.split(separator: "=")[1]))!)
            } else {
                foldVertical(position: Int(String(fold.split(separator: "=")[1]))!)
            }
        }
        return "\(printGrid())"
    }
    
    private func printGrid() -> String {
        var string = ""
        for y in 0..<grid.count {
            string += "\(grid[y].map{ String($0) }.joined(separator: ""))\n"
        }
        return string
    }
    
    private func buildGrid() {
        
        let lines = Input().strings(name: "Day13Input.txt", year: "2021")
        let coords = lines.filter { $0.contains(",") }.map { string in
            return Point(x: Int(string.split(separator: ",")[0])!, y: Int(string.split(separator: ",")[1])!)
        }
        
        folds = lines.filter { !$0.contains(",") }
        
        let maxY = coords.max { coord1, coord2 in
            coord1.y < coord2.y
        }
        
        let maxX = coords.max { coord1, coord2 in
            return coord1.x < coord2.x
        }
        
        grid = Array(repeating: Array(repeating: ".", count: maxX!.x + 1), count: maxY!.y + 1)
        for coord in coords {
            grid[coord.y][coord.x] = "#"
        }
    }
    
    private func foldVertical(position: Int) {
        var tempGrid = Array(repeating: Array(repeating: ".", count: position), count: grid.count)
        for y in 0..<grid.count {
            for x in 0..<grid[0].count {
                if x > position && grid[y][x] == "#" {
                    tempGrid[y][x - (((x % position) == 0 ? position : x % position) * 2)] = grid[y][x]
                } else if x < position {
                    tempGrid[y][x] = grid[y][x]
                }
            }
        }
        grid = tempGrid
    }
    
    private func foldHorizontal(position: Int) {
        var tempGrid = Array(repeating: Array(repeating: ".", count: grid[0].count), count: position)
        for y in 0..<grid.count {
            for x in 0..<grid[0].count {
                if y > position && grid[y][x] == "#" {
                    tempGrid[y - (((y % position) == 0 ? position : y % position) * 2)][x] = grid[y][x]
                } else if y < position {
                    tempGrid[y][x] = grid[y][x]
                }
            }
        }
        grid = tempGrid
    }
    
    struct Point {
        let x: Int
        let y: Int
    }
}
