/*
 * article_list_bloc
 * Create by Harrison.Fu on 2023/10/12-11:16
 */

import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../data/article.dart';
import '../data/rw_client.dart';
import 'bloc.dart';

class ArticleListBloc implements Bloc {
  // 1
  final _client = RWClient();
  // 2
  final _searchQueryController = StreamController<String?>();
  // 3
  Sink<String?> get searchQuery => _searchQueryController.sink;
  // 4
  late Stream<List<Article>?> articlesStream;

  // ArticleListBloc() {
  //   // 5
  //   articlesStream = _searchQueryController.stream
  //       .asyncMap((query) => _client.fetchArticles(query));
  // }

  ArticleListBloc() {
    articlesStream = _searchQueryController.stream
        .startWith(null) // 1
        .debounceTime(const Duration(milliseconds: 100)) // 2
        .switchMap( // 3
          (query) => _client.fetchArticles(query)
          .asStream() // 4
          .startWith(null), // 5
    );
  }


  // 6
  @override
  void dispose() {
    _searchQueryController.close();
  }
}
