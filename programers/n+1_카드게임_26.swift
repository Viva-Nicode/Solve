import Foundation

// n은 카드 뭉치의 카드 수
// 6 <= n <= 999
// 0 <= coin <= n
// 모든 카드는 중복되지 않음
// 도달 가능한 최대 라운드 수를 리턴

func solution_26(_ coin: Int, _ cards: [Int]) -> Int {

    var result = 1
    var coins = coin
    var hands = cards[0..<cards.count / 3]
    var drops: [Int] = []

    for i in stride(from: cards.count / 3, through: Int.max, by: 2) {

        if i >= cards.count - 1 { return result }

        drops.append(contentsOf: cards[i...i + 1])

        let hc = hands.count

        for (_, v) in hands.enumerated() {
            if let cost = hands.firstIndex(where: { cards.count + 1 == v + $0 }) {
                hands.remove(at: cost)
                hands.remove(at: hands.firstIndex(where: { $0 == v })!)
                result += 1
                break
            }
        }

        if hc == hands.count {

            var isPass = false

            for (i, v) in drops.enumerated() {
                if let idx = hands.firstIndex(where: { cards.count + 1 == $0 + v }) {
                    if coins >= 1 {
                        hands.remove(at: idx)
                        drops.remove(at: i)
                        result += 1
                        coins -= 1
                        isPass = true
                        break
                    } else {
                        break
                    }
                }
            }

            if isPass { continue }

            for (_, v) in drops.enumerated() {
                if let cost = drops.firstIndex(where: { cards.count + 1 == v + $0 }) {
                    if coins >= 2 {
                        drops.remove(at: cost)
                        drops.remove(at: drops.firstIndex(where: { $0 == v })!)
                        coins -= 2
                        result += 1
                        isPass = true
                        break
                    } else {
                        break
                    }
                }
            }

            if isPass {
                continue
            } else {
                return result
            }
        }
    }
    return result
}
