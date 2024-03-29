import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/components/progress.dart';
import 'package:news/models/comment.dart';
import 'package:news/models/news.dart';
import 'package:news/repositories/news.dart';
import 'package:news/screens/news/components/comments/card.dart';
import 'package:news/screens/news/components/comments/list.dart';

class DetailNews extends StatefulWidget {
  final int _newsId;
  DetailNews(this._newsId);

  @override
  _DetailNewsState createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  final NewsRepository repository = NewsRepository();

  News _news;

  @override
  void initState() {
    super.initState();
  }

  Future<News> _getNews() async {
    return repository.getNews(widget._newsId).then((news) {
      return news;
    });
  }

  Future<void> likeNews(BuildContext context) async{
    return repository.markAsLiked(widget._newsId).then((value){
      showLikedNotificationSnackBar(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () => likeNews(context),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              child: Icon(Icons.favorite, color: Colors.red,),
            ),
          )
        ],
      ),
      body: FutureBuilder<News>(
        future: _getNews(),
        builder: (context, snapshot) {
          final News news = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("No connection");
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
            case ConnectionState.done:
              this._news = news;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        _news.title,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 0.0,
                        ),
                        child: Text(
                          _news.subtitle,
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 0.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _news.author,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 0.0),
                                  child: Column(
                                    children: [
                                      Icon(Icons.comment_outlined),
                                      Text(_news.numComments.toString()),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 0.0),
                                  child: Column(
                                    children: [
                                      Icon(Icons.favorite_border_outlined),
                                      Text(_news.likes.toString())
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black54,
                      ),
                      Text(
                        _news.text,
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 0.0,
                        ),
                        child: Divider(
                          color: Colors.black54,
                        ),
                      ),
                      CommentList(news)
                    ],
                  ),
                ),
              );
              break;
          }
          return Text('Unknown Error');
        },
      ),
    );
  }

  void showLikedNotificationSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Você curtiu essa notícia!'),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
