//
//  ViewController.swift
//
//

import UIKit
import ARKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ARSCNViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var planeDetected: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    @IBOutlet var itemPicker: UIPickerView!
    
    
    let configuration = ARWorldTrackingConfiguration()
    var portalExisits = false
    var selectedItem: String?
    var itemsArray: [String] = []
    var shopArray: [String] = ["Chairs", "Lamps", "Tables", "Toys"]
    var itemNodeArray: Array = ["barstool", "blackchair", "officechair", "woodenchair"]
    var nodeManager = itemNode.init()
    var shopManager = shopNode.init()
    
    
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return shopArray.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return shopArray[row]
    }
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        print(shopArray[row])
        
        let chosenShopItem: String = shopArray[row]
        let node = self.sceneView.scene.rootNode
        let tablesArray: Array = ["glassTable", "hourglassTable", "lindaTable", "table"]
        let chairArray: Array = ["barstool", "blackchair", "officechair", "woodenchair"]
        let lampsArray: Array = ["cordLamp", "nordicLamp", "smallLamp", "tableLamp"]
        let toysArray: Array = ["c3poToy", "carToy", "foxToy", "pirateToy"]
        
        switch chosenShopItem {
        case "Chairs":
            // Removing Specific Children
            for itemNode in (self.sceneView?.scene.rootNode.childNodes)! {
                print(itemNode.name)
                //if the item node name is nil do nothing
                if itemNode.name == nil {
                    
                } else {
                    
                    
                    //if the itemNode is in the array
                    if itemNodeArray.contains(itemNode.name!) {
                        //check to see at what index
                        if let index = itemNodeArray.firstIndex(of: itemNode.name!) {
                            //get the last position of the node to be replaced
                            let replaceLocation = itemNode.position
                            //replace the old node
                            node.replaceChildNode(itemNode, with: nodeManager.addReplacementNode(assetFolder: "Models", givenNode: chairArray[index], fileExtension: "scn", position: replaceLocation))
                        }
                    }
                }
            }
            itemNodeArray = chairArray
        case "Tables":
            // Removing Specific Children
            for itemNode in (self.sceneView?.scene.rootNode.childNodes)! {
                print(itemNode.name)
                //if the item node name is nil do nothing
                if itemNode.name == nil {
                
                } else {
                    
                
                //if the itemNode is in the array
            if itemNodeArray.contains(itemNode.name!) {
                //check to see at what index
                if let index = itemNodeArray.firstIndex(of: itemNode.name!) {
                    //get the last position of the node to be replaced
                    let replaceLocation = itemNode.position
                    //replace the old node
                    node.replaceChildNode(itemNode, with: nodeManager.addReplacementNode(assetFolder: "Tables", givenNode: tablesArray[index], fileExtension: "scn", position: replaceLocation))
                }
            }
                }
            }
            itemNodeArray = tablesArray
        case "Lamps":
            // Removing Specific Children
            for itemNode in (self.sceneView?.scene.rootNode.childNodes)! {
                print(itemNode.name)
                //if the item node name is nil do nothing
                if itemNode.name == nil {
                    
                } else {
                    
                    
                    //if the itemNode is in the array
                    if itemNodeArray.contains(itemNode.name!) {
                        //check to see at what index
                        if let index = itemNodeArray.firstIndex(of: itemNode.name!) {
                            //get the last position of the node to be replaced
                            let replaceLocation = itemNode.position
                            //replace the old node
                            node.replaceChildNode(itemNode, with: nodeManager.addReplacementNode(assetFolder: "Lamps", givenNode: lampsArray[index], fileExtension: "scn", position: replaceLocation))
                        }
                    }
                }
            }
            itemNodeArray = lampsArray
        case "Toys":
            // Removing Specific Children
            for itemNode in (self.sceneView?.scene.rootNode.childNodes)! {
                print(itemNode.name)
                //if the item node name is nil do nothing
                if itemNode.name == nil {
                    
                } else {
                    
                    
                    //if the itemNode is in the array
                    if itemNodeArray.contains(itemNode.name!) {
                        //check to see at what index
                        if let index = itemNodeArray.firstIndex(of: itemNode.name!) {
                            //get the last position of the node to be replaced
                            let replaceLocation = itemNode.position
                            //replace the old node
                            node.replaceChildNode(itemNode, with: nodeManager.addReplacementNode(assetFolder: "Toys", givenNode: toysArray[index], fileExtension: "scn", position: replaceLocation))
                        }
                    }
                }
            }
            itemNodeArray = toysArray
        default:
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        // Detect the Horizontal Planes
        self.configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        // Runs the Function to configure cell in a Collection View
        self.itemCollectionView.dataSource = self
        // Runs the function to turn the selected cell to Green
        self.itemCollectionView.delegate = self
        self.sceneView.delegate = self
        self.registerGestureRecognizers()

        // Add the Tap Gesture, if a tap is recognized, execute the Handle Tap function
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        // Add tap gesture recognizer to the Scene View
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        
        self.itemPicker.delegate = self
        self.itemPicker.dataSource = self
        
    }
    
