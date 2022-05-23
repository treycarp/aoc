//
//  Day5.swift
//  AOC2021
//
//  Created by Trey Carpenter on 12/6/21.
//

import Foundation

public class Day5: Day {
    public override func part1() -> String {
        let coords = parse()
        
        var grid = Array(repeating: Array(repeating: ".", count: 10), count: 10)
        
        for coord in coords {
            guard coord.0 == coord.2 || coord.1 == coord.3 else { continue }
            if coord.2 - coord.0 == 0 { // vertical line
                let min = min(coord.1, coord.3)
                let max = max(coord.1, coord.3)
                for index in min...max {
                    grid[index][coord.2] = grid[index][coord.2] == "." ? "1" : "X"
                }
            } else if coord.3 - coord.1 == 0 { // horizontal line
                let min = min(coord.2, coord.0)
                let max = max(coord.2, coord.0)
                for index in min...max {
                    grid[coord.1][index] = grid[coord.1][index] == "." ? "1" : "X"
                }
            }
        }
        var count = 0
        for row in grid {
            //print("\(row.joined(separator: " "))\n")
            for cell in row {
                if cell == "X" {
                    count += 1
                }
            }
        }
        
        return "\(count)"
    }
    
    public override func part2() -> String {
        let coords = parse()
        
        var grid = Array(repeating: Array(repeating: ".", count: 10), count: 10)
        
        for coord in coords {
            if coord.2 - coord.0 == 0 { // vertical line
                let min = min(coord.1, coord.3)
                let max = max(coord.1, coord.3)
                for index in min...max {
                    grid[index][coord.2] = grid[index][coord.2] == "." ? "1" : "X"
                }
            } else if coord.3 - coord.1 == 0 { // horizontal line
                let min = min(coord.2, coord.0)
                let max = max(coord.2, coord.0)
                for index in min...max {
                    grid[coord.1][index] = grid[coord.1][index] == "." ? "1" : "X"
                }
            } else {
                let slope = Int((coord.3 - coord.1) / (coord.2 - coord.0))
                let intercept = slope * coord.0 + coord.1
                print(intercept)
//                for index in 0...xRange {
//                    grid[minY + index][minX + index] = grid[minY + index][minX + index] == "." ? "1" : "X"
//                }
            }
        }
        
        var count = 0
        for row in grid {
            print("\(row.joined(separator: " "))\n")
            for cell in row {
                if cell == "X" {
                    count += 1
                }
            }
        }
        
        return "\(count)"
    }
    
    private func parse() -> [(Int, Int, Int, Int)] {
        let lines = Input().strings(name: "Day5Input.txt", year: "2021")
        var coords = [(Int, Int, Int, Int)]()
        for line in lines {
            let splits = line.split(separator: " ")
            let coord1 = splits.first!.split(separator: ",").first!
            let coord2 = splits.first!.split(separator: ",").last!
            
            let coord3 = splits.last!.split(separator: ",").first!
            let coord4 = splits.last!.split(separator: ",").last!
            
            coords.append((Int(coord1)!, Int(coord2)!, Int(coord3)!, Int(coord4)!))
        }
        
        return coords
    }
}
