//
//  BoardManager.swift
//  TicTacToe
//
//  Created by Maurice Carrier on 5/14/15.
//  Copyright (c) 2015 MauriceCarrier. All rights reserved.
//

import UIKit

class GameBoardDelegate: NSObject {
   
    static var chosenSpacesDict = [String:String]()
    
    /**
    Checks if space is taken
    
    :param: spaceChecked String representing space to be checked
    :param: User Bool stating if user is checking for space
    
    :returns: Bool of whether space is available
    */
    static func checkSpaceAvailablity(spaceChecked: String, user: Bool) -> Bool {
        if (chosenSpacesDict[spaceChecked] == nil && user) ||
            (!user && spaceChecked != "X" && spaceChecked != "O") {
            return true
        } else {
            return false
        }
    
    }
    
    /**
    Records chosen space in dictionary
    
    :param: chosenSpace String representing space to be added
    :param: symbol String to be recorded for the chosenSpace
    
    :returns: void
    */
    static func addToChosenSpaces(chosenSpace: String, symbol: String) {
        chosenSpacesDict[chosenSpace] = symbol
    }
    
    
    /**
    Returns dictionary of chosen spaces
    
    :param: void
    
    :returns: chosenSpacesDict Dictionary of chosen spaces and their 
    corresponding symbols
    */
    static func getChosenSpaces() -> [String:String] {
        return chosenSpacesDict
    }
    
    /** 
    Resets chosenSpacesDict
    */
    static func resetChosenSpaces() {
        chosenSpacesDict = [String:String]() 
    }
    
    
    /**
    Checks selectedSpaces for a win
    
    :param: selectedSpaces dictionary of spaces already chosen
    
    :returns: Dictionary with win or no win bool and winners string
    */
    static func testForWin(selectedSpaces: [String: String]) -> [Bool: String] {
        var winDict = [Bool: String]()
        
        if let buttonOne = selectedSpaces["buttonOne"] {
            if let buttonTwo = selectedSpaces["buttonTwo"] {
                if let buttonThree = selectedSpaces["buttonThree"] {
                    // Top row win
                    if buttonOne == buttonTwo && buttonOne == buttonThree {
                        winDict = [true:buttonOne]
                    }
                }
            }
            
            if let buttonFour = selectedSpaces["buttonFour"] {
                if let buttonSeven = selectedSpaces["buttonSeven"] {
                    // First column win
                    if buttonOne == buttonFour && buttonOne == buttonSeven {
                        winDict = [true:buttonOne]
                    }
                }
            }
            
            if let buttonFive = selectedSpaces["buttonFive"] {
                if let buttonNine = selectedSpaces["buttonNine"] {
                    // Top left -> bottom right diagonal win
                    if buttonOne == buttonFive && buttonOne == buttonNine {
                        winDict = [true:buttonOne]
                    }
                }
            }
        }
        if let buttonTwo = selectedSpaces["buttonTwo"] {
            if let buttonFive = selectedSpaces["buttonFive"] {
                if let buttonEight = selectedSpaces["buttonEight"] {
                    // Second column
                    if buttonTwo == buttonFive && buttonTwo == buttonEight {
                        winDict = [true:buttonTwo]
                    }
                }
            }
            
        }
        if let buttonThree = selectedSpaces["buttonThree"] {
            if let buttonFive = selectedSpaces["buttonFive"] {
                if let buttonSeven = selectedSpaces["buttonSeven"] {
                    // Top right -> bottom left diagonal win
                    if buttonThree == buttonFive && buttonThree == buttonSeven {
                        winDict = [true:buttonThree]
                    }
                }
            }
            
            if let buttonSix = selectedSpaces["buttonSix"] {
                if let buttonNine = selectedSpaces["buttonNine"] {
                    // Third column win
                    if buttonThree == buttonSix && buttonThree == buttonNine {
                        winDict = [true:buttonThree]
                    }
                }
            }
        }
        if let buttonFive = selectedSpaces["buttonFive"] {
            if let buttonFour = selectedSpaces["buttonFour"] {
                if let buttonSix = selectedSpaces["buttonSix"] {
                    // Second row win
                    if buttonFour == buttonFive && buttonFour == buttonSix {
                        winDict = [true:buttonFour]
                    }
                }
            }
        }
        if let buttonSeven = selectedSpaces["buttonSeven"] {
            if let buttonEight = selectedSpaces["buttonEight"] {
                if let buttonNine = selectedSpaces["buttonNine"] {
                    // Third row win
                    if buttonSeven == buttonEight && buttonSeven == buttonNine {
                        winDict = [true:buttonSeven]
                    }
                }
            }
            
        }
        
        // Tie
        if let buttonOne = selectedSpaces["buttonOne"] {
            if let buttonTwo = selectedSpaces["buttonTwo"] {
                if let buttonThree = selectedSpaces["buttonThree"] {
                    if let buttonFour = selectedSpaces["buttonFour"] {
                        if let buttonFive = selectedSpaces["buttonFive"] {
                            if let buttonSix = selectedSpaces["buttonSix"] {
                                if let buttonSeven = selectedSpaces["buttonSeven"] {
                                    if let buttonEight = selectedSpaces["buttonEight"] {
                                        if let buttonNine = selectedSpaces["buttonNine"] {
                                            winDict = [true:"Tie"]
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return winDict
    }

}
