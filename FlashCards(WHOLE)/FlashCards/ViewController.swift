//
//  ViewController.swift
//  FlashCards
//
//  Created by Tom Kuhlwein on 9/20/18.
//  Copyright © 2018 AirCo. All rights reserved.
//

import UIKit
import Foundation
import os.log


/*
let data: Data // received from a network request, for example
let json = try? JSONSerialization.jsonObject(with: data, options: [])
*/
extension String {
    var data: Data { return Data(self.data) }
}

struct Blog: Decodable {
    let title: String
    let homepageURL: URL
    let articles: [Article]
    
    enum CodingKeys : String, CodingKey {
        case title
        case homepageURL = "home_page_url"
        case articles = "items"
    }
}

struct Article: Decodable {
    let id: String
    let url: URL
    let title: String
}

class ViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    

    @IBOutlet weak var textFieldFront: UITextField!
    @IBOutlet weak var textFieldBack: UITextField!
    @IBOutlet weak var flashCardFront: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var card: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Handle the text field's user input through delegate callbacks.
        textFieldFront.delegate = (self as UITextFieldDelegate)
        textFieldBack.delegate = (self as UITextFieldDelegate)
        
        textFieldFront.text = "People"
        textFieldBack.text = "Things that walk on their feet."
        
        let DTVC = DeckTableViewController()
        if DTVC.isViewing == true {
            print("YES")
            textFieldFront.isHidden = true
            textFieldBack.isHidden = true
        }
        
        // Example JSON with object root:
        /*
         {
         "someKey": 42.0,
         "anotherKey": {
         "someNestedKey": true
         }
         }
 
        if let dictionary = jsonWithObjectRoot as? [String: Any] {
            if let number = dictionary["someKey"] as? Double {
                // access individual value in dictionary
            }
            
            for (key, value) in dictionary {
                // access all key / value pairs in dictionary
            }
            
            if let nestedDictionary = dictionary["anotherKey"] as? [String: Any] {
                // access nested dictionary values by key
            }
        }
        
        // Example JSON with array root:
        /*
         [
         "hello", 3, true
         ]
         */
        if let array = jsonWithArrayRoot as? [Any] {
            if let firstObject = array.first {
                // access individual object in array
            }
            
            for object in array {
                // access all objects in array
            }
            
            for case let string as String in array {
                // access only string values in array
            }
        }*/
        
        // Set up views if editing an existing Meal.
        if let card = card {
            flashCardFront.setTitle(card.nameFront, for: UIControlState.normal)
            textFieldFront.text = card.nameFront
            textFieldBack.text = card.nameBack
        }

    }
    
    // MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        // *Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
            
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
            
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // *Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        // *This sets the values of the different app components to simple names like: name, photo, and rating.
        let nameFront = textFieldFront.text
        let nameBack = textFieldBack.text


        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        card = Card(nameFront: nameFront!, nameBack: nameBack!)
        
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

