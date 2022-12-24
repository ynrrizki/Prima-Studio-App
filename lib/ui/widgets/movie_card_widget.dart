import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prima_studio/app/models/film.dart';

import '../../config/routing/arguments/arguments.dart';

class MovieCardWidget extends StatelessWidget {
  const MovieCardWidget({
    Key? key,
    required this.film,
    required this.tag,
    this.isComingSoon = false,
    required this.index,
  }) : super(key: key);

  final List<Film> film;
  final Object tag;
  final bool isComingSoon;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: true).pushNamed(
            '/film-detail',
            arguments: FilmDetailArguments(
              bannerTag: '<banner-mc> ${film[index].title}',
              fabTag: '<fab-banner> ${film[index].title}',
              isComingSoon: isComingSoon,
              film: film[index],
              // title: film[index].title,
              // genre: film[index].genre,
              // description: film[index].description,
              // thumbnail: film[index].thumbnail,
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: '<banner-mc> ${film[index].title}',
              child: Material(
                type: MaterialType.transparency,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 200,
                    height: 190,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: film[index].thumbnail!,
                      fit: BoxFit.fitWidth,
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
            const SizedBox(
              height: 6,
            ),
            Text(
              // 'Title',
              film[index].title!,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              // 'Genre',
              film[index].genre!,
              style: GoogleFonts.plusJakartaSans(),
            ),
          ],
        ),
      ),
    );
  }
}
