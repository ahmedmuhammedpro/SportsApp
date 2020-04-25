//
//  LeagueDetailsPresenter.swift
//  SportsApp
//
//  Created by Reham Ezzat on 4/18/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import Foundation
import UIKit

class LeagueDetailsPresenter{
    let leagueService = LeagueService()
    let leagueDAO = LeagueDAO(appDelegate: UIApplication.shared.delegate as!  AppDelegate)
    
    let myQueue = DispatchQueue(label: "com.sports", qos: .userInteractive)
    
    func getEventsByLeagueId(eventState : EventState, leagueId : String, onCompletion: @escaping ([Event])->Void){
        myQueue.async {
            self.leagueService.getEventsByLeagueId(eventState: eventState, leagueId: leagueId, onCompletion: {(events) in
                onCompletion(events)
            })
        }
    }
    
    func getTeamsByLeagueName(leagueName : String, onCompletion: @escaping ([Team]) -> Void){
        myQueue.async {
            //.replacingOccurrences(of: " ", with: "%20")
            self.leagueService.getTeamsByLeagueName(leagueName: leagueName, onCompletion: {(teams) in
                
                onCompletion(teams)
            })
        }
    }
    
    func isFavoriteLeague(leagueId: String, onCompletion: @escaping (_ isFavorite : Bool) -> Void){
        myQueue.async {
            self.leagueDAO.findLeagueById(leagueId: leagueId, onCompletion: {(isFavorite) in
                onCompletion(isFavorite)
            })
        }
        
    }
    
    func addLeagueToFavorites(league : League){
        myQueue.async {
            self.leagueDAO.insertLeague(league: league)
        }
    }
    
    func removeLeagueFromFavorites(league : League){
        myQueue.async {
            self.leagueDAO.deleteLeague(league: league)
        }
    }
}
