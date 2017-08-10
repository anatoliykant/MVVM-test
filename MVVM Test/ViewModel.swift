//
//  ViewModel.swift
//  MVVM Test
//
//  Created by kant on 10.08.17.
//  Copyright © 2017 kant. All rights reserved.
//

import Foundation

protocol showCityPopulateViewModelProtocol: class {
  var cities: [City]? { get set }
  var citiesDidChange: ((showCityPopulateViewModelProtocol) -> ())? { get set }
  
  init(cities: [City])
  func addCity(city: City)
  func deleteCity(index: Int)
  func sortCities()
}

class ShowCityPopulateViewModel: showCityPopulateViewModelProtocol {
  
  var cities: [City]? {
    didSet {
      self.citiesDidChange?(self)
    }
  }
  
  var citiesDidChange: ((showCityPopulateViewModelProtocol) -> ())?
  
  required init(cities: [City]) {
    self.cities = cities
  }
  
  func addCity(city: City) {
    cities?.append(city)
  }
  
  func deleteCity(index: Int) {
    cities?.remove(at: index)
  }
  
  func sortCities() {
    self.cities = self.cities?.sorted(by: { $0.population > $1.population })
  }
}
