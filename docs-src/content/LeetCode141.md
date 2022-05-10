---
title      : "141【简单】环形链表 I"
description: 给定一个单链表头节点，判断是否有环。
date       : 2022-04-26T00:00:00+08:00
lastmod    : 2022-05-10T16:42:40+08:00

ContentType: 卡片 # 可选值：图书、章节、指南、手册、页面、文章
Sections:
  - Title: 相关内容
    Groups:
    - Title: 环形链表
      Links:
      - Type: Page
        URL : LeetCode142
---
题目链接: https://leetcode-cn.com/problems/linked-list-cycle/

## 思路
　　使用快慢指针判断是否有环。使用一个快指针，每次前进两个节点；一个慢指针，一次前进一个节点。两个指针相遇说明链表有环，快指针走到链表尾部说明链表无环。

## 完整代码
```swift
func hasCycle(_ head: ListNode?) -> Bool {
    if head == nil {
        return false
    }
    var fast = head
    var slow = head
    while fast?.next?.next != nil {
        fast = fast?.next?.next
        slow = slow?.next
        if fast === slow {
            return true
        }
    }
    return false
}
```

## 修订记录
### 2022-05-10T16:42:40+08:00
* 创建。