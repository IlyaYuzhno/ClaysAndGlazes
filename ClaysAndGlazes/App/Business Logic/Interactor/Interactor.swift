//
//  Interactor.swift
//  Clays & Glazes
//
//  Created by Ilya Doroshkevitch on 29.03.2021.
//

import Foundation


class Interactor {

    let basicJSON = "basicData"

    // MARK: - Public

    public func getClays(completion: @escaping ([Response]) -> Void) {

        if let path = Bundle.main.path(forResource: basicJSON, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode([Response].self, from: data)
                DispatchQueue.main.async {
                    completion(jsonResult)
                }
            } catch {
                print(error)
            }
        }
    }

    public func getTemperature(for clay: String, completion: @escaping (Array<String>) -> Void) {

        if let path = Bundle.main.path(forResource: basicJSON, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode([Response].self, from: data)
                let clay = jsonResult.filter { $0.clay == clay }
                let temperature = clay.map { $0.temperature }
                DispatchQueue.main.async {
                    completion(temperature[0].keys.map { $0 })
                }
            } catch {
                print(error)
            }
        }
    }

    public func getGlazes(for clay: String, temperature: String, crackleId: String, completion: @escaping ([String]) -> Void) {

        if let path = Bundle.main.path(forResource: basicJSON, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode([Response].self, from: data)
                let clay = jsonResult.filter { $0.clay == clay }
                let crackle = clay.map { $0.temperature }.first?.first(where: { $0.key == temperature })?.value
                var glazes: [String] = []

                switch crackleId {
                case "mnogo":
                    glazes = crackle?.mnogo ?? [""]
                case "malo":
                    glazes = crackle?.malo ?? [""]
                case "no":
                    glazes = crackle?.no ?? [""]
                default:
                    break
                }
                completion(glazes)

            } catch {
                print(error)
            }
        }
    }

    public func getGlazesBrand(for glaze: String, completion: @escaping ([String]) -> Void) {
        if let path = Bundle.main.path(forResource: "glazesData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode(GlazesResponse.self, from: data)
                let item = jsonResult.glazes.map { $0 }.filter { $0.list.contains(glaze) }
                let brand = item.map { $0.brand }
                DispatchQueue.main.async {
                    completion(brand)
                }
            } catch {
                print(error)
            }

        }

    }


    public func getClaysInfo(completion: @escaping ([String]) -> Void) {

        if let path = Bundle.main.path(forResource: basicJSON, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode([Response].self, from: data)
                let clayInfo = jsonResult.map { $0.info }
                DispatchQueue.main.async {
                    completion(clayInfo)
                }
            } catch {
                print(error)
            }
        }
    }

    

}
