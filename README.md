# Facility Flow
* for HackSMU
<br>
(this xcode project was initially created to test out CreateML and CoreML but i ended up coding it all on here, so please disregrard the xcode project file name 🙏)

## How to Deploy
Click on the green "code" button -> Click "Open with XCode" -> Clone
<br>
<br>
Once you're in Github, click make sure you select an appropriate device size (I recommend iPhone 12 and up for the best experience) at the very top of your XCode screen. Then, click the play button on the top left of your XCode screen near the red, green, and yellow button to run the simulator!
<br>
Device:
<br>
<img width="911" alt="Screenshot 2023-09-17 at 11 07 11 AM" src="https://github.com/snehab2/Facility-Flow/assets/86683361/41e37d5e-3d17-4a75-a6f3-6e9f32035bc0">
<br>
Simulator: 
<br>
<img width="267" alt="Screenshot 2023-09-17 at 11 07 19 AM" src="https://github.com/snehab2/Facility-Flow/assets/86683361/ed44e70a-3342-4f1e-9157-0a6f66a8c6e2">

## What it does
FacilityFlow helps you (i.e. managers) to access and keep track of your building's assets like elevators, public systems, fire alarms, etc. We created a seamless digital experience to make it easier and efficient for you! FacilityFlow allows you to monitor and control the assets in your building. You can track the health life of each asset, schedule servicing dates, etc.

## How we built it
* Front-end: We used Figma to prototype our app and make it interactive.
* Back-end: To implement a machine learning algorithm, we used CreateML to train a model given a dataset. In XCode, we utilized SwiftUI as our main frame work; CoreML to implement our ML model; Core Data to ensure each asset's information is individually saved and save the current state of the app so the user doesn't lose any data.

## Challenges we ran into
* This was our first time implementing ML and using Apple's CreateML using SwiftUI in XCode. It was difficult combining ML and Core Data and presenting the data in an accessible and intuitive way. A lot of our time was spent debugging and researching. This experience was a huge learning curve for us! 
* In terms of our front-end, we had a difficult time finding a way to connect our UI designs to our back-end into one file. Since all of us had different versions of Mac, we didn't want to encounter compatibility issues throughout our time programming, so we decided to split it. However, our UI designs on Figma are interactive! It's essentially our prototype. 

## Accomplishments that we're proud of
* Despite the challenges, we implemented ML and Core Data! There are still a few errors, but again, this was a huge learning experience for us as we played with different technologies!

## What we learned
* We learned more about prototyping in Figma and played around with the UI designs. 
* We dived more into XCode, SwiftUI, CreateML, CoreML, and Core Data. 

## What's next for FacilityFlow
**In terms of technicalities:**
* Combining both the front end design to the back end into one XCode file
* Fine tune our ML model (currently uses all of the data in the dataset, so in the future, we would take more time to clean our data and add any additional variables)
* Currently, the new servicing date after updating a servicing is the same for each asset in XCode. However, we programmed it to where each asset in core data has its own servicing date, but we had a difficult time showing it on the view. 
* Fine tune some of the design on the XCode project

**In the future:**
**In terms of app design:**
* Create an interactive, visual map for managers' accessibility.
* Organize data based on asset type, floor, room number, manufacturer, etc
* Integrate a chatbot that gives updates, recommendations, etc about assets and servicing
* Add a page where managers can contact asset specialists; combine this with the chatbot so managers can directly contact asset specialist(s)
* Have a view where residents/workers can report asset issues (like a report log)

**In the current XCode project, things we want to fix/add:**
* Implement more functionalities into the XCode project
