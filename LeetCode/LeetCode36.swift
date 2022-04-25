//
//  36.swift
//  LeetCode
//
//  Created by 杨林青 on 2022/4/25.
//

import Foundation

/// 有效的数独
///
/// 请你判断一个 9 x 9 的数独是否有效。只需要 根据以下规则 ，验证已经填入的数字是否有效即可。
///
/// 1. 数字 1-9 在每一行只能出现一次。
/// 2. 数字 1-9 在每一列只能出现一次。
/// 3. 数字 1-9 在每一个以粗实线分隔的 3x3 宫内只能出现一次。（请参考示例图）
///
/// >
/// > * 一个有效的数独（部分已被填充）不一定是可解的。
/// > * 只需要根据以上规则，验证已经填入的数字是否有效即可。
/// > * 空白格用 '.' 表示。
///
/// **示例 1:**
/// ![](LeetCode36.png)
/// **输入：**
/// ```
/// board =
/// [["5","3",".",".","7",".",".",".","."]
/// ,["6",".",".","1","9","5",".",".","."]
/// ,[".","9","8",".",".",".",".","6","."]
/// ,["8",".",".",".","6",".",".",".","3"]
/// ,["4",".",".","8",".","3",".",".","1"]
/// ,["7",".",".",".","2",".",".",".","6"]
/// ,[".","6",".",".",".",".","2","8","."]
/// ,[".",".",".","4","1","9",".",".","5"]
/// ,[".",".",".",".","8",".",".","7","9"]]
/// ```
/// **输出：**
/// ```
/// true
/// ```
///
/// **示例 2**
///
/// **输入：**
/// ```
/// board =
/// [["8","3",".",".","7",".",".",".","."]
/// ,["6",".",".","1","9","5",".",".","."]
/// ,[".","9","8",".",".",".",".","6","."]
/// ,["8",".",".",".","6",".",".",".","3"]
/// ,["4",".",".","8",".","3",".",".","1"]
/// ,["7",".",".",".","2",".",".",".","6"]
/// ,[".","6",".",".",".",".","2","8","."]
/// ,[".",".",".","4","1","9",".",".","5"]
/// ,[".",".",".",".","8",".",".","7","9"]]
/// ```
/// **输出：**
/// ```
/// false
/// ```
///
/// **解释:** 除了第一行的第一个数字从 5 改为 8 以外，空格内其他数字均与 示例1 相同。 但由于位于左上角的 3x3 宫内有两个 8 存在, 因此这个数独是无效的。
///
/// > Tip:
/// > * board.length == 9
/// > * `board[i].length == 9`
/// > * `board[i][j]` 是一位数字(1~9)或者“`.`”
///
/// ## Topics
/// ### 题解
/// - ``Solution``
struct LeetCode36: LeetCodeProblem {
    
    /// 九宫格内遍历时使用除法和取余即可计算坐标。
    /// ```swift
    /// for i in 0..<9 {
    ///     var nineSet = SudokuSet()
    ///     let topLeftRow = (i / 3) * 3
    ///     let topLeftCol = (i % 3) * 3
    ///     for j in 0..<9 {
    ///         let dRow = j / 3
    ///         let dCol = j % 3
    ///         let row = dRow + topLeftRow
    ///         let col = dCol + topLeftCol
    ///         if nineSet.addAndTest(board[row][col]) {
    ///             return false
    ///         }
    ///     }
    /// }
    /// ```
    class Solution {
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

        func isValidSudoku(_ board: [[Character]]) -> Bool {
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
    }
    
    /// 测试用例
    let example: [Example<[[Character]], Bool>] = [
        Example(input: [["5","3",".",".","7",".",".",".","."]
                        ,["6",".",".","1","9","5",".",".","."]
                        ,[".","9","8",".",".",".",".","6","."]
                        ,["8",".",".",".","6",".",".",".","3"]
                        ,["4",".",".","8",".","3",".",".","1"]
                        ,["7",".",".",".","2",".",".",".","6"]
                        ,[".","6",".",".",".",".","2","8","."]
                        ,[".",".",".","4","1","9",".",".","5"]
                        ,[".",".",".",".","8",".",".","7","9"]],
                answer: true),
        Example(input: [["8","3",".",".","7",".",".",".","."]
                        ,["6",".",".","1","9","5",".",".","."]
                        ,[".","9","8",".",".",".",".","6","."]
                        ,["8",".",".",".","6",".",".",".","3"]
                        ,["4",".",".","8",".","3",".",".","1"]
                        ,["7",".",".",".","2",".",".",".","6"]
                        ,[".","6",".",".",".",".","2","8","."]
                        ,[".",".",".","4","1","9",".",".","5"]
                        ,[".",".",".",".","8",".",".","7","9"]],
                answer: false)
    ]
    
    func test(_ input: [[Character]]) -> Bool {
        return Solution().isValidSudoku(input)
    }

}
