import 'package:flutter/material.dart';

// Global ValueNotifier for Notification Preference
ValueNotifier<bool> isNotificationEnabled = ValueNotifier(true);
// Creates a global notifier object with the value of true,
// allowing other widgets to listen to changes in the notification state and update their UI.

class NotificationSettings {
  static void enableNotifications(bool enabled) {
    isNotificationEnabled.value = enabled;
    print("Notifications are now ${enabled ? 'enabled' : 'disabled'}.");
  }
}
//first it is set to true because we need a centerlized logic for all the widgets, 
//espacially if you add functionality later.
//and the class is helpfull when we turn the notifications on and off.


