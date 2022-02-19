//
//  Service.swift
//  TestBankin
//
//  Created by Alex on 19/02/2022.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(NSError)
}

class Service {
    let session = URLSession(configuration: .default)
    var task: URLSessionDataTask?

    func getBanks(result: @escaping ((Result<GetBanksResponse>) -> ())) {
        var urlComponents = URLComponents(string: "https://sync.bankin.com/v2/banks")
        urlComponents?.queryItems = [URLQueryItem(name: "limit", value: "300")]
        
        guard let url = urlComponents?.url else {
            result(.failure(NSError(domain: "Local", code: 404, userInfo: ["message": "Fail to construct the URL"])))
            return
        }
        var request = URLRequest(url: url)
        request.setValue("2021-06-01", forHTTPHeaderField: "Bridge-Version")
        request.setValue(clientID, forHTTPHeaderField: "Client-Id")
        request.setValue(clientSecret, forHTTPHeaderField: "Client-Secret")

        task?.cancel()
        task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                result(.failure(NSError(domain: url.host ?? "bankin.com", code: 500, userInfo: ["message": error.debugDescription])))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                result(.failure(NSError(domain: url.host ?? "bankin.com", code: 404, userInfo: ["message": "response is not correct"])))
                return
            }

            guard response.statusCode == 200 else {
                result(.failure(NSError(domain: url.host ?? "bankin.com", code: response.statusCode, userInfo: ["message": "Response code is not 200: \(response.statusCode)"])))
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let data = data,
                  let responseResult = try? decoder.decode(GetBanksResponse.self, from: data) else {
                    result(.failure(NSError(domain: "Local", code: 404, userInfo: ["message": "JSON is not correctly decoded or data is missing"])))
                    return
                }

            print("[TestBankin] réponse reçue \"\(String(data: data, encoding: .utf8))\"")
            result(.success(responseResult))
        }
        task?.resume()
    }
}
