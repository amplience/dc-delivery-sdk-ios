//
//  NetworkingError.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 26/05/2022.
//

import Foundation

/// We use this enum to make sure we get clearer api errors.
public enum NetworkingError: Error, Equatable {
    case generic
    case badRequest
    case networkUnavailable
    case notFound
    case invalidResponse
    case decodingFailed
    case serverError
    case temporaryServerError
    case unauthorised
    case notAnError
    case badGateway
    case badURL
    case timedOut
    case cannotFindHost
    case cannotConnectToHost
    case notConnectedToInternet
    
    init(from statusCode: Int) {
        switch statusCode {
        case -1000:
            self = .badURL
        case -1001:
            self = .timedOut
        case -1003:
            self = .cannotFindHost
        case -1004:
            self = .cannotConnectToHost
        case -1005:
            self = .notConnectedToInternet
        case -1022 ... -999:
            self = .networkUnavailable
        case 400:
            self = .badRequest
        case 401...403:
            self = .unauthorised
        case 404:
            self = .notFound
        case 502:
            self = .badGateway
        case 413: // Temporary, when we fix server issues this won't be the case.
            self = .temporaryServerError
        case 500...520:
            self = .serverError
        case 200...210:
            self = .notAnError
        default:
            self = .generic
        }
    }
    
    public func readableString() -> String {
        switch self {
        case .serverError, .temporaryServerError, .decodingFailed, .badGateway:
            return "we're having temporary server issues, please try again later"
        case .badRequest:
            return "bad request"
        case .networkUnavailable:
            return "you're not connected to the internet"
        case .unauthorised:
            return "you're unauthorised. Please check your information and try again"
        case .notFound:
            return "we couldn't find what you're looking for"
        case .invalidResponse:
            return "the server returned an invalid response, please try again later"
        case .generic:
            return "an unknown error has occurred"
        case .notAnError:
            return "oops"
        case .badURL:
            return "we couldn't find the url"
        case .timedOut:
            return "the request is timed out"
        case .cannotFindHost:
            return "we couldn't find the host"
        case .cannotConnectToHost:
            return "we coudldn't connect to the host"
        case .notConnectedToInternet:
            return "we couldn't connect to the internet, please try again later"
        }
    }

    public func code() -> Int {
        let code: Int
        switch self {
        case .networkUnavailable:
            code = -1001
        case .badRequest:
            code = 400
        case .decodingFailed:
            code = 1
        case .invalidResponse:
            code = 2
        case .notFound:
            code = 404
        case .serverError:
            code = 500
        case .temporaryServerError:
            code = 413
        case .generic:
            code = 0
        case .unauthorised:
            code = 401
        case .notAnError:
            code = -1
        case .badGateway:
            code = 502
        case .badURL:
            code = -1000
        case .timedOut:
            code = -1001
        case .cannotFindHost:
            code = -1003
        case .cannotConnectToHost:
            code = -1004
        case .notConnectedToInternet:
            code = -1009
        }
        
        return code
    }
    
    static public func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        switch (lhs, rhs) {
        case (.generic, .generic), (.badRequest, .badRequest), (.networkUnavailable, .networkUnavailable), (.notFound, .notFound), (.invalidResponse, .invalidResponse), (.serverError, .serverError), (.unauthorised, .unauthorised):
            return true
        default:
            return false
        }
    }
    
}
