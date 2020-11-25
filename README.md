<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Tourist Location</h3>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#member">Member</a></li>
    
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This is an IOS APP Tourist Location project, which given a table of touristic locations and the services/cost associated with each location.

Here are what our App do:
* Search hotel information in the city by city name.
* Use data clustering to get most of the users’ favorite hotel facilities and service offered options and recommend the hotel


### Built With

Here are what we use in the development of our project
* [Xcode](https://developer.apple.com/xcode/) IOS Deployment Target: 14.2
* [Firebase](https://firebase.google.com/)


<!-- GETTING STARTED -->
## Getting Started

How to run our APP.

### Prerequisites

* Download the Xcode.
* iPhone

### Installation

1. Clone the project
   ```sh
   git clone https://github.com/LanJinUC/571Assignment.git
   ```
2. Either could run our APP onto a physical iPhone or iPad device or could use the Xcode Simulator which creates a simulalted IOS device on your Mac.
   
3. For Xcode Simulator
    * Open touristLocation.xcworkspace from the .zip.
    * Go up into the top left corner, click on the app name, and then in the dropdown list, you can select the simulator that you want to use. So the simulator device that you want to run our app on.
    * Hit the play button on the top left corner.

4. For Physical iPhone
    * Check Xcode and IOS versions match.
        -> If you head over to Xcode and go to About Xcode, you should see the version of your Xcode.
        -> So for Xcode version 12.2, you should have a physical device that is running 14.2. Go to your physical device, click the Settings and then General and About, then you can see your Software Version.
    * Add an Apple developer account.
        -> You can simply just use your free Apple ID.
        -> Go into Xcode and click on Preferences. Then here, you should be able to add a Apple ID by clicking on the Add button, select Apple ID. Enter your Apple ID which is usually an e-mail and then your password. Once you've successfully logged in, you should be able to see your app ID show up right here inside.
    * Sign the app.
        -> Back to our project, select the top blue file touristLocation on the left top.
        -> Target selected, and then head over to Signing & Capabilities tab and make sure that the Automatically managed signing checkbox is checked.
        -> Click on the Team dropdown list and then select the account that you've added just now.
        -> Once you've selected your team, all the errors on this page should go away.
        -> But if it does not and you see an error that says Fail to create Provisioning profile, then it might be because you haven't got your device connected using a USB cable. 
    * Connect physical device.
        -> Grab your USB cable and connect your physical device, your iPhone or your iPad to your Mac.
    * Trust yourself.
        -> You might see a pop up show up on your phone which asked you whther if you trust this computer. So go ahead and tap on the Trust button and it might also require you to type in the phone device passkey and follow the on-screen instructions to complete that process.
    * Build and run your app. 
        -> Go back to Xcode, click on the top bar here and select your physical phone as the device that you want to run your app onto.
        -> Now you might get a warning here saying something like device IOS version lower than deployment target. You need to update your iPhone to the latest version of IOS(14.2)



<!-- USAGE EXAMPLES -->
## Usage

* Once you run our APP, you can select the city you want to search.
* If you want to see some recommend the hotels, then click the Add Filter on the right top.


<!-- MEMBER -->
## Member

* Lan Jin - lan.jin@ucalgary.ca
* Sijia Yin - sijia.yin@ucalgary.ca
* Zhengyi Zhou - zhengyi.zhou1@ucalgary.ca

Project Link: [https://github.com/LanJinUC/571Assignment.git](https://github.com/LanJinUC/571Assignment.git)
