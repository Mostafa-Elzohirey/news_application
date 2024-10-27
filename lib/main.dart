import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/app_dio.dart';
import 'package:news_application/colors.dart';
import 'package:news_application/ui/app%20manager/app_cubit.dart';
import 'package:news_application/ui/news_main.dart';

import 'db/Shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  AppDio.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        )
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
                brightness: Brightness.light,
                bottomSheetTheme: BottomSheetThemeData(
                  backgroundColor: offWhite,
                  modalBackgroundColor: Colors.white,
                  dragHandleColor: Colors.black,
                ),
                scaffoldBackgroundColor: Colors.white,
                useMaterial3: true,
                primarySwatch: azureBlue,
                appBarTheme: AppBarTheme(
                  color: offWhite,
                  foregroundColor: Colors.black,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: Colors.white,
                    unselectedItemColor: Colors.grey,
                    selectedItemColor: azureBlue),
                iconTheme: IconThemeData(color: azureBlue)),
            darkTheme: ThemeData(
                brightness: Brightness.dark,
                bottomSheetTheme: BottomSheetThemeData(
                  modalBackgroundColor: Color(0xFF3A3B3C),
                  backgroundColor: Color(0xFF3A3B3C),
                ),
                scaffoldBackgroundColor: Color(0xFF3A3B3C),
                useMaterial3: true,
                primarySwatch: appBarColor,
                appBarTheme: AppBarTheme(
                  color: Color(0xFF18191A),
                  foregroundColor: Colors.white,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
                  backgroundColor: darkColor,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: appBarColor,
                  // selectedIconTheme: IconThemeData(color: azureBlue),
                ),
                iconTheme: IconThemeData(color: appBarColor)),
            themeMode: PreferenceUtils.getBool(PrefKeys.darkTheme)
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const NewsMainScreen(),
          );
        },
      ),
    );
  }
}
