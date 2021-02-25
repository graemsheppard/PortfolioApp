//
//  LotsView.swift
//  MyPort
//
//  Created by Graem Sheppard on 2021-02-11.
//

import SwiftUI

struct LotsView: View {
    
    @StateObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink(
                    destination: AddView(success: self.viewModel.getLots),
                    label: {
                        Text("+ Add Lot")
                            .bold()
                    }
                ).padding()
            }
            List {
                ForEach(viewModel.lots) { lot in
                    HStack {
                        Text(lot.symbol)
                            .font(.headline)
                        Text(lot.name?.uppercased() ?? "N/A")
                            .font(.subheadline)
                            .lineLimit(1)
                        Spacer()
                        Text(String(format: "%.2f %%", lot.percentageChange))
                            .padding(5)
                            .background(lot.percentageChange > 0 ? Color.green : (lot.percentageChange < 0 ? Color.red : Color.secondary))
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                    }
                }.onDelete(perform: { indexSet in viewModel.delete(indexSet: indexSet) })
            }
            Spacer()
        }
        .navigationTitle("My Lots")
        .alert(isPresented: self.$viewModel.error) {
            Alert(title: Text("Item Not Deleted"), message: Text("Please try again"), dismissButton: .default(Text("OK")))
        }
        
    }
}
