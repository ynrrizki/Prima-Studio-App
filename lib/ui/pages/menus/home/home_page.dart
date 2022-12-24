import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/blocs/blocs.dart';
import '../../../../app/models/models.dart';
import '../../../../config/routing/arguments/arguments.dart';
import '../../../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              snap: true,
              pinned: true,
              elevation: 2,
              floating: true,
              centerTitle: true,
              title: GestureDetector(
                onTap: () => scrollController.animateTo(
                    scrollController.position.minScrollExtent,
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    curve: Curves.ease),
                child: const PrimaStudio(fontSize: 20),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Theme.of(context).primaryColor,
            ),
          ];
        },
        body: ListView(
          padding: const EdgeInsets.only(
            bottom: 100,
          ),
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: BannerWidget(),
            ),
            // false ? const SizedBox(height: 25) : Container(),
            // false ? _categoryCardList(context, title: 'Latest') : Container(),
            // const SizedBox(height: 25),
            // _categoryCardList(
            //   context,
            //   title: 'Latest',
            //   isComingSoon: true,
            // ),
            // const SizedBox(height: 25),
            // const EventCardWidget(),
            const SizedBox(height: 25),
            _categoryCardList(
              context,
              title: 'Coming Soon',
              isComingSoon: true,
            ),
          ],
        ),
      ),
    );
  }
}

Column _categoryCardList(
  BuildContext context, {
  required String title,
  bool isComingSoon = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ),
            BlocBuilder<FilmBloc, FilmState>(
              buildWhen: (previous, current) {
                return current is FilmLoaded;
              },
              builder: (context, state) {
                return state is FilmLoaded
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pushNamed(
                            '/film-all',
                            arguments: FilmAllArguments(
                              film: state.films.where((film) {
                                if (!isComingSoon) {
                                  return film.isLatest;
                                } else {
                                  return film.isComingSoon;
                                }
                                // isComingSoon != true ? film.isLatest : isComingSoon,
                              }).toList(),
                              isComingSoon: isComingSoon,
                            ),
                          );
                        },
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pushNamed(
                            '/film-all',
                            arguments: FilmAllArguments(
                              film: [],
                              isComingSoon: isComingSoon,
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.orange,
                        ),
                      );
              },
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 100,
          maxHeight: 250,
        ),
        child: SizedBox(
          width: double.infinity,
          child: BlocBuilder<FilmBloc, FilmState>(
            buildWhen: (previous, current) {
              return current is FilmLoaded;
            },
            builder: (context, state) {
              if (state is FilmLoading) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: Film.films.where((film) {
                    if (!isComingSoon) {
                      return film.isLatest;
                    } else {
                      return film.isComingSoon;
                    }
                    // isComingSoon != true ? film.isLatest : isComingSoon;
                  }).length,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return MovieCardWidget(
                      film: Film.films.where((film) {
                        if (!isComingSoon) {
                          return film.isLatest;
                        } else {
                          return film.isComingSoon;
                        }
                        // isComingSoon != true ? film.isLatest : isComingSoon,
                      }).toList(),
                      tag: Film.films
                          .where((film) {
                            if (!isComingSoon) {
                              return film.isLatest;
                            } else {
                              return film.isComingSoon;
                            }
                            // isComingSoon != true ? film.isLatest : isComingSoon,
                          })
                          .map((film) => film.title)
                          .toList()
                          .toString(),
                      isComingSoon: isComingSoon,
                      index: index,
                    );
                  },
                );
              }
              if (state is FilmLoaded) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: state.films.where((film) {
                    if (!isComingSoon) {
                      return film.isLatest;
                    } else {
                      return film.isComingSoon;
                    }
                    // isComingSoon != true ? film.isLatest : isComingSoon;
                  }).length,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return MovieCardWidget(
                      film: state.films.where((film) {
                        if (!isComingSoon) {
                          return film.isLatest;
                        } else {
                          return film.isComingSoon;
                        }
                        // isComingSoon != true ? film.isLatest : isComingSoon,
                      }).toList(),
                      tag: state.films
                          .where((film) {
                            if (!isComingSoon) {
                              return film.isLatest;
                            } else {
                              return film.isComingSoon;
                            }
                            // isComingSoon != true ? film.isLatest : isComingSoon,
                          })
                          .map((film) => film.title)
                          .toList()
                          .toString(),
                      isComingSoon: isComingSoon,
                      index: index,
                    );
                  },
                );
              }
              return ListView();
            },
          ),
        ),
      ),
    ],
  );
}
