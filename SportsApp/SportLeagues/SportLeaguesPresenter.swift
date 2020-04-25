//
//  SportLeaguesPresenter.swift
//  SportsApp
//
//  Created by ahmedpro on 4/21/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import Foundation

class SportLeaguesPresenter: SportLeaguesPresenterProtocol {
    
    private let sportLeaguesView: SportLeaguesViewProtocol
    private let apiURL: String
    private lazy var sportLeaguesRemoteRepo = SportLeaguesRemoteRepo()
    
    init(sportLeaguesView: SportLeaguesViewProtocol, apiURL: String) {
        self.sportLeaguesView = sportLeaguesView
        self.apiURL = apiURL
    }
    
    func loadSportLeagues() {
        sportLeaguesRemoteRepo.fetchSportLeagues(apiURL: apiURL, complition: {
            sportLeagues in
            
            guard let validSportLeagues = sportLeagues else {
                self.sportLeaguesView.showNoInternetAlertView()
                return
            }
            
            DispatchQueue.main.async {
                self.sportLeaguesView.updateTableView(retrievedSportLeagues: validSportLeagues)
            }
        })
    }
}
