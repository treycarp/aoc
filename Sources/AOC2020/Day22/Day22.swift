//
//  Day22.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/22/20.
//

import Foundation

public class Day22: Day {
    
    public override func part1() -> String {
        let lines = Input().strings(name: "Day22Input.txt", year: "2020")
        var cardsP1 = [Int]()
        var cardsP2 = [Int]()
        
        var p2Input = false
        for line in lines {
            if line == "Player 1:" { continue }
            if line == "Player 2:" {
                p2Input = true
                continue
            }
            guard let card = Int(line) else { continue }
            if p2Input {
                cardsP2.append(card)
            } else {
                cardsP1.append(card)
            }
        }
        
        let result = playGame(p1: cardsP1, p2: cardsP2)
        let winningHand = result.0.count > 0 ? result.0 : result.1
        
        var multiplier = 0
        let answer = winningHand.reversed().reduce(0) {
            multiplier += 1
            return $0 + $1 * multiplier
        }
        return "Answer: \(answer)"
    }
    
    public override func part2() -> String {
        let lines = Input().strings(name: "Day22Input.txt", year: "2020")
        var cardsP1 = [Int]()
        var cardsP2 = [Int]()
        
        var p2Input = false
        for line in lines {
            if line == "Player 1:" { continue }
            if line == "Player 2:" {
                p2Input = true
                continue
            }
            guard let card = Int(line) else { continue }
            if p2Input {
                cardsP2.append(card)
            } else {
                cardsP1.append(card)
            }
        }
        
        let result = playGame(p1: cardsP1, p2: cardsP2, recurse: true)
        let winningHand = result.0.count > 0 ? result.0 : result.1
        
        var multiplier = 0
        let answer = winningHand.reversed().reduce(0) {
            multiplier += 1
            return $0 + $1 * multiplier
        }
        return "Answer: \(answer)"
    }
    
    private func playGame(p1: [Int], p2: [Int], game: Int = 1, recurse: Bool = false) -> ([Int], [Int]) {
        var cardsP1 = p1
        var cardsP2 = p2
        
        var round = 1
        var p1History = [[Int]]()
        var p2History = [[Int]]()
        while cardsP1.count != 0 && cardsP2.count != 0 {
            guard !cardsP1.containsSameElements(as: p1History) && !cardsP2.containsSameElements(as: p2History) else {
                return (cardsP1, [])
            }
            p1History.append(cardsP1)
            p2History.append(cardsP2)
            let cardP1 = cardsP1.remove(at: 0)
            let cardP2 = cardsP2.remove(at: 0)
            
            if recurse {
                // determine if value of both cards is higher than number of cards
                if cardsP1.count >= cardP1 && cardsP2.count >= cardP2 {
                    let result = playGame(p1: Array(cardsP1.prefix(cardP1)), p2: Array(cardsP2.prefix(cardP2)), game: game + 1, recurse: true)
                    if result.1.count == 0 {
                        cardsP1.append(cardP1)
                        cardsP1.append(cardP2)
                    } else if result.0.count == 0 {
                        cardsP2.append(cardP2)
                        cardsP2.append(cardP1)
                    } else if result.0.count == result.1.count {
                        cardsP1.append(cardP1)
                        cardsP2.append(cardP2)
                    }
                } else {
                    if cardP1 > cardP2 {
                        // p1 wins
                        cardsP1.append(cardP1)
                        cardsP1.append(cardP2)
                    } else if cardP1 < cardP2 {
                        // p2 wins
                        cardsP2.append(cardP2)
                        cardsP2.append(cardP1)
                    } else {
                        // draw
                        cardsP1.append(cardP1)
                        cardsP2.append(cardP2)
                    }
                }
            } else {
                if cardP1 > cardP2 {
                    // p1 wins
                    cardsP1.append(cardP1)
                    cardsP1.append(cardP2)
                } else if cardP1 < cardP2 {
                    // p2 wins
                    cardsP2.append(cardP2)
                    cardsP2.append(cardP1)
                } else {
                    // draw
                    cardsP1.append(cardP1)
                    cardsP2.append(cardP2)
                }
            }
            
            
            //print("Game \(game), round \(round):\nPlayer 1: \(cardsP1)\nPlayer 2: \(cardsP2)")
            round += 1
        }
        
        return (cardsP1, cardsP2)
    }
}

extension Array where Element: Comparable {
    func containsSameElements(as other: [[Element]]) -> Bool {
        for list in other {
            if self.count == list.count && self == list {
                return true
            }
        }
        return false
    }
}