//THis is the cell stuff -----------------------------------------------------------
    // How many cells the colection displays
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    // Configures every single source cell in collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! itemCell
        // Shows the Values from Array to Text Label
        cell.itemLabel.text = self.itemsArray[indexPath.row]
        return cell
    }
    
    // Function to turn the label to green when the item is selected
    // This function gets triggered whenever we select a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        self.selectedItem = itemsArray[indexPath.row]
        cell?.backgroundColor = UIColor.black
    }
    
    // Function to change the cell color back to normal on deselction
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.gray
    }
    
    // Recognize Horizontal Plane
    // Recognize Zoom in/out
    // Long Press: to rotate object about its axis
    func registerGestureRecognizers() {
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        //Dont like pans
        //let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan))
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        longPressGestureRecognizer.minimumPressDuration = 0.1
        self.sceneView.addGestureRecognizer(pinchGestureRecognizer)
       // self.sceneView.addGestureRecognizer(panGestureRecognizer)
        //Took out the rotating to prevent the walls from changing for now
       // self.sceneView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    

    
    // Function to Zoom in or Zoom out the Objects
    @objc func pinch(sender: UIPinchGestureRecognizer){
        let sceneView = sender.view as! ARSCNView
        let pinchLocation = sender.location(in: sceneView)
        let hitTest = sceneView.hitTest(pinchLocation)
        if !hitTest.isEmpty{
            let results = hitTest.first
            let node = results?.node
            let pinchAction = SCNAction.scale(by: sender.scale, duration: 0)
            // print(sender.scale)
            node?.runAction(pinchAction)
            sender.scale = 1.0
        }
    }
    
    // Function to detect Long Press
    // If Long Press: Rotate Object
    @objc func longPress(sender: UILongPressGestureRecognizer){
        let sceneView = sender.view as! ARSCNView
        // Get location of Holding in Scene View
        let holdLocation = sender.location(in: sceneView)
        // Check If location of holding matches the location of the object placed in scene view
        let hitTest = sceneView.hitTest(holdLocation)
        if !hitTest.isEmpty{
            // If holding, rotate the object node
            let results = hitTest.first
            // let node = results?.node
            
            // If currently pressing in scene view
            if sender.state == .began{
                // Rotate the Object along y axis 360 degrees
                let nodeAction = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 1)
                // Keep on Rotating
                let forever = SCNAction.repeatForever(nodeAction)
                results?.node.runAction(forever)
                print("Holding")
            }
            else if sender.state == .ended{
                // Stop rotation when no long hold
                results?.node.removeAllActions()
                print("Released")
            }
        }
    }
    
