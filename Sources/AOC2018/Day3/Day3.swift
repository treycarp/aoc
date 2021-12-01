//
//  Day3.swift
//  AOC2019
//
//  Created by Trey Carpenter on 11/25/21.
//

import Foundation

public class Day3: Day {
    public override func part1() -> String {
        let claims = Input().strings(name: "Day3Input.txt", year: "2018")
        var map = Array(repeating: Array(repeating: ".", count: 2000), count: 2000)
        
        var overlapCount = 0

        for claim in claims {
            //#250 @ 230,168: 19x25
            let splitClaim = claim.split(separator: " ")
            
            let claimNumber = String(splitClaim[0].dropFirst())
            
            let x = Int(String(splitClaim[2].dropLast().split(separator: ",")[0]))!
            let y = Int(String(splitClaim[2].dropLast().split(separator: ",")[1]))!
            
            let width = Int(String(splitClaim[3].split(separator: "x")[0]))!
            let height = Int(String(splitClaim[3].split(separator: "x")[1]))!
            
            for yIndex in y + 1..<y + 1 + height {
                for xIndex in x + 1..<x + 1 + width {
                    guard map[yIndex][xIndex] != "X" else { continue }
                    
                    if map[yIndex][xIndex] != "." {
                        map[yIndex][xIndex] = "X"
                        overlapCount += 1
                    } else {
                        map[yIndex][xIndex] = claimNumber
                    }
                }
            }
        }
        
        return "\(overlapCount)"
    }
    
    public override func part2() -> String {
        let claims = Input().strings(name: "Day3Input.txt", year: "2018")
        var map = Array(repeating: Array(repeating: ".", count: 2000), count: 2000)

        var nonOverlappedClaim = 0
        
        for claim in claims {
            //#250 @ 230,168: 19x25
            let splitClaim = claim.split(separator: " ")
            
            let claimNumber = String(splitClaim[0].dropFirst())
            
            let x = Int(String(splitClaim[2].dropLast().split(separator: ",")[0]))!
            let y = Int(String(splitClaim[2].dropLast().split(separator: ",")[1]))!
            
            let width = Int(String(splitClaim[3].split(separator: "x")[0]))!
            let height = Int(String(splitClaim[3].split(separator: "x")[1]))!
            
            for yIndex in y + 1..<y + 1 + height {
                for xIndex in x + 1..<x + 1 + width {
                    guard map[yIndex][xIndex] != "X" else { continue }
                    
                    if map[yIndex][xIndex] != "." {
                        map[yIndex][xIndex] = "X"
                    } else {
                        map[yIndex][xIndex] = claimNumber
                    }
                }
            }
        }
        
        for claim in claims {
            guard nonOverlappedClaim == 0 else { continue }
            //#250 @ 230,168: 19x25
            let splitClaim = claim.split(separator: " ")
            
            let claimNumber = Int(String(splitClaim[0].dropFirst()))!
            
            let x = Int(String(splitClaim[2].dropLast().split(separator: ",")[0]))!
            let y = Int(String(splitClaim[2].dropLast().split(separator: ",")[1]))!
            
            let width = Int(String(splitClaim[3].split(separator: "x")[0]))!
            let height = Int(String(splitClaim[3].split(separator: "x")[1]))!
            
            var overlapped = false
            for yIndex in y + 1..<y + 1 + height {
                guard overlapped == false else { continue }
                for xIndex in x + 1..<x + 1 + width {
                    guard overlapped == false else { continue }
                    if map[yIndex][xIndex] == "X" {
                        overlapped = true
                        nonOverlappedClaim = 0
                    } else {
                        nonOverlappedClaim = claimNumber
                    }
                }
            }
        }
        
        return "\(nonOverlappedClaim)"
    }
}
