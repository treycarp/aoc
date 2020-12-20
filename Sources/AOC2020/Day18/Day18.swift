//
//  Day18.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/18/20.
//

import Foundation

public class Day18: Day {
    
    public override func part1() -> String {
        //1 + 2 * 3 + 4 * 5 + 6
        let lines = Input().strings(name: "Day18Input.txt", year: "2020")
        var answer = 0
        for line in lines {
            var fullExpression = line.replacingOccurrences(of: " ", with: "")
            // first find end parentheses and then find it's partner, do math inside.
            fullExpression = replaceParens(expression: fullExpression, additionFirst: false)
            let expressions = fullExpression.split(usingRegex: "(?<=\\d)(?=\\D)|(?<=\\D)")
            answer += Int(doLeftRightMath(expressions))!
        }
        
        
        return "Answer: \(answer)"
    }
    
    public override func part2() -> String {
        let lines = Input().strings(name: "Day18Input.txt", year: "2020")
        var answer = 0
        for line in lines {
            var fullExpression = line.replacingOccurrences(of: " ", with: "")
            // first find end parentheses and then find it's partner, do math inside.
            fullExpression = replaceParens(expression: fullExpression, additionFirst: true)
            let expressions = fullExpression.split(usingRegex: "(?<=\\d)(?=\\D)|(?<=\\D)")
            answer += Int(doAdditionThenMultiply(expressions))!
        }
        return "Answer: \(answer)"
    }
    
    private func replaceParens(expression: String, additionFirst: Bool) -> String {
        var hasParens = true
        var newExpression = expression
        
        while hasParens {
            if let closeParenIndex = newExpression.firstIndex { $0 == ")" } {
                var clippedExpression = String(newExpression.prefix(upTo: closeParenIndex))
                if let openParenIndex = clippedExpression.lastIndex(of: "(") {
                    clippedExpression = String(clippedExpression.suffix(from: openParenIndex).dropFirst())
                    let arrayExpression = clippedExpression.split(usingRegex: "(?<=\\d)(?=\\D)|(?<=\\D)")
                    let parenAnswer = additionFirst ? doAdditionThenMultiply(arrayExpression) : doLeftRightMath(arrayExpression)
                    newExpression.replaceSubrange(openParenIndex...closeParenIndex, with: parenAnswer)
                }
            } else {
                hasParens = false
            }
        }
        
        return newExpression
    }
    
    private func doAdditionThenMultiply(_ expressions: [String]) -> String {
        guard expressions.contains("+") else { return doLeftRightMath(expressions) }
        
        let additionIndex = expressions.firstIndex { $0 == "+" }!
        let answer = doLeftRightMath(Array(expressions[additionIndex - 1...additionIndex + 1]))
        var newExpressions = expressions
        newExpressions.removeSubrange(additionIndex - 1...additionIndex + 1)
        newExpressions.insert(answer, at: additionIndex - 1 )
        return doAdditionThenMultiply(newExpressions)
    }
    
    private func doLeftRightMath(_ expressions: [String]) -> String {
        guard expressions.count >= 3 else { return expressions[0] }
        
        let lhs = Int(expressions[0])!
        let op = expressions[1]
        let rhs = Int(expressions[2])!
        var newExpression = expressions
        newExpression.removeSubrange(0...2)
        switch op {
        case "+":
            newExpression.insert(String(lhs + rhs), at: 0)
        case "*":
            newExpression.insert(String(lhs * rhs), at: 0)
        case "-":
            newExpression.insert(String(lhs - rhs), at: 0)
        case "/":
            newExpression.insert(String(lhs / rhs), at: 0)
        default:
            return ""
        }
        
        return doLeftRightMath(newExpression)
    }
}

extension String {
    func split(usingRegex pattern: String) -> [String] {
        let regex = try! NSRegularExpression(pattern: pattern)
        let matches = regex.matches(in: self, range: NSRange(0..<utf16.count))
        let ranges = [startIndex..<startIndex] + matches.map{Range($0.range, in: self)!} + [endIndex..<endIndex]
        return (0...matches.count).map {String(self[ranges[$0].upperBound..<ranges[$0+1].lowerBound])}
    }
}
