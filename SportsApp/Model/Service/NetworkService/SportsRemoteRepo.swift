//
//  CollectionViewCell.swift
//  SportsApp
//
//  Created by ahmedpro on 4/19/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

class SportsRemoteRepo {
    
    func fetchSports(apiURL: String, complition: @escaping ([Sport]?) -> Void) {
        
        // Check if there is internet connection or not
        guard Connectivity.isConnectedToInternet else {
            complition(nil)
            return
        }
        
        guard let url = URL(string: apiURL) else {
            print("Invalid URL")
            return
        }
        
        Alamofire.request(url).responseData(completionHandler: {response in
            guard response.result.isSuccess else {
                print("failed to response")
                return
            }
            let data = response.data
            let sports = self.mapJSONToSportsArray(data: data!)
            complition(sports)
        })
    }
    
    private func mapJSONToSportsArray(data: Data) -> [Sport]? {
        var sports = Array<Sport>()
        do {
            let json = try JSON(data: data)
            for item in json["sports"].arrayValue {
                
                let id = item["idSport"].intValue
                let name = item["strSport"].stringValue
                let format = item["strFormat"].stringValue
                let imageURL = item["strSportThumb"].stringValue
                let description = item["strSportDescription"].stringValue
                
                let sport = Sport(sportId: id, sportName: name, sportFormat: format, sportImageURL: imageURL, sportDescription: description)
                sports.append(sport)
                
            }
        } catch let errot as NSError {
            print(errot)
        }
        
        return sports
    }
}
