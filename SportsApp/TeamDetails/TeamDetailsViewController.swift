//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Reham Ezzat on 4/20/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import UIKit
import Kingfisher

class TeamDetailsViewController: UIViewController {
    
    var team : Team?
    
    @IBOutlet var teamNameLabel: UILabel!
    
    @IBOutlet var badgeImageView: UIImageView!
    @IBOutlet var tshirtImageView: UIImageView!
    
    @IBOutlet var stadiumImageView: UIImageView!
    
    @IBOutlet var foundYearLabel: UILabel!
    
    @IBOutlet var stadiumNameLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamNameLabel.text = team?.name
        badgeImageView.kf.setImage(with: URL(string: (team?.badge)!))
        tshirtImageView.kf.setImage(with: URL(string: (team?.tshirt)!))
        stadiumImageView.kf.setImage(with: URL(string: (team?.stadium)!))
        foundYearLabel.text = (team?.foundYear)!
        
        countryLabel.text = (team?.country)!
        stadiumNameLabel.text = team?.stadiumName
    }
    
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func openYoutubeChannel(_ sender: UIButton) {
        if(team!.youtube.isEmpty){
            displayAlert()
        }else{
            let youtubeURL = URL(string: "youtube://"+(team!.youtube))!
            if UIApplication.shared.canOpenURL(youtubeURL){
                UIApplication.shared.open(youtubeURL)
            }else{
                UIApplication.shared.open(URL(string: "https://"+(team!.youtube))!)
            }
        }
    }
    
    @IBAction func openFacebookPage(_ sender: Any) {
        if(team!.facebook.isEmpty){
            displayAlert()
        }else{
            let facebookURL = URL(string: "fb://"+(team!.facebook))!
            if UIApplication.shared.canOpenURL(facebookURL){
                UIApplication.shared.open(facebookURL)
            }else{
                UIApplication.shared.open(URL(string: "https://"+(team!.facebook))!)
            }
        }
    }
    
    @IBAction func openOfficialWebsite(_ sender: UIButton) {
        if(team!.website.isEmpty){
            displayAlert()
        }else{
            UIApplication.shared.open(URL(string: "https://"+(team!.website))!)
        }
    }
    
    func displayAlert(){
        let alert : UIAlertController = UIAlertController(title: "Error", message: "This link is not valid", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
