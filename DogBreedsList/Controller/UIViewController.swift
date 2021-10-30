//
//  UIViewController.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import UIKit

extension UIViewController {
    func saveUserDefaults(nome: String) {
        let defaults = UserDefaults.standard
        var favsDogs = self.getUserDefaults()
        if !favsDogs.contains(nome) {
            favsDogs.append(nome)
            defaults.set(favsDogs, forKey: "dogs")
        }
        self.getUserDefaults()
    }
    
    func getUserDefaults() -> [String] {
        let defaults = UserDefaults.standard
        guard let arrayString = defaults.object(forKey: "dogs") as? [String] else {
            return []}
            print(arrayString)
            return arrayString
    }
}
