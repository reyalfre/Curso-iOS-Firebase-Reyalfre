//
//  VistaGastos.swift
//  Curso iOS Firebase Reyalfre
//
//  Created by Equipo 8 on 2/3/26.
//

import FirebaseAuth
import SwiftUI

struct VistaGastos: View {
    var authManager: AuthManager

    @State private var viewModel: GastosViewModel
    @State private var mostrarAnadir = false

    init(authManager: AuthManager) {
        self.authManager = authManager
        let idUsuario = authManager.user?.uid ?? ""
        _viewModel = State(
            initialValue: GastosViewModel(idUsuario: idUsuario)
        )
    }

    var body: some View {
        NavigationStack {
            List {
                Section("Resumen") {
                    HStack {
                        Text("Total gastado")
                        Spacer()
                        Text(
                            viewModel.importeTotal,
                            format: .currency(code: "EUR")
                        )
                        .bold()
                        .font(.title3)
                    }
                }
                Section("Movimientos") {
                    ForEach(viewModel.gastos) {
                        gasto in
                        HStack {

                            if let categoria = viewModel.obtenerCategoria(
                                id: gasto.idCategoria
                            ) {
                                VStack {
                                    Image(systemName: categoria.icono)
                                        .foregroundStyle(
                                            Color.fromString(
                                                categoria.nombreColor
                                            )
                                        )
                                        .font(.title2)
                                        .clipShape(Circle())
                                    Text(categoria.nombre)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            } else {
                                VStack {
                                    Image(systemName: "questionmark.circle")
                                    Text("Sin categoria")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }

                            VStack(alignment: .leading) {
                                Text(gasto.titulo)
                                    .font(.headline)
                                Text(gasto.fecha, style: .date)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }

                            Spacer()

                            Text(gasto.importe, format: .currency(code: "EUR"))
                                .bold()
                                .foregroundStyle(
                                    (gasto.importe >= 0)
                                        ? Color.red : Color.green
                                )
                        }
                    }
                    .onDelete(perform: viewModel.borrarGasto)
                }
            }
            .navigationTitle("Mis gastos")
            .toolbar {

                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        //  mostrarAnadir.toggle()
                        authManager.logout()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundStyle(.red)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        mostrarAnadir.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $mostrarAnadir) {
                VistaAnadirGasto(viewModel: viewModel)
            }
        }
    }
}
/*
 #Preview {
 let gasto = Gasto(
 titulo: "Pan",
 importe: 2.15,
 fecha: Date(),
 idUsuario: "98fj928rdf"
 )
 VistaGastos(idUsuario: "98fj928rdf")
 }
 */
