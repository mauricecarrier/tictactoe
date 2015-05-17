//
//  GameBoardViewController.swift
//  TicTacToe
//
//  Created by Maurice Carrier on 5/12/15.
//  Copyright (c) 2015 MauriceCarrier. All rights reserved.
//

import UIKit

// User Symbol X or O
var userSymbol: String = ""
var challengerSymbol: String = ""

class  GameBoardViewController: UIViewController {
    
    // MARK: Properties
    
    //Board Spaces, top left is buttonOne, count left to right
    @IBOutlet weak var buttonOne:   UIButton!
    @IBOutlet weak var buttonTwo:   UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour:  UIButton!
    @IBOutlet weak var buttonFive:  UIButton!
    @IBOutlet weak var buttonSix:   UIButton!
    @IBOutlet weak var buttonSeven: UIButton!
    @IBOutlet weak var buttonEight: UIButton!
    @IBOutlet weak var buttonNine:  UIButton!
    
    //Array of buttons
    var buttonArray = [UIButton()]
    
    //Game information label
    @IBOutlet weak var displayLabel: UILabel!
    
    //Used to retain values for each space
    var buttonDictionary = [String: String]()
    
    
    //MARK: Initialization
    
    required override init(nibName nibNameOrNil: String?,
        bundle nibBundleOrNil: NSBundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        chooseSymbol()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: Game Setup
    
    /**
    Player is asked to choose between X or O
    */
    func chooseSymbol() {
        var chooseSymbolAlert = UIAlertController(title: "Please Choose",
            message: "X or O",
            preferredStyle: UIAlertControllerStyle.Alert)
        chooseSymbolAlert.addAction(UIAlertAction(title: "X",
            style: UIAlertActionStyle.Default,
            handler: { alertAction in self.startGame("X")}))
        chooseSymbolAlert.addAction(UIAlertAction(title: "O",
            style: UIAlertActionStyle.Default,
            handler: { alertAction in self.startGame("O")}))
        
        self.presentViewController(chooseSymbolAlert, animated: true, completion:nil)
    }
    
    
    //MARK: Game Actions
    
    /**
    Request user to make a move if it is user's turn, else initiates AI sequence, also sets
    chosen symbol for user and challenger
    
    :param: selectedSymbol the symbol selected by the user
    */
    func startGame(selectedSymbol: String) {
        userSymbol = selectedSymbol
        
        if userSymbol == "X" {
            setDisplayText("Please choose a space.")
            challengerSymbol = "O"
        } else {
            challengerSymbol = "X"
            var challengerSelection = AutomationDelegate.challengerChooseSpace(GameBoardDelegate.getChosenSpaces(), isFirstMove: true)
            mapButtons(challengerSelection, symbol: challengerSymbol)
        }
        setDisplayText("Please choose a space.")
        
    }
    
    
    /**
    User selects a space
    */
    @IBAction func spaceSelected(sender: AnyObject) {
        
        // Record users move
        mapButtons(sender.restorationIdentifier, symbol: userSymbol)
        setDisplayText("")
        
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
            self.challengersTurn()
        }
        
    }
    
