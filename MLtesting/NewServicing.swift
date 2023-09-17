//
//  ContentView.swift
//  MLtesting
//
//  Created by Sneha Bista on 9/16/23.
//

import CoreML
import CoreData
import SwiftUI

struct NewServicing: View {
    @State private var lastServiceDate = Date.now
    @State private var installationDate = Date.now
    @State private var predictionDate = Date.now
    let dateFormatter = DateFormatter()
    
    @State private var type = ""
    @State private var manufacturer = ""
    @State private var floor = ""
    @State private var room = 0
    @State private var operationalTime = 0
    @State private var workOrders = 0
    @State private var repairs = 0
    
    @Environment(\.managedObjectContext) var context
    @Binding var showNewServicing : Bool
    
    var assets = [" ", "Fire alarm", "Elevator", "Plumbing System", "HVAC", "Electrical"]
    var manufacturers = [" ", "Manufacturer_1", "Manufacturer_2", "Manufacturer_3", "Manufacturer_4", "Manufacturer_5"]
    var floors = [" ", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    var body: some View {
        VStack {
            // asset type
            ZStack {
                List {
                    Picker("Select asset type", selection: $type) {
                        ForEach(assets, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    // manufacturer
                    Picker("Select manufacturer", selection: $manufacturer) {
                        ForEach(manufacturers, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    // floor
                    Picker(selection: $floor, label: Text("Select floor number")) {
                        ForEach(floors, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    // room
                    HStack {
                        Text("Enter room number")
                        TextField(" ", value: $room, format: .number)
                    }
                    // operational time
                    HStack {
                        Text("Enter operational time")
                        TextField(" ", value: $operationalTime, format: .number)
                    }
                    // work orders
                    HStack {
                        Text("Enter work orders")
                        TextField(" ", value: $workOrders, format: .number)
                    }
                    // repairs
                    HStack {
                        Text("Enter repairs")
                        TextField(" ", value: $repairs, format: .number)
                    }
                    
                    DatePicker(selection: $installationDate, displayedComponents: .date,  label: { Text("Enter Installation Date")
                        
                    })
                    
                    DatePicker(selection: $lastServiceDate, displayedComponents: .date,  label: { Text("Enter Last Service Date")
                        
                    })
                }
            }
            
            Button(action: {
                self.calculatePrediction()
                self.saveInformation(date : predictionDate)
                self.showNewServicing = false
                }) {
                Text("Add")
            }

            Spacer()
            
            Text(predictionDate, format: .dateTime.day().month().year())
                
        }
        .padding()
    }
    
    func saveInformation(date : Date) {
        let newAsset = Asset(context: context)
        newAsset.id = UUID()
        newAsset.assetType = type
        newAsset.newDate = date
        newAsset.oldDate = lastServiceDate
        newAsset.floor = Int32(floor)!
        newAsset.operationalTime = Int32(operationalTime)
        newAsset.repairs = Int32(repairs)
        newAsset.room = Int32(room)
        newAsset.workOrders = Int32(workOrders)
        newAsset.manufacturer = manufacturer
                
        do {
            try context.save()
                    
        } catch {
            print(error)
        }
    }
    
    
    func calculatePrediction() {
        do {
            let config = MLModelConfiguration()
            let model = try PredictDuration(configuration: config)
            

            
            dateFormatter.dateFormat = "MM/DD/YYYY"


            let prediction = try model.prediction(
                assetType: type, floor: Double(floor)!, room: Double(room), installationDate: dateFormatter.string(from: installationDate), manufacturer: manufacturer,  operationalTime: Double(operationalTime), workOrders: Double(workOrders), repairs: Double(repairs), lastServicedDate: dateFormatter.string(from: lastServiceDate)
            )
            
            var dateComponent = DateComponents()
            dateComponent.day = Int(prediction.timeDuration)
            predictionDate = Calendar.current.date(byAdding: dateComponent, to: lastServiceDate) ?? lastServiceDate
            
        } catch {
            
        }
    }
}

struct NewServicing_Previews: PreviewProvider {
    static var previews: some View {
        NewServicing(showNewServicing: .constant(true))
    }
}
