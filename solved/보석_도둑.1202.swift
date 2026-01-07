import Foundation

struct Jewel {
    let weight: Int
    let price: Int
}

struct MaxHeap {
    private var heap: [Int] = []

    mutating func insert(_ value: Int) {
        heap.append(value)
        var idx = heap.count - 1
        while idx > 0 {
            let parent = (idx - 1) / 2
            if heap[parent] < heap[idx] {
                heap.swapAt(parent, idx)
                idx = parent
            } else {
                break
            }
        }
    }

    mutating func pop() -> Int? {
        guard !heap.isEmpty else { return nil }
        let result = heap[0]
        heap[0] = heap[heap.count - 1]
        heap.removeLast()
        var idx = 0

        while idx < heap.count {
            let left = idx * 2 + 1
            let right = idx * 2 + 2
            var largest = idx

            if left < heap.count && heap[left] > heap[largest] {
                largest = left
            }
            if right < heap.count && heap[right] > heap[largest] {
                largest = right
            }
            if largest == idx {
                break
            }
            heap.swapAt(idx, largest)
            idx = largest
        }
        return result
    }

    var isEmpty: Bool {
        return heap.isEmpty
    }
}

func solve_1202() {
    let firstLine = readLine()!.split(separator: " ").map { Int($0)! }
    let numJewels = firstLine[0]
    let numBags = firstLine[1]

    var jewels: [Jewel] = []
    var bags: [Int] = []

    // 보석 입력 처리
    for _ in 0..<numJewels {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        jewels.append(Jewel(weight: input[0], price: input[1]))
    }

    // 가방 입력 처리
    for _ in 0..<numBags {
        bags.append(Int(readLine()!)!)
    }

    // 보석은 무게 오름차순, 가방은 용량 오름차순으로 정렬
    jewels.sort { $0.weight < $1.weight }
    bags.sort()

    // 결과 변수 및 최대 힙 초기화
    var result = 0
    var heap = MaxHeap()

    var j = 0
    for bag in bags {
        // 현재 가방의 용량에 맞는 보석들을 힙에 추가
        while j < numJewels && jewels[j].weight <= bag {
            heap.insert(jewels[j].price)
            j += 1
        }
        // 힙에서 가장 가치가 높은 보석을 가져와 결과에 추가
        if let maxPrice = heap.pop() {
            result += maxPrice
        }
    }
    print(result)
}

/*
 https://www.acmicpc.net/problem/1202
 2025.2.4
 
 힙과 그리디
 */
