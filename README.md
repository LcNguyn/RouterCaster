 **RMIT University Vietnam**
 
 **Course:** COSC2659 iOS Development
 
 **Semester:** 2019A
 
 **Assessment:** Assignment 3
 
 **Created date:** 16/05/2019
 
 **Author:** 
   -  Tang Quang An (s3695273)
   -  Nguyen Tuan Loc (s3695769)
   -  Nguyen Dinh Anh Khoi (s3695517)
   -  Le Minh Kien (s3651471)
   -  Le Nghia (s3654028)
   
<br/>
<br/>

 **TABLE OF CONTENTS**
 [Go to](#introduction) 1. Introduction
 2. Features
 3. Diagrams
 4. Acknowledgments
 
<br/>
<br/>

# Introduction
  This is a project from group 6 of IOS development course (COSC2659) in semester A2019. It is called Routecaster app, a combination 
  between social and map navigation app which allows users to have their location and route shared to their friends as well as having chat
  feature for conversations. The features will be specifically explained in terms of flow (not fully front-end or back-end explanation) in
  features section below.

# Features
 ###  Download the application
 
   The user will not be able to download and install the app in his/her device. Since the download and installation requires us to 
   follow the terms and rules of Apple and also, the stakeholders does not recommended us to upload to Appstore due to mentioned 
   reasons, we decided not to do the Appstore upload.

 ###  Sign up/Log in
 
   Yes, the user can sign up by Facebook, Gmail and even in-app register, log i with the registred account (use email and password 
   to log in). This features are hugely supported by Firebase.

 ###  Reset password 

 ###  Onboarding

 ###  Tracking their routes and their friend’s routes
The user' location is kept in realtime. Furthermore, he/she is allowed their start and end points and see the route on their map. The user will be able to assign different colors to their friends'route so that it will be able to be displayed on map. Also, distance (in different units) and estimation time for finishing the route will be shown in our app. When the user is out of route, they will be notified.

The user can choose to see the specific friend’s routes or their current location (or both) on their map in different colors. And once user come to their end point, they will be able to record their actual time and distance for that route.

  ###  Manage friends
The user will be able to view their friend list, send request to add new friend, delete existing friends on their contact.
The user can also send messages to their friends.

  ###  Share
The user will be able to share their finished route directly to friends in the app.
The user will be able to share their finished route to social networks

 ###  Statistic
The user will be able to view their finished routes weekly, monthly.
The user will be able to make comparison between them and their selected friend’s statistics.

 ###  Manage settings
The user will be able to choose to display their friend’s avatars, name or both on the map with friend’s location
The user will be able to manage how many routes will be able to be displayed on their map.
The user will be able to manage their prefer units to input for each route.
The user will be able to manage their personal account.

# Diagram

# Acknowledgement
   1. https://firebase.google.com/docs/firestore/manage-data/add-data#update-data
   
   2. https://github.com/rebeloper/FirestoreAuth
