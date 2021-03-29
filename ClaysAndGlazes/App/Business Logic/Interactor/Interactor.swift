//
//  Interactor.swift
//  Clays & Glazes
//
//  Created by Ilya Doroshkevitch on 29.03.2021.
//

import Foundation


class Interactor {


    public func getClays(completion: @escaping ([String]) -> Void) {

        if let path = Bundle.main.path(forResource: "clays", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode([Response].self, from: data)
                let clays = jsonResult.map { $0.clay }
                DispatchQueue.main.async {
                    completion(clays)
                }
            } catch {
                print(error)
            }
        }
    }



    public func getTemperature(for clay: String, completion: @escaping ([String : Response.Crackle]) -> Void) {

        if let path = Bundle.main.path(forResource: "clays", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode([Response].self, from: data)
                let clay = jsonResult.filter { $0.clay == clay }
                let temperature = clay.map { $0.temperature }
                DispatchQueue.main.async {
                    completion(temperature[0])
                }
            } catch {
                print(error)
            }
        }
    }


    public func getGlazes(for clay: String, temp: String, crackleId: String, completion: @escaping ([String]) -> Void) {

        if let path = Bundle.main.path(forResource: "clays", ofType: "json") {
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
