//
//  DateButton.swift
//  SwiftUITaskAppV2
//
//  Created by Paul Franco on 3/21/21.
//

import SwiftUI

struct DateButton: View {
    // MARK: - PROPERTIES
    var title: String
    @ObservedObject var homeData: HomeViewModel
    
    // MARK: - BODY
    var body: some View {
        Button(action: { homeData.updateDate(value: title) }, label: {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(homeData.checkDate() == title ? .white : .gray)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(
                    homeData.checkDate() == title ?
                        LinearGradient(gradient: .init(colors: [Color("Orange"), Color("Red")]), startPoint: .leading, endPoint: .trailing)
                    :
                        LinearGradient(gradient: .init(colors: [Color.white]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(6)
        })
    }
}


// MARK: - PREVIEW
