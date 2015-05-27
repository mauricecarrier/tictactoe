//
//  AutomationDelegate.swift
//  TicTacToe
//
//  Created by Maurice Carrier on 5/13/15.
//  Copyright (c) 2015 MauriceCarrier. All rights reserved.
//

import UIKit



class AutomationDelegate: NSObject {
    
    /**
    Analyzes selected spaces and chooses next move for challenger
    
    :param: selectedSpaces dictionary of spaces already chosen
    
    :returns: space
    */
    static func challengerChooseSpace(chosenSpaces: [String: String], isFirstMove: Bool) -> String {
        
        var userSymbol = GameBoardViewController.getUserSymbol()
        var challengersSelection = String()
        var usedSpaces = ["buttonOne","buttonTwo","buttonThree","buttonFour","buttonFive",
            "buttonSix","buttonSeven","buttonEight","buttonNine"]
        
        if let buttonOne    = chosenSpaces["buttonOne"] {
            usedSpaces[0]   = buttonOne
        }
        if let buttonTwo    = chosenSpaces["buttonTwo"] {
            usedSpaces[1]   = buttonTwo
        }
        if let buttonThree  = chosenSpaces["buttonThree"] {
            usedSpaces[2]   = buttonThree
        }
        if let buttonFour   = chosenSpaces["buttonFour"] {
            usedSpaces[3]   = buttonFour
        }
        if let buttonFive   = chosenSpaces["buttonFive"] {
            usedSpaces[4]   = buttonFive
        }
        if let buttonSix    = chosenSpaces["buttonSix"] {
            usedSpaces[5]   = buttonSix
        }
        if let buttonSeven  = chosenSpaces["buttonSeven"] {
            usedSpaces[6]   = buttonSeven
        }
        if let buttonEight  = chosenSpaces["buttonEight"] {
            usedSpaces[7]   = buttonEight
        }
        if let buttonNine   = chosenSpaces["buttonNine"] {
            usedSpaces[8]   = buttonNine
        }
        
        challengersSelection = evaluateBestMove(usedSpaces, isFirstMove: isFirstMove)
        
        return challengersSelection
    }
    
    
    /**
    Evaluates best move for ai using spaces previously selected
    
    :param: array of strings representing spaces already used
    
    :returns: string representing best move for ai to make
    */
    static func evaluateBestMove(usedSpaces: [String], isFirstMove: Bool) -> String {
        
        // Take Middle space if open
        if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[4], user: false) {
            return usedSpaces[4]
            //Prevents fork from occuring by selecting corner if user has center
        } else if usedSpaces[4] == GameBoardViewController.getUserSymbol() && isFirstMove {
            let forkBusterArray = [0,2,6,8]
            let randomIndex = Int(arc4random_uniform(UInt32(forkBusterArray.count)))
            return usedSpaces[forkBusterArray[randomIndex]]
        }
        
        if usedSpaces[0] == usedSpaces[1] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[2], user: false) {
                return usedSpaces[2]
            }
        }
        if usedSpaces[0] == usedSpaces[2] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[1], user: false) {
                return usedSpaces[1]
            }
        }
        if usedSpaces[0] == usedSpaces[3] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[6], user: false) {
                return usedSpaces[6]
            }
        }
        if usedSpaces[0] == usedSpaces[4] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[8], user: false) {
                return usedSpaces[8]
            }
        }
        if usedSpaces[0] == usedSpaces[6] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[3], user: false) {
                return usedSpaces[3]
            }
        }
        if usedSpaces[0] == usedSpaces[8] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[5], user: false) {
                return usedSpaces[5]
            }
        }
        if usedSpaces[1] == usedSpaces[2] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[0], user: false) {
                return usedSpaces[0]
            }
        }
        if usedSpaces[1] == usedSpaces[3] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[0], user: false) {
                return usedSpaces[0]
            }
        }
        if usedSpaces[1] == usedSpaces[4] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[7], user: false) {
                return usedSpaces[7]
            }
        }
        if usedSpaces[1] == usedSpaces[5] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[2], user: false) {
                return usedSpaces[2]
            }
        }
        if usedSpaces[1] == usedSpaces[7] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[4], user: false) {
                return usedSpaces[4]
            }
        }
        if usedSpaces[2] == usedSpaces[4] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[6], user: false) {
                return usedSpaces[6]
            }
        }
        if usedSpaces[2] == usedSpaces[5] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[8], user: false) {
                return usedSpaces[8]
            }
        }
        if usedSpaces[2] == usedSpaces[6] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[4], user: false) {
                return usedSpaces[4]
            }
        }
        if usedSpaces[2] == usedSpaces[8] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[5], user: false) {
                return usedSpaces[5]
            }
        }
        if usedSpaces[3] == usedSpaces[4] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[5], user: false) {
                return usedSpaces[5]
            }
        }
        if usedSpaces[3] == usedSpaces[5] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[4], user: false) {
                return usedSpaces[4]
            }
        }
        if usedSpaces[3] == usedSpaces[6] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[0], user: false) {
                return usedSpaces[0]
            }
        }
        if usedSpaces[3] == usedSpaces[7] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[6], user: false) {
                return usedSpaces[6]
            }
        }
        if usedSpaces[4] == usedSpaces[5] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[3], user: false) {
                return usedSpaces[3]
            }
        }
        if usedSpaces[4] == usedSpaces[6] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[2], user: false) {
                return usedSpaces[2]
            }
        }
        if usedSpaces[4] == usedSpaces[7] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[1], user: false) {
                return usedSpaces[1]
            }
        }
        if usedSpaces[5] == usedSpaces[7] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[8], user: false) {
                return usedSpaces[8]
            }
        }
        if usedSpaces[5] == usedSpaces[8] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[2], user: false) {
                return usedSpaces[2]
            }
        }
        
        if usedSpaces[6] == usedSpaces[7] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[8], user: false) {
                return usedSpaces[8]
            }
        }
        if usedSpaces[6] == usedSpaces[8] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[7], user: false) {
                return usedSpaces[7]
            }
        }
        if usedSpaces[7] == usedSpaces[8] {
            if GameBoardDelegate.checkSpaceAvailablity(usedSpaces[6], user: false) {
                return usedSpaces[6]
            }
        }
        return nextAvailableSpace(usedSpaces)
    }
    
    
    /**
    Returns a nextAvailable space for computer to select
    
    :param: Array of strings representing used spaces
    
    :returns: String representing computers best move
    */
    static func nextAvailableSpace(usedSpaces: [String]) -> String {
        var count = 0
        var selectedSpace = String()
        
        for value in usedSpaces {
            
            if GameBoardDelegate.checkSpaceAvailablity(value, user: false) {
                selectedSpace = usedSpaces[count]
                return selectedSpace
            }
            count++
        }
        return selectedSpace
    }
    
}
