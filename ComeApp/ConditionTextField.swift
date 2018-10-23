//
//  ConditionTextField.swift
//  ComeApp
//
//  Created by kobi on 06/09/2017.
//  Copyright © 2017 Kobi Kanetti. All rights reserved.
//

import UIKit

class ConditionTextField: UITextField {

    
    enum Condition : Int {
        case good, bad, halfBroken, great, broken
        
        func stringVal() -> String{
            switch self {
            case .great: return "Great"
            case .good: return "Good"
            case .bad: return "Bad"
            case .halfBroken: return "Half Broken"
            case .broken: return "Broken"
         
            }
        }
    }

    
    var condition : Condition = .great{
        didSet{
            self.text = condition.stringVal()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
     func setup(){
        //super.setup()
        
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        self.inputView = pickerView
    }

    
}

extension ConditionTextField : UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let c = Condition(rawValue: row)
        return c?.stringVal()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard let c = Condition(rawValue: row) else{
            return
        }
        
        self.condition = c
        self.sendActions(for: .editingChanged)
        
    }
    
    
    
}


