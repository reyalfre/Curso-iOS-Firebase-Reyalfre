//
//  GastosViewModel.swift
//  Curso iOS Firebase Reyalfre
//
//  Created by Equipo 8 on 2/3/26.
//

import FirebaseFirestore
import Foundation
import Observation

enum ConstantesFirestore {
    static let coleccionGastos = "gastos"
}

// TODO: temporal
protocol GastosViewModelProtocol: Observable {
    var gastos: [Gasto] { get set }
    func escucharDatos()
    func anadirGasto(titulo: String, importe: Double)
}

@Observable
class GastosViewModel: GastosViewModelProtocol {
    var gastos: [Gasto] = []

    private var db = Firestore.firestore()
    private var idUsuario: String

    init(idUsuario: String) {
        self.idUsuario = idUsuario
        escucharDatos()
    }
    func escucharDatos() {
        //Consulta a "gastos" en Firestore, usando el idUsuario
        db.collection(ConstantesFirestore.coleccionGastos)
            .whereField(
                Gasto.CodingKeys.idUsuario.rawValue,
                isEqualTo: idUsuario
            )
            .order(by: Gasto.CodingKeys.fecha.rawValue, descending: true)
            .addSnapshotListener {
                snapshot,
                error in
                guard let documents = snapshot?.documents else {
                    print(
                        "Error al leer los documentos: \(error?.localizedDescription ?? "No hay documentos")"
                    )
                    return
                }
                self.gastos = documents.compactMap({
                    doc -> Gasto? in
                    try? doc.data(as: Gasto.self)
                })
            }

    }
    func anadirGasto(titulo: String, importe: Double) {
        let nuevoGasto = Gasto(
            titulo: titulo,
            importe: importe,
            fecha: Date(),
            idUsuario: idUsuario
        )
        do {
            try db.collection(ConstantesFirestore.coleccionGastos).addDocument(
                from: nuevoGasto
            )
        } catch {
            print("Error guardando: \(error)")
        }
    }
}
