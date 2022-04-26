//
//  File.swift
//  
//
//  Created by 杨林青 on 2022/4/26.
//

import XCTest
@testable import LeetCode

class Solution141Tests: XCTestCase {

    func testExample1() throws {
        let solution = LeetCode141()
        let (listHead, _) = solution.createList([3,2,0,-4], position: 1)
        self.measure {
            XCTAssertEqual(solution.hasCycle(listHead), true)
        }
    }
    
    func testExample2() throws {
        let solution = LeetCode141()
        let (listHead, _) = solution.createList([1,2], position: 0)
        self.measure {
            XCTAssertEqual(solution.hasCycle(listHead), true)
        }
    }
    
    func testExample3() throws {
        let solution = LeetCode141()
        let (listHead, _) = solution.createList([1], position: -1)
        self.measure {
            XCTAssertEqual(solution.hasCycle(listHead), true)
        }
    }
    
    func testExample4() throws {
        let solution = LeetCode141()
        let (listHead, _) = solution.createList([], position: -1)
        self.measure {
            XCTAssertEqual(solution.hasCycle(listHead), true)
        }
    }

}
