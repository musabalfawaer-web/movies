import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notifications = true;
  bool autoplay = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Preferences",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 15),

          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  value: notifications,
                  activeColor: Colors.red,
                  title: const Text(
                    "Notifications",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text(
                    "Receive notifications about new movies",
                  ),
                  secondary: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.red,
                  ),
                  onChanged: (value) {
                    setState(() {
                      notifications = value;
                    });
                  },
                ),

                const Divider(
                  height: 1,
                ),

                SwitchListTile(
                  value: autoplay,
                  activeColor: Colors.red,
                  title: const Text(
                    "Autoplay Trailers",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text(
                    "Automatically play movie trailers",
                  ),
                  secondary: const Icon(
                    Icons.play_circle_outline,
                    color: Colors.red,
                  ),
                  onChanged: (value) {
                    setState(() {
                      autoplay = value;
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            "App",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 15),

          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.language,
                    color: Colors.red,
                  ),
                  title: const Text(
                    "Language",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text(
                    "English",
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                  ),
                  onTap: () {},
                ),

                const Divider(
                  height: 1,
                ),

                ListTile(
                  leading: const Icon(
                    Icons.info_outline,
                    color: Colors.red,
                  ),
                  title: const Text(
                    "App Version",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text(
                    "1.0.0",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}