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

public extension Array where Element == Character {
    // Limitation: all elements are unique (otherwise: `nil` return)
    func replacementPermute(sampleSize width: Int) -> [String]? {
        guard count == Set(self).count else { return nil }

        var permutations: [String] = []
        if let zero = first {
            let numPerms = ((0..<width).reduce(1) { (p, _) in p * count })
            permutations.reserveCapacity(numPerms)
            for i in 0..<numPerms {
                let nonPaddedPermutation = String(i, radix: count)
                    .compactMap { Int(String($0), radix: count) }
                    .map { String(self[$0]) }
                    .joined()
                permutations.append(nonPaddedPermutation
                    .leftPadded(with: zero, toAtLeast: width))
            }
        }
        return permutations
    }
}
