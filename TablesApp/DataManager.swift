//
//  SpreadSheetViewModel.swift
//  TablesApp
//
//  Created by Дмитро  on 22/04/22.
//

import Foundation

protocol SpreadSheetViewModelDelegate: AnyObject {
    func reloadData()
}

class TableDataManager {
        
    weak var delegate: SpreadSheetViewModelDelegate?
    
    var intArray = [[0,0,0]]

    var numbersOfRows: Int {
        intArray[0].count
    }
    
    func numberOfElementsInSubArray(at index: Int) -> Int {
        intArray[index].count - 1
    }
    
    func calculateTotalNumber() {
        var sumNumber = 0
        for i in intArray.indices {
            sumNumber += intArray[i].last!
        }
        print("Total number is \(sumNumber)")
    }

    func checkIfNumberOfElementsGreater( than row: Int, at index: Int ) -> Int {
        let numberOfElements = numberOfElementsInSubArray(at: index)
        let standartCell = intArray[index][row]
        let sumCell = sumNumbersInSubArray(at: index)

        return row < numberOfElements ? standartCell : sumCell
    }

    func addPenultimateRows() {
        for i in intArray.indices {
            let int = intArray[i].count == 1 ? 2 :  1
            let penultimateIndex  = intArray[i].count - int
            intArray[i].insert(0, at: penultimateIndex)
        }
        delegate?.reloadData()
    }
    
    func removePenultimateRows() {
        for i in intArray.indices {
            let int = intArray[i].count == 2 ? 1 : 2
            let penultimateIndex = intArray[i].count - int
            intArray[i].remove(at: penultimateIndex)
        }
        delegate?.reloadData()
    }
    
    func addNewColumn() {
        let newArray = Array(repeating: 0, count: numbersOfRows)
        intArray.append(newArray)
        delegate?.reloadData()
    }
    
    func removeLastColumn() {
        let lastIndex = intArray.count - 1
        intArray.remove(at: lastIndex)
        delegate?.reloadData()
    }
    
    private func sumNumbersInSubArray(at index: Int) -> Int {
         let lastIndex = numberOfElementsInSubArray(at: index)

         intArray[index][lastIndex] = 0
  
         let sum = intArray[index].reduce(0) { $0 + $1 }
         intArray[index][lastIndex] = sum

         return sum
     }
    
}
