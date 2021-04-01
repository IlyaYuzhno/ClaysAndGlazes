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
    //[String : Response.Crackle]

    public func getGlazes(for clay: String, temp: String, crackleId: String, completion: @escaping ([String]) -> Void) {

        if let path = Bundle.main.path(forResource: basicJSON, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode([Response].self, from: data)

                let clay = jsonResult.filter { $0.clay == clay }
                let temperature = clay.map { $0.temperature }.first
                let yyy = temperature?.first(where: { $0.key == temp })?.value
                var glazes: [String] = []

                switch crackleId {
                case "mnogo":
                    glazes = yyy?.mnogo ?? [""]
                case "malo":
                    glazes = yyy?.malo ?? [""]
                case "no":
                    glazes = yyy?.no ?? [""]
                default:
                    break
                }

                DispatchQueue.main.async {
                    completion(glazes)
                }
            } catch {
                print(error)
            }
        }
    }




}
