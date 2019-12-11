//
//  Array.swift
//  AOC
//
//  Created by Trey Carpenter on 12/10/19.
//

import Foundation

public extension Array {
    func chopped() -> (Element, [Element])? {
        guard let x = self.first else { return nil }
        return (x, Array(self.suffix(from: 1)))
    }
}

public extension Array {
    func interleaved(_ element: Element) -> [[Element]] {
        guard let (head, rest) = self.chopped() else { return [[element]] }
        return [[element] + self] + rest.interleaved(element).map { [head] + $0 }
    }
}

public extension Array {
    var permutations: [[Element]] {
        guard let (head, rest) = self.chopped() else { return [[]] }
        return rest.permutations.flatMap { $0.interleaved(head) }
    }
}
