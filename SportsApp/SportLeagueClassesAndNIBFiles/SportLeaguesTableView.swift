//
//  LeagueTableView.swift
//  SportsApp
//
//  Created by ahmedpro on 4/21/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import UIKit

class SportLeaguesTableView: UITableView {
    
    override func awakeFromNib() {
        let cell = UINib(nibName: "SportLeaguesTableCell", bundle: nil)
        register(cell, forCellReuseIdentifier: "sportLeaguesCell")
    }
    
}
