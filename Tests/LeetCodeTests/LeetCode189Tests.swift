//
//  LeetCode189Tests.swift
//  
//
//  Created by 杨林青 on 2022/5/9.
//

import XCTest
@testable import LeetCode

class LeetCode189Tests: XCTestCase {

    func testExample1() throws {
        let solution = LeetCode189()
        var data = [1,2,3,4,5,6,7]
        let k = 3
        let answer = [5,6,7,1,2,3,4]
        // measure 中的块可能会执行多次，不适用本题。
        solution.rotate(&data, k)
        XCTAssertEqual(data, answer)
    }
    
    func testExample2() throws {
        let solution = LeetCode189()
        var data = [-1,-100,3,99]
        let k = 2
        let answer = [3,99,-1,-100]
        // measure 中的块可能会执行多次，不适用本题。
        solution.rotate(&data, k)
        XCTAssertEqual(data, answer)
    }
    
    func testExample3() throws {
        let solution = LeetCode189()
        var data = [1,2,3,4,5,6,7]
        let k = 0
        let answer = [1,2,3,4,5,6,7]
        // measure 中的块可能会执行多次，不适用本题。
        solution.rotate(&data, k)
        XCTAssertEqual(data, answer)
    }
    
    func testExample4() throws {
        let solution = LeetCode189()
        var data = [1]
        let k = 3
        let answer = [1]
        // measure 中的块可能会执行多次，不适用本题。
        solution.rotate(&data, k)
        XCTAssertEqual(data, answer)
    }
    
    func testExample5() throws {
        let solution = LeetCode189()
        var data = [1,2,3]
        let k = 3
        let answer = [1,2,3]
        // measure 中的块可能会执行多次，不适用本题。
        solution.rotate(&data, k)
        XCTAssertEqual(data, answer)
    }
    
    func testExample6() throws {
        let solution = LeetCode189()
        var data = [1,2,3]
        let k = 2
        let answer = [2,3,1]
        // measure 中的块可能会执行多次，不适用本题。
        solution.rotate(&data, k)
        XCTAssertEqual(data, answer)
    }

}
