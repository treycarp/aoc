//
//  Day3.swift
//  AOC
//
//  Created by Trey Carpenter on 12/2/20.
//

import Foundation

public class Day3: Day {
    
    private func findTrees(field: [[String]], move: (Int, Int)) -> Int {
        var currentPosition: (Int, Int) = (0,0)
        var trees = 0
        while currentPosition.0 < field.count {
            if field[currentPosition.0][currentPosition.1] == "#" {
                trees += 1
            }
            currentPosition = (currentPosition.0 + move.0, (currentPosition.1 + move.1) % field[currentPosition.0].count)
        }
        
        return trees
    }
    
    public override func part1() -> String {
        let move: (Int, Int) = (1,3)
        let field = Input().arrayOfCharacterLines(name: "Day3Input.txt", year: "2020")
        let trees = findTrees(field: field, move: move)
        return "Trees encountered: \(trees)"
    }
    
    public override func part2() -> String {
        let moves: [(Int, Int)] = [ (1,1), (1,3), (1,5), (1,7), (2,1)]
        let field = Input().arrayOfCharacterLines(name: "Day3Input.txt", year: "2020")
        let answer: Int = moves.reduce(1) {
            findTrees(field: field, move: $1) * $0
        }
        return "Answer: \(answer)"
    }
}
