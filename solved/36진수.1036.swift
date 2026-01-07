import Foundation

private let digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"

extension String {

    fileprivate func multiplyBy36() -> String {
        var carry = 0
        var result: [Int] = []

        for ch in self.reversed() {
            let digit = Int(String(ch))!
            let value = digit * 36 + carry
            result.append(value % 10)
            carry = value / 10
        }

        while carry > 0 {
            result.append(carry % 10)
            carry /= 10
        }

        return result.reversed().map(String.init).joined()
    }

    fileprivate func stringSum(add: Int) -> String {
        let a = Array(self).map { Int(String($0))! }
        let b = Array(String(add)).map { Int(String($0))! }

        var i = a.count - 1
        var j = b.count - 1
        var carry = 0
        var result: [Int] = []

        while i >= 0 || j >= 0 || carry > 0 {
            let x = i >= 0 ? a[i] : 0
            let y = j >= 0 ? b[j] : 0
            let sum = x + y + carry

            result.append(sum % 10)
            carry = sum / 10

            i -= 1
            j -= 1
        }

        return result.reversed().map(String.init).joined()
    }

    fileprivate func stringSum(add: String) -> String {
        let a = Array(self)
        let b = Array(add)

        var i = a.count - 1
        var j = b.count - 1
        var carry = 0
        var result: [Character] = []

        while i >= 0 || j >= 0 || carry > 0 {
            let x = i >= 0 ? Int(String(a[i]))! : 0
            let y = j >= 0 ? Int(String(b[j]))! : 0

            let sum = x + y + carry
            result.append(Character(String(sum % 10)))
            carry = sum / 10

            i -= 1
            j -= 1
        }

        return String(result.reversed())
    }

    fileprivate func thirtySixBaseToDecimal() -> String {
        let chars = Array(self)
        var result = ""

        for c in chars {
            let value: Int
            if c.isNumber {
                value = Int(String(c))!
            } else {
                value = Int(c.asciiValue! - Character("A").asciiValue!) + 10
            }
            result = result.multiplyBy36().stringSum(add: value)
        }
        return result
    }

    fileprivate func decimalToThirtySixBase() -> String {
        var number = self
        var result = ""

        while number != "0" {
            let (quotient, remainder) = number.divideBy36()
            result.append(digits[remainder])
            number = quotient
        }

        return result.isEmpty ? "0" : String(result.reversed())
    }

    fileprivate func divideBy36() -> (quotient: String, remainder: Int) {
        var remainder = 0
        var quotient = ""

        for ch in self {
            let digit = Int(String(ch))!
            let value = remainder * 10 + digit
            let q = value / 36
            remainder = value % 36

            if !(quotient.isEmpty && q == 0) {
                quotient.append(Character(String(q)))
            }
        }

        return (quotient.isEmpty ? "0" : quotient, remainder)
    }
}

//맞은 거
func solve_1036() {
    let fio = FileIO()
    let n = fio.readInt()
    var numbers: [String] = []
    for _ in 0..<n {
        numbers.append(fio.readString())
    }
    let k = fio.readInt()

    var list = [(String, String)](repeating: ("", "0"), count: 36)

    for (i, base) in digits.map({ String($0) }).enumerated() {
        let tempNumbers = numbers.map { number in
            number.map { String($0) == base ? "Z" : String($0) }.joined()
        }
        let tempNumbersValue =
            tempNumbers
            .map { $0.thirtySixBaseToDecimal() }
            .reduce("") { $0.stringSum(add: $1) }

        list[i] = (base, tempNumbersValue)
    }
    list = list.sorted(by: { lhs, rhs in
        if lhs.1.count != rhs.1.count {
            return lhs.1.count > rhs.1.count
        } else {
            for (l, r) in zip(lhs.1.map { String($0) }, rhs.1.map { String($0) }) {
                if l == r { continue }
                return Int(l)! > Int(r)!
            }
            return true
        }
    })

    for i in 0..<k {
        let find = list[i].0
        numbers = numbers.map { number in
            number.map { String($0) == find ? "Z" : String($0) }.joined()
        }
    }

    let result =
        numbers
        .map { $0.thirtySixBaseToDecimal() }
        .reduce("") { $0.stringSum(add: $1) }
        .decimalToThirtySixBase()

    print(result)

}

