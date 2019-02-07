//
//  .swift
//  ImageLoader
//
//  Created by Viresh Singh on 07/02/19.
//  Copyright © 2019 Viresh Singh. All rights reserved.
//

import Foundation
public enum ApplicationErrorType:Int
{
    case NetworkTimeout_1001                               =   -1001
    case NetworkServerNotFound_1003                        =   -1003
    case NetworkConnectionToServerFailed_1004              =   -1004
    case NetworkConnectionToServerLost_1005                =   -1005
    case NetworkInternetNotReachable_1009                  =   -1009
    case NetworkServerTrustEvaluationFailed_1202           =   -1202
    case NetworkServerTrustEvaluationFailed_999            =   -999
    case NetworkFileDirectoryNotFound_404                  =   404
    case NetworkUnAuthorisedError_401                      =   401
    case NetworkResourceAccessDenied_403                   =   403
    case NetworkInternalServerError_500                    =   500
    case NetworkServiceUnavailable_503                     =   503
    case NetworkBadRequest_400                             =   400
    case NetworkServiceError_408                           =   408
    case Unknown                                           =   99999
    
    static func networkErrorCode()->[ApplicationErrorType]
    {
        return [.NetworkTimeout_1001,.NetworkServerNotFound_1003,.NetworkConnectionToServerFailed_1004,.NetworkConnectionToServerLost_1005,.NetworkInternetNotReachable_1009,.NetworkServerTrustEvaluationFailed_1202,.NetworkServerTrustEvaluationFailed_999]
    }
}

class  ApplicationError{
    var errorCode:ApplicationErrorType = .Unknown
    var originalError:Error? = nil
    func displayableErrorMessage()->String
    {
        switch self.errorCode {
        case .NetworkTimeout_1001:
            return "Network Request Timeout"
        case .NetworkInternetNotReachable_1009, .NetworkServerNotFound_1003:
            return "Server not reachable"
        case .NetworkConnectionToServerFailed_1004:
            return "Network Connection Failed"
        case .NetworkConnectionToServerLost_1005:
            return "Network Connection Lost"
        
        case .NetworkServerTrustEvaluationFailed_1202, .NetworkServerTrustEvaluationFailed_999:
            return "Failed to Evaluate Server Trust. Either server is having Invalid or Self signed certificate."
        case .NetworkFileDirectoryNotFound_404:
            return "No Data Found"
        case .NetworkUnAuthorisedError_401:
            return "User not Authorized"
        case .NetworkResourceAccessDenied_403:
            return "Access Denied"
        case .NetworkInternalServerError_500,.NetworkServiceUnavailable_503,.NetworkServiceError_408:
            return "Internal Server Error"
        case .NetworkBadRequest_400:
            return "Bad Request"
        default:
            return "Some Error Occurred"
        }
    }
    
    class func error(with httpCode:Int) -> ApplicationError {
        let error = ApplicationError()
        switch httpCode {
        case -1001:
            error.errorCode = .NetworkTimeout_1001
            break
        case -1003:
            error.errorCode = .NetworkServerNotFound_1003
            break
        case -1004:
            error.errorCode = .NetworkConnectionToServerFailed_1004
            break
        case -1005:
            error.errorCode = .NetworkConnectionToServerLost_1005
            break
        case -1009:
            error.errorCode = .NetworkInternetNotReachable_1009
            break
        case -1012, -999:
            error.errorCode = .NetworkServerTrustEvaluationFailed_1202
            break
        case 404:
            error.errorCode = .NetworkFileDirectoryNotFound_404
            break
        case 401:
            error.errorCode = .NetworkUnAuthorisedError_401
            break
        case 403:
            error.errorCode = .NetworkResourceAccessDenied_403
            break
        case 408:
            error.errorCode = .NetworkServiceError_408
            break
        case 500,503:
            error.errorCode = .NetworkInternalServerError_500
            break
        default:
            error.errorCode = .Unknown
            break
        }
        return error
    }
    
    func isNetworkError() -> Bool {
        return  ApplicationErrorType.networkErrorCode().contains(self.errorCode)
    }
    
    class func genericError() -> ApplicationError
    {
        return ApplicationError()
    }
    
    class func NoDataError() -> ApplicationError
    {
        let error = ApplicationError()
        error.errorCode = .NetworkFileDirectoryNotFound_404
        return error
    }
}

