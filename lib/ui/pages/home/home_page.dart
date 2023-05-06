import 'dart:developer';

import 'package:dispatcher/model/article.dart';
import 'package:dispatcher/repository/articles_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/home/home_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../enums/nav_bar_item.dart';
import '../../widgets/article_card.dart';
import '../../widgets/app_bars/main_app_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../article_details/article_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() =>  HomaPageState();
}

class HomaPageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  final _scrollController = ScrollController();

  HomaPageState() {
    log("HomaPageState: init..");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      appBar: MainAppBar(
          title: NavbarItem.home.title
      ),
      body: _homeArticlesView(),
    );
  }

  Widget _homeArticlesView() {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          log("home_page: state = $state");
          if (state is HomeInitial) {
            context.read<HomeBloc>().add(FetchArticles());
          }
          else if (state is Loading) {
            return const SpinKitWave(color: AppColors.appBackground,);
          }
          else if (state is ArticlesLoaded) {
            log("home_page: ArticlesLoaded - ${state.articles.length} articles, isFetchingMore = ${state.isFetchingMore}");
            return getLArticlesListView(state.articles, state.isFetchingMore, context);
          }
          return const Text("Something went wrong!");
        },
      );
  }

  Widget getLArticlesListView(List<Article> articles, bool isFetchingMore, BuildContext context) {
    final itemCount = (isFetchingMore) ? articles.length+1 : articles.length;
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      itemBuilder: (context, position) {
        if (position >= articles.length) {
          return const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          );        }
        return InkWell(
          child: ArticleCard(article: articles[position]),
          onTap: () {
            log("getLArticlesListView: InkWell onTap()..");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticleDetailsPage(article: articles[position])
                )
            );
          }
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 16);
      },
      controller: _scrollController
        ..addListener(() {_onScroll(context);}),
    );
  }

  void _onScroll(BuildContext context) {
    final fetchingTh = 0.9 * _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= fetchingTh ) {
      context.read<HomeBloc>().add(FetchArticles());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }


  @override
  bool get wantKeepAlive => true;

}


