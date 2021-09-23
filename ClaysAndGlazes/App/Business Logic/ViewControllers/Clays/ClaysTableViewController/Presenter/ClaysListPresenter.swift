//
//  ClaysTableViewPresenter.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 30.07.2021.
//

import Foundation

final class ClaysTableViewPresenter: ClaysTableViewPresenterType {

    var interactor: ClaysGlazeLocalStorageService?

    init(interactor: ClaysGlazeLocalStorageService) {
        self.interactor = interactor
    }

    func present(completion: @escaping ([Section], [String], [String], [String], [String : String]) -> Void) {
        guard let interactor = interactor else { return }

        var sections: [Section] = []
        var claysList: [String] = []
        var filteredClaysList: [String] = []
        var claysInfo: [String] = []
        var claysInfoDictionary: [String : String] = [:]

        interactor.getClays() { response in
            let witgert = response.filter { $0.brand == "Witgert" }.map { $0.clay}
            let witgertInfo = response.filter { $0.brand == "Witgert" }.map { $0.info}
            let donbass = response.filter { $0.brand == "Donbass" }.map { $0.clay}
            let donbassInfo = response.filter { $0.brand == "Donbass" }.map { $0.info}
            let lagunaClay = response.filter { $0.brand == "LagunaClay" }.map { $0.clay}
            let lagunaClayInfo = response.filter { $0.brand == "LagunaClay" }.map { $0.info}
            let labCeramica = response.filter { $0.brand == "LabCeramica" }.map { $0.clay}
            let labCeramicaInfo = response.filter { $0.brand == "LabCeramica" }.map { $0.info}
            let valentineClays = response.filter { $0.brand == "ValentineClays" }.map { $0.clay}
            let valentineClaysInfo = response.filter { $0.brand == "ValentineClays" }.map { $0.info}
            let konakovsky = response.filter { $0.brand == "Konakovsky" }.map { $0.clay}
            let konakovskyInfo = response.filter { $0.brand == "Konakovsky" }.map { $0.info}
            let spain = response.filter { $0.brand == "SiO2, Spain" }.map { $0.clay}
            let spainInfo = response.filter { $0.brand == "SiO2, Spain" }.map { $0.info}
            let goerg = response.filter { $0.brand == "GOERG & SCHNEIDER" }.map { $0.clay}
            let goergInfo = response.filter { $0.brand == "GOERG & SCHNEIDER" }.map { $0.info}
            let raoul = response.filter { $0.brand == "Raoult & Beck" }.map { $0.clay}
            let raoulInfo = response.filter { $0.brand == "Raoult & Beck" }.map { $0.info}

            claysList = response.map { $0.clay}
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
