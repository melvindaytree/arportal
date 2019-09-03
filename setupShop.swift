//
//  shopSetup.swift
//  AR-Portal
//
//  Created by Daytree, Melvin (Synchrony) on 12/2/18.
//

import Foundation
import ARKit
import SceneKit

class shopNode: NSObject {
    func setupShop(nodeManager: itemNode, sceneView: ARSCNView, hitTestResult: ARHitTestResult ) {
        let officeChairNode = nodeManager.addNode(sceneView: sceneView, hitTestResult: hitTestResult, givenNode: "officechair", fileExtension: "scn", xoffset: 0.2, yoffset: 0, zoffset: -1.3)
            sceneView.scene.rootNode.addChildNode(officeChairNode)
        
        let blackChairNode = nodeManager.addNode(sceneView: sceneView, hitTestResult: hitTestResult, givenNode: "blackchair", fileExtension: "scn", xoffset: 0, yoffset: 0, zoffset: -2.3)
            sceneView.scene.rootNode.addChildNode(blackChairNode)
        
        let barstoolNode = nodeManager.addNode(sceneView: sceneView, hitTestResult: hitTestResult, givenNode: "barstool", fileExtension: "scn", xoffset: -1, yoffset: 0, zoffset: -2.3)
            sceneView.scene.rootNode.addChildNode(barstoolNode)
        
        let woodenChairNode = nodeManager.addNode(sceneView: sceneView, hitTestResult: hitTestResult, givenNode: "woodenchair", fileExtension: "scn", xoffset: -1, yoffset: 0, zoffset: -1.3)
            sceneView.scene.rootNode.addChildNode(woodenChairNode)
    }
}
