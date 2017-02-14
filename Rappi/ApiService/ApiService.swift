//
//  ApiService.swift
//  Rappi
//
//  Created by Santiago Restrepo on 13/02/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit
import SystemConfiguration

typealias ServiceResponse = (Any?, NSError?) -> Void

class ApiService: NSObject {
    
    static let shared = ApiService()
    
    let baseUrl = "https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json"
    
    func fetchData() -> Bool {
        if isInternetAvailable() {
            makeGETRequest(self.baseUrl) { (data, error) in
                if error != nil {
                    NSLog(error.debugDescription)
                } else {
                    print(data)
                    
                }
            }
            return true
        } else {
            return false
        }
    }
    
    private func makeGETRequest(_ url: String, completion: @escaping ServiceResponse) {
        let request = NSMutableURLRequest(url: URL(string: url)!)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if error != nil {
                NSLog(error.debugDescription)
            } else {
                
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) {
                    DispatchQueue.main.async {
                        completion(json, error as NSError?)
                    }
                }
            }
        })
        task.resume()
    }
    
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
}
