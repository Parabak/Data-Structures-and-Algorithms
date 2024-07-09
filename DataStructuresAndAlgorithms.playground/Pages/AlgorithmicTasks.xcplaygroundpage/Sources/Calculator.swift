import Foundation


/*
 In Swift, implement a calculator class. The calculator can perform Addition, Subtraction, Multiplication and Division
 on 2 Integers and returns an Integer. In the logic you can only use the '+' plus operator and a constant with value of -1.

 Division will return only the smallest whole number (e.g. 14/5 = 2)
 */

public struct Calculator {

    static public func addition(x: Int, y: Int) -> Int {
        return x + y
    }

    static public func subtraction(x: Int, y: Int) -> Int {
        return x + flipSign(x: y)
    }

    static public func multiplication(x: Int, y: Int) -> Int {

        if y == 0 || x == 0 { return 0 }
        if y == 1 { return x }

        var result = 0

        var multiplicant = x
        var multiplier = y
        if multiplicant < 0 { multiplicant = flipSign(x: multiplicant) }
        if multiplier < 0 { multiplier = flipSign(x: multiplier) }

        while multiplier > 0 {
            result = addition(x: result, y: multiplicant)
            multiplier = addition(x: multiplier, y: -1)
        }

        if (x < 0 && y > 0 ) || (y < 0 && x > 0) {
            result = flipSign(x: result)
        }

        return result
    }

    static public func division(x: Int, y: Int) -> Int {
        if y == 0 || x == 0 { return 0 }
        if y == 1 { return x }

        var divisor = x
        var divider = y
        if divisor < 0 { divisor = flipSign(x: divisor) }
        if divider < 0 { divider = flipSign(x: divider) }

        var result = 0
        for index in 1...divisor {
            if multiplication(x: index, y: divider) > divisor {
                break
            }

            result = index
        }

        if (x < 0 && y > 0 ) || (y < 0 && x > 0) {
            result = flipSign(x: result)
        }

        return result
    }

    static private func flipSign(x: Int) -> Int {

        guard x != 0 else { return 0 }

        var tmp = 0
        let constanst = -1

        let range = x > 0 ? 0..<x : x..<0

        for _ in range {
            tmp = tmp + (x > 0 ? constanst : 1)
        }

        return tmp
    }
}

/*
Calculator.subtraction(x: 6, y: 2) // 4
Calculator.subtraction(x: -6, y: 2) // -8
Calculator.subtraction(x: -6, y: -2) // -4

Calculator.multiplication(x: 3, y: 3) // 9
Calculator.multiplication(x: 3, y: 0) // 0
Calculator.multiplication(x: 0, y: 3) // 0

Calculator.multiplication(x: -3, y: 3) // -9
Calculator.multiplication(x: 3, y: -3) // -9
Calculator.multiplication(x: -3, y: -3) // 9

Calculator.division(x: 10, y: 2) // 5
Calculator.division(x: 14, y: 5) // 2
Calculator.division(x: 10, y: -2) // -5
Calculator.division(x: -14, y: 5) // -2
Calculator.division(x: -14, y: -5) // 2
 */

