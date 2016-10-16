##iOS 10 Day by Day :: Day 5 :: User Notifications

[原文出处](https://www.shinobicontrols.com/blog/ios-10-day-by-day-day-5-user-notifications)


##iOS10 Notification 简介

很久以前，开发者就可以在 iOS 里预约本地通知了，但是之前的 API 缺乏细粒度的控制能力。幸运的是，苹果在 iOS 10 中改善了这一点，发布了新的 UserNotifications 框架。这个框架在处理本地通知及远程推送方面的 API 丰富了许多，同时写法更加简便。

>本地通知（local notification）是用 app 来预约的通知，例如：提醒你带午饭的闹钟。而远程推送（remote notification）一般是服务器发起的，传到苹果的 APNS 服务器上，APNS 再推送到用户手机上。例如：推送给所有用户，告诉他们 app 发布新版本了。

## 示例工程
>本示例工程运行在 Xcode 8 GM 版本上

To take a look at the new User Notifications framework, we’ll build a simple app which allows users to schedule an alert for a task they need to do. The notification will be displayed every 60 seconds and will repeat until the user cancels the reminder. As always, the code is available on Github.

A loudspeaker indicates a notification is currently scheduled whilst a loudspeaker with a line through it indicates no notification exists for that task.

![1](https://www.shinobicontrols.com/wp-content/uploads/2016/08/Schedule_Unschedule_Notification.gif)


We’ll add the ability for the user to respond from the notification itself:

![2](https://www.shinobicontrols.com/wp-content/uploads/2016/08/Action_Cancel.gif)


##UI
Our application is just a simple tableview that displays a list of task the user may want to be reminded about. Other than a simple custom cell, there’s not much more to it than that.

The tasks are defined like so within our NagMeTableViewController:


```
class NagMeTableViewController: UITableViewController {
  typealias Task = String

  let tasks: [Task] = [
      "Wash Up",
      "Walk Dog",
      "Exercise"
  ]
  // Rest of class
```

Our table view is populated with the tasks and each cell is setup to call a closure when the mute/unmute button is toggled.

```
// Rest of NagMeTableViewController
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell

    let task = tasks[indexPath.row]

    cell.nameLabel.text = task

    // Set the cell's icon to indicate whether notification exists or not
    retrieveNotification(for: task) {
        request in
        request != nil ? cell.showReminderOnIcon() : cell.showReminderOffIcon()
    }

    // Closure invoked when button tapped
    cell.onButtonSelection = {
        [unowned self] in
        self.toggleReminder(for: task)
    }

    return cell
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return tasks.count
  }
}
```

To determine if the user is currently being ‘nagged’ about a task, we call retrieveNotification(for: task) which we’ll define later. If a notification object exists then we know the user has requested to be notified about the task.

When the cell’s button is tapped, we’ll call another method we’re yet to implement called toggleReminder(for: task). This is where the magic will happen to schedule our notifications.

##Requesting Authorization