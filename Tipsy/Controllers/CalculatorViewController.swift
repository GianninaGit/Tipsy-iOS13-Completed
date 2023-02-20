
import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tipsyBrain  = TipsyBrain()
    var tipSeleccionado = 10.0
    var cantidadDePersonas = 2
    var inputValue = 0.0
    var resultadoCalculado = 0.0
    
    @IBAction func tipChanged(_ sender: UIButton) {
        // desmarco todo para que solo se seleccione el sender
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        // variable local para editar input: convertirlo en doble y eliminar el %
        let tip1 = sender.titleLabel?.text!
        tipSeleccionado = Double(tip1!.dropLast())!
        // para que desaparezca el keyboard al seleccionar el tip
        billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        cantidadDePersonas = Int(sender.value)
        splitNumberLabel.text = String(cantidadDePersonas)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let decimalTip = tipsyBrain.decimalTip(tip: tipSeleccionado)
        
        // si el input viene con coma, tengo que convertirla en punto
        let textoInput = String(billTextField.text!)
        let textoConComaCambiadaPorPunto = tipsyBrain.checkComa(textoIngresado: textoInput)
        
        inputValue = Double(textoConComaCambiadaPorPunto) ?? 0.0
        
        resultadoCalculado = tipsyBrain.calcular(gasto: inputValue, tip: decimalTip, personas: Double(cantidadDePersonas))

        self.performSegue(withIdentifier: "goToHere", sender: self)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHere" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.resultadoValue = String(format: "%.2f", resultadoCalculado)
            destinationVC.numberOfPeople = String(cantidadDePersonas)
            destinationVC.tip = String(format: "%.0f", tipSeleccionado)
        }
    }
}
