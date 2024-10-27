import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/colors.dart';
import 'package:news_application/db/Shared.dart';
import 'package:news_application/ui/app%20manager/app_cubit.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      appBar: AppBar(
        // backgroundColor: appBarColor,
        // foregroundColor: Colors.white,

        title: const Text(
          "Settings",
          // style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          settingsItem(
              onTap: () {
                // navToSelectCountry();
              },
              icon: Icons.language,
              title: "Country",
              value: "us"),
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
              onTap: () {
                showThemeBottomSheet();
              },
              icon: Icons.color_lens_rounded,
              title: "Theme",
              value: Theme.of(context).brightness == Brightness.dark
                  ? "Dark"
                  : "Light"),
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
        color:
            Theme.of(context).brightness == Brightness.dark
            ? darkColor
            : Colors.grey[300],
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(
              icon,
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

  void showThemeBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 20),
                const Text('Select Theme'),
                SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    await PreferenceUtils.setBool(
                      PrefKeys.darkTheme,
                      false,
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? darkColor
                        : Colors.grey[300],
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(Icons.light_mode),
                        SizedBox(width: 15,),
                        const Text(
                          'Light',
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    await PreferenceUtils.setBool(
                      PrefKeys.darkTheme,
                      true,
                    );
                    Navigator.pop(context);
                  },
                  child: Container(

                    decoration: BoxDecoration(
                      color:Theme.of(context).brightness == Brightness.dark
                          ? darkColor
                          : Colors.grey[300],
                    ),

                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(Icons.dark_mode),
                        SizedBox(width: 15,),
                        const Text(
                          'Dark',
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      BlocProvider.of<AppCubit>(context).themeChanged();
    });
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
