//
//  File.swift
//  
//
//  Created by 杨林青 on 2022/4/26.
//

import Foundation


/// 【中等】环形链表 II
///
/// 给定一个单链表头节点，判断是否有环。如果有，返回链表开始入环的第一个节点，否则返回 `null`。
///
/// 题目链接：https://leetcode-cn.com/problems/linked-list-cycle-ii/
///
/// ## Topics
/// ### 题解
/// - ``detectCycle(_:)``
///
/// ## See Also
/// ### 环形链表
/// - ``Solution141``
public class LeetCode142 {
    /// 给定的单链表定义
    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
        }
    }
    
    /// 使用快慢指针判断是否有环。
    ///
    /// 参考链接：https://www.programmercarl.com/0142.环形链表II.html
    ///
    /// 使用一个快指针，每次前进两个节点；一个慢指针，一次前进一个节点。
    /// 两个指针相遇说明链表有环，快指针走到链表尾部说明链表无环。
    ///
    /// 有一个结论：当快慢指针第一次相遇后，从链表头部再创建一个慢指针。
    /// 两个慢指针最终会在入环节点相遇。证明见《代码随想录》的《[环形链表 II](https://www.programmercarl.com/0142.环形链表II.html)》。
    public func detectCycle(_ head: ListNode?) -> ListNode? {
        if head == nil {
            return nil
        }
        var fast = head
        var slow = head
        while fast?.next?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
            if fast === slow {
                var slow2 = head
                while slow !== slow2 {
                    slow = slow?.next
                    slow2 = slow2?.next
                }
                return slow2
            }
        }
        return nil
    }
    
    /// 根据输入构造链表。
    /// - Parameters:
    ///   - data: 链表节点数据。
    ///   - position: 链表入环的第一个节点的下标。-1 表示无环。
    /// - Returns: 构造的单链表的头节点和答案。
    public func createList(_ data: [Int], position: Int) -> (ListNode?, ListNode?) {
        if data.isEmpty {
            return (nil, nil)
        }
        var list = [ListNode?]()
        list.reserveCapacity(data.count)
        for val in data {
            list.append(ListNode(val))
        }
        if data.count >= 2 {
            for i in 0..<(list.count-1) {
                list[i]!.next = list[i+1]
            }
        }
        if position >= 0 && position < data.count {
            list.last!!.next = list[position]
            return (list[0], list[position])
        } else {
            return (list[0], nil)
        }
    }
}
