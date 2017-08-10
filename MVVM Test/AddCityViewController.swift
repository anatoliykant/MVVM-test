//
//  AddCityViewController.swift
//  MVVM Test
//
//  Created by kant on 10.08.17.
//  Copyright © 2017 kant. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController {
  
  @IBOutlet weak var nameOfCityTextField: UITextField!
  @IBOutlet weak var сityPopulationTextField: UITextField!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var sendToServerLabel: UILabel!
  @IBOutlet weak var addCityButton: UIButton!
  
  var viewModel: showCityPopulateViewModelProtocol? {
    didSet {
      viewModel?.sortCities()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  func setup() {
    self.title = "Новый город"
    activityIndicator.isHidden = true
    sendToServerLabel.isHidden = true
    
    //кнопка "Отмена" слева на NavigationBar
    let new = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(back))
    self.navigationItem.leftBarButtonItem = new
  }
  
  func back() {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func addCityPressed(_ sender: UIButton) {
    if
      let name  = nameOfCityTextField.text,
      let pop   = сityPopulationTextField.text,
      name     != "",
      pop      != "",
      let viewM = self.viewModel
    {
      let city = City(nameOfCity: name, population: Int(pop)!)
      viewM.addCity(city: city)
      sendToServerAction()//Показать на 2 сек активити индикатор и вернуться на предыдущий VC
    } else {
      showAlertController()
    }
  }
  
  func sendToServerAction() {
    self.addCityButton.isHidden     = true
    self.sendToServerLabel.isHidden = false
    self.activityIndicator.isHidden = false
    self.activityIndicator.startAnimating()
    
    Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
      self.navigationController?.popViewController(animated: true)
    }
  }
  
  func showAlertController() {
    let alertC = UIAlertController(title: "Ошибка",
                                   message: "Все поля должны быть заполнены!",
                                   preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
    alertC.addAction(cancelAction)
    self.present(alertC, animated: true, completion: nil)
  }
}
