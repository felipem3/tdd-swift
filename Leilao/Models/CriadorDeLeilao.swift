//
//  CriadorDeLeilao.swift
//  Leilao
//
//  Created by Felipe Tatizawa on 05/07/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

class CriadorDeLeilao: NSObject {
    
    private var leilao: Leilao!
    
    func para(descricao:String) -> Self {
        leilao = Leilao(descricao: descricao)
        
        return self //possibilita invocar outros metodos seguidos deste
    }
    
    func lance(usuario: Usuario, valor: Double) -> Self {
        leilao.propoe(lance: Lance(usuario, valor))
        
        return self
    }
    
    func constroi() -> Leilao {
        return leilao
    }
}
