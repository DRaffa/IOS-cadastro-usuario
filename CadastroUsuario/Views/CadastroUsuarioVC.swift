//
//  CadastroUsuarioVC.swift
//  CadastroUsuario
//
//  Created by Rafael Jose on 30/09/20.
//

import UIKit

class CadastroUsuarioVC: UIViewController {

    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtCpf: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtDataNascimento: UITextField!
    @IBOutlet weak var txtEndereco: UITextField!
    @IBOutlet weak var txtNumero: UITextField!
    @IBOutlet weak var txtBairro: UITextField!
    @IBOutlet weak var txtCidade: UITextField!
    @IBOutlet weak var txtEstado: UITextField!
    
    @IBOutlet weak var btnBuscarEndereco: UIButton!
    @IBOutlet weak var btnCadastrar: UIButton!
    var isRegisterValid: Bool = false
    var usuario: Usuario?
    
    // MARK: View Layout
    
    fileprivate func configScreen() {
        // self.enderecoView.isHidden = true
        self.configHiddenEndereco(true)
        self.configTestFields()
        self.btnBuscarEndereco.layer.cornerRadius = 4
        self.btnCadastrar.layer.cornerRadius = 4
    }
    
    fileprivate func configHiddenEndereco(_ hidden: Bool) {
        self.txtEndereco.isHidden = hidden
        self.txtNumero.isHidden = hidden
        self.txtBairro.isHidden = hidden
        self.txtCidade.isHidden = hidden
        self.txtEstado.isHidden = hidden
    }
    
    fileprivate func configTestFields() {
        self.txtNome.delegate = self
        self.txtCpf.delegate = self
        self.txtEmail.delegate = self
        self.txtDataNascimento.delegate = self
        
       // self.txtEndereco.delegate = self
       // self.txtNumero.delegate = self
       // self.txtBairro.delegate = self
       // self.txtCidade.delegate = self
       // self.txtEstado.delegate = self
        
        self.txtEndereco.isUserInteractionEnabled = false
        self.txtNumero.isUserInteractionEnabled = false
        self.txtBairro.isUserInteractionEnabled = false
        self.txtCidade.isUserInteractionEnabled = false
        self.txtEstado.isUserInteractionEnabled = false
    }
    
    fileprivate func validateFields(textField:UITextField) {
        
        if let value = textField.text {
            
            if value.isEmpty {
                self.isRegisterValid = false
            } else {
                self.isRegisterValid = true
            }
        } else {
            self.isRegisterValid = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configScreen()
        self.configHiddenEndereco(false)
        self.configTestFields()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buscarEndereco(_ sender: UIButton) {
        
        if self.txtNome.text?.isEmpty == true || self.txtCpf.text?.isEmpty == true || self.txtEmail.text?.isEmpty == true || self.txtDataNascimento.text?.isEmpty == true {
            print("tem campo que precisa ser preeenchido")
        } else  {
            
            //Convertendo um valor para Numerico
            // let cpfInteiro: Int = Int(self.txtCpf.text ?? "0") ?? 0
            // let cpfInteiroNulo: Int? = Int(self.txtCpf.text ?? "0")
            
            self.usuario = Usuario(nome: self.txtNome.text, cpf: txtCpf.text, email: txtEmail.text, data: txtDataNascimento.text, endereco: nil)
            self.performSegue(withIdentifier: "Endereco", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Endereco" {
            let vc: CadastroEnderecoVC? = segue.destination as? CadastroEnderecoVC
            
            vc?.delegate = self
        } else {
            //Criar uma controller DetailVC
            
            //let vc: DetailVC? = segue.destination as DetailVC
        }
    }
    
}

extension CadastroUsuarioVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case self.txtNome:
            self.txtCpf.becomeFirstResponder()
        case self.txtCpf:
            self.txtEmail.becomeFirstResponder()
        case self.txtEmail:
            self.txtDataNascimento.becomeFirstResponder()
        default:
            self.txtDataNascimento.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validateFields(textField: textField)
    }
}


extension CadastroUsuarioVC: CadastrEnderecoVCProtocol {
    func successRegisterAddress(address: Endereco) {
        self.configHiddenEndereco(false)
        self.usuario?.endereco = address
        
        self.txtEndereco.text = usuario?.endereco?.rua
        self.txtNumero.text = usuario?.endereco?.complemento
        self.txtBairro.text = usuario?.endereco?.bairro
        self.txtCidade.text = usuario?.endereco?.cidade
        self.txtEstado.text = usuario?.endereco?.estado        
    }
}
