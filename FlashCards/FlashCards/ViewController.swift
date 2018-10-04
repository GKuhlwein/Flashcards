//
//  ViewController.swift
//  FlashCards
//
//  Created by Tom Kuhlwein on 9/20/18.
//  Copyright © 2018 AirCo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    

    @IBOutlet weak var textFieldFront: UITextField!
    @IBOutlet weak var textFieldBack: UITextField!
    @IBOutlet weak var flashCardFront: UIButton!
    
    var card: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Handle the text field's user input through delegate callbacks.
        textFieldFront.delegate = (self as UITextFieldDelegate)
        textFieldBack.delegate = (self as UITextFieldDelegate)
        
        // Set up views if editing an existing Meal.
       /* if let card = card {
            flashCardFront.title = card.nameFront
            textFieldFront.text = card.nameFront
            textFieldBack.text = card.nameBack
        }
 */
    }
    
    var front = true
    
    @IBAction func flipCard(_ sender: UIButton) {
        if front == true {
            flashCardFront.setTitle(textFieldBack.text, for:.normal)
            front = false
        }
        else if front == false {
            flashCardFront.setTitle(textFieldFront.text, for:.normal)
            front = true
        }
    }

    struct Deck: Decodable {
        let meta: [MetaData]
        let cards: [CardDeck]
    }
    
    struct MetaData: Decodable {
        let token: String
        let version: String
        let title: String
    }
    
    struct CardDeck: Decodable {
        let front: String
        let back: String
    }

    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        // *Finished entering a name. Hides keyboard.
        textField.resignFirstResponder()
        return true
    }
    //
    @IBAction func textFieldDidEndEditing(_ textField: UITextField) {
        flashCardFront.setTitle(textFieldFront.text, for:.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

