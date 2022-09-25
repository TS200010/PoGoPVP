//
//  PoGoModel.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 13/08/2022.
//

import Foundation

//
// MARK: The VIEWMODEL
//       =============
//
// When a VIEWMOEL instance is created this in turn creates the MODEL itself
//
class CPoGoViewModel: ObservableObject {
    
     static func CreatePoGoModel() -> PoGoModel {
         print("********** CreatePoGoModel")
         var p = PoGoModel( )
         if !p.initialisePoGoModel(){
             // TODO: this a bit more nicely!
             print("********** Model was not created correctly")
         }
         print("********** Model created")
         return p
    }
    
    @Published private var poGoModel = CreatePoGoModel()
    
// MARK: Functions EXPRESSING Model features here. The VIEW calls these to get Model data
    
    
// MARK: INTENTS here. The VIEW calls these in reaction to user input.
    func chooseNormal() {
        print("Normal")
    }
    
}

