//
//  Network Service.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 19.07.2021.
//

import Foundation

protocol Network {
    func fetchGenericJSONData<T: Decodable>(resource: String, completion: @escaping ([T]) -> Void)
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T?
    func jsonRequest(resource: String, completion: @escaping (Data?) -> Void)
}


class NetworkService: Network {

    func fetchGenericJSONData<T: Decodable>(resource: String, completion: @escaping ([T]) -> Void) {
        jsonRequest(resource: resource) { data in
            guard let decoded = self.decodeJSON(type: [T].self, from: data) else { return }
            completion(decoded)
        }


/*
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)

                let jsonResult = try JSONDecoder().decode([T].self, from: data)
                DispatchQueue.main.async {
                    completion(jsonResult)
                }
            } catch {
                print(error)
            }
        }
*/

    }

    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print(jsonError)
            return nil
        }

    }

    func jsonRequest(resource: String, completion: @escaping (Data?) -> Void) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                completion(data)
            } catch {
                print(error)
            }
        }
    }




}
