//
//  VistaGastos.swift
//  Curso iOS Firebase Reyalfre
//
//  Created by Equipo 8 on 2/3/26.
//

import SwiftUI

// TODO: viewmodel temporal
@Observable
class GastosViewModelMock: GastosViewModelProtocol {
    var gastos: [Gasto] = []
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
    func anadirGasto(titulo: String, importe: Double) {
        let gasto = Gasto(
            titulo: titulo,
            importe: importe,
            fecha: Date(),
            idUsuario: idUsuario
        )
        gastos.append(gasto)
    }
}

struct VistaGastos: View {
    @State private var viewModel: any GastosViewModelProtocol
    @State private var mostrarAnadir = false

    init(idUsuario: String) {
        _viewModel = State(
//            initialValue: GastosViewModelMock(idUsuario: idUsuario)
            initialValue: GastosViewModel(idUsuario: idUsuario)
        )
    }

    var body: some View {
        NavigationStack {
            List(viewModel.gastos) {
                gasto in
                HStack {
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
                            (gasto.importe >= 0) ? Color.red : Color.green
                        )
                }
            }
            .navigationTitle("Mis gastos")
            .toolbar {
                Button {
                    mostrarAnadir.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $mostrarAnadir) {
                VistaAnadirGasto(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    let gasto = Gasto(
        titulo: "Pan",
        importe: 2.15,
        fecha: Date(),
        idUsuario: "98fj928rdf"
    )
    VistaGastos(idUsuario: "98fj928rdf")
}
