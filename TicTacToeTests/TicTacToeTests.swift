//
//  TicTacToeTests.swift
//  TicTacToeTests
//
//  Created by Maurice K Carrier Jr  on 5/12/15.
//  Copyright (c) 2015 MauriceCarrier. All rights reserved.
//

import UIKit
import XCTest

class TicTacToeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /**
    Test all winning board configurations
    */
    func testWinningBoardConfigurations() {
        
        
        var symbolOptions = ["X", "O"]
        for value in symbolOptions {
            var symbol = value 
            
            
            var topRowWin           = ["buttonOne": symbol, "buttonTwo": symbol, "buttonThree": symbol]
            var secondRowWin        = ["buttonFour": symbol, "buttonFive": symbol, "buttonSix": symbol]
            var thirdRowWin         = ["buttonSeven": symbol, "buttonEight": symbol, "buttonNine": symbol]
            var diagonalWinRight    = ["buttonOne": symbol, "buttonFive": symbol, "buttonNine": symbol]
            var diagonalWinLeft     = ["buttonThree": symbol, "buttonFive": symbol, "buttonSeven": symbol]
            var columnOneWin        = ["buttonOne": symbol, "buttonFour": symbol, "buttonSeven": symbol]
            var columnTwoWin        = ["buttonTwo": symbol, "buttonFive": symbol, "buttonEight": symbol]
            var columnThreeWin      = ["buttonThree":symbol, "buttonSix": symbol, "buttonNine": symbol]
            
            var winDict = [topRowWin, secondRowWin, thirdRowWin, diagonalWinRight, diagonalWinLeft, columnOneWin, columnTwoWin, columnThreeWin]
            for winningSequence in winDict {
                
                var isWinningSequence : [Bool:String] = GameBoardDelegate.testForWin(winningSequence)
                if isWinningSequence[true] != nil {
                    XCTAssert(true, "\(winningSequence.description) successfully detected")
                    NSLog("Winning Sequence \(winningSequence.description) successfully detected")
                } else {
                    XCTAssert(false, "\(winningSequence.description) not detected")
                    NSLog("Winning Sequence \(winningSequence.description) not detected")
                }
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
