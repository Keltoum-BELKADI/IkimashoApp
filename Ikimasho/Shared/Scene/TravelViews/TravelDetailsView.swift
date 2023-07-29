//
//  EmployeeDetailsView.swift
//  CD_One_To_Many_Relationship
//
//  Created by Kel_Jellysh on 28/07/2023.
//

import SwiftUI

struct TravelDetailsView: View {
    @ObservedObject  var travel: Travel
    @State var editView = false
    var body: some View {
            List {
                Section {
                    if (travel.townImageData != nil){
                        Image(uiImage: UIImage(data: travel.townImageData!)!)
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .frame(width: 250, height: 250, alignment: .center)
                            .padding(.leading, 35)
                    }
                } header: {
                    Text("Photo")
                } .listRowBackground(Color.clear)
                    .headerProminence(.increased)
                Section {
                    Text("Date: " + (travel.date ?? ""))
                    Text("Ville de départ: " + (travel.startTown ?? ""))
                    Text("Ville de départ: " + (travel.destinationTown ?? ""))
                    Text("Vol et heure: " + (travel.flight ?? ""))
                    Text("Train et heure: " + (travel.train ?? ""))
                    Text("Hotel et adresse: " + (travel.hotel ?? ""))
                        .lineLimit(10)
                    Text("Heure du check-in: " + (travel.checkin ?? ""))
                    Text("Heure du check-out: " + (travel.checkout ?? ""))
                    Text("Durée du séjour: " + (travel.time ?? ""))
                } header: {
                    Text("Informations sur le trajet.")
                }footer: {
                    Text("Ne pas oublier les bagages, de les peser et de se présenter en avance train ou avion.")
                        .lineLimit(2)
                }
                .headerProminence(.increased)
                
                Section {
                    Text("Note: " + (travel.note ?? ""))
                } header: {
                    Text("Informations relatives au séjour")
                } footer: {
                    Text("On retrouve toutes les activités a faire avec les informations sur les transports et où trouver les billets pour les attractions.")
                        .lineLimit(3)
                }
                .headerProminence(.increased)
                .navigationTitle(travel.destinationTown ?? "" )
            } .sheet(isPresented: $editView){
                TravelEditView(travel: travel)
                    .environment(\.locale, Locale(identifier: "fr"))
                    .background(Image("Background").resizable().ignoresSafeArea().opacity(0.4))
                    .scrollContentBackground(.hidden)
            }.toolbar {
                ToolbarItemGroup(placement:.navigationBarTrailing){
                    Button(action: {
                        editView.toggle()
                    }, label: {
                        Label("Modifier des informtions",systemImage: "square.and.pencil")
                            .foregroundColor(.black)
                    })
                }
            }
        }
}
