//
//  Day4.swift
//  AOC2021
//
//  Created by Trey Carpenter on 12/3/21.
//

import Foundation

public class Day4: Day {
    private func buildBoards(_ lines: [String]) -> [[[Int]]] {
        var boards = [[[Int]]]()
        var board = [[Int]]()
        
        for index in 2..<lines.count {
            guard lines[index] != "" else {
                boards.append(board)
                board = [[Int]]()
                continue
            }
            
            // row
            board.append(lines[index].split(separator: " ").map { Int($0)! })
        }
        
        return boards
    }
    
    public override func part1() -> String {
        
        let lines = Input().strings(name: "Day4Input.txt", year: "2021", omitBlanks: false)
        let numbers = lines[0].split(separator: ",").map { Int($0)! }
        let boards = buildBoards(lines)
        
        var calledNumbers = [Int]()
        
        var bingoBoard: [[Int]]?
        
        for number in numbers {
            guard bingoBoard == nil else { continue }
            calledNumbers.append(number)
            for board in boards {
                //check row
                for row in board {
                    let set = Set(row)
                    if set.isSubset(of: calledNumbers) {
                        bingoBoard = board
                    }
                }
                //check column
                for colIndex in 0..<board.count {
                    let set = Set(board.getColumn(column: colIndex))
                    if set.isSubset(of: calledNumbers) {
                        bingoBoard = board
                    }
                }
            }
        }
        guard let bingoBoard = bingoBoard else {
            return "Something messed up."
        }

        var sum = 0
        for row in bingoBoard {
            for number in row {
                if !calledNumbers.contains(number) {
                    sum += number
                }
            }
        }

        let lastNumber = calledNumbers.last!
        
        return "\(sum * lastNumber)"
    }
    
    public override func part2() -> String {
        let lines = Input().strings(name: "Day4Input.txt", year: "2021", omitBlanks: false)
        let numbers = lines[0].split(separator: ",").map { Int($0)! }
        var boards = buildBoards(lines)
        
        var calledNumbers = [Int]()
        
        var losingBoard: [[Int]]?
        
        for number in numbers {
            guard losingBoard == nil else { continue }
            var boardsToRemove = [[[Int]]]()
            calledNumbers.append(number)
            for board in boards {
                //check row
                for row in board {
                    let set = Set(row)
                    if set.isSubset(of: calledNumbers) {
                        boardsToRemove.append(board)
                    }
                }
                //check column
                for colIndex in 0..<board.count {
                    let set = Set(board.getColumn(column: colIndex))
                    if set.isSubset(of: calledNumbers) {
                        boardsToRemove.append(board)
                    }
                }
            }
            if boards.count > 1 && boardsToRemove.count > 0 {
                boards.removeAll { board in
                    boardsToRemove.contains(board)
                }
            } else if boards.count == 1 && boardsToRemove.count >= 0{
                losingBoard = boards.first
            }
        }
        guard let losingBoard = losingBoard else {
            return "Something messed up."
        }

        var sum = 0
        for row in losingBoard {
            for number in row {
                if !calledNumbers.contains(number) {
                    sum += number
                }
            }
        }

        let lastNumber = calledNumbers.last!
        
        return "\(sum * lastNumber)"
    }
}

extension Array where Element : Collection {
    func getColumn(column : Element.Index) -> [ Element.Iterator.Element ] {
        return self.map { $0[ column ] }
    }
    
    // commically bad
    func getDiagonal(reverse: Bool = false) -> [ Any ] {
        var diagonal = [Any]()
        if reverse {
            for index in self.count-1...0 {
                diagonal.append(self[index])
            }
        } else {
            for index in 0..<self.count {
                diagonal.append(self[index])
            }
        }
        
        return diagonal
    }
}
