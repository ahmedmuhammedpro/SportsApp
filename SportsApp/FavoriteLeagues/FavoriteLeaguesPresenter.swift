//
//  FavoriteLeaguesPresenter.swift
//  SportsApp
//
//  Created by ahmedpro on 4/25/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import Foundation

class FavoriteLeaguesPresenter: FavoriteLeaguesPresenterProtocol {
    
    let favoriteLeaguesView: FavoriteLeaguesViewProtocol
    let leagueDao: LeagueDAO
    
    init(favoriteLeaguesView: FavoriteLeaguesViewProtocol, appDelegate: AppDelegate) {
        
        self.favoriteLeaguesView = favoriteLeaguesView
        self.leagueDao = LeagueDAO(appDelegate: appDelegate)
    }
    
    func loadSportLeagues() {
        leagueDao.getAllLeagues(onCompletion: {sportLeagues in
            self.favoriteLeaguesView.updateTableView(retrievedSportLeagues: sportLeagues)
        })
    }
    
}
