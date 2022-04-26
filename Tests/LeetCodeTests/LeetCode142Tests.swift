//
//  File.swift
//  
//
//  Created by 杨林青 on 2022/4/26.
//

import XCTest
@testable import LeetCode

class Solution142Tests: XCTestCase {

    func testExample1() throws {
        let solution = LeetCode142()
        let (listHead, position) = solution.createList([3,2,0,-4], position: 1)
        self.measure {
            XCTAssertIdentical(solution.detectCycle(listHead), position)
        }
    }
    
    func testExample2() throws {
        let solution = LeetCode142()
        let (listHead, position) = solution.createList([1,2], position: 0)
        self.measure {
            XCTAssertIdentical(solution.detectCycle(listHead), position)
        }
    }
    
    func testExample3() throws {
        let solution = LeetCode142()
        let (listHead, position) = solution.createList([1], position: -1)
        self.measure {
            XCTAssertIdentical(solution.detectCycle(listHead), position)
        }
    }
    
    func testExample4() throws {
        let solution = LeetCode142()
        let (listHead, position) = solution.createList([], position: -1)
        self.measure {
            XCTAssertIdentical(solution.detectCycle(listHead), position)
        }
    }

}
