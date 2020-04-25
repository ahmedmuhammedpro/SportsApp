//
//  CollectionViewCell.swift
//  SportsApp
//
//  Created by ahmedpro on 4/19/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import UIKit
import Kingfisher

class SportsViewController: UIViewController, SportsViewProtocol {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var spotsPresenter: SportsPresenterProtocol?
    
    private var sports = Array<Sport>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sports"
        spotsPresenter = SportsPresenter(sportsView: self, apiURL: "https://www.thesportsdb.com/api/v1/json/1/all_sports.php")
        loadSports()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func updateCollectionView(retrievedSports: [Sport]?) {
        guard let validSports = retrievedSports else {
            print("something is wrong whith retrived sports")
            return
        }
        
        sports += validSports
        collectionView.reloadData()
    }
    
    func showNoInternetAlertView() {
        let alert = UIAlertController(title: "NO INTERNET", message: "Sorry! there is no iternet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "TRY", style: .default, handler: { alertAction in self.loadSports()}))
        present(alert, animated: true, completion: nil)
    }
    
    private func loadSports() {
        spotsPresenter?.loadSports()
    }
}

// extention with Collection deleagtes
extension SportsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sport = sports[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.sportImageView.kf.setImage(with: URL(string: sport.sportImageURL ?? ""))
        cell.sportImageView.kf.indicatorType = .activity
        cell.sportLabel.text = sport.sportName
        
        //This creates the shadows and modifies the cards a little bit
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leaguesView = storyboard?.instantiateViewController(withIdentifier: "sportLeaguesView") as! SportLeaguesViewController
        leaguesView.sportName = sports[indexPath.item].sportName
        navigationController?.pushViewController(leaguesView, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumLineSpacing
        let adjustedWidth = collectionViewWidth - spaceBetweenCells
        let width: CGFloat = floor(adjustedWidth / 2)
        let height: CGFloat = 140
        return CGSize(width: width, height: height)
    }
}
