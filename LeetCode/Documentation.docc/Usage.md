# 使用说明

创建题目、测试题解。

## 创建题目

要创建新的题目，首先以 “LeetCode编号” 的格式创建一个 Swift 代码文件，
然后在文件中创建一个满足 ``LeetCodeProblem`` 要求的结构体。这个结构体就是题目。

一个题目应当包含一个由 LeetCode 给出的 `Solution` 子类，这个子类就是题解。除题解外，
题目还应包含测试用例、测试函数和题目说明。题目说明写在题目的文档中。题解的思路写在
`Solution` 子类的文档中。

## 测试题解

在 `main.swift` 中，将要测试的题目赋值给 ``problem``，然后编译并运行程序。
程序会给出每个测试用例是否通过。

```swift
let problem = LeetCode36()
```

## Topics

### 创建题解

- ``LeetCodeProblem``

### 主程序
- ``problem``
