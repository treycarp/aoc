//
//  Day2.swift
//  AOC2022
//
//  Created by Trey Carpenter on 12/2/22.
//

import Foundation

enum RPSSelection: Int {
    case rock = 1
    case paper = 2
    case scissors = 3
    
    init?(value: String) {
        switch value {
        case "A", "X":
            self = .rock
        case "B", "Y":
            self =  .paper
        case "C", "Z":
            self =  .scissors
        default:
            return nil
        }
    }
}

extension RPSSelection {
    
    static func compare(selection1: RPSSelection, selection2: RPSSelection) -> (Int, Int) {
        if selection1 == selection2 {
            return (selection1.rawValue + 3, selection1.rawValue + 3)
        } else if case .rock = selection1 {
            if case .paper = selection2 {
                // Lose to paper
                return (selection1.rawValue, selection2.rawValue + 6)
            } else {
                // Defeat scissors
                return (selection1.rawValue + 6, selection2.rawValue)
            }
        } else if case .paper = selection1 {
            if case .scissors = selection2 {
                // Lose to scissors
                return (selection1.rawValue, selection2.rawValue + 6)
            } else {
                // Defeat rock
                return (selection1.rawValue + 6, selection2.rawValue)
            }
        } else {
            if case .rock = selection2 {
                // Lose to rock
                return (selection1.rawValue, selection2.rawValue + 6)
            } else {
                // Defeat paper
                return (selection1.rawValue + 6, selection2.rawValue)
            }
        }
    }
}

enum RPSOutcome: String {
    case draw = "Y"
    case win = "Z"
    case lose = "X"
    
    static func evaluate(selection: RPSSelection, outcome: RPSOutcome) -> Int {
        switch outcome {
        case .draw:
            return selection.rawValue + 3
        case .win:
            if case .rock = selection {
                return RPSSelection.paper.rawValue + 6
            } else if case .paper = selection {
                return RPSSelection.scissors.rawValue + 6
            } else {
                return RPSSelection.rock.rawValue + 6
            }
        case .lose:
            if case .rock = selection {
                return RPSSelection.scissors.rawValue
            } else if case .paper = selection {
                return RPSSelection.rock.rawValue
            } else {
                return RPSSelection.paper.rawValue
            }
        }
    }
}

public class Day2: Day {
    
    public override func part1() -> String {
        let lines = Input().strings(name: "Day2Input.txt", year: "2022")
        let sum = lines.reduce(0) { partialResult, line in
            guard let opponentSelection = RPSSelection(value: String(line.split(separator: " ")[0])),
                  let mySelection = RPSSelection(value: String(line.split(separator: " ")[1])) else { return 0 }
            let returnValue = RPSSelection.compare(selection1: opponentSelection, selection2: mySelection).1
            return partialResult + returnValue
        }
        return "\(sum)"
    }
    
    public override func part2() -> String {
        let lines = Input().strings(name: "Day2Input.txt", year: "2022")
        let sum = lines.reduce(0) { partialResult, line in
            guard let opponentSelection = RPSSelection(value: String(line.split(separator: " ")[0])),
                  let outcome = RPSOutcome(rawValue: String(line.split(separator: " ")[1])) else { return 0 }
            let returnValue = RPSOutcome.evaluate(selection: opponentSelection, outcome: outcome)
            return partialResult + returnValue
        }
        return "\(sum)"
    }
}
