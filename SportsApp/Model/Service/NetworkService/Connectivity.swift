//
//  Connectivity.swift
//  SportsApp
//
//  Created by ahmedpro on 4/23/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