//    @objc func pan(sender: UIPanGestureRecognizer){
//        let sceneView = sender.view as! ARSCNView
//        // Get location of Holding in Scene View
//        let holdLocation = sender.location(in: sceneView)
//        let hitTest = sceneView.hitTest(holdLocation, types: .existingPlane)
//        let hitTestFake = sceneView.hitTest(holdLocation)
//
//
//        if !hitTest.isEmpty{
//            let results = hitTestFake.first
//            let node = results?.node
//            node?.position = SCNVector3Make(hitTest.worldTransform.columns.3.x, hitTest.worldTransform.columns.3.y, hitTest.worldTransform.columns.3.z)
//        }
//    }
    
    // Function to Place items on a Horizontal Surface
    func addItem(hitTestResult: ARHitTestResult){
        if let selectedItem = self.selectedItem {
            print("item is placed")
            // When Plane is detected, place the object on that
            let scene = SCNScene(named: "Models.scnassets/\(selectedItem).scn")
            let node = (scene?.rootNode.childNode(withName: selectedItem,recursively:false))!
            // Get transform matrix to get the values to place objects right on top of horzontal surface detected
            let transform = hitTestResult.worldTransform
            // Position of detected surface is in 3rd column of transform matrix
            let thirdColumn = transform.columns.3
            // Position the Object node right where the detected surface is
            node.position = SCNVector3(thirdColumn.x,thirdColumn.y,thirdColumn.z)
            // Rotate Table around itself
            if selectedItem == "table"{
                self.centerPivot(for: node)
            }
            self.sceneView.scene.rootNode.addChildNode(node)
        }
    }
    
    // Function to make Table rotate along y-axis
    func centerPivot(for node: SCNNode) {
        let min = node.boundingBox.min
        let max = node.boundingBox.max
        node.pivot = SCNMatrix4MakeTranslation(
            min.x + (max.x - min.x)/2,
            min.y + (max.y - min.y)/2,
            min.z + (max.z - min.z)/2
        )
    }



    
