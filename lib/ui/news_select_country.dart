import 'package:flutter/material.dart';

import '../db/Shared.dart';

class SelectCountry extends StatefulWidget {
  const SelectCountry({super.key});

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  final countries = ['us', 'eg', 'sa', 'ae', 'ca'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Country"),
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => saveSelectedCountry(countries[index]),
            child: Container(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text(
                      countries[index],
                      style: const TextStyle(fontSize: 20),
                    ),
                    const Spacer(),
                    const Icon(Icons.keyboard_arrow_right_sharp),
                  ],
                )),
          );
        },
      ),
    );
  }

  saveSelectedCountry(String selectedCountry) async {
    PreferenceUtils.setString(PrefKeys.selectedCountry, selectedCountry);
    Navigator.pop(context);
  }
}
