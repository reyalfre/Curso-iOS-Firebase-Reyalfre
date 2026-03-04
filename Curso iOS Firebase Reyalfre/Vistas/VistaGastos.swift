//
//  VistaGastos.swift
//  Curso iOS Firebase Reyalfre
//
//  Created by Equipo 8 on 2/3/26.
//

import SwiftUI
import FirebaseAuth

// TODO: viewmodel temporal
@Observable
class GastosViewModelMock: GastosViewModelProtocol {
    var gastos: [Gasto] = []
    var importeTotal: Double = 15.0
    private var idUsuario: String

    init(idUsuario: String, gastos: [Gasto] = []) {
        self.idUsuario = idUsuario
        self.gastos = gastos

        let gasto = Gasto(
            titulo: "Pan",
            importe: 2.15,
            fecha: Date(),
            idUsuario: "98fj928rdf"
        )
        self.gastos.append(gasto)
    }
    func escucharDatos() {
        // En el mock se queda vacía
    }
    func anadirGasto(
        titulo: String,
        importe: Double,
        categoria: CategoriaGastos
    ) {
        let gasto = Gasto(
            titulo: titulo,
            importe: importe,
            fecha: Date(),
            categoria: categoria,
            idUsuario: idUsuario
        )
        gastos.append(gasto)
    }
    func borrarGasto(indices: IndexSet) {
    }
}

struct VistaGastos: View {
    var authManager: AuthManager

    @State private var viewModel: any GastosViewModelProtocol
    @State private var mostrarAnadir = false

    init(authManager: AuthManager) {
        self.authManager = authManager
        let idUsuario = authManager.user?.uid ?? ""
        _viewModel = State(
            //            initialValue: GastosViewModelMock(idUsuario: idUsuario)
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

                            Image(systemName: gasto.categoria.nombreIcono)
                                .font(.title2)
                                .frame(width: 40, height: 40)
                                .background(gasto.categoria.color.opacity(0.2))
                                .foregroundStyle(gasto.categoria.color)
                                .clipShape(Circle())
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
                ToolbarItem(placement: .topBarTrailing){
                    Button{
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
