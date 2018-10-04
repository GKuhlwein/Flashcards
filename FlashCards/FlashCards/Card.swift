//
//  Card.swift
//  FlashCards
//
//  Created by Tom Kuhlwein on 9/26/18.
//  Copyright © 2018 AirCo. All rights reserved.
//

import Foundation
import UIKit
import os.log

class Card{
    
    
    // MARK: Properties
    
    //
    var nameFront: String
    var nameBack: String
    
    struct PropertyKey {
        static let nameFront = "nameFront"
        static let nameBack = "nameBack"
    }
    
    /* MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    */
    // MARK: Initialization
    
    
    init?(nameFront: String, nameBack: String) {
        
        // *The name must not be empty
        guard !nameFront.isEmpty else {
            return nil
        }
        
        guard !nameBack.isEmpty else {
            return nil
        }
        
        // *Initialize stored properties.
        self.nameFront = nameFront
        self.nameBack = nameBack
    }
}

