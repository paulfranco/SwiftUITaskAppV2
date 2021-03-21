//
//  Home.swift
//  SwiftUITaskAppV2
//
//  Created by Paul Franco on 3/21/21.
//

import SwiftUI
import CoreData

struct Home: View {
    // MARK: - PROPERTIES
    @StateObject var homeData = HomeViewModel()
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)], animation: .spring()) var results : FetchedResults<Task>
    @Environment(\.managedObjectContext) var context
    
    // MARK: - BODY
    var body: some View {
        // Mark: - VSTACK
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
            // MARK: - VSTACK
            VStack(spacing: 0) {
                // MARK: - HSTACK
                HStack {
                    Text("Tasks")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Spacer()
                }//: HSTACK
                .padding()
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.white)
                
                if results.isEmpty {
                    
                    Spacer()
                    
                    Text("No Tasks!!!!")
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                    
                    Spacer()
                } else {
                    // MARK: - SCROLLVIEW
                    ScrollView(.vertical, showsIndicators: false, content: {
                        // MARK: - LAZYVSTACK
                        LazyVStack(alignment: .leading, spacing: 20){
                            // MARK: - FOREACH
                            ForEach(results) { task in
                                // MARK: - VSTACK
                                VStack(alignment: .leading, spacing: 5, content: {
                                    Text(task.content ?? "")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    Text(task.date ?? Date(), style: .date)
                                        .fontWeight(.bold)
                                })
                                .foregroundColor(.black)
                                .contextMenu {
                                    Button(action: { homeData.editItem(item: task) }, label: {
                                        Text("Edit")
                                    })
                                    
                                    Button(action: {
                                        context.delete(task)
                                        try! context.save()
                                    }, label: {
                                        Text("Delete")
                                    })
                                }
                            }//: FOREACH
                        }//: LAZYVSTACK
                        .padding()
                    })//: SCROLLVIEW
                    
                }
            }//: VSTACK
            Button(action: { homeData.isNewData.toggle() }, label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                        AngularGradient(gradient: .init(colors: [Color("Orange"),Color("Red")]), center: .center)
                    )
                    .clipShape(Circle())
            })
            .padding()
        }) //: ZSTASCK
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        .sheet(isPresented: $homeData.isNewData, content: {
            NewDataView(homeData: homeData)
        })
    }
}

// MARK: - PREVIEW
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
