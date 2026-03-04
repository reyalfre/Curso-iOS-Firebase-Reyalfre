//
//  Gasto.swift
//  Curso iOS Firebase Reyalfre
//
//  Created by Equipo 8 on 2/3/26.
//

import FirebaseFirestore
import Foundation

struct Gasto: Identifiable, Codable {
    @DocumentID var id: String?
    var titulo: String
    var importe: Double
    var fecha: Date
    
    var categoria: CategoriaGastos = .sinCategoria
    
    var idUsuario: String
    
    enum CodingKeys: String, CodingKey{
        case id, titulo, importe, fecha, idUsuario, categoria
    }
}
