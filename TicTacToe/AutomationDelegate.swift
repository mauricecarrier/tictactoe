//
//  AutomationDelegate.swift
//  TicTacToe
//
//  Created by Maurice Carrier on 5/13/15.
//  Copyright (c) 2015 MauriceCarrier. All rights reserved.
//

import UIKit



class AutomationDelegate: NSObject {
    
    // dictionary of selected spaces used to run minimax
    static var minMaxChosenSpaces :[String:String] = [String:String]()
    static var mappedChosenSpaces = [String]()
    static var winningSequence = [0:[0,1,2],
        1:[3,4,5],
        2:[6,7,8],
        3:[0,3,6],
        4:[1,4,7],
        5:[2,5,8],
        6:[0,4,8],
        7:[2,4,6]]
    
    static var userSymbol = GameBoardViewController.getUserSymbol()
    static var challengerSymbol = GameBoardViewController.getChallengerSymbol()
    
    /**
    Analyzes selected spaces and chooses next move for challenger
    
    :param: selectedSpaces dictionary of spaces already chosen
    
    :returns: space
    */
    static func challengerChooseSpace(chosenSpaces: [String: String], isFirstMove: Bool) -> String {
        
        var userSymbol = GameBoardViewController.getUserSymbol()
        var challengersSelection = String()
        var usedSpaces : [String] = mapButtonsToSpaces(chosenSpaces)
        self.minMaxChosenSpaces = chosenSpaces
        
        if chosenSpaces.count == 0 {
            return "buttonFive"
        }
        
        challengersSelection = evaluateBestMove(usedSpaces, isChallenger: true)
        return challengersSelection
    }
    
    /**
    Maps chosen spaces to the corresponding button on the UI
    
    :param: selectedSpaces dictionary of spaces already chosen
    
    :returns: array of buttons matching usedSpaces
    
    */
    static func mapButtonsToSpaces(chosenSpaces: [String: String]) -> [String] {
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
        
        return usedSpaces
    }
    
    /**
    Evaluates best move for ai using spaces previously selected
    
    :param: array of strings representing spaces already used
    
    :returns: string representing best move for ai to make
    */
    static func evaluateBestMove(usedSpaces: [String], isChallenger: Bool) -> String {
        
        var scoreArray = minimax(usedSpaces, isChallenger: isChallenger)
        return scoreArray[1] as! String
    }
    
    static func minimax(usedSpaces: [String], isChallenger: Bool) -> NSArray {
        
        var legalMoves = [String]()
        var symbol = String()
        var bestScore = isChallenger ? -9999999 : 9999999
        var scoreArray = []
        var bestMove = String()
        
        for moves in usedSpaces {
            if moves != "X" && moves != "O" {
                legalMoves.append(moves)
            }
        }
        
        if legalMoves.count == 0 {
            bestScore = evaluateScore(usedSpaces)
        } else {
        
        for space in legalMoves {
            
            symbol = isChallenger ? self.challengerSymbol : self.userSymbol
            

            self.minMaxChosenSpaces[space] = symbol
            self.mappedChosenSpaces = mapButtonsToSpaces(self.minMaxChosenSpaces)
            
            if isChallenger {
                scoreArray = minimax(self.mappedChosenSpaces , isChallenger: !isChallenger)
                
                if (scoreArray[0] as! Int) > bestScore {
                    bestScore = scoreArray[0] as! Int
                        bestMove = space
                }
            } else {
                scoreArray = minimax(self.mappedChosenSpaces , isChallenger: !isChallenger)
                
                if (scoreArray[0] as! Int) < bestScore {
                    bestScore = scoreArray[0] as! Int
                    bestMove = space
                }
            }
                self.minMaxChosenSpaces.removeValueForKey(space)
            }
        }
        return [bestScore, bestMove]
    }
    
    
    static func evaluateScore(usedSpaces: [String]) -> Int {
        var compScore = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
        var count = 0
        var maxScore = -9999999.0
        var minScore = 99999999.0
        var evaluatedScore = 0
        
        
        while count < usedSpaces.count - 1 {
            for (space, valueArray) in self.winningSequence {
                
                for value in valueArray {
                    if count == value {
                        
                        if usedSpaces[count] == challengerSymbol {
                            compScore[space] += 1.0
                        } else if usedSpaces[count] == userSymbol {
                            compScore[space] -= 1.0
                        } else {
                            compScore[space] += 0.0
                        }
                    }
                }
            }
            count++
        }
        for score in compScore {
            if score > maxScore {
                maxScore = score
            } else if score < minScore {
                minScore = score
            }
        }
        
        if sqrt(minScore) > sqrt(maxScore) {
            evaluatedScore = Int(minScore)
        } else {
            evaluatedScore = Int(maxScore)
        }
        
        return evaluatedScore
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