// 틀린 거
func solve_1036_wrong() {
    let fio = FileIO()
    let n = fio.readInt()
    var numbers: [String] = []
    for _ in 0..<n {
        numbers.append(fio.readString())
    }
    let k = fio.readInt()

    for _ in 0..<k {
        // Z는 Z로 변환할 필요가 없으므로
        // 맨 왼쪽의 연이은 Z들을 제거한 numbers이다.
        let tempNumbers = numbers.map {
            String($0.drop(while: { $0 == "Z" }))
        }

        // 가장 긴 자릿수를 가진 숫자들을 구한다.
        var temps: [String] = []
        var maxLen = 0

        for number in tempNumbers {
            if maxLen < number.count {
                maxLen = number.count
                temps = []
                temps.append(number)
            } else if maxLen == number.count {
                temps.append(number)
            }
        }

        // 가장 긴 자릿수를 가진 숫자가 여러개인 경우 맨 윈쪽의 수가 가장 작은 수를 구한다.
        // 자릿수가 같다면 Y보단 1을 Z로 변환하는게 이득이므로.
        var maxDigitIndex = Int.max

        for temp in temps {
            if temp.isEmpty { continue }
            if let ii = digits.firstIntIndex(where: { String($0) == temp[0] }) {
                maxDigitIndex = min(maxDigitIndex, ii)
            }
        }

        // numbers 업데이트.
        if maxDigitIndex != Int.max {
            let find = digits[maxDigitIndex]

            numbers = numbers.map { number in
                number.map { String($0) == find ? "Z" : String($0) }.joined()
            }
        }
    }

    let answer =
        numbers
        .map { $0.thirtySixBaseToDecimal() }
        .reduce("") { $0.stringSum(add: $1) }
        .decimalToThirtySixBase()

    print(answer)
}

/*
 https://www.acmicpc.net/problem/1036
 36진수.1036
 2026.1.7

 구현 + 그리디 문제.

 36진수 정수가 최대 50자리까지 입력으로 주어질 수 있으므로 계산으론 안되고 매우큰 정수 문자열 사칙연산을 직접 구현해야 한다.

 처음엔 그리디한 방법으로 각 주어진 36진수 수들중 자릿수가 가장 큰수들만 골라내고 같은 자릿수를 가진 수들이 있다면 가장 왼쪽이 작은걸 골라서 Z로 바꿔주면

 더했을 때 가장 큰수를 얻을 수있다고 생각했다. 근데 오답 이고 반례는 모르겠다.

 그리디 방법을 바꿨다.

 그냥 치환가능한 숫자 0 ~ Z까지 36번 돌면서 해당 수를 Z로 바꿨을때 얻을수있는 이득을 전부구해서 내림차순 정렬한다.

 상위 k개를 골라서 원본에서 Z로 치환해서 더해서 출력하면 정답이었다.

 그리디자체의 난이도는 그닥이었는데 매우 큰수 사칙연산 구현 & 진수변환 이좀 까다롭고 귀찮은 문제였다.


1
ZZZZZZZ
36

1
KEQUALS36
36

8
RSTUVWXY12RSTUVWXY12RSTUVWXY12RSTUVWXY12RSTUVWXY1
RSTUVWXY12RSTUVWXY12RSTUVWXY12RSTUVWXY12RSTUVWXY1
RSTUVWXY12RSTUVWXY12RSTUVWXY12RSTUVWXY12RSTUVWXY1
RSTUVWXY12RSTUVWXY12RSTUVWXY12RSTUVWXY12RSTUVWXY1
RSTUVWXY12RSTUVWXY12RSTUVWXY12RSTUVWXY12RSTUVWXY1
RSTUVWXY12RSTUVWXY12RSTUVWXY12RSTUVWXY12RSTUVWXY1
RSTUVWXY12RSTUVWXY12RSTUVWXY12RSTUVWXY12RSTUVWXY1
RSTUVWXY12RSTUVWXY12RSTUVWXY12RSTUVWXY12RSTUVWXY1
14
 */
