import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/blocs/blocs.dart';
import '../../../../../app/models/film.dart';
import '../../../../../ui/widgets/expandable_fab.dart';
import '../../../../../config/routing/arguments/arguments.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  DetailPage({
    super.key,
    required this.heroTag,
    this.fabTag,
    this.isComingSoon = false,
    required this.film,
  });

  final Object heroTag;
  Object? fabTag;
  final bool isComingSoon;
  final Film film;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  dynamic ratingUser = 0.0;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // var rating =
    //     widget.film.starRating.entries.map((m) => m.value['rating']).toList() ??
    //         0;
    // dynamic rateAvg = rating;
    // rateAvg = context.read<RatingCubit>().getAvgRating(rateAvg);
    // double average = 0.0;
    // var sum = rating.fold(0, (p, c) => p + c);
    // if (sum > 0) {
    //   average = sum / rating.length;
    // }
    // double rateAvg = average;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      floatingActionButton: ExpandableFab(
        // ignore: unnecessary_null_in_if_null_operators
        heroTag: widget.fabTag ?? null,
        distance: 63,
        children: [
          ActionButton(
            onPressed: () {
              return _showModalBottomSheet(context);
            },
            icon: const Icon(Icons.add_reaction),
          ),
          ActionButton(
            onPressed: () => Navigator.of(context).pushNamed(
              '/film-video',
              arguments: FilmVideoArguments(
                bannerTag: widget.heroTag,
                film: widget.film,
              ),
            ),
            icon: const Icon(Icons.play_arrow),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: FloatingActionButton(
            heroTag: null,
            mini: true,
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).primaryColor,
            elevation: 1,
            highlightElevation: 2,
            child: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.heroTag,
              child: Padding(
                padding: const EdgeInsets.only(left: 45),
                child: GestureDetector(
                  onVerticalDragDown: (value) {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Scaffold(
                            extendBody: true,
                            extendBodyBehindAppBar: true,
                            backgroundColor: Colors.black,
                            appBar: AppBar(
                              iconTheme:
                                  const IconThemeData(color: Colors.white),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.transparent,
                              title: Text(widget.film.title!),
                            ),
                            body: Hero(
                              tag: widget.heroTag,
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 15,
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      widget.film.thumbnail!,
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ));
                  },
                  child: Container(
                    height: 500,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 15,
                        ),
                      ],
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          widget.film.thumbnail!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45, right: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    widget.film.title!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.film.genre!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 23,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      foregroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      _showModalBottomSheet(context);
                    },
                    child: BlocBuilder<FilmBloc, FilmState>(
                      bloc: context.read<FilmBloc>()
                        ..add(LoadRating(film: widget.film)),
                      buildWhen: (previous, current) => current is RatingLoaded,
                      builder: (context, state) {
                        if (state is RatingLoading) {
                          return CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          );
                        } else if (state is RatingLoaded) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RatingBar(
                                allowHalfRating: true,
                                itemSize: 24,
                                ignoreGestures: true,
                                ratingWidget: RatingWidget(
                                  full: Icon(
                                    Icons.star,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  half: Icon(
                                    Icons.star_half,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  empty: Icon(
                                    Icons.star_border,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                initialRating: state.rating,
                                onRatingUpdate: (value) {},
                              ),
                              const SizedBox(height: 15),
                              state.rating == 0.0
                                  ? const Text('Not yet Rating')
                                  : Text(
                                      'Rate ${num.parse(state.rating.toStringAsExponential(3))}'),
                            ],
                          );
                        } else {
                          return const Text('Not yet Rating');
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 40, bottom: 90),
                    child: Text(
                      widget.film.description!,
                      style: GoogleFonts.plusJakartaSans(
                        height: 1.8,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModalBottomSheet(context) {
    showModalBottomSheet(
      constraints: const BoxConstraints(
        maxHeight: 275,
      ),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Text(
                  widget.film.title!,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Rate this Movie',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                BlocBuilder<FilmBloc, FilmState>(
                  bloc: context.read<FilmBloc>()
                    ..add(LoadRatingByUser(film: widget.film)),
                  buildWhen: (previous, current) =>
                      current is RatingByUserLoaded,
                  builder: (context, state) {
                    if (state is RatingByUserLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is RatingByUserLoaded) {
                      ratingUser = state.rating;
                      return RatingBar(
                        allowHalfRating: true,
                        itemSize: 35,
                        glow: false,
                        ratingWidget: RatingWidget(
                          full: Icon(
                            Icons.star,
                            color: Theme.of(context).primaryColor,
                          ),
                          half: Icon(
                            Icons.star_half,
                            color: Theme.of(context).primaryColor,
                          ),
                          empty: const Icon(
                            Icons.star_border,
                            color: Colors.grey,
                          ),
                        ),
                        // initialRating: double.parse(ratingUser.toString()),
                        initialRating: state.rating,
                        onRatingUpdate: (value) {
                          context.read<FilmBloc>().add(
                                AddRating(film: widget.film, value: value),
                              );
                        },
                      );
                    } else {
                      return const Text('Something went wrong.');
                    }
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }
}
