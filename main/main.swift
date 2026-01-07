import Foundation

extension String {

    fileprivate func thirtySixBaseToDecimal() -> String {
        let chars = Array(self)
        var result = 0

        for c in chars {
            let value: Int
            if c.isNumber {
                value = Int(String(c))!
            } else {
                value = Int(c.asciiValue! - Character("A").asciiValue!) + 10
            }
            result = result * 36 + value
        }

        return String(result)
    }

    fileprivate func decimalToThirtySixBase() -> String {
        var number = Int(self)!
        if number == 0 { return "0" }

        let digits = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        var result = ""

        while number > 0 {
            result.append(digits[number % 36])
            number /= 36
        }

        return String(result.reversed())
    }
}

func solve_1036() {
    let fio = FileIO()
    let n = fio.readInt()
    var numbers: [String] = []
    for _ in 0..<n {
        numbers.append(fio.readString())
    }
    let k = fio.readInt()

    for _ in 0..<k {
        var temps: [String] = []
        var maxLen = 0

        for number in numbers {
            if maxLen < number.count {
                maxLen = number.count
                temps = []
                temps.append(number)
            } else if maxLen == number.count {
                temps.append(number)
            }
        }

        var maxDigitIndex = 0
        let digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for temp in temps {
            let ii = digits.firstIntIndex(where: { String($0) == temp[0] })!
            maxDigitIndex = max(maxDigitIndex, ii)
        }
        
        let find = digits[maxDigitIndex]
        
        numbers = numbers.map{ number in
            number.map{ String($0) == find ? "Z" :  String($0)}.joined()
        }
        
        

    }

    print(String(numbers.map { Int($0.thirtySixBaseToDecimal())! }.reduce(0, +)).decimalToThirtySixBase())

}

solve_1036()

/*
 https://www.acmicpc.net/problem/1036
 36진수.1036
 2026.1.6

 */
