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
    static let coleccionCategorias = "categorias"
}

@Observable
class GastosViewModel {
    var gastos: [Gasto] = []
    var categorias: [Categoria] = []
    var importeTotal: Double = 0.0

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
                self.gastos = documents.compactMap {
                    doc -> Gasto? in
                    try? doc.data(as: Gasto.self)
                }
                // $0 contiene el acumulado hasta el momento, $1. importe el importe de un gasto
                self.importeTotal = self.gastos.reduce(0) { $0 + $1.importe }
            }
        //Consulta a "gastos" en Firestore, usando el idUsuario
        db.collection(ConstantesFirestore.coleccionCategorias)
            .whereField(
                Gasto.CodingKeys.idUsuario.rawValue,
                isEqualTo: idUsuario
            )
            .addSnapshotListener {
                snapshot,
                error in
                guard let documents = snapshot?.documents else {
                    print(
                        "Error al leer los documentos: \(error?.localizedDescription ?? "No hay documentos")"
                    )
                    return
                }
                self.categorias = documents.compactMap {
                    doc -> Categoria? in try? doc.data(as: Categoria.self)
                }
            }

    }
    func anadirGasto(
        titulo: String,
        importe: Double,
        //categoria: CategoriaGastos,
        idCategoria: String
    ) {
        let nuevoGasto = Gasto(
            titulo: titulo,
            importe: importe,
            fecha: Date(),
            idCategoria: idCategoria,
            idUsuario: idUsuario,
        )
        do {
            try db.collection(ConstantesFirestore.coleccionGastos).addDocument(
                from: nuevoGasto
            )
        } catch {
            print("Error guardando: \(error)")
        }
    }
    func borrarGasto(indices: IndexSet) {
        indices.forEach {
            indice in
            let gasto = gastos[indice]

            guard let idGasto = gasto.id else { return }

            db.collection(ConstantesFirestore.coleccionGastos).document(idGasto)
                .delete {
                    error in
                    if let error {
                        print("Error al borrar: \(error.localizedDescription)")
                    }
                }
        }
    }
    func anadirCategoria(nombre: String, icono: String, color: String) {
        let categoria = Categoria(
            nombre: nombre,
            icono: icono,
            nombreColor: color,
            idUsuario: idUsuario
        )
        do {
            try db.collection(ConstantesFirestore.coleccionCategorias)
                .addDocument(from: categoria)
        } catch {
            print("Error guardando: \(error)")
        }

    }
    
    //función helper para casar la categoría que corresponde a un gasto
    func obtenerCategoria(id: String) -> Categoria? {
        categorias.first(where: { $0.id == id })
    }
}
