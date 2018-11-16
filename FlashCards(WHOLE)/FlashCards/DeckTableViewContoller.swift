//
//  DeckTableViewContoller.swift
//  FlashCards
//
//  Created by Tom Kuhlwein on 10/25/18.
//  Copyright © 2018 AirCo. All rights reserved.
//

import Foundation


class DeckTableViewController: UITableViewController {

    // MARK: Properties
    var decks = [Deck]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved meals, otherwise load saved data.
        if let savedMeals = loadMeals() {
            meals += savedMeals
        }
        else {
            // Load the sample data
            loadSampleMeals()
        }
        
    }

    
    // MARK: Private Methods
    
    private func loadSampleMeals() {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        guard let meal1 = Meal(name: "Corn", photo: photo1, rating: 4) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal2 = Meal(name: "Corny", photo: photo2, rating: 5) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal3 = Meal(name: "Corniest", photo: photo3, rating: 3) else {
            fatalError("Unable to instantiate meal1")
        }
        
        meals += [meal1, meal2, meal3]
    }

    private func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }

    private func loadMeals() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
    }
