//
//  CustomParser.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 8/24/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import Foundation

class CustomParser: Parser {
    public init() {}

    public func parse<T>(data: Data?, response: URLResponse?, error: Error?) -> Result<T> where T : Decodable {
        if let error = error {
            return .failure(error.localizedDescription)
        }
        guard let response = response as? HTTPURLResponse else { return .failure("Response is not in HTTPResponse format") }
        switch response.statusCode {
        case 200...499:
            guard let data = data else { return .failure(NetworkResponse.noData.rawValue) }

            checkForJson(data)

            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(T.self, from: data)
                return .success(response)
            } catch {
                return .failure(error.localizedDescription)
            }
        case 300...399:
            return .failure(NetworkResponse.redirect.rawValue)
        case 400...499:
            return .failure(NetworkResponse.authenticationError.rawValue)
        case 500...501:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }

    private func checkForJson(_ data: Data) -> Void {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print(json)
        } catch {
            print("Error json: ", error.localizedDescription)
        }
    }
}
