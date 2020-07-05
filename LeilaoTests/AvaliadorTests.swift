//
//  AvaliadorTests.swift
//  LeilaoTests
//
//  Created by Felipe Tatizawa on 04/07/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import XCTest

@testable import Leilao

class AvaliadorTests: XCTestCase {

    private var joao: Usuario!
    private var maria: Usuario!
    private var jose: Usuario!
    
    private var leiloeiro: Avaliador!
    
    //executa antes de cada teste (configurar/declarar variavel)
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        joao = Usuario(nome: "Joao")
        jose = Usuario(nome: "Jose")
        maria = Usuario(nome: "Maria")
        leiloeiro = Avaliador()
    }
    
    //executado após cada teste (desalocar objeto etc..)
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDeveEntenderLancesEmOrdemCrescente(){
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 4")
            .lance(usuario: maria, valor: 250.0)
            .lance(usuario: joao, valor: 300.0)
            .lance(usuario: jose, valor: 400.0)
            .constroi()
        
        try? leiloeiro.avalia(leilao: leilao)

        XCTAssertEqual(250.0, leiloeiro.menorLance())//boas praticas: primeiro valor que espera
        XCTAssertEqual(400.0, leiloeiro.maiorLance())
    }
    
    func testDeveEntenderLeilaoComApenasUmLance(){
        let leilao = Leilao(descricao: "Playstation 4")
        leilao.propoe(lance: Lance(joao, 1000))
        
        try? leiloeiro.avalia(leilao: leilao)
        
        XCTAssertEqual(1000.0, leiloeiro.menorLance())
        XCTAssertEqual(1000.0, leiloeiro.maiorLance())
    }
    
    func testDeveEncontrarOsTresMaioresLances(){
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 4")
            .lance(usuario: joao,valor: 300.0)
            .lance(usuario: maria,valor: 400.0)
            .lance(usuario: joao,valor: 500.0)
            .lance(usuario: maria,valor: 600.0)
            .constroi()
        
        try? leiloeiro.avalia(leilao: leilao)
        
        let listaLances = leiloeiro.tresMaiores()
        
        XCTAssertEqual(3, listaLances.count)
        XCTAssertEqual(600, listaLances[0].valor)
        XCTAssertEqual(500, listaLances[1].valor)
        XCTAssertEqual(400, listaLances[2].valor)
    }
    
    func testDeveIgnorarLeilaoSemNenhumLance(){
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 4")
            .constroi()
        XCTAssertThrowsError(try leiloeiro.avalia(leilao: leilao),"Não é possível avaliar leilão sem lances",{ (error) in print(error.localizedDescription)})
    }
}
