//
//  GameScene.swift
//  PingPong
//
//  Created by Ettore Developer on 01/03/23.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    private let motionManager = CMMotionManager()
    
    let repetitionFactor: Double = 2.0
    
    var isFingerOnPlayer1 = false
        var isFingerOnPlayer2 = false
    
   
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        motionManager.startAccelerometerUpdates()
        
        // crei un corpo fisico con skphisicbody solo col perimetro della view
//        let corpoFisicoConfine = SKPhysicsBody(edgeLoopFrom: self.frame)
//        // attrito 0 non rallenta la palla
//        corpoFisicoConfine.friction = 0
//        // restituttion non fa perdere forza alla palla quando urta gli angoli
//        corpoFisicoConfine.restitution = 1
//        self.physicsBody = corpoFisicoConfine
//        
//        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        // crei un riferimento col nome "palla" alla sprite
        /*
         if let children = scene?.children {
         for child in children {
         if child.name == "palla" {
         child.physicsBody?.applyImpulse(CGVector(dx: 100, dy: -100))
         }
         
         }
         }*/
        //print(scene?.children)
        
        //let palla = scene?.childNode(withName: "palla") as! SKSpriteNode
        let palla = childNode(withName: "palla") as! SKSpriteNode
        let hitboxPalla = SKPhysicsBody(circleOfRadius: 20)
        palla.physicsBody = hitboxPalla
        // applica un impulso con forza costante intensita 100 e -100
        //palla.physicsBody?.applyImpulse(CGVector(dx: -350, dy: 200))
        
        // palla.physicsBody = SKPhysicsBody(circleOfRadius: 90)
        
        
        
        
        
        
