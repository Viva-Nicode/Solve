import Foundation

func solve_1069() {
    let io = FileIO()
    let x = io.readInt(), y = io.readInt(), d = io.readInt(), t = io.readInt()

    let dis = sqrt(Double(x ^^ 2 + y ^^ 2))
    var answer = dis

    let jumpCount = Int(dis / Double(d))

    if jumpCount > 0 {
        let remain = dis - Double(jumpCount * d)
        answer = min(answer, Double((jumpCount + 1) * t))
        answer = min(answer, Double(jumpCount * t) + remain)
    } else {
        answer = min(answer, Double(t) + (Double(d) - dis))
        answer = min(answer, Double(t) * 2)
    }
    print(answer)
}

/*
 https://www.acmicpc.net/problem/1069
 집으로.1069
 2025.2.21
 
 아이디어 떠올리기가 약간 어려운 문제.
 
 점프를 두번하면 최대 (점프거리) * 2까지를 갈수있다는 점만 깨닫으면 풀린다.
 
 Int와 Double을 연산해야 하므로 타입의 주의.
 
 
 */

/*
 
6 8 5 3
 6
 
3 4 6 3
 4
 
318 445 1200 800
 546.9451526432975
 
400 300 150 10
 40
 
6 8 3 2
 7
 
10 10 1000 5
 10
 
 */


