//
//  SportLeaguesRemoteRepo.swift
//  SportsApp
//
//  Created by ahmedpro on 4/21/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

class SportLeaguesRemoteRepo {
    
    func fetchSportLeagues(apiURL: String, complition: @escaping ([SportLeague]?) -> Void) {
        
        // Check if there is internet connection or not
        guard Connectivity.isConnectedToInternet else {
            complition(nil)
            return
        }
        
        guard let url = URL(string: apiURL) else {
            print("invalid url")
            return
        }
        
        Alamofire.request(url).responseData(completionHandler: {response in
            guard response.result.isSuccess else {
                print("failed to response")
                return
            }
            
            let data = response.data
            let sportLeagues = self.mapJSONToSportLeagueArray(data: data!)
            complition(sportLeagues)
        })
    }
    
    private func mapJSONToSportLeagueArray(data: Data) -> [SportLeague] {
        var sportLeagues = Array<SportLeague>()
        
        do {
            let json = try JSON(data: data)
            for item in json["countrys"].arrayValue {
                let id = item["idLeague"].intValue
                let sportName = item["Soccer"].stringValue
                let leagueName = item["strLeague"].stringValue
                let leagueCountry = item["strCountry"].stringValue
                let youtubeURL = item["strYoutube"].stringValue
                let imageURL = item["strBadge"].stringValue
                
                let sportLeague = SportLeague(leagueId: id, sportName: sportName, leagueName: leagueName, leagueCountry: leagueCountry, leagueYoutubeURL: youtubeURL, leagueImageURL: imageURL)
                sportLeagues.append(sportLeague)
            }
        } catch let error as NSError {
            print(error)
        }
        
        return sportLeagues
    }
}
