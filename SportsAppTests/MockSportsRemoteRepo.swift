//
//  MockSportsRemoteRepo.swift
//  SportsAppTests
//
//  Created by ahmedpro on 4/30/20.
//  Copyright © 2020 ahmedpro. All rights reserved.
//

import Foundation
@testable import SportsApp

class MockSportsRemoteRepo {
    
    var shouldSportsBeNil: Bool
    init(shouldSportsBeNil: Bool) {
        self.shouldSportsBeNil = shouldSportsBeNil
    }
    
    let sportsJSON : [[String:Any]] = [["idSport": 102,
                                        "strSport":"Soccer",
                                        "strFormat":"TeamvsTeam",
                                        "strSportThumb":"https://www.thesportsdb.com/images/sports/soccer.jpg",
                                        "strSportThumbGreen":"https://www.thesportsdb.com/images/sports/motorsport_green2.jpg",
                                        "strSportDescription":"Association football, more commonly known as football or soccer,"],
                                       ["idSport": 103,
                                        "strSport":"Motorsport",
                                        "strFormat":"EventSport",
                                        "strSportThumb":"https://www.thesportsdb.com/images/sports/motorsport.jpg",
                                        "strSportThumbGreen":"https://www.thesportsdb.com/images/sports/motorsport_green2.jpg",
                                        "strSportDescription":"Motorsport or motor sport is a global term used"
        ]
    ]
    
}

extension MockSportsRemoteRepo {
    
    func fetchSports(complition: @escaping ([Sport]?) -> Void) {
        if shouldSportsBeNil {
            complition(nil)
        } else {
            var sports = Array<Sport>()
            for item in sportsJSON {
                let id = item["idSport"] as! Int
                let name = item["strSport"] as! String
                let format = item["strFormat"] as! String
                let imageURL = item["strSportThumb"] as! String
                let description = item["strSportDescription"] as! String
                
                let sport = Sport(sportId: id, sportName: name, sportFormat: format, sportImageURL: imageURL, sportDescription: description)
                sports.append(sport)
            }
            
            complition(sports)
        }
    }
}
