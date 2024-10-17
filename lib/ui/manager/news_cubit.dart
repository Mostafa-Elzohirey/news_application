import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/news_response.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  int currentIndex = 0;
  bool isLoading = true;
  final titles = [
    'Business',
    'Entertainment',
    'Sports',
    'Science',
    'Technology',
  ];
  List<Articles> articles = [];
  final categories = [
    'business',
    'entertainment',
    'sports',
    'science',
    'technology',
  ];
  void getNewsByCategory(String category) async {
    final response = await Dio()
        .get("https://newsapi.org/v2/top-headlines", queryParameters: {
      "country": "us",
      "category": category,
      "apiKey": "2ed58f61455141cf8f8e60b3582dc5fb",
    });
    isLoading = false;
    final newsResponse = NewsResponse.fromJson(response.data);
    articles = newsResponse.articles;
    emit(GetNews());
  }

  void navToSettings() {
    emit(NavToSettings());
  }

  void navToDescription(index) {
    emit(NavToDescription());
  }

  void changeCategory(int selectedIndex) {
    isLoading = true;
    currentIndex = selectedIndex;
    emit(ChangeCategory());
    getNewsByCategory(categories[currentIndex]);
  }
}
