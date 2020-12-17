//
//  Math.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/13/20.
//

import Foundation

public class Math {
    
    public init() {
        //Empty init
    }
    
    func euclid(_ m:Int, _ n:Int) -> (Int,Int) {
        if m % n == 0 {
            return (0,1)
        } else {
            let rs = euclid(n % m, m)
            let r = rs.1 - rs.0 * (n / m)
            let s = rs.0
     
            return (r,s)
        }
    }
    
    func gcd(_ m:Int, _ n:Int) -> Int {
        let rs = euclid(m, n)
        return m * rs.0 + n * rs.1
    }
    
    public func lcm(_ x: Int, _ y: Int) -> Int {
        return x / gcd(x, y) * y
    }
    
    func coprime(_ m:Int, _ n:Int) -> Bool {
        return gcd(m,n) == 1 ? true : false
    }
    
    public func crt(_ a_i:[Int], _ n_i:[Int]) -> Int {
        // There is no identity operator for elements of [Int].
        // The offset of the elements of an enumerated sequence
        // can be used instead, to determine if two elements of the same
        // array are the same.
        let divs = n_i.enumerated()
     
        // Check if elements of n_i are pairwise coprime divs.filter{ $0.0 < n.0 }
        divs.forEach{
            n in divs.filter{ $0.0 < n.0 }.forEach{
                assert(coprime(n.1, $0.1))
            }
        }
     
        // Calculate factor N
        let N = n_i.map{$0}.reduce(1, *)
     
        // Euclidean algorithm determines s_i (and r_i)
        var s:[Int] = []
     
        // Using euclidean algorithm to calculate r_i, s_i
        n_i.forEach{ s += [euclid($0, N / $0).1] }
     
        // Solve for x
        var x = 0
        a_i.enumerated().forEach{
            x += $0.1 * s[$0.0] * N / n_i[$0.0]
        }
     
        // Return minimal solution
        return x % N
    }
}
