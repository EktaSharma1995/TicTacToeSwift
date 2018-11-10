//
//  ViewController.swift
//  TicTacToe
//
//  Created by Ekta Sharma on 2018-11-02.
//  Copyright © 2018 Ekta Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        ticTacToeView.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var displayNameLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var displayGameResultLabel: UILabel!
    
    @IBOutlet weak var registerView: UIView!
    
    @IBOutlet weak var ticTacToeView: UIView!
    
    var activePlayer = 1
    var gameState = [0,0,0,0,0,0,0,0,0]
    let winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    var gameIsActive = true
    
    //Delegation
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        genderTextField.resignFirstResponder()
        return false
    }

    @IBAction func registerButton(_ sender: Any) {
        displayNameLabel.text = "Welcome " + nameTextField.text!
        registerView.isHidden = true
        ticTacToeView.isHidden = false
        segment.selectedSegmentIndex = 1
    }
    
    @IBAction func segmentControlButton(_ sender: Any) {
        if(segment.selectedSegmentIndex == 0){
            ticTacToeView.isHidden = true
            registerView.isHidden = false;
        } else {
            registerView.isHidden = true
            ticTacToeView.isHidden = false
        }
        
    }

    @IBAction func action(_ sender: AnyObject) {
        if(gameState[sender.tag-1] == 0) && gameIsActive == true{
            gameState[sender.tag-1] = activePlayer
            if(activePlayer == 1)
            {
                (sender as AnyObject).setImage(UIImage(named: "cross.png"), for: UIControl.State())
                activePlayer = 2
            }
            else{
                (sender as AnyObject).setImage(UIImage(named: "circle.jpg"), for: UIControl.State())
                activePlayer = 1
            }
        }
        
        for combination in winningCombinations
        {
             if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]
            {
            
                gameIsActive = false
            
                if gameState[combination[0]] == 1
                {
                    displayGameResultLabel.text = "Cross has won! "
                } else
                {
                    displayGameResultLabel.text = "Nought has won! "
                }
                
                playAgainButton.isHidden = false
                displayGameResultLabel.isHidden = false
            }
        }
        
        gameIsActive = false
        
        for i in gameState
        {
            if i == 0
            {
                gameIsActive = true
                break
            }
        }
        
        if gameIsActive == false
        {
            displayGameResultLabel.text = "IT WAS A DRAW"
            displayGameResultLabel.isHidden = false
            playAgainButton.isHidden = false
        }
        
    }
    
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBAction func playAgain(_ sender: AnyObject)
    {
        gameState = [0,0,0,0,0,0,0,0,0]
        gameIsActive =  true
        activePlayer = 1
        
        playAgainButton.isHidden = true
        displayGameResultLabel.isHidden = true
        
        for i in 1...9
        {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControl.State())
        }
    }
    
}

