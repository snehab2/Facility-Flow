//
//  UpdateServicing.swift
//  MLtesting
//
//  Created by Sneha Bista on 9/16/23.
//

import CoreML
import CoreData
import SwiftUI

struct UpdateServicing: View {
    @Binding var showUpdateServicing : Bool
    @EnvironmentObject var prevDate: ServiceDate
    @State private var newServiceDate = Date.now
    @State private var predictionDate = Date.now

    @Environment(\.managedObjectContext) var context

    
    let dateFormatter = DateFormatter()
    
//    @ObservedObject var asset: Asset
//    init(id objectID: NSManagedObjectID, in context: NSManagedObjectContext) {
//        if let person = try? context.existingObject(with: objectID) as? Asset {
//            self.asset = asset
//        } else {
//            // if there is no object with that id, create new one
//            self.asset = Asset(context: context)
//            try? context.save()
//        }
//    }
    
    var body: some View {
        VStack {
            Text("Recent service date: \(self.prevDate.prevDate, format: .dateTime.day().month().year())")
            DatePicker(selection: $newServiceDate, displayedComponents: .date,  label: { Text("Enter Service Completion")
            })
            
            Button(action: {
                self.calculatePrediction()
                prevDate.prevDate = predictionDate
            }) {
                Text("Show new servicing date")
            }
            Text(predictionDate, format: .dateTime.day().month().year())

            Button(action: {
                //self.saveInformation(date : self.prevDate.prevDate)
                self.showUpdateServicing = false
                }) {
                Text("Save")
            }
            
        }
        .padding(.horizontal, 20.0)
        .environmentObject(prevDate)
    }
    
//    private func saveInformation(date : Date) {
//        asset.oldDate = date
//        asset.newDate = predictionDate
//        prevDate.prevDate = predictionDate
//
//
//        do {
//            try context.save()
//
//        } catch {
//            print(error)
//        }
//    }
    
   private func calculatePrediction() {
        do {
            let config = MLModelConfiguration()
            let model = try PredictDuration(configuration: config)
            
            dateFormatter.dateFormat = "MM/DD/YYYY"

            let prediction = try model.prediction(
                assetType: prevDate.type, floor: Double(prevDate.floor), room: Double(prevDate.room), installationDate: dateFormatter.string(from: prevDate.prevDate), manufacturer: prevDate.manufacturer,  operationalTime: Double(prevDate.operationalTime), workOrders: Double(prevDate.workOrders), repairs: Double(prevDate.repairs), lastServicedDate: dateFormatter.string(from: newServiceDate)
            )
            
            var dateComponent = DateComponents()
            dateComponent.day = Int(prediction.timeDuration)
            predictionDate = Calendar.current.date(byAdding: dateComponent, to: newServiceDate) ?? newServiceDate
            
        } catch {
            
        }
    }
}

struct UpdateServicing_Previews: PreviewProvider {
    static var previews: some View {
        UpdateServicing(showUpdateServicing: .constant(true))
            .environmentObject(ServiceDate())
    }
}
