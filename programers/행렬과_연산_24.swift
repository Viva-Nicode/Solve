import Foundation

class H_Node {
    var v: Int = 0
    var n: H_Node?
    var p: H_Node?

    init(v: Int, n: H_Node? = nil, p: H_Node? = nil) {
        self.v = v
        self.p = p
        self.n = n
    }
}

class RowNode {
    var n: RowNode?
    var p: RowNode?
    var head: H_Node
    var tail: H_Node

    init(n: RowNode? = nil, head: H_Node, tail: H_Node) {
        self.n = n
        self.head = head
        self.tail = tail
    }
}

func solution_24(_ rc: [[Int]], _ operations: [String]) -> [[Int]] {

    var leftHead: H_Node?
    var leftTail: H_Node?

    var rightHead: H_Node?
    var rightTail: H_Node?

    var rowHead: RowNode?
    var rowTail: RowNode?

    for r in 0..<rc.count {

        let leftNode = H_Node(v: rc[r][0])

        if leftTail != nil {
            leftTail?.n = leftNode
            leftNode.p = leftTail
            leftTail = leftNode
        } else {
            leftHead = leftNode
            leftTail = leftNode
        }

        let rightNode = H_Node(v: rc[r][rc[0].count - 1])

        if rightTail != nil {
            rightTail?.n = rightNode
            rightNode.p = rightTail
            rightTail = rightNode
        } else {
            rightHead = rightNode
            rightTail = rightNode
        }

        if rc[0].count > 2 {
            var rowHeadNode: H_Node?
            var prevNode: H_Node?

            for i in 1...rc[0].count - 2 {
                let node = H_Node(v: rc[r][i])

                if prevNode != nil {
                    prevNode!.n = node
                    node.p = prevNode
                    prevNode = node
                } else {
                    rowHeadNode = node
                    prevNode = node
                }
            }

            let rowNode = RowNode(head: rowHeadNode!, tail: prevNode!)

            if rowTail != nil {
                rowTail?.n = rowNode
                rowNode.p = rowTail
                rowTail = rowNode
            } else {
                rowHead = rowNode
                rowTail = rowNode
            }
        }
    }

    for operation in operations {
        switch operation {
        case "ShiftRow":
            leftTail?.n = leftHead
            leftHead?.p = leftTail
            let lptail = leftTail?.p
            leftTail?.p?.n = nil
            leftTail?.p = nil

            leftHead = leftTail
            leftTail = lptail

            rightTail?.n = rightHead
            rightHead?.p = rightTail
            let rptail = rightTail?.p
            rightTail?.p?.n = nil
            rightTail?.p = nil

            rightHead = rightTail
            rightTail = rptail

            if rc[0].count > 2 {
                rowTail?.n = rowHead
                rowHead?.p = rowTail
                let rowPtail = rowTail?.p
                rowTail?.p?.n = nil
                rowTail?.p = nil

                rowHead = rowTail
                rowTail = rowPtail
            }

        default:
            if rc[0].count > 2 {
                leftHead?.n?.p = nil
                var tempNode = leftHead?.n
                leftHead?.n = nil

                rowHead?.head.p = leftHead!
                leftHead?.n = rowHead?.head

                rowHead?.head = leftHead!
                leftHead = tempNode

                rowHead?.tail.p?.n = nil
                tempNode = rowHead?.tail.p
                rowHead?.tail.p = nil

                rightHead?.p = rowHead?.tail
                rowHead?.tail.n = rightHead!

                rightHead = rowHead?.tail
                rowHead?.tail = tempNode!

                rightTail?.p?.n = nil
                tempNode = rightTail?.p
                rightTail?.p = nil

                rowTail?.tail.n = rightTail!
                rightTail?.p = rowTail?.tail

                rowTail?.tail = rightTail!
                rightTail = tempNode

                rowTail?.head.n?.p = nil
                tempNode = rowTail?.head.n
                rowTail?.head.n = nil

                leftTail?.n = rowTail?.head
                rowTail?.head.p = leftTail!

                leftTail = rowTail?.head
                rowTail?.head = tempNode!
            } else {
                leftHead?.n?.p = nil
                var tempNode = leftHead?.n
                leftHead?.n = rightHead!
                rightHead?.p = leftHead

                rightHead = leftHead
                leftHead = tempNode

                rightTail?.p?.n = nil
                tempNode = rightTail?.p
                rightTail?.p = leftTail
                leftTail?.n = rightTail

                leftTail = rightTail
                rightTail = tempNode
            }
        }
    }

    func getResult() -> [[Int]] {
        var result: [[Int]] = Array(repeating: Array(repeating: -1, count: rc[0].count), count: rc.count)

        var lnode: H_Node = leftHead!
        var rnode: H_Node = rightHead!

        if rc[0].count > 2 {
            var rowNode: RowNode = rowHead!
            for r in 0...rc.count - 1 {

                result[r][0] = lnode.v
                if lnode.n != nil {
                    lnode = lnode.n!
                }

                result[r][rc[0].count - 1] = rnode.v
                if rnode.n != nil {
                    rnode = rnode.n!
                }

                var node: H_Node? = rowNode.head
                var idx = 1
                while node != nil {
                    result[r][idx] = node!.v
                    idx += 1
                    node = node?.n
                }
                if rowNode.n != nil {
                    rowNode = rowNode.n!
                }
            }
        } else {
            for r in 0...rc.count - 1 {
                result[r][0] = lnode.v
                if lnode.n != nil {
                    lnode = lnode.n!
                }

                result[r][1] = rnode.v
                if rnode.n != nil {
                    rnode = rnode.n!
                }
            }
        }
        return result
    }
    return getResult()
}
