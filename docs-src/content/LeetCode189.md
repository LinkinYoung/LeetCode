---
title      : "189【中等】轮转数组"
description: 将数组原地向右移动 k 个位置。k 是非负数。
date       : 2022-05-10T16:42:53+08:00
lastmod    : 2022-05-10T16:42:53+08:00

ContentType: 卡片 # 可选值：图书、章节、指南、手册、页面、文章
---

题目链接: https://leetcode.cn/problems/rotate-array/

## 思路
　　把 0 处的数移到 k 处，然后将 k 处的数移到 2k 处，循环。当 k 与 `nums.count` 的最大公约数为 1 时，会遍历数组的每一个元素。当 k 与 `nums.count` 的最大公约数为 n 时，设 k = np， nums.count = nq。经过观察可见从任意一点开始，每次移动 k，可以遍历到间隔为 n 的所有元素。因此，只需要从 0 到 p-1 开始反复遍历即可。

## 完整代码
```swift
/// 使用辗转相除法求最大公约数。
func gcd(_ a: Int, _ b: Int) -> Int {
    var m = a
    var n = b
    var r = 0
    while n > 0 {
        r = m % n
        m = n
        n = r
    }
    return m
}

func rotate(_ nums: inout [Int], _ k: Int) {
    if k == 0 {
        return
    }
    let n = gcd(nums.count, k)
    let count = nums.count
    var i = 0
    while i < n {
        var current = i
        var next = (i + k) % count
        var currentVal = nums[current]
        var nextVal = nums[next]
        while next != i {
            nums[next] = currentVal
            current = next
            currentVal = nextVal
            next = (next + k) % count
            nextVal = nums[next]
        }
        nums[i] = currentVal
        i += 1
    }
}
```

## 修订记录
### 2022-05-10T16:42:53+08:00
* 创建。