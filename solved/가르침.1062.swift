import Foundation

func solve_1062() {
    let io = FileIO()
    let n = io.readInt(), k = io.readInt()
    var ans = 0
    var wordsBit = Array(repeating: 0, count: 50)
    var lettersLearned = 0

    if k < 5 {
        print(0)
        return
    }

    for i in 0..<n {
        let word = io.readString().map { String($0) }
        for j in word {
            wordsBit[i] |= 1 << (Int(Character(j).asciiValue! - 97))
        }
    }

    func dfs (_ depth: Int, _ start: Int) {
        var count = 0

        if depth == k - 5 {
            for i in 0..<n {
                if wordsBit[i] & lettersLearned == wordsBit[i] {
                    count += 1
                }
            }
            ans = max(ans, count)
            return
        }

        for i in start...25 {
            if (lettersLearned & (1 << i)) == 0 {
                lettersLearned |= (1 << i)
                dfs(depth + 1, i)
                lettersLearned &= ~(1 << i)
            }
        }
    }

    lettersLearned |= 1 << (Int(Character("a").asciiValue! - 97))
    lettersLearned |= 1 << (Int(Character("n").asciiValue! - 97))
    lettersLearned |= 1 << (Int(Character("t").asciiValue! - 97))
    lettersLearned |= 1 << (Int(Character("i").asciiValue! - 97))
    lettersLearned |= 1 << (Int(Character("c").asciiValue! - 97))

    dfs(0, 0)
    print(ans)
}

/*
 https://www.acmicpc.net/problem/1062
 가르침.1062
 2025.2.20
 
 c++ 같은거로는 완전탐색만 해도 된다던데 swift는 비트마스킹을 사용해야 시간초과가 발생하지 않는다고 한다.
 
 현재 배운 문자들과 어떤 단어를 읽을떄 알아야하는 단어를 비트마스킹을 통해 저장하여야 한다.
 
 lettersLearned에 지금까지 배운 문자들이 비트마스킹되어 저장된다.
 
 가장 오른쪽 비트가 1이라면 a를 배운것이 된다. a = 97, z = 122 이고,
 
 a, n, t, i, c는 무조건 배워야 하므로, lettersLearned |= 1 << (배우고자 하는 문자의 아스키 값 - a의 아스키 값)하면 된다.
 
 lettersLearned |= 1 << (a의 아스키 값 - 97)
 lettersLearned |= 1 << (c의 아스키 값 - 97)
 
 을 하면 lettersLearned는 0000000101이되고 이는 a, c를 배운것이 된다.
 
 var wordsBit = Array(repeating: 0, count: 50)
 
 그다음 각 단어들을 순회하면서 해당 단어를 읽기 위해 필요한 문자들을 비트마스킹을 통해 저정한다.
 
 마지막으로 DFS를 통해 (배울수 있는 문자의 수k - 필수로 배워야하는 문자 5)개의 문자들로 이루어진 조합을 전부 탐색하면된다.
 
 알파벳 소문자가 총 26개이기 때문에 조합의 가짓수는 최대 10,400,600가지로 그다지 크지 않다.
 
 */

