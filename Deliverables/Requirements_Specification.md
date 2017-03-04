#Requirements Specification

#5

##5.1 Introduction
This requirements specification is for BasketAI, an autonomous AI driven drone to record basketball games. Users will be able to select and change recording focus during a live game of basketball. The AI will track and moniter each player so that it can switch focus seamlessly. The remainder of this document is structured as follows: section 5.2 contains the functional requirements, section 5.3 contains the performance requirements, and section 5.5 contains the environment requirements.<br />

##5.2  Functional Requirements
Each user shall have an account to automatically sync with their drone. BasketAI shall allow users to easily choose which player to follow through a simple web app or phone app. Users shall also be able to choose to focus on the movement of the ball. Users shall be able to change the angle of view.

**5.2.1 General requirements** <br />
5.2.1.1 The app shall allow user input for all players <br />
5.2.1.2 The app shall include a live video feed from the drone <br />
5.2.1.3 The app shall include an option for changing the angle of view <br />
5.2.1.4 The app shall have an end session button which has the drone land safely and power off <br />
5.2.1.5 The app shall have selections for each player inputed <br />
5.2.1.6 The app shall have a half time button which will tigger a safe landing and power off.

##5.4 Performance Requirements
5.4.1 The live video feed shall not be delayed more than 1-2 seconds <br />
5.4.2 The change in focus from player to player shall be smooth and take less than 5 seconds <br />
5.4.3 The connection from the drone to the app shall not fail and result in a drone crash <br />
5.4.4 Players being tracked shall be tracked either off or on court <br />
5.4.5 App will tigger a safe landing and power off protocol if battery is detected to be low in drone<br />

##5.5 Environment Requirements

**5.5.1 Development Environment Requirements**<br />
5.5.1.1 Developing the iOS version of the application shall require Xcode 8 and Swift 3.<br />>

**5.5.2 Execution Environment Requirements**<br />
5.5.2.1 Hardware Requirements<br />
The application shall not require any special computing hardware to operate.<br />

**5.5.2.2 Software Requirements**<br />
5.5.2.2.1 The application shall be accessed through devices that use iOS 9.0 and up on the following devices: <br />
* iPhone 4
* iPhone 4s
* iPhone 5
* iPhone 5s
* iPhone 5c
* iPhone 6
* iPhone 6s
* iPhone 6 plus
* iPhone 6s plus
* iPhone SE
* iPhone 7
* iPhone 7 plus

5.5.2.2.3 The application shall be accessed through the following web browsers:<br />
* Google Chrome 53.0 and up
* Firefox 50.0
* Safari 9.1
* Microsoft Edge 20.1
 
