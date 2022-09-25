//
//  ContentView.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 28/05/2022.
//

//
// MARK: The VIEW
//       ========
//

import SwiftUI

struct PoGoView: View {
    
    @ObservedObject var viewModel: CPoGoViewModel
    
    var body: some View {
                VStack{
                    Spacer()
                    Text("You are being attacked...\nHow dangerous is this?")
                    Spacer()
                    Circle()
//                        .fill().foregroundColor(Color.ui.Normal)
                        .fill().foregroundColor(Color("Normal"))
                        .frame(width: 100.0, height: 100.0 )
                        .position(x:250, y: 150)
                        .onTapGesture{
                            viewModel.chooseNormal()
                        }
                    Circle()
                        .fill().foregroundColor(Color.ui.Fire)
                        .frame(width: 200, height: 200)
                        .position(x:150, y: 100)
                }
            .background( Image("PoGoBk"))
//            .blur(radius:10)


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CPoGoViewModel()
        PoGoView( viewModel: viewModel )
    }
}
