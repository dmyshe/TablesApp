//
//  TextFieldCell.swift
//  TablesApp
//
//  Created by Дмитро  on 21/04/22.
//

import Cocoa

class TextFieldCell: NSTableCellView {
 
    @IBOutlet  weak var label: NSTextField!
    
   
    
    func configure(with string: String) {
        label.stringValue = string
    }
}
