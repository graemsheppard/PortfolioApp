//
//  AddView.swift
//  MyPort
//
//  Created by Graem Sheppard on 2021-02-18.
//

import Foundation
import SwiftUI

struct AddView: View {
    let success: () -> Void
    init (success: @escaping () -> Void) {
        self.success = success
    }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>


    @StateObject var viewModel: ViewModel = ViewModel()
    var body: some View {
            Form {
                Section {
                    HStack {
                        Text("Symbol: ")
                        TextField("AAPL", text: $viewModel.symbol)
                            .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                            .disableAutocorrection(true)
                            
                    }
                    HStack {
                        Text("Quantity: ")
                        TextField("Enter a number", text: $viewModel.quantity)
                            .disableAutocorrection(true)
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("Price: ")
                        TextField("Average price per share", text: $viewModel.purchasePrice)
                    }
                    HStack {
                        Text("Date: ")
                        DatePicker.init("", selection: $viewModel.date, in: ...Date(), displayedComponents: [.date])
                            .labelsHidden()
                        
                    }
                }
                Section {
                    Button(action: {
                        if (viewModel.isValid()) {
                            viewModel.submit(completion: {
                                success()
                                self.presentationMode.wrappedValue.dismiss()
                            })
                            
                        }
                        
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Submit")
                                .foregroundColor(.blue)
                                .bold()
                            Spacer()
                        }
                    })
                }
            }.navigationTitle("Add Lot")
    }
}
