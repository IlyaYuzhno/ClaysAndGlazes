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

class ClaysGlazeLocalStorageService {

    let glazesListJSON = DataResources.glazesListJSON
    static var storage = Storage.storage()

    // MARK: - Generic methods

    // Get clays or glazes list
    func getData<T: Codable>(resource: String, completion: @escaping ([T]) -> Void) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode([T].self, from: data)
                completion(jsonResult)
            } catch {
                print(error)
            }
        }
    }

    // Get temperatures info for selected item
    func getItemTemperature(resource: String, for item: String, completion: @escaping (Array<String>) -> Void) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode([ClaysGlazeItem].self, from: data)
                let itemToReturn = jsonResult.filter { $0.item == item }
                let temperature = itemToReturn.map { $0.temperature }

                completion(temperature[0].keys.map { $0 })

            } catch {
                print(error)
            }
        }
    }

    // Get list of items for selected item temperature etc.
    func getItemsForSelectedItem(resource: String, for item: String, temperature: String, crackleId: String, completion: @escaping ([String]) -> Void) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode([ClaysGlazeItem].self, from: data)
                let claysGlazes = jsonResult.filter { $0.item == item }
                let crackle = claysGlazes.map { $0.temperature }.first?.first(where: { $0.key == temperature })?.value
                var items: [String] = []

                switch crackleId {
                case "mnogo":
                    items = crackle?.mnogo ?? [""]
                case "malo":
                    items = crackle?.malo ?? [""]
                case "no":
                    items = crackle?.no ?? [""]
                default:
                    break
                }
                completion(items)
            } catch {
                print(error)
            }
        }
    }

   // Get item image from Firebase storage
    class func getItemImageFromFirebase(path: String, imageName: String, imageView: UIImageView) {
        let itemsImagesRef = storage.reference(withPath: path)
        let image = itemsImagesRef.child("\(imageName).png")
        let placeholderImage = UIImage(named: "placeholder.png")
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        imageView.sd_setImage(with: image, placeholderImage: placeholderImage)
    }

    // MARK: - Non-generic
     func getGlazesBrand(for glaze: String, completion: @escaping ([String]) -> Void) {
        if let path = Bundle.main.path(forResource: glazesListJSON, ofType: "json") {
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

    // MARK: - For future use
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
