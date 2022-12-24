import 'package:flutter/material.dart';
import '../../../../../app/models/models.dart';
import '../../../../widgets/widgets.dart';

class AllPage extends StatelessWidget {
  const AllPage({super.key, required this.film, this.isComingSoon = false});
  final bool isComingSoon;
  final List<Film> film;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              snap: true,
              pinned: true,
              elevation: 2,
              floating: true,
              centerTitle: true,
              title: isComingSoon
                  ? const Text('Coming Soon')
                  : const Text('Latest'),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Theme.of(context).primaryColor,
            ),
          ];
        },
        body: ListView.builder(
          itemCount: film
              .where(
                (film) => isComingSoon ? film.isComingSoon : film.isLatest,
              )
              .length,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemBuilder: (context, index) {
            return LongMovieCardWidget(
              film: film
                  .where((film) =>
                      isComingSoon ? film.isComingSoon : film.isLatest)
                  .toList(),
              index: index,
            );
          },
        ),
      ),
    );
  }
}
