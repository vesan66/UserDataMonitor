#  UserDataMonitor
## A way of logging some data on a background running app.

### Purpose
On building backgroundtasks, it is not easy to monitor, what is going on. There is the option with 'import os.log', which is every time a good solution for the whole app. But sometimes it is a bit annyoing. Specially if you need to do the Sysdiagnose-cycle.
The idea here is, that a app-group has shared userdata. This app gives - if put in the same app-group - the ability to display this UserData. The app, which is under test uses the class 'UserStorageProvider.swift' to store your desired logdata. 
Now you can see this posts in the app 'UserDataMonitor'.

### Screenshots
![Mainview](/screenshotsklein/IMG_6695_klein.jpg)

### Use
Take this app here and modify it to your needs.
1. Be sure, that your app and this one resides in the same App Group.
```
public static let containerSharedGroup: String = "group.com.YourGroup"
```
2. Put the swift file 'UserStorageProvider.swift' in your project.
3. Use the following line to post a log entry:
```
UserStorageProvider.share.AppendItem("Hello world!")
```    
4. Open the 'UserDataMonitor' to see the logs.

### Important
Remove the class and the calls after the job is done. This is nothing for a production environment. 

### License
MIT license