//        let player1 = childNode(withName: "player1") as! SKSpriteNode
//        let hitboxPlayer = SKPhysicsBody(rectangleOf: CGSize(width: 200, height: 40))
//        player1.physicsBody = hitboxPlayer
//        player1.physicsBody!.allowsRotation = false
//        player1.physicsBody!.isDynamic = false
//        player1.name = "player1"
        
        
        //        let player2 = childNode(withName: "player2") as! SKSpriteNode
        //        player2.physicsBody!.isDynamic = false
        //                player2.physicsBody!.allowsRotation = false
        
        let wall = childNode(withName: "wall") as! SKSpriteNode
        let hitboxWall = SKPhysicsBody(rectangleOf: CGSize(width: 200, height: 40))
        wall.physicsBody = hitboxWall
        wall.physicsBody!.allowsRotation = false
        wall.physicsBody!.isDynamic = false
        wall.name = "wall"
        
        //         func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //                // recupero la posizione del tocco sullo schermo
        //                let tocco = touches.first
        //             let posizioneTocco = tocco!.location(in: self)
        ////
        ////             let pos = "\(posizioneTocco.x) \(posizioneTocco.y)"
        ////                print(pos)
        //
        //                /*
        //                creo una sorta di area di gioco.
        //                - sotto la coordinata Y (verticale) 270 è area del giocatore 1
        //                - tra la coordinata 1000<Y<1330 l'area di gioco è del giocatore 2
        //                questa impostazione è utile quando vuoi gestire degli oggetti e creare eventi solo per un giocatore
        //                */
        //                if (posizioneTocco.y <= 270) {
        //                    print("Generato un tocco nell'area del player1")
        //                } else if (posizioneTocco.y <= 1330 && posizioneTocco.y >= 1000) {
        //                    print("Generato un tocco nell'area del player2")
        //                }
        //
        //                // controlla che il corpo fisico selezionato alla posizioneTocco sia esistente
        //                // se esiste ne preleva il nome e attiva uno dei due if
        //             if let corpoFisico = physicsWorld.body(at: posizioneTocco) {
        //                    if corpoFisico.node!.name == "player1" {
        //                        print("Player1: Selezionato")
        //                        isFingerOnPlayer1 = true
        //                        isFingerOnPlayer2 = false
        //                    }
        //                    else if(corpoFisico.node!.name == "player2") {
        //                        print("Player2: Selezionato")
        //                        isFingerOnPlayer2 = true
        //                        isFingerOnPlayer1 = false
        //                    }
        //                }
        //            }
        
        func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
            
            let tocco = touches.first
            let posizioneTocco = tocco!.location(in: self)
            
            
            if (posizioneTocco.y <= 270) {
                print("Generato un tocco nell'area del player1")
            } else if (posizioneTocco.y <= 1330 && posizioneTocco.y >= 1000) {
                print("Generato un tocco nell'area del player2")
            }
            
            if let corpoFisico = physicsWorld.body(at: posizioneTocco) {
                if corpoFisico.node!.name == "player1" {
                    print("Player1: Selezionato")
                    isFingerOnPlayer1 = true
                    isFingerOnPlayer2 = false
                }
                else if(corpoFisico.node!.name == "player2") {
                    print("Player2: Selezionato")
                    isFingerOnPlayer2 = true
                    isFingerOnPlayer1 = false
                }
            }
        
            self.run(SKAction.sequence([SKAction.wait(forDuration: 0.4*repetitionFactor), SKAction.run({
                 self.addChild(palla)
            })]))
            
        }
        
         func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
                
             func muoviGiocatore(node: String) {
                         // salva la posizione del tocco
                         let tocco = touches.first
                 let posizioneTocco = tocco!.location(in: self)
                         // recupero la posizione del tocco precedente a quello appena effettuato
                 let posizioneToccoPrecedente = tocco!.previousLocation(in: self)
                         
                         // recupero il node del giocatore
                 let giocatore = childNode(withName: node) as! SKSpriteNode
                         
                         // calcola la nuova posizione per il giocatore
                         var giocatoreX = giocatore.position.x + (posizioneTocco.x - posizioneToccoPrecedente.x)
                         
                         // limita la coordinata X in modo da non far uscire fuori dallo schermo il giocatore mentre si muove
                         giocatoreX = max(giocatoreX, giocatore.size.width/2)
                         giocatoreX = min(giocatoreX, self.size.width - giocatore.size.width/2)
                         
                         // aggiorna le coordinate e quindi muove il giocatore
                         giocatore.position = CGPointMake(giocatoreX, giocatore.position.y)
                     }
             
             if isFingerOnPlayer1 {
                 muoviGiocatore(node: "player1")
             } else if isFingerOnPlayer2 {
                 muoviGiocatore(node: "player2")
             }
                
                // controlla se si sta toccando il giocatore 1 o 2 e attiva la rispettiva funzione
//                if isFingerOnPlayer1 {
////                    muoviGiocatore(node: "player1")
//
//                } else if isFingerOnPlayer2 {
//                    muoviGiocatore(node: "player2")
//                }
            }
        
//        func muoviGiocatore(node: String) {
//            // salva la posizione del tocco
//            let tocco = touches.first
//            let posizioneTocco = tocco!.location(in: self)
////            // recupero la posizione del tocco precedente a quello appena effettuato
////            let posizioneToccoPrecedente = tocco!.previousLocation(in: self)
////
////            // recupero il node del giocatore
//            let giocatore = childNode(withName: node) as! SKSpriteNode
//
//            // calcola la nuova posizione per il giocatore
//            var giocatoreX = giocatore.position.x + (posizioneTocco.x - posizioneToccoPrecedente.x)
//
//            // limita la coordinata X in modo da non far uscire fuori dallo schermo il giocatore mentre si muove
//            giocatoreX = max(giocatoreX, giocatore.size.width/2)
//            giocatoreX = min(giocatoreX, self.size.width - giocatore.size.width/2)
//
//            // aggiorna le coordinate e quindi muove il giocatore
//            giocatore.position = CGPointMake(giocatoreX, giocatore.position.y)
//
//          //  let move = SKAction.move(to: posizioneTocco, duration: 0.1)
//
//        }
//
        
        func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
               self.isFingerOnPlayer1 = false
               self.isFingerOnPlayer2 = false
           }
             
       
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.x * 9.8*2, dy: accelerometerData.acceleration.y * 9.8*2)
        }
    }
    
}
