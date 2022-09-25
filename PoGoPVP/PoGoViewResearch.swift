//
//  PoGoView.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 11/08/2022.
//

import Foundation

// Save this remember how to create a view on the learnable

protocol KnowledgeItemxxx: Codable, Hashable {
    var id: ID { get set }
    var question: String { get }
    var correctAnswer: String { get }
    func showYourself()->Void   // This function shows the item of knowledge in the view passed
    // Can I put all the plumbing in here for showing a question and getting an answer?
    // https://stackoverflow.com/questions/62895948/how-to-return-a-view-type-from-a-function-in-swift-ui
    /*@ViewBuilder*/ func getView(view: String) -> /*some View*/Int
    
    // Do we also need to take account of model changes that update the view in this protocol?
    // https://www.hackingwithswift.com/quick-start/swiftui/whats-the-difference-between-observedobject-state-and-environmentobject
    
}

// How to create a custom View
//     https://developer.apple.com/documentation/swiftui/view
// Tutorial on Views from Apple
//     https://developer.apple.com/tutorials/swiftui/creating-and-combining-views

// TODO What is this for
// =====================
/*
extension @ViewBuilder func getView( view: String ) -> some View {
    switch view {
    case "CreateUser":
        Text(view)
    case "Abc":
        Image("Abc")
    default:
        EmptyView()
    }
}
*/
