---
title      : "36【中等】有效的数独 "
description: 判断一个 9x9 的数独是否有效。只要每一行、每一列、每个九宫格内数字 1～9 均只出现了一次即为有效。
date       : 2022-04-25T00:00:00+08:00
lastmod    : 2022-05-10T16:19:27+08:00

ContentType: 卡片 # 可选值：图书、章节、指南、手册、页面、文章
---

题目链接: https://leetcode.cn/problems/valid-sudoku/

## 思路
　　判断一个集合内是否已有某个数字比较简单。我直接使用一个布尔型数组实现。难点在于在遍历九宫格。这里我使用整除和取余计算坐标。首先将九个九宫格从左到右，从上到下按照 0～9 编号，然后每个九宫格内的格子按 0～9 的顺序编号。如下：

```
1 2 3
4 5 6
7 8 9
```

外层循环遍历 9 个九宫格，内层循环遍历九宫格内 9 个格子。为了计算清晰，这里均计算左上角的下标。

```swift
for i in 0..<9 {
    var nineSet = SudokuSet()
    let topLeftRow = (i / 3) * 3
    let topLeftCol = (i % 3) * 3
    for j in 0..<9 {
        let dRow = j / 3
        let dCol = j % 3
        let row = dRow + topLeftRow
        let col = dCol + topLeftCol
        if nineSet.addAndTest(board[row][col]) {
            return false
        }
    }
}
```

　　代码中的 `SodokuSet` 结构体实现如下：

```swift
/// 表示一行、一列或者一个九宫格内已有的数字集合。
private struct SudokuSet {
    private var flag = [Bool](repeating: false, count: 9)
    
    /// 向集合添加数字，并检测集合中是否已经存在该数字。
    /// - Parameter num: 要添加的数字。
    /// - Returns: 集合中是否存在该数字。
    public mutating func addAndTest(_ num: Character) -> Bool {
        switch num {
        case "1", "2", "3", "4", "5", "6", "7", "8", "9":
            let n = num.asciiValue! - Character("1").asciiValue!
            if flag[Int(n)] {
                return true
            } else {
                flag[Int(n)] = true
                return false
            }
        default:
            return false
        }
    }
}
```

　　

## 完整代码
```swift
public func isValidSudoku(_ board: [[Character]]) -> Bool {
    for i in 0..<9 {
        var rowSudokuSet = SudokuSet()
        var columnSudokuSet = SudokuSet()
        for j in 0..<9 {
            if rowSudokuSet.addAndTest(board[i][j]) {
                return false
            }
            if columnSudokuSet.addAndTest(board[j][i]) {
                return false
            }
        }
    }
    for i in 0..<9 {
        var nineSet = SudokuSet()
        let topLeftRow = (i / 3) * 3
        let topLeftCol = (i % 3) * 3
        for j in 0..<9 {
            let dRow = j / 3
            let dCol = j % 3
            let row = dRow + topLeftRow
            let col = dCol + topLeftCol
            if nineSet.addAndTest(board[row][col]) {
                return false
            }
        }
    }
    return true
}
```

## 修订记录
### 2022-05-10T16:19:27+08:00
* 创建。