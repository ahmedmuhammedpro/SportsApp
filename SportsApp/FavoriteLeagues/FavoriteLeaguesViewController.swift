//
//  FavoriteLeaguesViewController.swift
//  SportsApp
//
//  Created by ahmedpro on 4/25/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import UIKit

class FavoriteLeaguesViewController: UIViewController, FavoriteLeaguesViewProtocol {
    
    @IBOutlet weak var noFavoriteLeaguesLabel: UILabel!
    private var favoriteLeaguesPresenter: FavoriteLeaguesPresenterProtocol?
    private var tableView: UITableView?
    private var sportLeagues = Array<SportLeague>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite Leagues"
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        favoriteLeaguesPresenter = FavoriteLeaguesPresenter(favoriteLeaguesView: self, appDelegate: appDelegate)
        
        if let tb = Bundle.main.loadNibNamed("SportLeaguesTableView", owner: self, options: nil)?.first as? SportLeaguesTableView {
            tableView = tb
            tableView?.delegate = self
            tableView?.dataSource = self
            tableView?.isHidden = true
            view.addSubview(tableView!)
        }
    }
    
    func updateTableView(retrievedSportLeagues: [SportLeague]) {
        if retrievedSportLeagues.count > 0 {
            noFavoriteLeaguesLabel.isHidden = true
            tableView?.isHidden = false
            sportLeagues = retrievedSportLeagues
            tableView!.reloadData()
        } else {
            tableView?.isHidden = true
            noFavoriteLeaguesLabel.isHidden = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favoriteLeaguesPresenter?.loadSportLeagues()
    }
}

extension FavoriteLeaguesViewController: UITableViewDelegate, UITableViewDataSource {
    
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
