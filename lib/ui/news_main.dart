import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:news_application/animations/scale_route.dart';
import 'package:news_application/ui/manager/news_cubit.dart';
import 'package:news_application/ui/news_description.dart';
import 'package:news_application/ui/news_screen.dart';
import 'package:news_application/ui/settings.dart';

import 'app manager/app_cubit.dart';
import 'manager/news_state.dart';

class NewsMainScreen extends StatefulWidget {
  const NewsMainScreen({super.key});

  @override
  State<NewsMainScreen> createState() => _NewsMainScreenState();
}

class _NewsMainScreenState extends State<NewsMainScreen>
    with TickerProviderStateMixin {
  final cubit = NewsCubit();
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: 3, milliseconds: 300));
    _animationController.forward();
    _animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        cubit.getNewsByCategory(cubit.categories[cubit.currentIndex]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<NewsCubit, NewsState>(
        listener: (context, state) {
          if (state is NavToSettings) {
            navToSettings();
          }
        },
        child: BlocBuilder<NewsCubit, NewsState>(
          buildWhen: (previous, current) {
            return current is GetNews || current is ChangeCategory;
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(cubit.titles[cubit.currentIndex]),
                actions: [
                  IconButton(
                    onPressed: () {
                      navToSettings();
                    },
                    icon: const Icon(Icons.settings),
                  ),
                ],
              ),
              body: _animationController.status.isCompleted
                  ? cubit.isLoading
                      ? Center(
                          child:
                              Lottie.asset("assets/animations/Loading2.json"))
                      : NewsScreen(
                          category: cubit.categories[cubit.currentIndex])
                  : Center(
                      child: Lottie.asset('assets/animations/Loading.json')),
              bottomNavigationBar: BottomNavigationBar(

                onTap: (selectedIndex) {
                  cubit.changeCategory(selectedIndex);
                },
                currentIndex: cubit.currentIndex,
                type: BottomNavigationBarType.shifting,
                // unselectedItemColor: Colors.grey,
                // selectedItemColor: appBarColor,
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.business),
                    label: cubit.titles[0], // Corrected index
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.gamepad_outlined),
                    label: cubit.titles[1], // Corrected index
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.sports_soccer),
                    label: cubit.titles[2], // Corrected index
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.science),
                    label: cubit.titles[3], // Corrected index
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.biotech_outlined),
                    label: cubit.titles[4], // Corrected index
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void navToSettings() {
    Navigator.push(
      context,
      ScaleRoute(
        page: const Settings(),
      ),
    ).then((value) {
      BlocProvider.of<AppCubit>(context).themeChanged();
    });
  }

  void navToDescription(String title, String url) {
    Navigator.push(
      context,
      ScaleRoute(
        page: Description(
          title: title,
          url: url,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose animation controller
    _animationController.dispose();
    super.dispose();
  }
}
