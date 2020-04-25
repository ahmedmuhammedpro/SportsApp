//
//  EventCollectionViewCell.swift
//  SportsApp
//
//  Created by Reham Ezzat on 4/18/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import UIKit
import EventKit

class EventCollectionViewCell: UICollectionViewCell {
    
    var eventStore : EKEventStore?
    
    //@IBOutlet var eventNameLabel: UILabel!
    
    @IBOutlet var eventDateLabel: UILabel!
    
    //@IBOutlet var eventTimeLabel: UILabel!
    
    
    @IBOutlet var eventNameLabel: UITextView!
    @IBAction func setEventReminder(_ sender: UISwitch) {
        /*eventStore = EKEventStore()
         eventStore?.requestAccess(to: EKEntityType.reminder, completion: { (granted, error) in
         if(!granted){
         print("access no granted")
         }
         })
         
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
         
         let dateElements = eventDateLabel.text?.split(separator: "/")
         let dayStr = String(dateElements?[0] ?? "00")
         let monthStr = String(dateElements?[1] ?? "00")
         let yearStr = "20"+String(dateElements?[2] ?? "00")
         
         let dateAndTimeStr = yearStr + "-" + monthStr + "-" + dayStr + "'T'" + eventTimeLabel.text!
         
         let date : Date = dateFormatter.date(from: dateAndTimeStr) ?? Date()
         
         let reminders = eventStore?.calendars(for: EKEntityType.event)
         print((reminders?.count)!)
         
         let reminder : EKReminder = EKReminder(eventStore: eventStore!)
         reminder.calendar = eventStore?.defaultCalendarForNewReminders()
         
         let alarm : EKAlarm = EKAlarm(absoluteDate: date)
         reminder.addAlarm(alarm)
         
         reminder.title = eventNameLabel.text
         
         do{
         try eventStore?.save(reminder, commit: true)
         }catch let error{
         print(error)
         }*/
    }
}
