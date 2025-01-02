import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:myapp/notification_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dark Theme Toggle
            SwitchListTile(
              title: Text(
                "Dark Theme",
                style: theme.textTheme.labelLarge,
              ),
              value: isDarkTheme.value,
              onChanged: (value) {
                setState(() {
                  isDarkTheme.value = value;
                });
              },
            ),

            // Notifications Toggle
            SwitchListTile(
              title: Text(
                "Enable Notifications",
                style: theme.textTheme.labelLarge,
              ),
              value: isNotificationEnabled.value,
              onChanged: (value) {
                setState(() {
                  NotificationSettings.enableNotifications(value);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
