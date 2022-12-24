import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prima_studio/app/blocs/film/film_bloc.dart';
import 'package:prima_studio/app/models/film.dart';
import 'package:prima_studio/config/routing/arguments/arguments.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _indexCarousel = 0;
  List<Film> films = Film.films;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        BlocBuilder<FilmBloc, FilmState>(
          bloc: context.read<FilmBloc>()..add(const LoadFilm()),
          buildWhen: (previous, current) {
            return current is FilmLoaded;
          },
          builder: (context, state) {
            if (state is FilmLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FilmLoaded) {
              return CarouselSlider(
                items: state.films
                    .where((film) => film.isRecomended)
                    .map((film) => HeroCarouselCard(
                        film: film, indexCarousel: _indexCarousel))
                    .toList(),
                options: CarouselOptions(
                  height: 230,
                  aspectRatio: 4 / 3,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _indexCarousel = index;
                    });
                  },
                ),
              );
            } else {
              return const Text('Something went wrong.');
            }
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class HeroCarouselCard extends StatelessWidget {
  const HeroCarouselCard({
    super.key,
    required this.film,
    required this.indexCarousel,
  });

  final Film film;
  final int indexCarousel;

  @override
  Widget build(BuildContext context) {
    // List<T> map<T>(List list, Function handler) {
    //   List<T> result = [];
    //   for (var i = 0; i < list.length; i++) {
    //     result.add(handler(i, list[i]));
    //   }
    //   return result;
    // }

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true).pushNamed(
              '/film-detail',
              arguments: FilmDetailArguments(
                // tag: '$indexCarousel-detailPage-banner',
                bannerTag: '<banner> ${film.title}',
                fabTag: '<fab-banner> ${film.title}',
                film: film,
                // title: film.title,
                // genre: film.genre,
                // description: film.description,
                // thumbnail: film.thumbnail,
              ),
            );
          },
          child: HeroMode(
            enabled: true,
            child: Hero(
              // tag: '$indexCarousel-detailPage-banner',
              tag: '<banner> ${film.title}',
              // tag: DetailPage,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: film.thumbnail!.isEmpty
                        ? null
                        : DecorationImage(
                            image: CachedNetworkImageProvider(film.thumbnail!),
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.linearToSrgbGamma(),
                          ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: film.thumbnail!,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Align(
        //   alignment: Alignment.bottomLeft,
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 30),
        //     child: BlocBuilder<FilmBloc, FilmState>(
        //       builder: (context, state) {
        //         if (state is FilmLoading) {
        //           return Row();
        //         }
        //         if (state is FilmLoaded) {
        //           return Row(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             children: map<Widget>(
        //                 state.films.where((film) => film.isRecomended).toList(),
        //                 (index, url) {
        //               return Container(
        //                 width: indexCarousel == index ? 27.5 : 8.5,
        //                 height: 4,
        //                 margin: const EdgeInsets.symmetric(
        //                   vertical: 10.0,
        //                   horizontal: 2.0,
        //                 ),
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(5),
        //                   color: indexCarousel == index
        //                       ? const Color(0xffEF8A23)
        //                       : Colors.white,
        //                 ),
        //               );
        //             }),
        //           );
        //         }
        //         return Row();
        //       },
        //     ),
        //   ),
        // ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 30, bottom: 15),
            child: FloatingActionButton(
              heroTag: '<fab-banner> ${film.title}',
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                  '/film-video',
                  arguments: FilmVideoArguments(
                    bannerTag: '<banner> ${film.title}',
                    film: film,
                  ),
                );
              },
              child: const Icon(Icons.play_arrow),
            ),
          ),
        ),
      ],
    );
  }
}
