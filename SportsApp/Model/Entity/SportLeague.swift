//
//  SportLeague.swift
//  SportsApp
//
//  Created by ahmedpro on 4/21/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import Foundation

struct SportLeague {
    
    var leagueId: Int?
    var sportName: String?
    var leagueName: String?
    var leagueCountry: String?
    var leagueYoutubeURL: String?
    var leagueImageURL: String?
    
    init() {
    }
    
    init(leagueId: Int, sportName: String, leagueName: String, leagueCountry: String, leagueYoutubeURL: String, leagueImageURL: String) {
        
        self.leagueId = leagueId
        self.sportName = sportName
        self.leagueName = leagueName
        self.leagueCountry = leagueCountry
        self.leagueYoutubeURL = leagueYoutubeURL
        self.leagueImageURL = leagueImageURL
    }
}
