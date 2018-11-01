//
//  AppError.swift
//  Grailed_Feed
//
//  Created by C4Q on 10/31/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
    case codingError(rawError: Error)
}

