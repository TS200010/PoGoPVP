//
//  PoGoPVPApp.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 28/05/2022.
//

import SwiftUI


@main
struct PoGoApp: App {
    private let vm = CPoGoViewModel()
    var body: some Scene {
        WindowGroup {
            PoGoView( viewModel: vm )
        }
    }
}
