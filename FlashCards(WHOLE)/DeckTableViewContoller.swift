//
//  DeckTableViewContoller.swift
//  FlashCards
//
//  Created by Tom Kuhlwein on 10/25/18.
//  Copyright © 2018 AirCo. All rights reserved.
//

import Foundation
import UIKit
import os.log

class DeckTableViewController: UITableViewController {
    
    // MARK: Properties
    var cards = [Card]()
    var isViewing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved cards, otherwise load saved data.
        if let savedCards = loadCards() {
            cards += savedCards
        }
        else {
            // Load the sample data
            loadSampleCards()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "DeckTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DeckTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
            
        }
        // Fetches the appropriate meal for the data source layout.
        let card = cards[indexPath.row]
        
        
        cell.deckName.text = card.nameFront

        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            cards.remove(at: indexPath.row)
            saveCards()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new card.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let cardDetailViewController = segue.destination as? ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedCardCell = sender as? DeckTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            guard let indexPath = tableView.indexPath(for: selectedCardCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedCard = cards[indexPath.row]
            cardDetailViewController.card = selectedCard
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
            
        }
    }
    
    
    // MARK: Actions
    @IBAction func unwindToCardList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ViewController, let card = sourceViewController.card {
            isViewing = true
            print("OKAY")
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // Update an existing Meal.
                cards[selectedIndexPath.row] = card
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: cards.count, section: 0)
                
                cards.append(card)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the Cards.
            saveCards()
        }
    }
    
    // MARK: Private Methods
    
    private func loadSampleCards() {
        guard let deck1 = Card(nameFront: "Corn", nameBack: "Something Grown by farmers." ) else {
            fatalError("Unable to instantiate deck1")
        }
        
        guard let deck2 = Card(nameFront: "Corn Bread", nameBack: "Made with corn and tastes gross.") else {
            fatalError("Unable to instantiate deck2")
        }
        
        guard let deck3 = Card(nameFront: "Corn Meal", nameBack: "Something made with corn that just sounds gross.") else {
            fatalError("Unable to instantiate deck3")
        }
        
        cards += [deck1, deck2, deck3]
    }
    
    private func saveCards() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(cards, toFile: Card.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Cards successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save cards...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadCards() -> [Card]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Card.ArchiveURL.path) as? [Card]
    }
}
