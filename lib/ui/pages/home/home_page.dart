import 'package:dispatcher/constants/constants.dart';
import 'package:dispatcher/repository/articles_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/home/home_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../enums/nav_bar_item.dart';
import '../../widgets/article_card.dart';
import '../../widgets/main_app_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocProvider(
        create: (context) => HomeBloc(),
        child: Scaffold(
          appBar: MainAppBar(
              title: NavbarItem.home.title,
              bgColor: AppColors.appBackground
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              debugPrint("home_page: state = $state");
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
                );
              }
              return const SpinKitWave(color: AppColors.appBackground,);
            },
          ),
        ),
      );

}


