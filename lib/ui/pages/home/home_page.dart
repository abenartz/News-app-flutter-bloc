import 'dart:developer';

import 'package:dispatcher/repository/articles_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/home/home_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../enums/nav_bar_item.dart';
import '../../widgets/article_card.dart';
import '../../widgets/main_app_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() =>  HomaPageState();
}

class HomaPageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  final _scrollController = ScrollController();

  HomaPageState() {
    log("HomaPageState: init..");
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MainAppBar(
          title: NavbarItem.home.title,
          bgColor: AppColors.appBackground
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
          if (state is ArticlesLoaded) {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.articles.length,
              itemBuilder: (context, position) {
                return ArticleCard(article: state.articles[position]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 16);
              },
              controller: _scrollController,
            );
          }
          return const SpinKitWave(color: AppColors.appBackground,);
        },
      );
  }

  void _onScroll() {
    final fetchingTh = 0.9 * _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= fetchingTh) {
      log("HomePage: End of scroll..");
    }
  }

  @override
  bool get wantKeepAlive => true;

}


