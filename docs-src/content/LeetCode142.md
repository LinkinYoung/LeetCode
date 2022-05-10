---
title      : "142【中等】环形链表 II"
description: 给定一个单链表头节点，判断是否有环。如果有，返回链表开始入环的第一个节点。
date       : 2022-04-26T00:00:00+08:00
lastmod    : 2022-05-10T16:42:47+08:00

ContentType: 卡片 # 可选值：图书、章节、指南、手册、页面、文章
Sections:
  - Title: 相关内容
    Groups:
    - Title: 环形链表
      Links:
      - Type: Page
        URL : LeetCode141
---

题目链接: https://leetcode-cn.com/problems/linked-list-cycle-ii/

## 思路
　　使用快慢指针判断是否有环，见《141 环形链表 I》。判断有环后有一个结论：当快慢指针第一次相遇后，从链表头部再创建一个慢指针。两个慢指针最终会在入环节点相遇。证明见《代码随想录》的《[环形链表 II](https://www.programmercarl.com/0142.环形链表II.html)》。

## 完整代码
```swift
func detectCycle(_ head: ListNode?) -> ListNode? {
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
```

## 修订记录
### 2022-05-10T16:42:47+08:00
* 创建。