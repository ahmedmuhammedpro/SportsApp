//
//  SportLeaguesPresenterProtocol.swift
//  SportsApp
//
//  Created by ahmedpro on 4/21/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import Foundation

protocol SportsViewProtocol {
    
    func updateCollectionView(retrievedSports: [Sport]?)
    func showNoInternetAlertView()
}
