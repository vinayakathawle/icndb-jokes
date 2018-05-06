/*
 * Copyright © 2017 Vinayak Kakade. All rights reserved.
 */

import UIKit


/**
 Enum for error code.
 
 - ServerUnavailable1001:   Server Unavailable
 - ServerUnavailable1002:   Server Unavailable
 - ServerUnavailable1003:   Server Unavailable
 - ServerUnavailable1011:   Server Unavailable
 - ServerUnavailable1004:   Server Unavailable
 - networkUnavailable1005:  Network Unavailable
 - networkUnavailable1009:  Network Unavailable
 - DataUnAvailable1008:     Data UnAvailable
 - UnknownError:            Unknown Error
 - NoUserToken:             NoUserToken
 - MultipartEncodingFailed: Multipart Encoding Failed
 - ServerUnavailable1004::  Server Unavailable
 - SessionTimeOut
 */
enum ErrorCode: Int{
    case serverUnavailable1001  = -1001
    case serverUnavailable1002  = -1002
    case serverUnavailable1003  = -1003
    case serverUnavailable1011  = -1011
    case serverUnavailable1004 = -1004
    case networkUnavailable1005 = -1005
    case networkUnavailable1009 = -1009
    case dataUnAvailable1008 = -1008
    case unknownError = 0
    case noUserToken
    case multipartEncodingFailed
    case empltyText
    case sessionTimeOut
    
    /**
     This return the localized description for each error.
     
     - returns: The localized description of error.
     */
    func localizedDescription() -> String{
        switch self{
        case .serverUnavailable1001, .serverUnavailable1002, .serverUnavailable1003, .serverUnavailable1011, .serverUnavailable1004:
            return "Server temporarily unavailable. Please try again later"
            
        case  .networkUnavailable1005, .networkUnavailable1009:
            return "No network connection. Please try again later"
            
        case .dataUnAvailable1008:
            return "No data available on the server. Please try again later"
            
        case .unknownError:
            return "Server temporarily unavailable. Please try again later"
            
        case .noUserToken:
            return "Authentication failed."
            
        case .multipartEncodingFailed:
            return "Upload failed. Please try again later."
            
        case .empltyText:
            return "Search can not be empty."
        case .sessionTimeOut:
            return "Session Timeout. Please login Again"
            
        }
    }
}

extension NSError{
    
    /**
     Create detault error object with given error code.
     
     - parameter errorCode: The error code from error code enum.
     
     - returns: void.
     */
    convenience init(errorCode: ErrorCode){
        self.init(domain: "ErrorDomain", code: errorCode.rawValue, userInfo: [NSLocalizedDescriptionKey : errorCode.localizedDescription()])
    }
}
