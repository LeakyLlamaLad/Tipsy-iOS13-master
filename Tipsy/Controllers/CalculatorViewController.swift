//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPcnButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLable: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var billSplit = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        billTextField.resignFirstResponder()
    
        //Deselect all tip buttons
        zeroPctButton.isSelected = false
        tenPcnButton.isSelected = false
        twentyPctButton.isSelected = false
        
        //Select the pressed tip button
        sender.isSelected = true
        
        //Set var tip to value of selected tip button
        //dropLast() removes the percent sign from the button lable
        let tipButtonValue = sender.currentTitle!.dropLast()
        tip = Double(tipButtonValue)! / 100
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        billTextField.resignFirstResponder()
        
        splitNumberLable.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: Any) {
        
        let bill = billTextField.text!
    
        if bill != "" {
            billTotal = Double(bill)!
            let splitAmount = billTotal * (1 + tip) / Double(numberOfPeople)
            let formatedSplitAmount = String(format: "%.02f", splitAmount)
            billSplit = formatedSplitAmount
        }
        
        performSegue(withIdentifier: "goToResults", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.totalValue = billSplit
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPeople
        }
    }
    
    /*
    @IBAction func calculatePressed(_ sender: UIButton) {
        let height = heightSlider.value
        let weight = weightSlider.value
        
        calculatorBrain.calculateBMI(height: height, weight: weight)

        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiValue = calculatorBrain.getBMIValue()
            destinationVC.advice = calculatorBrain.getAdvice()
            destinationVC.color = calculatorBrain.getColor()
        }
    }
 */
    
}

