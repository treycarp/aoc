//
//  Day11.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/11/20.
//

import Foundation

public class Day11: Day {
    public override func part1() -> String {
        var seats = Input().arrayOfCharacterLines(name: "Day11Input.txt", year: "2020")
        var seatsChanged = true
        while seatsChanged {
            seatsChanged = false
            var newSeats = seats
            for (rowIndex, row) in seats.enumerated() {
                for (columnIndex, seat) in row.enumerated() {
                    switch seat {
                    case "L":
                        if countAdjacentSeatsOccupied(row: rowIndex, col: columnIndex, rows: seats) == 0 {
                            newSeats[rowIndex][columnIndex] = "#"
                            seatsChanged = true
                        }
                    case "#":
                        if countAdjacentSeatsOccupied(row: rowIndex, col: columnIndex, rows: seats) >= 4 {
                            newSeats[rowIndex][columnIndex] = "L"
                            seatsChanged = true
                        }
                    case ".":
                        break
                    default:
                        break
                    }
                }
            }
            seats = newSeats
        }
        let count = seats.reduce(0) {
            $0 + $1.filter { seat -> Bool in
                seat == "#"
            }.count
        }
        return "Answer: \(count)"
    }
    
    public override func part2() -> String {
        var seats = Input().arrayOfCharacterLines(name: "Day11Input.txt", year: "2020")
        var seatsChanged = true
        while seatsChanged {
            seatsChanged = false
            var newSeats = seats
            for (rowIndex, row) in seats.enumerated() {
                for (columnIndex, seat) in row.enumerated() {
                    switch seat {
                    case "L":
                        if countVisibleOccupiedSeats(row: rowIndex, col: columnIndex, rows: seats) == 0 {
                            newSeats[rowIndex][columnIndex] = "#"
                            seatsChanged = true
                        }
                    case "#":
                        if countVisibleOccupiedSeats(row: rowIndex, col: columnIndex, rows: seats) >= 5 {
                            newSeats[rowIndex][columnIndex] = "L"
                            seatsChanged = true
                        }
                    case ".":
                        break
                    default:
                        break
                    }
                }
            }
            seats = newSeats
        }
        let count = seats.reduce(0) {
            $0 + $1.filter { seat -> Bool in
                seat == "#"
            }.count
        }
        return "Answer: \(count)"
    }
    
    private func countVisibleOccupiedSeats(row: Int, col: Int, rows: [[String]]) -> Int {
        var count = 0
        let directions: [Direction] = [.north, .south, .east, .west, .northeast, .northwest, .southwest, .southeast]
        directions.forEach {
            if isDirectionOccupied(row: row, col: col, rows: rows, direction: $0) {
                count += 1
            }
        }
        return count
    }
    
    private func isDirectionOccupied(row: Int, col: Int, rows: [[String]], direction: Direction) -> Bool {
        var colIndex = col
        var rowIndex = row
        while rowIndex >= 0 && rowIndex < rows.count && colIndex >= 0 && colIndex < rows[rowIndex].count {
            
            if !(rowIndex == row && colIndex == col) && rows[rowIndex][colIndex] == "#" {
                return true
            } else if !(rowIndex == row && colIndex == col) && rows[rowIndex][colIndex] == "L" {
                return false
            }
            
            switch direction {
            case .north:
                rowIndex -= 1
            case .south:
                rowIndex += 1
            case .east:
                colIndex += 1
            case .west:
                colIndex -= 1
            case .northeast:
                rowIndex -= 1
                colIndex += 1
            case .southeast:
                rowIndex += 1
                colIndex += 1
            case .southwest:
                rowIndex += 1
                colIndex -= 1
            case .northwest:
                rowIndex -= 1
                colIndex -= 1
            }
        }
        
        
        return false
    }
    
    private func countAdjacentSeatsOccupied(row: Int, col: Int, rows: [[String]]) -> Int {
        var count = 0
        // north
        if row > 0 && rows[row - 1][col] == "#" { count += 1 }
        // south
        if row < rows.count - 1 && rows[row + 1][col] == "#" { count += 1 }
        // west
        if col > 0 && rows[row][col - 1] == "#" { count += 1 }
        // east
        if col < rows[row].count - 1 && rows[row][col + 1] == "#" { count += 1 }
        // north east
        if col < rows[row].count - 1 && row > 0 && rows[row - 1][col + 1] == "#" { count += 1 }
        // south east
        if col < rows[row].count - 1 && row < rows.count - 1 && rows[row + 1][col + 1] == "#" { count += 1 }
        // south west
        if col > 0 && row < rows.count - 1 && rows[row + 1][col - 1] == "#" { count += 1 }
        // north west
        if col > 0 && row > 0 && rows[row - 1][col - 1] == "#" { count += 1 }
        return count
    }
}

enum Direction {
    case north
    case south
    case east
    case west
    case northeast
    case northwest
    case southwest
    case southeast
}
