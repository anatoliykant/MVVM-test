//
//  TableViewController.swift
//  MVVM Test
//
//  Created by kant on 10.08.17.
//  Copyright © 2017 kant. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
  
  var viewModel: showCityPopulateViewModelProtocol! {
    didSet {
      self.viewModel.citiesDidChange = { model in
        citiesModel = model.cities!
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = ShowCityPopulateViewModel(cities: citiesModel)
    showActivityIndicatory(uiView: self.view)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.sortCities()
    tableView.reloadData()
  }
  
  @IBAction func editingRowsPressed(_ sender: UIBarButtonItem) {
    self.isEditing = !self.isEditing
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var count = 0
    if let countOfCitites = viewModel.cities?.count {
      count = countOfCitites
    }
    return count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
    if let cities = viewModel.cities {
      cell.cityLabel.text     = cities[indexPath.row].nameOfCity
      cell.populateLabel.text = String(cities[indexPath.row].population)
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      // Delete the row from the data source
      viewModel.deleteCity(index: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let addCityVC = segue.destination as? AddCityViewController else { return }
    addCityVC.viewModel = self.viewModel
    self.isEditing = false
  }
  
  func showActivityIndicatory(uiView: UIView) {
    let container: UIView = UIView(frame: CGRect(x: 0, y: -64,
                                                 width: UIScreen.main.bounds.width,
                                                 height: UIScreen.main.bounds.height))
    container.backgroundColor = .white
    
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    actInd.activityIndicatorViewStyle = .gray
    actInd.center = CGPoint(x: container.frame.size.width / 2,
                            y: container.frame.size.height / 2)
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
    label.text = "Идет загрузка..."
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.center = CGPoint(x: container.frame.size.width / 2,
                           y: container.frame.size.height / 2 + 30)
    
    container.addSubview(actInd)
    container.addSubview(label)
    self.tableView.addSubview(container)
    actInd.startAnimating()
    
    Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
      
      UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
        container.alpha = 0
      }, completion: { (complet) in
        actInd.stopAnimating()
        container.isHidden = true
      })
    }
  }
}