    /**
    Checks for end of game and initiates ai move if not then checks game status again
    */
    func challengersTurn() {
        
        var challengersMove : String?
        var isGameOver : [Bool:String]
        
        isGameOver = GameBoardDelegate.testForWin(GameBoardDelegate.getChosenSpaces())
        
        if let endGame = isGameOver[true] {
            gameOver(endGame)
        } else {
            challengersMove = AutomationDelegate.challengerChooseSpace(GameBoardDelegate.getChosenSpaces(), isFirstMove: false)
            mapButtons(challengersMove, symbol: challengerSymbol)
            
            isGameOver = GameBoardDelegate.testForWin(GameBoardDelegate.getChosenSpaces())
            
            if let challengerWins = isGameOver[true] {
                gameOver(challengerWins)
            } else {
                setDisplayText("Please choose a space.")
            }
        }
    }
    
    
    /**
    Records symbol onto selected button
    
    :param: buttonSelected String representation of buton selected
    :param: symbol String representation of symbol to be assigned to button
    */
    func mapButtons(buttonSelected: String?, symbol: String) {
        var isUser = Bool()
        
        if symbol == userSymbol {
            isUser = true
        } else {
            isUser = false
        }
        
        if GameBoardDelegate.checkSpaceAvailablity(buttonSelected!, user: isUser) {
            if buttonSelected == "buttonOne" {
                setButton(buttonOne, symbol: symbol)
                GameBoardDelegate.addToChosenSpaces("buttonOne", symbol: symbol)
            } else if buttonSelected == "buttonTwo" {
                setButton(buttonTwo, symbol: symbol)
                GameBoardDelegate.addToChosenSpaces("buttonTwo", symbol: symbol)
            } else if buttonSelected == "buttonThree" {
                setButton(buttonThree, symbol: symbol)
                GameBoardDelegate.addToChosenSpaces("buttonThree", symbol: symbol)
            } else if buttonSelected == "buttonFour" {
                setButton(buttonFour, symbol: symbol)
                GameBoardDelegate.addToChosenSpaces("buttonFour", symbol: symbol)
            } else if buttonSelected == "buttonFive" {
                setButton(buttonFive, symbol: symbol)
                GameBoardDelegate.addToChosenSpaces("buttonFive", symbol: symbol)
            } else if buttonSelected == "buttonSix" {
                setButton(buttonSix, symbol: symbol)
                GameBoardDelegate.addToChosenSpaces("buttonSix", symbol: symbol)
            } else if buttonSelected == "buttonSeven" {
                setButton(buttonSeven, symbol: symbol)
                GameBoardDelegate.addToChosenSpaces("buttonSeven", symbol: symbol)
            } else if buttonSelected == "buttonEight" {
                setButton(buttonEight, symbol: symbol)
                GameBoardDelegate.addToChosenSpaces("buttonEight", symbol: symbol)
            } else if buttonSelected == "buttonNine" {
                setButton(buttonNine, symbol: symbol)
                GameBoardDelegate.addToChosenSpaces("buttonNine", symbol: symbol)
            }
        } else  {
            setDisplayText("Please choose an unselected space")
        }
    }
    
    /**
    Sets appropriate symbol and attributes to selected button
    
    :param: buttonSelected
    :param: symbol to be affixed to button
    */
    func setButton(buttonSelected: UIButton, symbol: String) {
        buttonSelected.setTitle(symbol, forState: UIControlState.Normal)
        buttonSelected.enabled = false
        buttonSelected.alpha = 1.0
        
        if symbol == "X" {
            buttonSelected.backgroundColor = UIColor.redColor()
        } else {
            buttonSelected.backgroundColor = UIColor.yellowColor()
        }
        
        buttonArray.append(buttonSelected)
    }
    
    /**
    Shows alert announcing winner
    
    :param: winnerSymbol String value of the winning symbol
    */
    func gameOver(winnerSymbol: String) {
        
        var winner = String()
        
        if userSymbol == winnerSymbol  {
            winner = "You Win"
        } else if challengerSymbol == winnerSymbol {
            winner = "You Lose"
        } else {
            winner = "It's a tie."
        }
        
        setDisplayText(winner)
        
        var gameOverAlert = UIAlertController(title: "Game Over!", message: winner,
            preferredStyle: UIAlertControllerStyle.Alert)
        gameOverAlert.addAction(UIAlertAction(title: "Play Again",
            style: UIAlertActionStyle.Default,
            handler: { alertAction in self.reset()}))
        
        self.presentViewController(gameOverAlert, animated: true, completion: nil)
        
    }
    
    //MARK: Delgates
    
    
    /**
    Reset gameboard to original state
    */
    func reset() {
        
        for button in self.buttonArray {
            button.setTitle("", forState: UIControlState.Normal)
            button.enabled = true
            button.backgroundColor = UIColor.whiteColor()
        }
        buttonDictionary = [String:String]()
        challengerSymbol = ""
        userSymbol = ""
        GameBoardDelegate.resetChosenSpaces()
        setDisplayText("")
        
        self.viewDidAppear(true)
    }
    
    /**
    Returns symbol assigned to user
    
    :param: none
    
    :returns: String representing user's symbol
    */
    static func getUserSymbol() -> String {
        return userSymbol
    }
    
    /**
    Returns symbol assigned to challenger
    
    :param: none
    
    :returns: String representing challenger's symbol
    */
    static func getChallengerSymbol() -> String {
        return challengerSymbol
    }
    
    /**
    Sets displayLabelText
    
    :param: value String to be assigned to displayLabel
    */
    func setDisplayText(value: String) {
        self.displayLabel.text = value
    }
    
    
}

