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
        VStack {
            Form {
                Section {
                    HStack {
                        Text("Symbol: ")
                        TextField("AAPL", text: $viewModel.symbol.toNonOptional())
                            .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                            .disableAutocorrection(true)
                            
                    }
                    HStack {
                        Text("Quantity: ")
                        TextField("Enter a number", text: $viewModel.quantity.toNonOptional())
                            .disableAutocorrection(true)
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("Price: ")
                        TextField("Average price per share", text: $viewModel.purchasePrice.toNonOptional())
                    }
                    HStack {
                        Text("Date: ")
                        DatePicker.init("", selection: $viewModel.date, in: ...Date(), displayedComponents: [.date])
                            .labelsHidden()
                        
                    }
                }
                Section {
                    Button(action: {
                            viewModel.submit(completion: {
                                self.success()
                                self.presentationMode.wrappedValue.dismiss()
                            })
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Submit")
                                .foregroundColor(.blue)
                                .bold()
                            Spacer()
                        }
                        
                    })
                }
            }
        }
        .navigationTitle("Add Lot")
        .alert(isPresented: self.$viewModel.error) {
            Alert(title: Text("Item Not Added"), message: Text("Please fill out all fields"), dismissButton: .default(Text("OK")))
        }
    }
}

extension Binding where Value == String? {
    func toNonOptional() -> Binding<String> {
        return Binding<String>(
            get: {
                return self.wrappedValue ?? ""
            },
            set: {
                self.wrappedValue = $0
            }
        )
    }
}
