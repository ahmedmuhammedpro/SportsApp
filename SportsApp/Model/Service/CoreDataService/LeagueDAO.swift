//
//  LeagueDAO.swift
//  SportsApp
//
//  Created by Reham Ezzat on 4/18/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import Foundation
import CoreData

class LeagueDAO{
    var managedContext : NSManagedObjectContext?
    
    
    init(appDelegate: AppDelegate) {
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func insertLeague(league : League){
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteLeague", in: self.managedContext!)
        let leagueObject = NSManagedObject(entity: entity!, insertInto: self.managedContext)
        
        leagueObject.setValue(league.id, forKey: "id")
        leagueObject.setValue(league.name, forKey: "name")
        leagueObject.setValue(league.badge, forKey: "badge")
        leagueObject.setValue(league.youtube, forKey: "youtube")
        
        do{
            try self.managedContext?.save()
        }catch let error as NSError{
            print(error)
        }
    }
    
    func deleteLeague(league : League){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeague")
        fetchRequest.predicate = NSPredicate(format: "id == %@", league.id)
        
        do{
            let leagueObject = try managedContext?.fetch(fetchRequest).first
            
            managedContext?.delete(leagueObject!)
            try managedContext!.save()
            
        }catch let error as NSError{
            print(error)
        }
    }
    
    func findLeagueById(leagueId : String, onCompletion: @escaping (_ isFavorite : Bool) -> Void){
        let request = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeague")
        request.predicate = NSPredicate(format: "id == %@", leagueId)
        var counter = 0
        do{
            counter = try self.managedContext?.count(for: request) ?? 0
            
            if(counter > 0){
                onCompletion(true)
            }else{
                onCompletion(false)
            }
        }catch let error as NSError{
            print(error)
        }
    }
    
    func getAllLeagues(onCompletion: @escaping([SportLeague])->Void){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeague")
        var _favoriteLeagues : [SportLeague] = []
        
        do{
            let favoriteLeagues = try managedContext?.fetch(fetchRequest)
            
            favoriteLeagues?.forEach({(league) in
                _favoriteLeagues.append(SportLeague(leagueId: Int(league.value(forKey: "id") as! String) ?? 0, sportName: "", leagueName: league.value(forKey: "name") as! String, leagueCountry: "", leagueYoutubeURL: league.value(forKey: "youtube") as! String, leagueImageURL: league.value(forKey: "badge") as! String))
            })
            onCompletion(_favoriteLeagues)
        }catch let error as NSError{
            print(error)
        }
    }
    
    
}
