//
//  HomePage.swift
//  MLtesting
//
//  Created by Sneha Bista on 9/16/23.
//

import CoreData
import SwiftUI

class ServiceDate: ObservableObject {
    @Published var prevDate = Date()
    @Published var uuid = UUID()
    @Published var type = ""
    @Published var manufacturer = ""
    @Published var floor = 0
    @Published var room = 0
    @Published var operationalTime = 0
    @Published var workOrders = 0
    @Published var repairs = 0
}

struct HomePage: View {
    @Environment(\.managedObjectContext) var context
    @State private var showNewServicing = false
    @State private var showUpdateServicing = false
    @EnvironmentObject var updateDate: ServiceDate
    @FetchRequest(
               entity: Asset.entity(), sortDescriptors: [ NSSortDescriptor(keyPath: \Asset.id, ascending: false) ])

    var manageAssets: FetchedResults<Asset>
    
//    @State var prevDate = ""
//
    @StateObject var prevDate = ServiceDate()
    var body: some View {
            VStack {
                HStack(alignment: .top) {
                    Text("Manage Servicing")
                        .font(.system(size: 20))
                        .fontWeight(.black)
                    Spacer()
                    Button(action: {
                        self.showNewServicing = true
                    }) {
                        Text("+")
                    }
                }
                .padding(.horizontal, 20.0)
                .frame(height: 200.0)
                Spacer()
                
                
                List {
                    ForEach(manageAssets, id: \.self) { asset in
                        //                    dateFormatter.dateFormat = "MM/DD/YYYY"
                        HStack {
//                            Text("\(asset.assetType ?? "Asset") at \(asset.newDate!, format: .dateTime.day().month().year())")
                            if !showUpdateServicing {
                                Text("\(prevDate.type) at \(convertToString(date: prevDate.prevDate))")
                            }
                            else {
                                Text("\(asset.assetType ?? "Asset") at \(asset.newDate!, format: .dateTime.day().month().year())")
                            }
                            Spacer()
                            Button(action: {
                                self.showUpdateServicing = true
                                self.prevDate.prevDate = asset.newDate!
                                self.prevDate.uuid = asset.id!
                                self.prevDate.type = asset.assetType!
                                self.prevDate.manufacturer = asset.manufacturer!
                                self.prevDate.floor = Int(asset.floor)
                                self.prevDate.room = Int(asset.room)
                                self.prevDate.operationalTime = Int(asset.operationalTime)
                                self.prevDate.workOrders = Int(asset.workOrders)
                                self.prevDate.repairs = Int(asset.repairs)
                            }) {
                                Text("Update servicing")
                            }
                        }
                        
                    }
                    
                }
                
                
            }
            .sheet(isPresented: $showNewServicing) {
                NewServicing(showNewServicing: $showNewServicing)
            }
            .sheet(isPresented: $showUpdateServicing) {
                UpdateServicing(showUpdateServicing: $showUpdateServicing)
            }
            .environmentObject(prevDate)
    }
}

func convertToString(date : Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter.string(from: date)
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
            .listStyle(.plain)
            .environmentObject(ServiceDate())
    }
}
