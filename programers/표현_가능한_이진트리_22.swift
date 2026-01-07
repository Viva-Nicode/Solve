import Foundation

func Insertdummy(_ number: Int64) -> String {
    let nodeCount = [1, 3, 7, 15, 31, 63, 127]
    let binString: String = String(number, radix: 2)
    let nodes = nodeCount.first(where: { $0 >= binString.count }) ?? 0
    return String(repeating: "0", count: nodes - binString.count) + binString
}

func dfs_3(_ subBinString: String) -> Int {

    if subBinString.count != 1 {
        let leftResult = dfs_3(String(subBinString.prefix(subBinString.count / 2)))
        let rightResult = dfs_3(String(subBinString.suffix(subBinString.count / 2)))
        if leftResult == -1 || rightResult == -1 {
            return -1
        }
        let index = subBinString.index(subBinString.startIndex, offsetBy: subBinString.count / 2)
        let parent = Int(String(subBinString[index]))
        if (leftResult == 1 || rightResult == 1) && parent == 0 {
            return -1
        } else { return parent ?? 0 }
    } else {
        return Int(subBinString) ?? 0
    }
}

func solution_22(_ numbers: [Int64]) -> [Int] {
    var aws: [Int] = []
    for elem in numbers {
        let bs = Insertdummy(elem)
        let dd = dfs_3(bs)
        if dd == -1 {
            aws.append(0)
        } else {
            aws.append(1)
        }
    }
    return aws
}
