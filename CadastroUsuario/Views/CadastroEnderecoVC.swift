//
//  CadastroEndereco.swift
//  CadastroUsuario
//
//  Created by Rafael Jose on 28/09/20.
//

import UIKit

protocol CadastrEnderecoVCProtocol: class {
    func successRegisterAddress(address: Endereco)
}

class CadastroEnderecoVC: UIViewController {

    @IBOutlet weak var txtRua: UITextField!
    @IBOutlet weak var txtNumero: UITextField!
    @IBOutlet weak var txtBairro: UITextField!
    @IBOutlet weak var txtCidade: UITextField!
    @IBOutlet weak var txtEstado: UITextField!
    
    // usado quando se tem um protocolo
    weak var delegate: CadastrEnderecoVCProtocol?
    
    fileprivate func configTestFields() {
        
        self.txtRua.delegate = self
        self.txtNumero.delegate = self
        self.txtBairro.delegate = self
        self.txtCidade.delegate = self
        self.txtEstado.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func clicouCadastrarEndereco(_ sender: UIButton) {
        if  self.txtRua.text?.isEmpty == true || txtNumero.text?.isEmpty == true || self.txtBairro.text?.isEmpty == true ||
                txtCidade.text?.isEmpty == true || self.txtEstado.text?.isEmpty == true {
            
        } else {
            
            var endereco: Endereco = Endereco(rua: self.txtRua.text, complemento: txtNumero.text, bairro: txtBairro.text, cidade: txtCidade.text, estado: txtEstado.text)
            
            self.delegate?.successRegisterAddress(address: endereco)
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension CadastroEnderecoVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case self.txtRua:
            self.txtNumero.becomeFirstResponder()
        case self.txtNumero:
            self.txtBairro.becomeFirstResponder()
        case self.txtBairro:
            self.txtCidade.becomeFirstResponder()
        case self.txtCidade:
            self.txtEstado.becomeFirstResponder()
        default:
            self.txtEstado.resignFirstResponder()
        }
        
        return true
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        validateFields(textField: textField)
//    }
}
