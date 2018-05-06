//
//  APIManager.swift
//  Jokes
//
//  Created by Vinayak Kakade on 5/6/18.
//  Copyright © 2018 Vinayak Kakade. All rights reserved.
//

import UIKit

// Encapsulation for response obtained from network call
public enum ServiceResponse{
    case success(data: Data?)
    case failure(error: Error?)
}

class APIManager: NSObject {
    
    typealias WebServiceSuccessClosure = (_ response: AnyObject) -> Void
    typealias WebServiceFailureClosure = (_ error: NSError) -> Void
    
    static let sharedInstance = APIManager()
    
    /**
     This method will call service and return clouser base on response.
     
     - parameter serviceURL:       service URL.
     - parameter successClosure: On sucss this block will get call.
     - parameter failureClosure: On failure this block will get call.
     */
    func getJoke(_ serviceURL: String, successClosure: @escaping WebServiceSuccessClosure, failureClosure: @escaping WebServiceFailureClosure){
        
        // Setup the session to make REST GET call.
        let session = URLSession.shared
        let url = URL(string: serviceURL)!
        
        // Make the GET call
        session.dataTask(with: url, completionHandler: { ( data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            // Make sure we get an OK response
            guard let realResponse = response as? HTTPURLResponse,
                realResponse.statusCode == 200 else {
                    ApplicationUtility.showToast(message: COMMAN_ERROR_MSG)
                    return
            }
            
            self.parseJSONResponse(ServiceResponse.success(data: data), successClosure: successClosure, failureClosure: failureClosure)
            
        } ).resume()
    }
    
    /**
     This method will switch to case of http response and will call to appropriate colsure.
     
     - parameter response:       Http response object.
     - parameter successClosure: On sucss this block will get call.
     - parameter failureClosure: On failure this block will get call.
     */
    func parseJSONResponse(_ response: ServiceResponse, successClosure: WebServiceSuccessClosure, failureClosure: WebServiceFailureClosure){
        switch response{
        case .success(let data):
            if let d = data , d.count > 0  {
                if let jsonObject = try? JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.allowFragments),let jsonDictionary = jsonObject as? [String: AnyObject]  {
                    successClosure(jsonDictionary  as AnyObject)
                }
                else {
                    failureClosure(NSError(errorCode: .serverUnavailable1001))
                }
            }
            else if !Reachability.isReachable() {
                failureClosure(NSError(errorCode: .networkUnavailable1009))
            }
            else{
                failureClosure(NSError(errorCode: .dataUnAvailable1008))
            }
            break
            
        case .failure(let error):
            if let e = error as NSError?{
                failureClosure(e)
            }
            
            break
        }
    }


}
