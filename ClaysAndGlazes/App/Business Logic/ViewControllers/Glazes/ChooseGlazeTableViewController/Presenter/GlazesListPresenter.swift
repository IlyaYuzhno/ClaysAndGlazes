//
//  GlazesListPresenter.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 22.07.2021.
//

import UIKit

final class ChooseGlazeTableViewPresenter: ClaysTableViewPresenterType {

    var storageService: ClaysGlazeLocalStorageService?
    let glazesBasicJSON = "GlazesInfo"

    init(storageService: ClaysGlazeLocalStorageService) {
        self.storageService = storageService
    }

    func present(completion: @escaping ([Section], [String], [String], [String], [String : String]) -> Void) {

        var sections: [Section] = []
        var glazesList: [String] = []
        var filteredGlazesList: [String] = []
        var glazesInfo: [String] = []
        var glazesInfoDictionary: [String : String] = [:]

        storageService?.getData(resource: glazesBasicJSON) { (response: [ClaysGlazeItem]) in
            let labCeramica = response.filter { $0.brand == "Lab Ceramica" }.map { $0.item }
            let labCeramicaInfo = response.filter { $0.brand == "Lab Ceramica" }.map { $0.info}
            let prodesco = response.filter { $0.brand == "Prodesco" }.map { $0.item }
            let prodescoInfo = response.filter { $0.brand == "Prodesco" }.map { $0.info}
            let amaco = response.filter { $0.brand == "Amaco" }.map { $0.item }
            let amacoInfo = response.filter { $0.brand == "Amaco" }.map { $0.info}
            let terracolor = response.filter { $0.brand == "Terracolor" }.map { $0.item }
            let terracolorInfo = response.filter { $0.brand == "Terracolor" }.map { $0.info}
            let mayco = response.filter { $0.brand == "Mayco" }.map { $0.item }
            let maycoInfo = response.filter { $0.brand == "Mayco" }.map { $0.info}
            let botz = response.filter { $0.brand == "Botz" }.map { $0.item }
            let botzInfo = response.filter { $0.brand == "Botz" }.map { $0.info}
            let spectrum = response.filter { $0.brand == "Spectrum" }.map { $0.item }
            let spectrumInfo = response.filter { $0.brand == "Spectrum" }.map { $0.info}

            let subList = labCeramica + prodesco + amaco
            let subListTwo = terracolor + mayco + botz

            glazesList = subList + subListTwo + spectrum
            glazesInfo = response.map { $0.info}
            glazesInfoDictionary = Dictionary(uniqueKeysWithValues: zip(glazesList , glazesInfo ))

            filteredGlazesList = glazesList

            sections = [
                Section(name: "Lab Ceramica", items: labCeramica, info: labCeramicaInfo),
                Section(name: "Prodesco", items: prodesco, info: prodescoInfo),
                Section(name: "Amaco", items: amaco, info: amacoInfo),
                Section(name: "Terracolor", items: terracolor, info: terracolorInfo),
                Section(name: "Mayco", items: mayco, info: maycoInfo),
                Section(name: "BOTZ", items: botz, info: botzInfo),
                Section(name: "Spectrum", items: spectrum, info: spectrumInfo),
            ]}
        completion(sections, glazesList, glazesInfo, filteredGlazesList, glazesInfoDictionary)
    }
}

