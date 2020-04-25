//
//  LeagueService.swift
//  SportsApp
//
//  Created by Reham Ezzat on 4/18/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import Foundation
import SwiftyJSON

class LeagueService{
    
    func getEventsByLeagueId(eventState : EventState, leagueId : String, onCompletion: @escaping ([Event])->Void){
        
        let url : URL?
        
        if(eventState == EventState.UPCOMING){
            url = URL(string: "https://www.thesportsdb.com/api/v1/json/1/eventsnextleague.php?id=" + leagueId)
        }else{
            url = URL(string: "https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id=" + leagueId)
        }
        
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request){(data, response, error) in
            do{
                var events : [Event] = []
                let json = try JSON(data: data!)
                let eventsJSON = json["events"]
                
                
                
                for (_, eventJSON) in eventsJSON{
                    
                    let homeTeam : String = eventJSON["strHomeTeam"].string ?? "No Name"
                    let awayTeam : String = eventJSON["strAwayTeam"].string ?? "No Name"
                    let date : String = eventJSON["strDate"].string ?? "No Date"
                    let time : String = eventJSON["strTime"].string ?? "No Time"
                    let homeTeamScore : Int = eventJSON["intHomeScore"].int ?? 0
                    let awayTeamScore : Int = eventJSON["intAwayScore"].int ?? 0
                    let homeTeamId : String = eventJSON["idHomeTeam"].string ?? "No Id"
                    let awayTeamId : String = eventJSON["idAwayTeam"].string ?? "No Id"
                    events.append(Event(name: "\(homeTeam) Vs \(awayTeam)", date: date, time: time, homeTeamScore: homeTeamScore, awayTeamScore: awayTeamScore, homeTeamId: homeTeamId, awayTeamId: awayTeamId))
                }
                onCompletion(events)
                
            }catch{
                print("\n******herererre*****\n")
                print(error)
                onCompletion([])
            }
        }
        task.resume()
    }
    
    
    
    func getTeamsByLeagueName(leagueName : String, onCompletion: @escaping ([Team]) -> Void){
        let originalStr = "https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l=" + leagueName
        let escapeStr = originalStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: escapeStr!)
        
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request){(data, response, error) in
            do{
                
                let json = try JSON(data: data!)
                let teamsJSON = json["teams"]
                
                var teams : [Team] = []
                
                for (_, teamJSON) in teamsJSON{
                    
                    let teamId : String = teamJSON["idTeam"].string ?? "No Id"
                    let teamName : String = teamJSON["strTeam"].string ?? "No Name"
                    let teamBadge : String = teamJSON["strTeamBadge"].string ?? "No Badge"
                    let teamTshirt : String = teamJSON["strTeamJersey"].string ?? "No T-shirt"
                    let teamCountry : String = teamJSON["strCountry"].string ?? "No Country"
                    let teamStadium : String = teamJSON["strStadiumThumb"].string ?? "No Stadium"
                    let teamStadiumName : String = teamJSON["strStadium"].string ?? "No Stadium"
                    let teamFoundYear : String = teamJSON["intFormedYear"].string ?? "0000"
                    let teamFacebook : String = teamJSON["strFacebook"].string ?? ""
                    let teamYoutube : String = teamJSON["strYoutube"].string ?? ""
                    let teamWebsite : String = teamJSON["strWebsite"].string ?? ""
                    teams.append(Team(id: teamId, name: teamName, badge: teamBadge, tshirt: teamTshirt, foundYear: teamFoundYear, country: teamCountry, stadium: teamStadium, stadiumName: teamStadiumName, youtube: teamYoutube, facebook: teamFacebook, website: teamWebsite))
                }
                print(teams.count)
                onCompletion(teams)
                
            }catch{
                print(error)
            }
        }
        task.resume()
    }
    
    
    
}
