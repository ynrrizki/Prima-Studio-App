import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prima_studio/app/models/film.dart';
import 'package:prima_studio/config/routing/arguments/arguments.dart';

class LongMovieCardWidget extends StatelessWidget {
  const LongMovieCardWidget({
    Key? key,
    required this.film,
    // required this.tag,
    required this.index,
  }) : super(key: key);
  final List<Film> film;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            '/film-detail',
            arguments: FilmDetailArguments(
              bannerTag: '<banner-all> ${film[index].title}',
              fabTag: '<fab-banner-all> ${film[index].title}',
              film: film[index],
            ),
          );
        },
        child: Row(
          children: [
            Hero(
              tag: '<banner-all> ${film[index].title}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: CachedNetworkImage(
                    imageUrl: film[index].thumbnail!,
                    fit: BoxFit.fitHeight,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      film[index].title!,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      film[index].genre!,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      film[index].description!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: GoogleFonts.plusJakartaSans(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/film-video',
                        arguments: FilmVideoArguments(
                          bannerTag: '<banner-all> ${film[index].title}',
                          film: film[index],
                        ),
                      );
                    },
                    heroTag: '<fab-banner-all> ${film[index].title}',
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(Icons.play_arrow),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class LongMovieCardWidget extends StatelessWidget {
//   const LongMovieCardWidget({
//     Key? key,
//     required this.film,
//     // required this.tag,
//     required this.index,
//   }) : super(key: key);
//   final List<Film> film;
//   // final Object tag;
//   final int index;
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(5),
//       ),
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       elevation: 1.5,
//       child: SizedBox(
//         height: 120,
//         child: InkWell(
//           onTap: () {
//             // print('<banner-all> ${film[index].title}');
//             Navigator.of(context).pushNamed(
//               '/film-detail',
//               arguments: FilmDetailArguments(
//                 bannerTag: '<banner> ${film[index].title}',
//                 title: film[index].title,
//                 genre: film[index].genre,
//                 description: film[index].description,
//                 thumbnail: film[index].thumbnail,
//                 isComingSoon: film[index].isComingSoon,
//               ),
//             );
//           },
//           child: Row(
//             children: [
//               Hero(
//                 tag: '<banner> ${film[index].title}',
//                 child: Container(
//                   width: 90,
//                   height: double.infinity,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: NetworkImage(film[index].thumbnail),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//               // Image.network(film[index].thumbnail),
//               Expanded(
//                 child: Stack(
//                   children: [
//                     SizedBox(
//                       width: double.infinity,
//                       child: film[index].thumbnail != null
//                           ? Ink.image(
//                               image: NetworkImage(film[index].thumbnail),
//                               fit: BoxFit.cover,
//                             )
//                           : null,
//                     ),
//                     Row(
//                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // Image.asset(film[index].thumbnail!,
//                         //     fit: BoxFit.cover, width: 100, height: 120),
//                         Expanded(
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             decoration: const BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Color.fromARGB(143, 255, 255, 255),
//                                   Color.fromARGB(223, 255, 255, 255),
//                                 ],
//                                 stops: [0.2, 0.2],
//                                 // begin: FractionalOffset.topCenter,
//                                 // end: FractionalOffset.bottomCenter,
//                               ),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const SizedBox(height: 15),
//                                 Text(
//                                   film[index].title,
//                                   style: GoogleFonts.plusJakartaSans(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black87),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   film[index].genre,
//                                   style: GoogleFonts.plusJakartaSans(
//                                     fontSize: 16,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(width: 20),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
