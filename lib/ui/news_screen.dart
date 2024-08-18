import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:news_application/colors.dart';
import 'package:news_application/model/news_response.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key, required this.category});

  final String category;
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  List<Articles> articles=[];
  @override
  void initState() {
    super.initState();
    getNewsByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index){
            Articles article= articles[index];
        return  Container(

          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                article.urlToImage.isEmpty?
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.image_not_supported_outlined,size: 60,),
                    ):
                ClipRRect(borderRadius:BorderRadius.circular(10) ,child: Image.network(article.urlToImage)),
                Text(article.author),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
                  child: Text(article.title),
                ),
          
              ],
            ),
          ),
        );
      });


  }
  void getNewsByCategory(String category) async{
    final response = await Dio().get(
        "https://newsapi.org/v2/top-headlines",
        queryParameters:{
          "country":"us",
          "category":category,
          "apiKey":"2ed58f61455141cf8f8e60b3582dc5fb",

        }
    );
    final newsResponse =NewsResponse.fromJson(response.data);
    articles = newsResponse.articles;
    setState(() {});
  }
}

