//
//  main.swift
//  LeetCode
//
//  Created by 杨林青 on 2022/4/25.
//

import Foundation

/// 测试用例。
///
/// 每条测试用例包含一个输入和一个正确答案。
///
/// `ExampleInput` 指代实际的输入。如果输入由多个参数组成，
/// 可以使用一个结构体保存输入。例如，如果输入包含一个整数和一个数组，
/// 那么可以这样定义：
/// ```swift
/// struct ExampleInput {
///     let n: Int
///     let data: [Int]
/// }
/// ```
/// `ExampleOutput` 指代实际的输出，一般为 `Bool` 或 `Int`。
struct Example<ExampleInput, ExampleOutput> {
    /// 测试用例的输入。
    let input: ExampleInput
    /// 测试用例的正确答案。
    let answer: ExampleOutput
}

/// 能够被主程序自动测试的力扣题目。
///
/// 一个题目包含题解、测试数据和题解调用函数。
///
/// ## Topics
/// ### 题解
/// - ``example``
/// - ``Solution``
/// - ``test(_:)``
///
/// ### 测试用例
/// - ``Example``
/// - ``ProblemInput``
/// - ``ProblemOutput``
protocol LeetCodeProblem {
    /// 由力扣给出的题解模版类。
    associatedtype Solution
    /// 包含所有数据的输入。
    associatedtype ProblemInput
    /// 包含所有数据的输出。
    associatedtype ProblemOutput: Equatable
    
    /// 测试用例。
    ///
    /// 测试用例是一个数组，每个元素包含输入和答案。如果输入和答案包含多个参数，
    /// 可以使用一个结构体表示。下面的例子中，输入包含一个整数和一个数组，输出是一个整数。
    /// ```swift
    /// struct ExampleInput {
    ///     let n: Int
    ///     let data: [Int]
    /// }
    ///
    /// let example: [Example<ExampleInput, Int>] = [
    ///     Example(input: ExampleInput(n: 1, data: [0]), answer: 0),
    ///     Example(input: ExampleInput(n: 2, data: [0, 1]), answer: 1),
    /// ]
    /// ```
    var example: [Example<ProblemInput, ProblemOutput>] { get }
    /// 题解调用函数。
    ///
    /// 由于主程序不知道每道题的输入/输出格式，
    /// 主程序将测试用例的输入发送给此函数，并将此函数的输出与答案比较。
    func test(_ input: ProblemInput) -> ProblemOutput
}

/// 要测试的问题。
let problem = LeetCode36()
/// 当前测试用例编号。
private var count = 1
/// 测试用例总量。
private let total = problem.example.count
for example in problem.example {
    print("测试用例 \(count)/\(total)", separator: "", terminator: " ")
    if problem.test(example.input) != example.answer {
        print("答案错误。")
    } else {
        print("通过。")
    }
    count += 1
}
print("测试完成。")


