//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Reham Ezzat on 4/18/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import UIKit
import Kingfisher

class LeagueDetailsViewController: UIViewController {
    
    private let leagueDetailsPresenter = LeagueDetailsPresenter()
    
    var leagueId : String? = "4328"
    var leagueName : String? = "English Premier League"
    
    
    var sportLeague : SportLeague?
    var events : [Event] = []
    var results : [Event] = []
    var teams : [Team] = []
    
    @IBOutlet var eventsCollectionView: UICollectionView!
    
    
    @IBOutlet var resultsCollectionView: UICollectionView!
    
    @IBOutlet var teamsCollectionView: UICollectionView!
    
    //@IBOutlet var favoriteImageView: UIImageView!
    
    @IBOutlet var favoriteLeagueButton: UIButton!
    
    var isFavoriteLeague : Bool = false
    
    
    @IBOutlet var leagueNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leagueName = sportLeague?.leagueName
        leagueId = String((sportLeague?.leagueId)!)
        
        checkFavoriteLeague()
        
        getLeagueEvents(eventState: EventState.UPCOMING)
        getLeagueEvents(eventState: EventState.PAST)
        getLeagueTeams()
        
        leagueNameLabel.text = leagueName ?? "No Name"
        /*let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleFavoriteLeagueTap))
         favoriteImageView.isUserInteractionEnabled = true
         favoriteImageView.addGestureRecognizer(tapGestureRecognizer)*/
        
    }
    
    @IBAction func addToRemoveFromFavoriteLeagues(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        /*if let _ = UIImage(named: "non-favorite-icon"){
         sender.setImage(UIImage(named: "favorite-icon"), for: .normal)
         }
         if let _ = UIImage(named: "favorite-icon"){
         sender.setImage(UIImage(named: "non-favorite-icon"), for: .selected)
         }*/
        if(isFavoriteLeague){
            sender.setImage(UIImage(named: "non-favorite-icon"), for: .normal)
            isFavoriteLeague = false
            print("***false****")
            removeFromFavorites()
        }else{
            sender.setImage(UIImage(named: "favorite-icon"), for: .normal)
            isFavoriteLeague = true
            print("***true****")
            
            addToFavorites()
        }
        
    }
    func checkFavoriteLeague(){
        leagueDetailsPresenter.isFavoriteLeague(leagueId: leagueId!){(isFavoriteLeague) in
            self.isFavoriteLeague = isFavoriteLeague
            DispatchQueue.main.async {
                if(self.isFavoriteLeague){
                    //self.favoriteImageView.image = UIImage(named: "favorite-icon")
                    
                    print("******true")
                    self.favoriteLeagueButton.setImage(UIImage(named: "favorite-icon"), for: .normal)
                }else{
                    //self.favoriteImageView.image = UIImage(named: "non-favorite-icon")
                    print("******false")
                    
                    self.favoriteLeagueButton.setImage(UIImage(named: "non-favorite-icon"), for: .normal)
                }
            }
        }
    }
    
    func getLeagueEvents(eventState : EventState){
        leagueDetailsPresenter.getEventsByLeagueId(eventState: eventState, leagueId: leagueId!){(events) in
            if(eventState == EventState.UPCOMING){
                self.events = events
                DispatchQueue.main.async {
                    self.eventsCollectionView.reloadData()
                }
            }else{
                self.results = events
                DispatchQueue.main.async {
                    self.resultsCollectionView.reloadData()
                }
            }
            
        }
    }
    
    func getLeagueTeams(){
        leagueDetailsPresenter.getTeamsByLeagueName(leagueName: leagueName!){(teams) in
            self.teams = teams
            DispatchQueue.main.async {
                self.teamsCollectionView.reloadData()
                //print("teams came********")
                //self.eventsCollectionView.reloadData()
            }
        }
    }
    
    /*@objc func handleFavoriteLeagueTap(){
     if(isFavoriteLeague){
     favoriteImageView.image = UIImage(named: "non-favorite-icon")
     isFavoriteLeague = false
     removeFromFavorites()
     }else{
     favoriteImageView.image = UIImage(named: "favorite-icon")
     isFavoriteLeague = true
     addToFavorites()
     }
     }*/
    
    func addToFavorites(){
        //var league = League(id: "4328", name: "English Premier League", badge: "ba", youtube: "yo")
        let league = League(id: String((sportLeague?.leagueId)!), name: (sportLeague?.leagueName)!, badge: (sportLeague?.leagueImageURL)!, youtube: (sportLeague?.leagueYoutubeURL)!)
        leagueDetailsPresenter.addLeagueToFavorites(league: league)
    }
    
    func removeFromFavorites(){
        //var league = League(id: "4328", name: "English Premier League", badge: "ba", youtube: "yo")
        let league = League(id: String((sportLeague?.leagueId)!), name: (sportLeague?.leagueName)!, badge: (sportLeague?.leagueImageURL)!, youtube: (sportLeague?.leagueYoutubeURL)!)
        leagueDetailsPresenter.removeLeagueFromFavorites(league: league)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let teamDetailsViewController = segue.destination as! TeamDetailsViewController
        teamDetailsViewController.team = teams[(teamsCollectionView.indexPathsForSelectedItems?.first?.row)!]
    }
}

extension LeagueDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        /*if(events.count == 0){
         let view = CGRect(x: eventsCollectionView.view.x, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
         }*/
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case eventsCollectionView:
            return events.count
        case teamsCollectionView:
            return teams.count
        case resultsCollectionView:
            return results.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case eventsCollectionView:
            let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCollectionViewCell
            
            eventCell.eventNameLabel.text = events[indexPath.row].name
            eventCell.eventDateLabel.text = events[indexPath.row].date + " at " + events[indexPath.row].time
            //eventCell.eventTimeLabel.text = events[indexPath.row].time
            
            //let homeTeamBadge = teams.filter{$0.id == events[indexPath.row].homeTeamId}.first?.badge
            //let img = homeTeam
            //eventCell.homeTeamBadgeImageView.image = UIImage(named: homeTeamBadge ?? "")
            //print("hererrer**********")
            return eventCell
        case teamsCollectionView:
            let teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCollectionViewCell
            teamCell.badgeImageView.kf.setImage(with: URL(string: teams[indexPath.row].badge))
            return teamCell
        case resultsCollectionView:
            let resultCell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultCell", for: indexPath) as! ResultCollectionViewCell
            
            resultCell.eventNameLabel.text = results[indexPath.row].name
            resultCell.dateLabel.text = results[indexPath.row].date + " at " + results[indexPath.row].time
            //resultCell.timeLabel.text = results[indexPath.row].time
            resultCell.homeTeamScoreLabel.text = String(results[indexPath.row].homeTeamScore)
            resultCell.awayTeamScoreLabel.text = String(results[indexPath.row].awayTeamScore)
            
            return resultCell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == teamsCollectionView){
            //let teamDetailsViewController = TeamDetailsViewController()
            //teamDetailsViewController.team = teams[indexPath.row]
            
            //performSegue(withIdentifier: "teamSegue", sender: self)
        }
    }
    
    
}
