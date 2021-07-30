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

    func getClays(completion: @escaping ([Response]) -> Void) {
        if let path = Bundle.main.path(forResource: claysBasicJSON, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode([Response].self, from: data)
                completion(jsonResult)
            } catch {
                print(error)
            }
        }
    }

     func getTemperature(for clay: String, completion: @escaping (Array<String>) -> Void) {
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

    func getGlazes(for clay: String, temperature: String, crackleId: String, completion: @escaping ([String]) -> Void) {
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

     func getGlazesBrand(for glaze: String, completion: @escaping ([String]) -> Void) {
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

     func getClaysInfo(completion: @escaping ([String]) -> Void) {
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

    // MARK: Get clay image from Firebase storage
    class func getClayImageFromFirebase(imageName: String, imageView: UIImageView) {
        let claysImagesRef = storage.reference(withPath: "images/clays")
        let image = claysImagesRef.child("\(imageName).png")
        let placeholderImage = UIImage(named: "placeholder.png")
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        imageView.sd_setImage(with: image, placeholderImage: placeholderImage)
    }

    // MARK: - Glazes stuff

    let glazesBasicJSON = "GlazesInfo"

     func getGlazesList(completion: @escaping ([GlazesResponse]) -> Void) {
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

     func getGlazeTemperature(for glaze: String, completion: @escaping (Array<String>) -> Void) {
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

     func getClaysForGlaze(for glaze: String, temperature: String, crackleId: String, completion: @escaping ([String]) -> Void) {
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

     func getGlazeInfo(completion: @escaping ([String]) -> Void) {
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
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        imageView.sd_setImage(with: image, placeholderImage: placeholderImage)
    }


/*
    func fetchGenericJSONData<T: Decodable>(resource: String, completion: @escaping ([T]) -> Void) {
        jsonRequest(resource: resource) { data in
            let decoded = self.decodeJSON(type: [T].self, from: data)
            completion(decoded!)
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
 */

}
