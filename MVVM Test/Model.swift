//
//  Model.swift
//  MVVM Test
//
//  Created by kant on 10.08.17.
//  Copyright © 2017 kant. All rights reserved.
//

import Foundation

struct City {
  let nameOfCity: String
  let population: Int
}

var citiesModel: [City] = [
  City(nameOfCity: "Риверан", population: 2000000),
  City(nameOfCity: "Королевская гавань", population: 15000000),
  City(nameOfCity: "Утес Кастерли", population: 400000)]
