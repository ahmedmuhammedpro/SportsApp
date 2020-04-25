//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by ahmedpro on 4/21/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import UIKit
import Kingfisher

class SportLeaguesViewController: UIViewController, SportLeaguesViewProtocol {
    
    var sportName: String?
    private var tableView: UITableView?
    private var sportLeaguesPresenter: SportLeaguesPresenterProtocol?
    private var sportLeagues = Array<SportLeague>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tb = Bundle.main.loadNibNamed("SportLeaguesTableView", owner: self, options: nil)?.first as? SportLeaguesTableView {
            tableView = tb
            tableView?.delegate = self
            tableView?.dataSource = self
            
            view.addSubview(tableView!)
        }
        
        if let validSportName = sportName {
            title = validSportName
            sportLeaguesPresenter = SportLeaguesPresenter(sportLeaguesView: self, apiURL: getURLWithoutSpace(s: validSportName))
            sportLeaguesPresenter?.loadSportLeagues()
        }
    }
    
    
    func updateTableView(retrievedSportLeagues: [SportLeague]) {
        sportLeagues = retrievedSportLeagues
        tableView?.reloadData()
    }
    
    func showNoInternetAlertView() {
        let alert = UIAlertController(title: "NO INTERNET", message: "Sorry! there is no iternet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "TRY", style: .default, handler: { alertAction in self.loadSportLeagues()}))
        present(alert, animated: true, completion: nil)
    }
    
    private func loadSportLeagues() {
        sportLeaguesPresenter?.loadSportLeagues()
    }
    
    private func getURLWithoutSpace(s: String) -> String {
        let arr = s.split(separator: " ")
        
        if arr.count > 1 {
            var url = "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?s="
            for i in 0..<arr.count - 1 {
                url += "\(arr[i])%20"
            }
            
            url += arr[arr.count - 1]
            return url
        }
        
        return "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?s=\(s)"
    }
    
}

// extention with Table deleagtes
extension SportLeaguesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportLeagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sportLeague = sportLeagues[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "sportLeaguesCell") as! SportLeaguesTableCell
        cell.sportLeagueImageView.kf.setImage(with: URL(string: sportLeague.leagueImageURL ?? ""))
        cell.sportLeagueImageView.kf.indicatorType = .activity
        cell.sportLeagueLabel.text = sportLeague.leagueName ?? ""
        
        cell.youtubeButton.tag = indexPath.item
        cell.youtubeButton.addTarget(self, action: #selector(goToYoutube(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetailsStoryBoard = UIStoryboard(name: "Reham", bundle: nil)
        let leagueDetailsView = leagueDetailsStoryBoard.instantiateViewController(withIdentifier: "LDVC") as! LeagueDetailsViewController
        leagueDetailsView.sportLeague = sportLeagues[indexPath.item]
        present(leagueDetailsView, animated: true, completion: nil)
    }
    
    @objc private func goToYoutube(_ sender: UIButton) {
        let s = sportLeagues[sender.tag].leagueYoutubeURL ?? ""
        if !s.isEmpty {
            let url = URL(string: "https://\(s)")!
            if !UIApplication.shared.canOpenURL(url)  {
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            let alertView = UIAlertController(title: "YOUTUBE", message: "Sorry! there is no youtube's channel availabel yet.", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            navigationController?.present(alertView, animated: true, completion: nil)
        }
    }
}
