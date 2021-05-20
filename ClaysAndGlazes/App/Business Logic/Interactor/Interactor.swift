//
//  Interactor.swift
//  Clays & Glazes
//
//  Created by Ilya Doroshkevitch on 29.03.2021.
//
import Foundation
import Firebase
import FirebaseUI
import UIKit

class Interactor {

    let claysBasicJSON = "ClaysInfo"
    static var storage = Storage.storage()

    // MARK: - Clays stuff

    public func getClays(completion: @escaping ([Response]) -> Void) {

        if let path = Bundle.main.path(forResource: claysBasicJSON, ofType: "json") {
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
        if let path = Bundle.main.path(forResource: claysBasicJSON, ofType: "json") {
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
        if let path = Bundle.main.path(forResource: claysBasicJSON, ofType: "json") {
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
        if let path = Bundle.main.path(forResource: "GlazesList", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode(GlazesSearchResponse.self, from: data)
                let item = jsonResult.glazes.map { $0 }.filter { $0.list.contains(glaze) }
                let brand = item.map { $0.brand }
                completion(brand)
            } catch {
                print(error)
            }

        }

    }

    public func getClaysInfo(completion: @escaping ([String]) -> Void) {
        if let path = Bundle.main.path(forResource: claysBasicJSON, ofType: "json") {
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

    // MARK: - Glazes stuff

    let glazesBasicJSON = "GlazesInfo"

    public func getGlazesList(completion: @escaping ([GlazesResponse]) -> Void) {
        if let path = Bundle.main.path(forResource: glazesBasicJSON, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode([GlazesResponse].self, from: data)
                DispatchQueue.main.async {
                    completion(jsonResult)
                }
            } catch {
                print(error)
            }

        }
    }

    public func getGlazeTemperature(for glaze: String, completion: @escaping (Array<String>) -> Void) {
        if let path = Bundle.main.path(forResource: glazesBasicJSON, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode([GlazesResponse].self, from: data)
                let glaze = jsonResult.filter { $0.glaze == glaze }
                let temperature = glaze.map { $0.temperature }
                DispatchQueue.main.async {
                    completion(temperature[0].keys.map { $0 })
                }
            } catch {
                print(error)
            }
        }
    }

    public func getClaysForGlaze(for glaze: String, temperature: String, crackleId: String, completion: @escaping ([String]) -> Void) {
        if let path = Bundle.main.path(forResource: glazesBasicJSON, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode([GlazesResponse].self, from: data)
                let glaze = jsonResult.filter { $0.glaze == glaze }
                let crackle = glaze.map { $0.temperature }.first?.first(where: { $0.key == temperature })?.value
                var clays: [String] = []

                switch crackleId {
                case "mnogo":
                    clays = crackle?.mnogo ?? [""]
                case "malo":
                    clays = crackle?.malo ?? [""]
                case "no":
                    clays = crackle?.no ?? [""]
                default:
                    break
                }
                DispatchQueue.main.async {
                    completion(clays)
                }
            } catch {
                print(error)
            }
        }
    }

    public func getGlazeInfo(completion: @escaping ([String]) -> Void) {
        if let path = Bundle.main.path(forResource: glazesBasicJSON, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode([GlazesResponse].self, from: data)
                let glazeInfo = jsonResult.map { $0.info }
                DispatchQueue.main.async {
                    completion(glazeInfo)
                }
            } catch {
                print(error)
            }
        }
    }

    // MARK: Get glaze image from Firebase storage
    class func getGlazeImageFromFirebase(imageName: String, imageView: UIImageView) {
        let glazesImagesRef = storage.reference(withPath: "images/glazes")
        let image = glazesImagesRef.child("\(imageName).png")
        let placeholderImage = UIImage(named: "placeholder.png")
        imageView.sd_setImage(with: image, placeholderImage: placeholderImage)
    }



}
