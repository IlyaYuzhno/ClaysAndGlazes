//
//  ClaysTableViewPresenter.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 30.07.2021.
//

import Foundation

final class ClaysTableViewPresenter: ClaysTableViewPresenterType {

    var storageService: ClaysGlazeLocalStorageService?

    init(storageService: ClaysGlazeLocalStorageService) {
        self.storageService = storageService
    }

    func present(completion: @escaping ([Section], [String], [String], [String], [String : String]) -> Void) {
        guard let storageService = storageService else { return }

        var sections: [Section] = []
        var claysList: [String] = []
        var filteredClaysList: [String] = []
        var claysInfo: [String] = []
        var claysInfoDictionary: [String : String] = [:]
        let claysBasicJSON = "ClaysInfo"

        storageService.getData(resource: claysBasicJSON) { (response: [ClaysGlazeItem]) in
            let witgert = response.filter { $0.brand == "Witgert" }.map { $0.item}
            let witgertInfo = response.filter { $0.brand == "Witgert" }.map { $0.info}
            let donbass = response.filter { $0.brand == "Donbass" }.map { $0.item}
            let donbassInfo = response.filter { $0.brand == "Donbass" }.map { $0.info}
            let lagunaClay = response.filter { $0.brand == "LagunaClay" }.map { $0.item}
            let lagunaClayInfo = response.filter { $0.brand == "LagunaClay" }.map { $0.info}
            let labCeramica = response.filter { $0.brand == "LabCeramica" }.map { $0.item}
            let labCeramicaInfo = response.filter { $0.brand == "LabCeramica" }.map { $0.info}
            let valentineClays = response.filter { $0.brand == "ValentineClays" }.map { $0.item}
            let valentineClaysInfo = response.filter { $0.brand == "ValentineClays" }.map { $0.info}
            let konakovsky = response.filter { $0.brand == "Konakovsky" }.map { $0.item}
            let konakovskyInfo = response.filter { $0.brand == "Konakovsky" }.map { $0.info}
            let spain = response.filter { $0.brand == "SiO2, Spain" }.map { $0.item}
            let spainInfo = response.filter { $0.brand == "SiO2, Spain" }.map { $0.info}
            let goerg = response.filter { $0.brand == "GOERG & SCHNEIDER" }.map { $0.item}
            let goergInfo = response.filter { $0.brand == "GOERG & SCHNEIDER" }.map { $0.info}
            let raoul = response.filter { $0.brand == "Raoult & Beck" }.map { $0.item}
            let raoulInfo = response.filter { $0.brand == "Raoult & Beck" }.map { $0.info}

            claysList = response.map { $0.item}
            claysInfo = response.map { $0.info}
            claysInfoDictionary = Dictionary(uniqueKeysWithValues: zip(claysList , claysInfo ))

             filteredClaysList = claysList

             sections = [
                Section(name: "Witgert", items: witgert, info: witgertInfo),
                Section(name: "Керамические массы Донбасса", items: donbass, info: donbassInfo),
                Section(name: "Laguna Clay", items: lagunaClay, info: lagunaClayInfo),
                Section(name: "Lab Ceramica", items: labCeramica, info: labCeramicaInfo),
                Section(name: "Valentine Clays", items: valentineClays, info: valentineClaysInfo),
                Section(name: "Конаковский шамот", items: konakovsky, info: konakovskyInfo),
                Section(name: "SiO2, Испания", items: spain, info: spainInfo),
                Section(name: "GOERG & SCHNEIDER", items: goerg, info: goergInfo),
                Section(name: "Raoult & Beck", items: raoul, info: raoulInfo)
            ]}

        completion(sections, claysList, claysInfo, filteredClaysList, claysInfoDictionary)
    }
}
