//
//  DateButton.swift
//  SwiftUITaskAppV2
//
//  Created by Paul Franco on 3/21/21.
//

import SwiftUI

//struct DateButton: View {
//    // MARK: - PROPERTIES
//    var title: String
//    @ObservedObject var homeData: HomeViewModel
//
//    // MARK: - BODY
//    var body: some View {
//        Button(action: { homeData.updateDate(value: title) }, label: {
//            Text(title)
//                .fontWeight(.bold)
//        })
//        .buttonStyle(GradientButtonStyle(isSelected: homeData.isDateEqual() == title))
//    }
//}


// MARK: VIEW MODIFIER
struct GradientBackground: ViewModifier {
    let isSelected: Bool
    let selected = LinearGradient(gradient: .init(colors: [Color("Orange"), Color("Red")]), startPoint: .leading, endPoint: .trailing)
    let unSelected = LinearGradient(gradient: .init(colors: [Color.white]), startPoint: .leading, endPoint: .trailing)
    func body(content: Content) -> some View {
        content.background(isSelected ? selected : unSelected)
    }
}

struct GradientButtonStyle: ButtonStyle {
    
    let isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fixedSize()
            .foregroundColor(isSelected ? .white : .gray)
            .frame(maxWidth: .infinity)
            .padding()
            .modifier(GradientBackground(isSelected: isSelected))
            .cornerRadius(6)
            .shadow(radius: configuration.isPressed ? 5 : 10 )
    }
}


// MARK: - PREVIEW
//struct DateButton_Previews: PreviewProvider {
//    static var previews: some View {
//        DateButton(title: "Today", homeData: HomeViewModel())
//            .padding()
//    }
//}
