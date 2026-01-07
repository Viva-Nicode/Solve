import Foundation

func solve_1005() {

    let fIO = FileIO()
    let n = fIO.readInt()
    var answer = ""

    for _ in 0..<n {
        let buildingCount = fIO.readInt(), dependencyCount = fIO.readInt()
        let timeTakens = (0..<buildingCount).map { _ in fIO.readInt() }
        var dependencies = [[Int]](repeating: [], count: timeTakens.count)
        var inDegrees = [Int](repeating: 0, count: timeTakens.count)

        for _ in 0..<dependencyCount {
            let leading = fIO.readInt() - 1, lagging = fIO.readInt() - 1
            dependencies[leading].append(lagging)
            inDegrees[lagging] += 1
        }

        let desBuilding = fIO.readInt() - 1

        var dp = [Int](repeating: 0, count: timeTakens.count)
        var q: [Int] = []

        for i in 0..<inDegrees.count {
            if inDegrees[i] == .zero {
                q.append(i)
                dp[i] = timeTakens[i]
            }
        }

        while !q.isEmpty {
            let building = q.removeFirst()
            for i in dependencies[building] {
                inDegrees[i] -= 1
                dp[i] = max(dp[i], timeTakens[i] + dp[building])
                if inDegrees[i] == .zero {
                    if i == desBuilding {
                        q = []
                    } else {
                        q.append(i)
                    }
                }
            }
        }
        answer += "\(dp[desBuilding])\n"
    }

    print(answer)
}

/*
 https://www.acmicpc.net/problem/1005
 2025.2.16
 
 아이디어
 
 일단 의존성 그래프인 dependencies를 완성했다.
 하지만 이 그래프는 최종 목적 건물을 건설하기 위해 필요하지않은 건물까지 포함되어있다.
 따라서 DFS 또는 BFS를 통해 반드시 건설해야 하는 건물 그래프로 바꿔준다.
 이후 위상 정렬 할때처럼 진입차수가 0인 건물들(=아무 건물도 의존하지 않는 건물들)을 동시에 계속 지어주면서 max(걸리는 시간들)을 누적시킨다.
 
 라고 생각했는데 아니였음 왜?
 목적건물을 건성하기 위해 반드시 건설해야 하는 건물 그래프가 있다고 가정하면 루트노드는 목적 건물이된다.
 
 이때 리프노드들은 어떤 건물에도 의존하지 않는 즉시 건설 가능한 건물들인데, 위 알고리즘 대로라면 모든 리프노드들을 동시에 건설한다.
 
 하지만 모든 리프노드 건물이 아닌 트리의 레벨이 가장 낮은 리프노드 건물들을 먼저 건설하고 나머지 리프노드들을 건설해야하는 테케가 발견되어 버려서 실패.
 
 애초에 dfs인줄 알았으나, 위상정렬과 dp를 활용하는 문제였다.
 
 위상 정렬을 시행한다.
 동시에, dp에 i번째 건물을 짓기위해 발생하는 최소비용을 저장한다.
 따라서 dp[목적건물번호]가 정답이 된다.
 
 */
