//
//  itemNode.swift
//  AR-Portal
//
//  Created by Daytree, Melvin (Synchrony) on 11/27/18.
//  Copyright © 2018 Anuj Dutt. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class itemNode: NSObject {
    func addNode(sceneView: ARSCNView, hitTestResult: ARHitTestResult, givenNode: String, fileExtension: String, xoffset: Float, yoffset: Float, zoffset: Float) -> SCNNode {
      
        //define portalScene
        let portalScene = SCNScene(named: "Models.scnassets/\(givenNode).\(fileExtension)")
        
        let chairNode = portalScene!.rootNode.childNode(withName: givenNode, recursively: true)!
        
        // Get the transform matrix from the hit test
        let transform = hitTestResult.worldTransform
        
        // get the x, y and z positions from the transform matrix
        var planeXposition = transform.columns.3.x
        var planeYposition = transform.columns.3.y
        var planeZposition = transform.columns.3.z
        
        planeXposition = planeXposition + xoffset
        planeYposition = planeYposition + yoffset
        planeZposition = planeZposition + zoffset
        
        chairNode.position =  SCNVector3(planeXposition, planeYposition, planeZposition)
        chairNode.name = givenNode
        
        chairNode.renderingOrder = 1
        // Add the portal node to thee scene view
        
        return chairNode
        
    }
    
    func addReplacementNode(assetFolder: String, givenNode: String, fileExtension: String, position: SCNVector3) -> SCNNode {
        //define portalScene
        let portalScene = SCNScene(named: "\(assetFolder).scnassets/\(givenNode).\(fileExtension)")
        
        let itemNode = portalScene!.rootNode.childNode(withName: givenNode, recursively: true)!
        
        itemNode.name = givenNode
        //itemNode.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        itemNode.position = position
        itemNode.renderingOrder = 1
        // Add the portal node to thee scene view
        
        return itemNode
    }
}
