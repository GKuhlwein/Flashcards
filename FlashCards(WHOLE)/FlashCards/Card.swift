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

class Card: NSObject{
    
    
    // MARK: Properties
    
    //
    var nameFront: String
    var nameBack: String
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    // MARK: Initialization
    
    init?(nameFront: String, nameBack: String) {
        
        
        // *Initialize stored properties.
        self.nameFront = nameFront
        self.nameBack = nameBack
        
    }
}

