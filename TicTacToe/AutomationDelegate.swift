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
        
        var scoreArray = minimax(2, usedSpaces: usedSpaces, isChallenger: isChallenger)
        return scoreArray[1] as! String
    }
    
    /**
    Minimax algorithm, recursively iterates through available moves, comparing min and max scores to 
    select the most valuable move
    
    :param: depth Int value of number of moves to perform
    :param: usedSpaces String array of spaces previously selected
    :param: isChallenger Bool value of player making selection
    
    :returns: NSArray of the bestMove and it's corresponding bestScore
    */
    static func minimax(depth: Int, usedSpaces: [String], isChallenger: Bool) -> NSArray {
        
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
        
        if (legalMoves.count == 0 || depth == 0) {
            bestScore = evaluateScore(usedSpaces)
        } else {
            
            for space in legalMoves {
                
                symbol = isChallenger ? self.challengerSymbol : self.userSymbol
                
                
                self.minMaxChosenSpaces[space] = symbol
                self.mappedChosenSpaces = mapButtonsToSpaces(self.minMaxChosenSpaces)
                
                if isChallenger {
                    scoreArray = minimax(depth - 1, usedSpaces: self.mappedChosenSpaces , isChallenger: !isChallenger)
                    
                    if (scoreArray[0] as! Int) > bestScore {
                        bestScore = scoreArray[0] as! Int
                        bestMove = space
                    }
                } else {
                    scoreArray = minimax(depth - 1, usedSpaces: self.mappedChosenSpaces , isChallenger: !isChallenger)
                    
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
    
    
    /**
    Checks players space selections against winningSequences and returns scores
    Challenger 1,2,3 in a row == 1,10,100
    User 1,2,3 in a row == -1,-10,-100
    
    :param: usedSpaces String array of spaces taken
    
    :returns: score value as an Int
    */
    static func evaluateScore(usedSpaces: [String]) -> Int {
        var compScore = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
        var count = 0
        var evaluatedScore = 0
        
        while count < usedSpaces.count {
            for (space, valueArray) in self.winningSequence {
                
                for value in valueArray {
                    if count == value {
                        
                        // Iterate through used spaces, if space matches challenger symbol add 1, if it is userSymbol
                        // subtract one, if empty add 0
                        if usedSpaces[count] == challengerSymbol {
                            compScore[space] += 1.0
                        } else if usedSpaces[count] == userSymbol {
                            compScore[space] -= 1.0
                        } else {
                            compScore[space] -= 0
                        }
                    }
                }
            }
            count++
        }
        
        // Map values and compile board score
        for score in compScore {
            
            var temp = Int(score)
            
            if temp == 1 {
                temp = 1
            } else if temp == -1 {
                temp = -1
            } else if temp == 2 {
                temp = 10
            } else if temp == -2 {
                temp = -10
            } else if temp == 3 {
                temp = 100
            } else if temp == -3 {
                temp = -100
            } else if temp == 0 {
                temp = 0
            }
            
            evaluatedScore += temp
        }
        
        return evaluatedScore
    }
}
