import Foundation

func solve_1017() {

    let _ = Int(readLine()!)!
    let numbers = readLine()!.components(separatedBy: " ").map { Int($0)! }

    var leftSet: [Int] = []
    var rightSet: [Int] = []

    if numbers[0] % 2 == 0 {
        for number in numbers {
            if number % 2 == 0 {
                leftSet.append(number)
            } else {
                rightSet.append(number)
            }
        }
    } else {
        for number in numbers {
            if number % 2 == 0 {
                rightSet.append(number)
            } else {
                leftSet.append(number)
            }
        }
    }

    if leftSet.count != rightSet.count {
        print(-1)
        return
    }

    var che = [Bool](repeating: true, count: 1999 + 1)
    var adj = [[Int]](repeating: [], count: leftSet.count)

    for i in 2...Int(sqrt(Double(1999))) + 1 {
        if che[i] {
            var j = 2
            while i * j <= 1999 {
                che[i * j] = false
                j += 1
            }
        }
    }

    for i in 0..<leftSet.count {
        for j in 0..<rightSet.count {
            if che[leftSet[i] + rightSet[j]] {
                adj[i].append(j)
            }
        }
    }

    var answers: [Int] = []
    var leftMatched: [Int]
    var rightMatched: [Int]
    var visited: [Bool]
    var pairSize: Int = 0

    for i in 0..<adj[0].count {
        let pairedIndex = adj[0][i]
        pairSize = 1

        leftMatched = [Int](repeating: -1, count: leftSet.count)
        rightMatched = [Int](repeating: -1, count: rightSet.count)

        leftMatched[i] = pairedIndex
        rightMatched[pairedIndex] = 0

        for j in 1..<leftSet.count {
            visited = [Bool](repeating: false, count: leftSet.count)
            if dfs(j) { pairSize += 1 }
        }

        if pairSize == rightSet.count {
            answers.append(rightSet[pairedIndex])
        }
    }

    if answers.isEmpty {
        print(-1)
        return
    } else {
        print(answers.sorted().map { String($0) }.joined(separator: " "))
    }

    func dfs(_ leftIndex: Int) -> Bool {
        if leftIndex == 0 || visited[leftIndex] { return false }
        visited[leftIndex] = true

        for i in 0..<adj[leftIndex].count {
            let rightIndex = adj[leftIndex][i]

            if rightMatched[rightIndex] == -1 || dfs(rightMatched[rightIndex]) {
                leftMatched[leftIndex] = rightIndex
                rightMatched[rightIndex] = leftIndex
                return true
            }
        }
        return false
    }
}

/*
 
 https://www.acmicpc.net/problem/1017
 소수_쌍.1017
 2025.3.13
 
 에라토스테네스의 체와 DFS를 통한 이분 매칭 알고리즘
 
 매칭된 두수의 합이 소수인지 아닌지를 알아야 하고, 수의 범위가 1 ~ 1000이므로
 2부터 2000까지의 범위중 소수들을 에라토스테네스의 체를 통하여 구할 수 있다.
 
 (짝수 + 짝수)와 (홀수 + 홀수)는 절대로 소수가 될 수 없으므로 이분 매칭을 위한 두 그룹을 전체 수들중 짝수인 그룹, 홀수인 그룹으로 나누어 준다.
 
 만약 두 그룹의 사이즈가 다르다면 어떤 경우에도 모든 수들이 이분 매칭 될 수 없으므로 -1을 출력하고 리턴한다.
 
 주어진 입력으로 주어진 수들중 첫번쨰수가 짝수라면 leftSet은 짝수그룹이 홀수라면 홀수그룹이된다.
 
 leftSet의 수들은 매칭될 수를 rightSet에서 찾는 입장이되고, rightSet은 매칭 당하는 입장이된다.
 
 adj는 leftSet수들을 기준으로 rightSet에서 어떤 수와 매칭되어야 합이 소수가 되는지를 알기위한 배열로
 
 adj[1] = [1,2,3] 일때 leftSet의 1번째 인덱스의 수는 rightSet의 1,2,3번째 수와 매칭되었을떄 합이 소수가됨을 의미한다.
 
 
 
 
 
 
 
 
 
 
 
 
 */

