import Foundation

func solve_1019() {
    var ans = [Int](repeating: 0, count: 10)
    let n = FileIO().readInt()
    let stringn = String(n)

    for i in 0..<stringn.count {
        let placeMultiplier = 10^^(stringn.count - i - 1)
        let zeroCount = String(placeMultiplier).map { String($0) }.filter { $0 == "0" }.count
        var initList: [Int] = []

        if stringn[i] == "0" { continue }

        if placeMultiplier == 1 {
            for ii in 0..<stringn.count - 1 {
                ans[Int(stringn[ii])!] += Int(stringn[stringn.count - 1])!
            }
            if Int(stringn[stringn.count - 1])! > 0 {
                (1...Int(stringn[stringn.count - 1])!).forEach { ans[$0] += 1 }
            }
        } else if placeMultiplier == 10 {
            initList = [1, 2, 1, 1, 1, 1, 1, 1, 1, 1]
        } else {
            let zs = "\(zeroCount - 2)\(String(repeating: "8", count: max(0, zeroCount - 2)))9"
            initList = [Int(zs)! + zeroCount, Int("\(zeroCount)\(String(repeating: "0", count: max(0, zeroCount - 1)))")! + 1]
            (0..<8).forEach { _ in initList.append(Int("\(zeroCount)\(String(repeating: "0", count: max(0, zeroCount - 1)))")!) }
        }

        if placeMultiplier > 1 {
            let digit = Int(stringn[i])!

            if digit > 1 {
                for ii in 1..<digit {
                    let addedNum = Int("\(zeroCount)\(String(repeating: "0", count: zeroCount - 1))")!
                    initList = initList.map { $0 + addedNum }
                    initList[ii] += placeMultiplier
                    initList[ii] -= 1
                    initList[ii + 1] += 1
                }
            }
        }

        if i > 0 && stringn.count - 1 > i {
            let m = String(stringn.suffix(stringn.count - i))
            let mm = Int("\(m[0])\(String(repeating: "0", count: String(m).count - 1))")!

            for ii in 0..<i {
                initList[Int(stringn[ii])!] += mm
            }

            for ii in 1..<m.count {
                initList[0] += (m.count - ii) * Int("9\(String(repeating: "0", count: ii - 1))")!
            }
        }

        for iii in 0..<initList.count {
            ans[iii] += initList[iii]
        }

    }
    print(ans.map { String($0) }.joined(separator: " "))
}

/*
 https://www.acmicpc.net/problem/1019
 책_페이지.1019
 2025.2.23
 
 규칙성은 아래와 같다.
 
 순서대로 n이 10, 20, 30... 인경우
 [1, 2, 1, 1, 1, 1, 1, 1, 1, 1]
 [2, 12, 3, 2, 2, 2, 2, 2, 2, 2]
 [3, 13, 13, 4, 3, 3, 3, 3, 3, 3]
 [4, 14, 14, 14, 5, 4, 4, 4, 4, 4]
 [5, 15, 15, 15, 15, 6, 5, 5, 5, 5]
 [6, 16, 16, 16, 16, 16, 7, 6, 6, 6]
 [7, 17, 17, 17, 17, 17, 17, 8, 7, 7]
 [8, 18, 18, 18, 18, 18, 18, 18, 9, 8]
 [9, 19, 19, 19, 19, 19, 19, 19, 19, 10]
 
 100, 200, 300... 인경우
 [11, 21, 20, 20, 20, 20, 20, 20, 20, 20]
 [31, 140, 41, 40, 40, 40, 40, 40, 40, 40]
 [51, 160, 160, 61, 60, 60, 60, 60, 60, 60]
 [71, 180, 180, 180, 81, 80, 80, 80, 80, 80]
 [91, 200, 200, 200, 200, 101, 100, 100, 100, 100]
 [111, 220, 220, 220, 220, 220, 121, 120, 120, 120]
 [131, 240, 240, 240, 240, 240, 240, 141, 140, 140]
 [151, 260, 260, 260, 260, 260, 260, 260, 161, 160]
 [171, 280, 280, 280, 280, 280, 280, 280, 280, 181]
 
 1000, 2000, 3000, 4000인경우
 [192, 301, 300, 300, 300, 300, 300, 300, 300, 300]
 [492, 1600, 601, 600, 600, 600, 600, 600, 600, 600]
 [792, 1900, 1900, 901, 900, 900, 900, 900, 900, 900]
 [1092, 2200, 2200, 2200, 1201, 1200, 1200, 1200, 1200, 1200]
 
 10,000
 [2893, 4001, 4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000]
 [6893, 18000, 8001, 8000, 8000, 8000, 8000, 8000, 8000, 8000]
 [10893, 22000, 22000, 12001, 12000, 12000, 12000, 12000, 12000, 12000]
 [14893, 26000, 26000, 26000, 16001, 16000, 16000, 16000, 16000, 16000]
 
 100,000
 [38894, 50001, 50000, 50000, 50000, 50000, 50000, 50000, 50000, 50000]
 [88894, 200000, 100001, 100000, 100000, 100000, 100000, 100000, 100000, 100000]
 
 1,000,000
 [488895, 600001, 600000, 600000, 600000, 600000, 600000, 600000, 600000, 600000]
 [1088895, 2200000, 1200001, 1200000, 1200000, 1200000, 1200000, 1200000, 1200000, 1200000]
 
 0이 출현하는 횟수는 n이 10,000인 경우 (10000에서 0의 갯수 - 2)(10000에서 0의 갯수 - 2만큼의 8)9
 
 이렇게 해서 38889에다가 10000에서 0의 갯수를 더하면 38894가 된다.
 
 나머지는 10000에서 0의 갯수 즉 4에다가 4-1만큼의 0을 붙이면 4000이된다.
 20000일때의 1의 출현 횟수는 10000 + 원래값 + 4000이다.
 
 n이 12345인 경우 10000, 2000, 300, 40, 5 로 분할해서 각각을 구해서 더했다.
 
 단 아래 경우의 주의
 
 가장 왼쪽자리 즉 12345에서 10000을계산할 때는 그냥 더하지만
 
 2000을 계산할 때는 가장 왼쪽 1이 2000번 반복한다.
 
 그리고 1 ~ 2000까지는 규칙성으로 바로 구해줄 수있지만 실제로는
 10001 10002 10003 ... 11998 11999 12000 이렇게 가기때문에
 10001 10002 10003 왼쪽 부분처럼 0이 추가로 발생하는거 더해줘야한다.
 
 */