//----------------------------------------------------------------------------------------------------------------------
    
    
    
    
    
    // Function to handle Tap Gesture in Scene View
    @objc func handleTap(sender: UITapGestureRecognizer) {
        // Check if tap was performed, then move forward else, return
        guard let sceneView = sender.view as? ARSCNView else {return}
        // Get the location of the touch in the Scene View
        let touchLocation = sender.location(in: sceneView)
        // use hit test to get the location of tap
        let hitTestResult = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
        let hitTestResultFirst = hitTestResult.first
        let hitTestVirtual = sceneView.hitTest(touchLocation, options: [SCNHitTestOption.searchMode: 1])
        
        //Check if the portal currently exists
        if portalExisits == true {
            //if it does exist and an item is chosen from the list place that item
            if !hitTestResult.isEmpty{
                self.addItem(hitTestResult: hitTestResult.first!)
            } else {
                    //if the portal exists and the user clicks on a node add it to the placement array
                //Check to see if the virtual place is empty... If no node exists dont do anything
                if hitTestVirtual.isEmpty {
                    return
                } else {
                    let nodeHit = hitTestVirtual[0]
                    let nodeName = nodeHit.node.name
                    print("Print the nodename: \(nodeName!)")
                
                switch nodeName {
                case "table":
                    itemsArray.append(nodeName!)
                    itemCollectionView.reloadData()
                case "barstool":
                    itemsArray.append(nodeName!)
                    itemCollectionView.reloadData()
                case "officechair":
                    itemsArray.append(nodeName!)
                    itemCollectionView.reloadData()
                case "woodenchair":
                    itemsArray.append(nodeName!)
                    itemCollectionView.reloadData()
                case "blackchair":
                    itemsArray.append(nodeName!)
                    itemCollectionView.reloadData()
                case "pirateToy":
                    itemsArray.append(nodeName!)
                    itemCollectionView.reloadData()
                case "cordLamp":
                    itemsArray.append(nodeName!)
                    itemCollectionView.reloadData()
                case "smallLamp":
                    itemsArray.append(nodeName!)
                    itemCollectionView.reloadData()
                case "carToy":
                    itemsArray.append(nodeName!)
                    itemCollectionView.reloadData()
                case "foxToy":
                    itemsArray.append(nodeName!)
                    itemCollectionView.reloadData()
                    default:
                        return
                    }
                }
            }
        } else {
            
            //if the portal doesn't exist yet setup the basic layout
            if !hitTestResult.isEmpty {
                // if tap is recognized, add the portal in front of camera
                
                
               shopManager.setupShop(nodeManager: nodeManager, sceneView: sceneView, hitTestResult: hitTestResultFirst!)
                
                //This adds the portal to the scene
                //Should be ran after all the other objects are created in order to hide them behind the walls
                self.addPortal(hitTestResult: hitTestResult.first!)
                
                portalExisits = true
                playArAudio()
                itemPicker.isHidden = false
            } else {
                return
            }
        }
        
        
    }
    
    // Function to add the Portal in front of the Camera location
    func addPortal(hitTestResult: ARHitTestResult) {
        // Define the Portal Scene
        let portalScene = SCNScene(named: "Portal.scnassets/PortalBig.scn")
        // Create the portal node, recursive as there are multiple levels in its children
        let portalNode = portalScene!.rootNode.childNode(withName: "Portal", recursively: false)!
        // Get the transform matrix from the hit test
        let transform = hitTestResult.worldTransform
        
        // get the x, y and z positions from the transform matrix
        let planeXposition = transform.columns.3.x
        let planeYposition = transform.columns.3.y
        let planeZposition = transform.columns.3.z
        
        // Place the portal in the location of the x ,y ,z coordinates obtained
        portalNode.position =  SCNVector3(planeXposition, planeYposition, planeZposition)
        // Add the portal node to thee scene view
        self.sceneView.scene.rootNode.addChildNode(portalNode)
    
        // Add image to the walls on inside of the portal room
        self.addPlane(nodeName: "roof", portalNode: portalNode, imageName: "top")
        self.addPlane(nodeName: "floor", portalNode: portalNode, imageName: "bottom")
        self.addWalls(nodeName: "backWall", portalNode: portalNode, imageName: "back")
        self.addWalls(nodeName: "sideWallA", portalNode: portalNode, imageName: "sideA")
        self.addWalls(nodeName: "sideWallB", portalNode: portalNode, imageName: "sideB")
        self.addWalls(nodeName: "sideDoorA", portalNode: portalNode, imageName: "sideDoorA")
        self.addWalls(nodeName: "sideDoorB", portalNode: portalNode, imageName: "sideDoorB")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else {return}
        DispatchQueue.main.async {
            // Keep the plane detected label as hidden
            self.planeDetected.isHidden = false
        }
        
        // if horizontal plane found, display plane detected for 3 seconds and then make it hidden
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.planeDetected.isHidden = true
        }
    }
    
    // Add images to the walls of the portal
    func addWalls(nodeName: String, portalNode: SCNNode, imageName: String) {
        // Add top and bottom to the portal
        let child = portalNode.childNode(withName: nodeName, recursively: true)
        child?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Portal.scnassets/\(imageName).png")
        // By default the rendering order of walls, roof and bottom is "0".
        // More the rendering Order, more the transparency
        // Using this, the mask will be rendered first and then the walls. so, they appear transparent
        child?.renderingOrder = 200
        if let mask = child?.childNode(withName: "mask", recursively: false) {
            // Make masks completely Transparent
            mask.geometry?.firstMaterial?.transparency = 0.000001
        }
    }
    
    // Add images to the roof and floor of the portal
    // Rule of Thumb: If an opaque object is rendered way after the translucent object, then the colors will mix.
    // Since mask is transparent, it'll make the walls to appear transparent as well.
    func addPlane(nodeName: String, portalNode: SCNNode, imageName: String) {
        let child = portalNode.childNode(withName: nodeName, recursively: true)
        child?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Portal.scnassets/\(imageName).png")
        // render floor and ceiling after the mask rendering
        child?.renderingOrder = 200
    }
    
    
    
    func playArAudio() {
        let audioSource = SCNAudioSource(fileNamed: "jazz-loop.wav")!
        print(audioSource)
        audioSource.volume = 0.5
        audioSource.rate = 0.1
        audioSource.loops = true
        audioSource.isPositional = true
        audioSource.shouldStream = false
        audioSource.load()
        
        let player = SCNAudioPlayer(source: audioSource)
        print(player)
        let node = self.sceneView?.scene.rootNode
        print(node)
        node!.addAudioPlayer(player)
    }
    
}



extension  Int {
    var degreesToRadians: Double {return Double(self) * .pi/180}
}
