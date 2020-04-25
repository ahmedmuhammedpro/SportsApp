//
//  CollectionViewCell.swift
//  SportsApp
//
//  Created by ahmedpro on 4/19/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import Foundation

struct Sport {
    
    var sportId: Int?
    var sportName: String?
    var sportFormat: String?
    var sportImageURL: String?
    var sportDescription: String?
    
    init() {
    }
    
    init(sportId: Int, sportName: String, sportFormat: String, sportImageURL: String, sportDescription: String) {
        self.sportId = sportId
        self.sportName = sportName
        self.sportFormat = sportFormat
        self.sportImageURL = sportImageURL
        self.sportDescription = sportDescription
    }
    
}
