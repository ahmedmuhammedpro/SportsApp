//
//  CollectionViewCell.swift
//  SportsApp
//
//  Created by ahmedpro on 4/19/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import Foundation

class SportsPresenter: SportsPresenterProtocol {
    
    private let sportsView: SportsViewProtocol
    private let apiURL: String
    private lazy var sportsRemoteRepo = SportsRemoteRepo()
    
    init(sportsView: SportsViewProtocol, apiURL: String) {
        self.sportsView = sportsView
        self.apiURL = apiURL
    }
    
    func loadSports() {
        sportsRemoteRepo.fetchSports(apiURL: apiURL, complition: {sports in
            guard let validSports = sports else {
                self.sportsView.showNoInternetAlertView()
                return
            }
            DispatchQueue.main.async {
                self.sportsView.updateCollectionView(retrievedSports: validSports)
            }
        })
    }
    
}
