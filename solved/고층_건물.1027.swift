import Foundation

func solve_1027() {
    let fio = FileIO()
    let n = fio.readInt()
    var answer = 0

    let buildings: [Int] = (0..<n).map { _ in fio.readInt() }

    for i in 0..<buildings.count {
        var maximumInclination = Double.zero
        var viewCount = 0

        for ii in i + 1..<buildings.count {
            if ii == i + 1 {
                maximumInclination = Double(buildings[ii] - buildings[i]) / Double(ii - i)
                viewCount += 1
            } else {
                let inclination = Double(buildings[ii] - buildings[i]) / Double(ii - i)
                if maximumInclination < inclination {
                    maximumInclination = inclination
                    viewCount += 1
                }
            }
        }

        maximumInclination = .zero

        for ii in stride(from: i - 1, through: 0, by: -1) {
            if ii == i - 1 {
                maximumInclination = Double(buildings[ii] - buildings[i]) / Double(ii - i)
                viewCount += 1
            } else {
                let inclination = Double(buildings[ii] - buildings[i]) / Double(ii - i)
                if maximumInclination > inclination {
                    maximumInclination = inclination
                    viewCount += 1
                }
            }
        }
        answer = max(answer, viewCount)
    }
    print(answer)
}

/*
 https://www.acmicpc.net/problem/1027
 2025.2.18
 어느 두 점을 이은 선분의 기울기를 구해야 하는문제.
 
 완전 탐색 하면된다.
 
 */

/*
15
1 5 3 2 6 3 2 6 4 2 5 7 3 1 5

1
10
 
4
5 5 5 5
 
5
1 2 7 3 2
 
10
1000000000 999999999 999999998 999999997 999999996 1 2 3 4 5
 
5
6 5 5 5 6
 4
 
10
10 1 1 1 1 1 1 1 1 10
 9
 
12
1 3 2 5 4 6 4 7 2 1 10 3
 6
 
11
9 9 9 9 9 10 10 10 10 10 11
 7
 
22
9 9 9 9 9 9 9 10 10 10 10 10 10 10 11 11 11 11 11 11 11 12
 9
 */
