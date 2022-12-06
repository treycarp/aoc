//
//  Day5.swift
//
//  Created on 12/5/22.
//  
//

import Foundation

class Stack<T> {
    private var items: [T] = []
    
    init(items: [T]) {
        self.items = items
    }
    
    convenience init() {
        self.init(items: [])
    }
    
    func peek() -> T? {
        items.first
    }
    
    func pop() -> T {
        items.removeFirst()
    }
    
    func push(element: T) {
        items.insert(element, at: 0)
    }
    
    func count() -> Int {
        items.count
    }
}

struct Move {
    let from: Int
    let to: Int
    let quantity: Int
}

public class Day5: Day {
    
    private func createStacks() -> [Stack<String>] {
        var stacks = [Stack<String>]()
        let stack1 = Stack(items: ["N", "V", "C", "S"])
        let stack2 = Stack(items: ["S", "N", "H", "J", "M", "Z"])
        let stack3 = Stack(items: ["D", "N", "J", "G", "T", "C", "M"])
        let stack4 = Stack(items: ["M", "R", "W","J", "F", "D", "T"])
        let stack5 = Stack(items: ["H", "F", "P"])
        let stack6 = Stack(items: ["J", "H", "Z", "T", "C"])
        let stack7 = Stack(items: ["Z", "L", "S", "F", "Q", "R", "P", "D"])
        let stack8 = Stack(items: ["W", "P", "F", "D", "H", "L", "S", "C"])
        let stack9 = Stack(items: ["Z", "G", "N", "F", "P", "M", "S", "D"])
        stacks.append(stack1)
        stacks.append(stack2)
        stacks.append(stack3)
        stacks.append(stack4)
        stacks.append(stack5)
        stacks.append(stack6)
        stacks.append(stack7)
        stacks.append(stack8)
        stacks.append(stack9)
        return stacks
    }
    
    private func createMoves() -> [Move] {
        return Input().strings(name: "Day5Input.txt", year: "2022").map {
            let parts = $0.split(separator: " ")
            return Move(from: Int(String(parts[3]))!, to: Int(String(parts[5]))!, quantity: Int(String(parts[1]))!)
        }
        
    }

    public override func part1() -> String {
        
        let stacks = createStacks()
        let moves = createMoves()
        
        for move in moves {
            for _ in 0..<move.quantity {
                let pop = stacks[move.from - 1].pop()
                stacks[move.to - 1].push(element: pop)
            }
        }

        return "\(stacks.map { $0.peek()! }.joined())"
    }

    public override func part2() -> String {
        
        let stacks = createStacks()
        let moves = createMoves()
        
        for move in moves {
            let tempStack = Stack<String>()
            for _ in 0..<move.quantity {
                tempStack.push(element: stacks[move.from - 1].pop())
            }
            for _ in 0..<tempStack.count() {
                let pop = tempStack.pop()
                stacks[move.to - 1].push(element: pop)
            }
        }
        return "\(stacks.map { $0.peek()! }.joined())"
    }
}
