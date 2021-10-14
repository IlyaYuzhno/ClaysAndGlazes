//
//  SegerFormulaClaculator.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 14.10.2021.
//

protocol SegerFormulaCalculatorType: AnyObject {
    func calculate(formula: [String:Float])
    func showFormula() -> [String : [String: Float]]
}

class SegerFormulaCalculator: SegerFormulaCalculatorType {

    var calculatedFormula: [String : Float]?

    let alcaliList = ["Na2O", "K2O", "Li2O"]
    let aEarthList = ["CaO", "MgO", "SrO", "ZnO", "FeO", "CoO", "CuO", "NiO", "MnO"]
    let stabsList = ["Al2O3", "B2O3"]
    let gFormersList = ["SiO2", "TiO2", "ZrO2", "SnO2"]
    let gOtherList = ["Fe2O3", "MnO2"]

    func calculate(formula: [String : Float]) {
        calculatedFormula = formula
    }

    func showFormula() -> [String : [String: Float]] {
        var formulaFinal: [String : [String : Float]] = [:]
        var alcali = [String:Float]()
        var aEarth = [String:Float]()
        var stabs = [String:Float]()
        var gFormers = [String:Float]()
        var gOther = [String:Float]()

        guard let calculatedFormula = calculatedFormula else {
            return [:]
        }

        for key in calculatedFormula.keys {

            (0..<alcaliList.count).forEach { i in
                if key == alcaliList[i] {
                    let value = calculatedFormula[alcaliList[i]] ?? Float(0.0)
                    alcali[alcaliList[i]] = value
                }
            }

            (0..<aEarthList.count).forEach { i in
                if key == aEarthList[i] {
                    let value = calculatedFormula[aEarthList[i]] ?? Float(0.0)
                    aEarth[aEarthList[i]] = value
                }
            }

            (0..<stabsList.count).forEach { i in
                if key == stabsList[i] {
                    let value = calculatedFormula[stabsList[i]] ?? Float(0.0)
                    stabs[stabsList[i]] = value
                }
            }

            (0..<gFormersList.count).forEach { i in
                if key == gFormersList[i] {
                    let value = calculatedFormula[gFormersList[i]] ?? Float(0.0)
                    gFormers[gFormersList[i]] = value
                }
            }

            (0..<gOtherList.count).forEach { i in
                if key == gOtherList[i] {
                    let value = calculatedFormula[gOtherList[i]] ?? Float(0.0)
                    gOther[gOtherList[i]] = value
                }
            }
        }

        formulaFinal["alcali"] = alcali
        formulaFinal["aEarth"] = aEarth
        formulaFinal["stabs"] = stabs
        formulaFinal["gFormers"] = gFormers
        formulaFinal["gOther"] = gOther

        print(formulaFinal)


        return formulaFinal
    }

}

