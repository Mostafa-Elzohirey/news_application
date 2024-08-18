import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_application/animations/scale_route.dart';
import 'package:news_application/colors.dart';
import 'package:news_application/db/Shared.dart';
import 'package:news_application/ui/news_description.dart';
import 'package:news_application/ui/settings.dart';

import '../model/news_response.dart';

class NewsMainScreen extends StatefulWidget {
  const NewsMainScreen({super.key});

  @override
  State<NewsMainScreen> createState() => _NewsMainScreenState();
}

class _NewsMainScreenState extends State<NewsMainScreen> {
  int currentIndex = 0;
  bool isLoading = true;
  final titles = [
    'Business',
    'Entertainment',
    'Sports',
    'Science',
    'Technology ',
  ];

  List<Articles> articles = [];
  final categories = [
    'business',
    'entertainment',
    'sports',
    'science',
    'technology',
  ];
  @override
  void initState() {
    super.initState();
    if (PreferenceUtils.getString(PrefKeys.selectedCountry).isEmpty) {
      PreferenceUtils.setString(PrefKeys.selectedCountry, 'us');
    }
    getNewsByCategory(categories[currentIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: appBarColor,
        title: Text(titles[currentIndex]),
        actions: [
          IconButton(
              onPressed: () {
                navToSettings();
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: appBarColor,
            ))
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                Articles article = articles[index];
                return Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        article.urlToImage.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 60,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(article.urlToImage)),
                        Text(article.author),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15),
                          child: InkWell(
                            onTap: () {
                              navToDescription(article.title, article.url);
                              print(article.url);
                            },
                            child: Text(article.title),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (selectedIndex) {
            isLoading = true;
            setState(() {
              currentIndex = selectedIndex;
              getNewsByCategory(categories[currentIndex]);
            });
          },
          elevation: 0,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.shifting,
          unselectedItemColor: Colors.grey,
          selectedItemColor: appBarColor,
          // backgroundColor: mainColor,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.business),
              label: titles[currentIndex],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.gamepad_outlined),
              label: titles[currentIndex],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.sports_soccer),
              label: titles[currentIndex],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.science),
              label: titles[currentIndex],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.biotech_outlined),
              label: titles[currentIndex],
            ),
          ]),
    );
  }

  void getNewsByCategory(String category) async {
    final response = await Dio()
        .get("https://newsapi.org/v2/top-headlines", queryParameters: {
      "country": PreferenceUtils.getString(PrefKeys.selectedCountry),
      "category": category,
      "apiKey": "2ed58f61455141cf8f8e60b3582dc5fb",
    });
    isLoading = false;
    final newsResponse = NewsResponse.fromJson(response.data);
    articles = newsResponse.articles;
    setState(() {});
  }

  void navToSettings() {
    Navigator.push(
      context,
      ScaleRoute(
        page: const Settings(),
      ),
    ).then((value) => getNewsByCategory(categories[currentIndex]));
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
}
