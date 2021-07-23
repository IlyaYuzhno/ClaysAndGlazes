//
//  GlazesListPresenter.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 22.07.2021.
//

import UIKit

extension ChooseGlazeTableViewController {
     func getData() {
        interactor.getGlazesList() { [weak self] response in
            let labCeramica = response.filter { $0.brand == "Lab Ceramica" }.map { $0.glaze }
            let labCeramicaInfo = response.filter { $0.brand == "Lab Ceramica" }.map { $0.info}
            let prodesco = response.filter { $0.brand == "Prodesco" }.map { $0.glaze }
            let prodescoInfo = response.filter { $0.brand == "Prodesco" }.map { $0.info}
            let amaco = response.filter { $0.brand == "Amaco" }.map { $0.glaze }
            let amacoInfo = response.filter { $0.brand == "Amaco" }.map { $0.info}
            let terracolor = response.filter { $0.brand == "Terracolor" }.map { $0.glaze }
            let terracolorInfo = response.filter { $0.brand == "Terracolor" }.map { $0.info}
            let mayco = response.filter { $0.brand == "Mayco" }.map { $0.glaze }
            let maycoInfo = response.filter { $0.brand == "Mayco" }.map { $0.info}
            let botz = response.filter { $0.brand == "Botz" }.map { $0.glaze }
            let botzInfo = response.filter { $0.brand == "Botz" }.map { $0.info}
            let spectrum = response.filter { $0.brand == "Spectrum" }.map { $0.glaze }
            let spectrumInfo = response.filter { $0.brand == "Spectrum" }.map { $0.info}

            let subList = labCeramica + prodesco + amaco
            let subListTwo = terracolor + mayco + botz

            self?.glazeList = subList + subListTwo + spectrum
            self?.glazeInfo = response.map { $0.info}
            self?.glazeInfoDictionary = Dictionary(uniqueKeysWithValues: zip(self?.glazeList ?? [""], self?.glazeInfo ?? [""]))

            self?.filteredGlazeList = self?.glazeList ?? [""]

            // Add new section here
            self?.sections = [
                Section(name: "Lab Ceramica", items: labCeramica, info: labCeramicaInfo),
                Section(name: "Prodesco", items: prodesco, info: prodescoInfo),
                Section(name: "Amaco", items: amaco, info: amacoInfo),
                Section(name: "Terracolor", items: terracolor, info: terracolorInfo),
                Section(name: "Mayco", items: mayco, info: maycoInfo),
                Section(name: "BOTZ", items: botz, info: botzInfo),
                Section(name: "Spectrum", items: spectrum, info: spectrumInfo),
            ]
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
