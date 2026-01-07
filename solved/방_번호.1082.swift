import Foundation

func solve_1082() {
    let _ = Int(readLine()!)!
    let numbers = readLine()!.components(separatedBy: " ").map { Int($0)! }
    var m = Int(readLine()!)!

    var minWithoutZero = Int.max
    var minIndexWithoutZero = 0

    for (i, cost) in numbers.enumerated() {
        if i == 0 {
            continue
        } else {
            if m >= cost && minWithoutZero >= cost {
                minWithoutZero = cost
                minIndexWithoutZero = i
            }
        }
    }

    if minWithoutZero == Int.max {
        print(0)
        return
    }

    var minn = minWithoutZero
    var minIndex = minIndexWithoutZero

    if numbers[0] < minWithoutZero {
        minn = numbers[0]
        minIndex = 0
    }

    var ddd = "\(String(minIndexWithoutZero))\(String(repeating: String(minIndex), count: (m - minWithoutZero) / minn))"
    m -= minWithoutZero
    m -= m / minn * minn

    func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
        var chars = Array(myString) // gets an array of characters
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }

    for (i, d) in ddd.enumerated() {
        if i == 0 {
            let ss = m + numbers[Int(String(d))!]
            var c = -1
            var newidx = -1

            for (iii, n) in numbers.enumerated() {
                if iii == 0 { continue }

                if n <= ss {
                    c = n
                    newidx = iii
                }
            }

            if c != -1 {
                m += numbers[Int(String(d))!]
                m -= c
                ddd = replace(myString: ddd, i, Character(String(newidx)))
            }

        } else {
            let ss = m + numbers[Int(String(d))!]
            var c = -1
            var newidx = -1

            for (iii, n) in numbers.enumerated() {

                if n <= ss {
                    c = n
                    newidx = iii
                }
            }

            if c != -1 {
                m += numbers[Int(String(d))!]
                m -= c
                ddd = replace(myString: ddd, i, Character(String(newidx)))
            }
        }

        if m <= 0 { break }
    }

    print(ddd)

}

/*
 https://www.acmicpc.net/problem/1082
 방_번호.1082
 2025.2.25
 
 정말 개그지같은 풀기 싫은 문제였다.
 
 원래는 DP + 브루트 포스인데
 
 그냥 아이디어로 해결(애드 혹? 그리디?)
 
 1. 돈이 되는 한 가장 긴 방 번호를 만든다.
 
 방번호 맨 왼쪽은 0번을 제외한 방번호중 가장싼거(맨앞에 0이 못오므로), 그외 나머지 방번호들은 전부 0번을 포함한 제일싼거로 최대한 길게 채워준다.
 
 그러면 AAAAAAAAA 또는 ABBBBBBB같이 된다.
 
 이제 맨 왼쪽부터 반복하면서 이거 팔아버리고 더 높은 번호중에 살수있는게 있나? 를 본다
 
 살수있으면산다. 돈이 0원이 되거나 이제 팔아도 살수있는게 없을 때까지 반복한다.
 
 */

