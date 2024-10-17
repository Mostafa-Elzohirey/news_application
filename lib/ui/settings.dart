import 'package:flutter/material.dart';

import '../colors.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: appBarColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          settingsItem(
            onTap: () {
              // navToSelectCountry();
            },
            icon: Icons.language,
            title: "Country",
            value:"us"
          ),
          settingsItem(
              onTap: () {},
              icon: Icons.language,
              title: "Language",
              value: "en"),
          settingsItem(
              onTap: () {},
              icon: Icons.notifications,
              title: "Notifications",
              value: "On"),
          settingsItem(
              onTap: () {},
              icon: Icons.color_lens_rounded,
              title: "Theme",
              value: "Light"),
        ],
      ),
    );
  }

  Widget settingsItem({
    required GestureTapCallback onTap,
    required IconData icon,
    required String title,
    String value = '',
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(
              icon,
              color: appBarColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Icon(Icons.keyboard_arrow_right_sharp),
          ],
        ),
      ),
    );
  }

  // void navToSelectCountry() {
  //   Navigator.push(
  //     context,
  //     ScaleRoute(
  //       page: const SelectCountry(),
  //     ),
  //   ).then(
  //     (value) => setState(
  //       () {},
  //     ),
  //   );
  // }
}
