import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/model/news_response.dart';
import 'package:news_application/ui/manager/news_cubit.dart';
import 'package:news_application/ui/manager/news_state.dart';
import '../animations/scale_route.dart';
import 'news_description.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key, required this.category});

  final String category;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    // Access the cubit provided by BlocProvider in NewsMainScreen
    final cubit = context.read<NewsCubit>();

    return BlocBuilder<NewsCubit, NewsState>(
      buildWhen: (previous, current) {
        return current is GetNews;
      },
      builder: (context, state) {
        // Check if there are articles to display
        if (cubit.articles.isEmpty) {
          return const Center(child: Text("No articles found"));
        }

        return ListView.builder(
          itemCount: cubit.articles.length,
          itemBuilder: (context, index) {
            Articles article = cubit.articles[index];
            return InkWell(
              onTap: () {
                // Navigate to description with the tapped article's details
                navToDescription(article.title, article.url);
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
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
                        child: Image.network(article.urlToImage),
                      ),
                      Text(article.author.isEmpty ? "Unknown Author" : article.author),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                        child: Text(
                          article.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
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
