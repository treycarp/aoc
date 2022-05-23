//
//  Day9.swift
//  AOC2021
//
//  Created by Trey Carpenter on 12/9/21.
//

import Foundation

public class Day9: Day {
    
    public override func part1() -> String {
        let grid: [[Int]] = Input().strings(name: "Day9Input.txt", year: "2021").map { Array($0).map { Int(String($0))! } }
        var lowPoints = [Int]()
        for yIndex in 0..<grid.count {
            for xIndex in 0..<grid[yIndex].count {
                if isLowest(grid: grid, point: Point(x: xIndex, y: yIndex)) {
                    lowPoints.append(grid[yIndex][xIndex])
                }
            }
        }
        let sum = lowPoints.reduce(0, +) + lowPoints.count
        return "\(sum)"
    }
    
    public override func part2() -> String {
        return ""
    }
    
    private func isLowest(grid: [[Int]], point: Point) -> Bool {
        if point.x > 0 { // check left
            guard grid[point.y][point.x - 1] > grid[point.y][point.x] else { return false}
        }
        
        if point.x < grid[point.y].count - 1 { // check right
            guard grid[point.y][point.x + 1] > grid[point.y][point.x] else { return false}
        }
        
        if point.y > 0 { // check up
            guard grid[point.y - 1][point.x] > grid[point.y][point.x] else { return false }
        }
        
        if point.y < grid.count - 1 { //check down
            guard grid[point.y + 1][point.x] > grid[point.y][point.x] else { return false }
        }
        
        return true
    }
}

struct Point {
    let x: Int
    let y: Int
}
