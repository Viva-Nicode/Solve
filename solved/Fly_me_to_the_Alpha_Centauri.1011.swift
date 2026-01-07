import Foundation

func solve_1011() {
    let fio = FileIO()
    let tc = fio.readInt()
    var answer = ""

    for _ in 0..<tc {
        var summations: [Int] = [1]
        var moveCount = Int.zero
        var s = fio.readInt(), distance = fio.readInt()
        distance -= s

        if distance <= 3 {
            answer += "\(distance)\n"
            continue
        }

        for i in 2..<60000 { summations.append(summations.last! + i) }

        var left = 0, right = summations.count - 1

        // 이분탐색이다.
        // 사실 복잡도가 O(60000)이라서 이분탐색 안해도 될거같았지만 초과나면 귀찮게 일두번 해야하니까 그냥 해주었다.
        while left < right {
            let mid = (left + right) / 2
            // summations[mid]값 자체를 기준으로 이분 탐색하는 것이 아닌
            // summations[mid] * 2 - (summations[mid] - summations[mid - 1]) 처럼 summations[mid]값을 기반으로 계산된 값을 기준으로 이분 탐색한다.
            if distance < summations[mid] * 2 - (summations[mid] - summations[mid - 1]) {
                right = mid
            } else {
                left = mid + 1
            }
        }

        // lower bound는 찾고자 하는 값 이상이 나타나는 최초 위치를 찾으므로 만약 찾고자 하는 값보다 큰값을 찾았다면 1을 뺴줘서 찾은값 바로 전값으로 바꾼다.
        right -= distance < summations[right] * 2 - (summations[right] - summations[right - 1]) ? 1 : 0

        // 이동해야 하는 거리에서 이동한 만큼 거리를 빼준다.
        distance -= summations[right] * 2 - (summations[right] - summations[right - 1])
        // 왼쪽 부터 더해지는 값 순서대로
        // ((right + 1) * 2 - 1) 최고속력 right만큼 이동한 횟수
        // (distance / (right + 1)) 최고속력으로 이동하고 남은 거리에서 한번더 횟수1만 소비해서 최고속력으로 이동한 횟수
        // (distance % (right + 1) > 0 ? 1 : 0) 그러고도 이동할 거리가 남았으면 그냥 1더한다.
        moveCount += ((right + 1) * 2 - 1) + (distance / (right + 1)) + (distance % (right + 1) > 0 ? 1 : 0)
        answer += "\(moveCount)\n"
    }
    print(answer)
}

/*
 https://www.acmicpc.net/problem/1011
 2025.2.17
 
 구현이나, 알고리즘의 난이도 보다는 약간의 아이디어가 필요했던 쉬운 골드 문제?
 
 어떤 거리를 최소한의 횟수로 도달해야 하므로 가능한 만큼 가속을 해야한다.
 
 하지만 도착지점에는 1칸이동으로 도착해야하므로 가속했던만큼 감속하는 구간도 필요하다.(도착 직전의 속력이 2이하 여야한다.)
 
 예를 들어, 속도를 10만큼 가속해서 현재 속력이 10이라면, 10, 9 ,8 ... 3, 2, 1처럼 감속하는 구간이 반드시 필요하게 된다.
 
 최고 속력을 3으로 가속했을 때 이동되는 최소 거리는 1 + 2 + 3 + 2 + 1 = 9이다.
 최고 속력을 4로 가속했을 때 이동되는 최소 거리는 1 + 2 + 3 + 4 + 3 + 2 + 1 = 16이다.
 최고 속력을 5로 가속했을 때 이동되는 최소 거리는 25이다.
 
 따라서 이동해야 하는 거리가 20이라면 최고속력으로 4만큼 속력을 낼 수 있다.
 5를 내면 최소 거리가 25이므로 도착 직전에 속력 1로 도착할 수가 없다.
 
 그래서 20의 거리를 최고속력 4로 이동했다고 치자.
 그럼 20 - 16 = 4칸만큼 남는다.
 
 문제 조건에서 이전 속력이 k였다면 다음 이동거리는 (k - 1) 또는 k 또는 (k + 1) 중에서 결정할 수 있다.
 
 따라서 최고 속력이 4이고 남은 거리가 4라면 1부터 최고속력까지(=1, 2, 3, 4)중에서 이동횟수 1만 소비해서 이동할수 있다.
 
 1, 2, 3, 4중에서 남은 거리 4를 1, 3을 골라서 이동했다고 치자.
 
 1, 1, 2, 3, 3, 4, 3, 2, 1 = 20
 1, 2, 3, 3, 4, 3, 2, 1, 1 = 20
 총 9번으로 20을 이동했다.
 
 1, 2, 3, 4중에서 남은 거리4를 4를 골라서 이동했다고 치자.
 
 1, 2, 3, 4, 4, 3, 2, 1
 총 8번으로 20을 이동했다.
 
 따라서 남은 거리는 가능한 최고속력에 가까운 속력으로 이동시킨다.
 
 코드에서는 남은 거리를 최고속력으로 나눈 몫을 이동횟수에 더해주고, 나눈 나머지가 0이아니라면 이동횟수에 +1을 해주었다.
 */
