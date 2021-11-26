//
//  Day20.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/21/20.
//

import Foundation

public class Day20: Day {
    public override func part1() -> String {
        var tiles = parseInput()
        
        // find all sides
        for (index, var tile) in tiles.enumerated() {
            
            //rotate
            for r in 0...3 {
                print("\(tile.tileNumber)")
                tile.rotate(degrees: 90 * r)
                for flipCount in 1...2 {
                    tiles.forEach { testTile in
                        let sideMatched = tile.matchesSide(aTile: testTile)
                        if sideMatched != .none {
                            print("\(tile.tileNumber) side: \(sideMatched) flipped: \(flipCount>1) rotated: \(90 * r) - matched \(testTile.tileNumber)")
                        }
                        tiles[index].matched(side: sideMatched, index: testTile.tileNumber)
                    }
                    tile.flip()
                }
            }
            tile.reset()
        }
        
        // report out which tiles only have two matches
        var corners = [Int]()
        tiles.forEach {
            guard $0.isCorner() != nil else { return }
            corners.append($0.tileNumber)
        }
        
        let product = corners.reduce(1, *)
        return "Answer: \(product)"
    }
    
    private func parseInput() -> [Tile] {
        let lines = Input().strings(name: "Day20TestInput.txt", year: "2020", omitBlanks: false)
        var tileNumber = 0
        var tiles: [Tile] = []
        var grid: [[String]] = []
        for line in lines {
            if line == "" {
                tiles.append(Tile(tileNumber: tileNumber, originalGrid: grid, grid: grid))
                grid = []
                continue
            }
            if line.contains(":") {
                tileNumber = Int(String(line.suffix(5).dropLast()))!
            } else {
                grid.append(line.map { String($0) })
            }
        }
        
        return tiles
    }
    
    public override func part2() -> String {
        return ""
    }
}

struct Tile {
    let tileNumber: Int
    var originalGrid: [[String]]
    var grid: [[String]]
    
    var left: Int? = nil
    var right: Int? = nil
    var top: Int? = nil
    var bottom: Int? = nil
    
    func printGrid() {
        let str = grid.map {
            $0.map { char -> String in
                char
            }.joined()
        }.joined(separator: "\n")
        print("Tile: \(tileNumber):\n\(str)")
    }
    
    mutating func rotate(degrees: Int) {
        guard degrees > 0 else { return }
        var newGrid: [[String]] = Array(repeating: Array(repeating: "", count: grid[0].count), count: grid.count)
        let num = degrees / 90
        for _ in 0...num {
            for row in 0..<grid.count {
                for col in 0..<grid[0].count {
                    newGrid[col][grid.count - 1 - row] = grid[row][col]
                }
            }
        }
        grid = newGrid
    }
    
    mutating func flip() {
        for row in 0..<grid.count {
            grid[row].reverse()
        }
    }
    
    func matchesSide(aTile: Tile) -> MatchedSide {
        guard aTile.tileNumber != tileNumber else { return .none }
        if aTile.grid[aTile.grid.count - 1].joined() == grid[0].joined() { // bottom to top
            return .bottom
        } else if aTile.grid[0].joined() == grid[grid.count - 1].joined() { // top to bottom
            return .top
        } else if aTile.grid.map({ $0[0] }).joined() == grid.map({ $0[grid.count - 1] }).joined()  { // left to right
            return .left
        } else if aTile.grid.map({ $0[aTile.grid.count - 1] }).joined() == grid.map({ $0[0] }).joined()  { // right to left
            return .right
        } else {
            return .none
        }
    }
    
    func hasMatch(for side: MatchedSide) -> Bool {
        if side == .bottom {
            return bottom != .none
        } else if side == .top {
            return top != .none
        } else if side == .right {
            return right != .none
        } else if side == .left {
            return left != .none
        }
        return false
    }
    
    mutating func matched(side: MatchedSide, index: Int) {
        switch side {
        case .bottom: bottom = index
        case .top: top = index
        case .left: left = index
        case .right: right = index
        default: break
        }
    }
    
    mutating func reset() {
        grid = originalGrid
    }
    
    func isCorner() -> Corner? {
        if top == nil && right == nil { return .topRight }
        else if top == nil && left == nil { return .topLeft }
        else if bottom == nil && right == nil { return .bottomRight }
        else if bottom == nil && left == nil { return .bottomLeft }
        return nil
    }
}

enum MatchedSide {
    case top
    case right
    case left
    case bottom
    case none
}

enum Corner {
    case topRight
    case topLeft
    case bottomRight
    case bottomLeft
}

extension Int {
    var double: Double {
        Double(self)
    }
}

extension Double {
    var roundedInt: Int {
        Int(self.rounded())
    }
}
