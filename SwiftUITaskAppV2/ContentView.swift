//
//  ContentView.swift
//  SwiftUITaskAppV2
//
//  Created by Paul Franco on 3/21/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    // MARK: - BODY
    var body: some View {
        Home()
        
    }

    
}


// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
