import 'package:flutter/material.dart';
import 'package:prima_studio/app/models/film.dart';

import '../../config/routing/arguments/arguments.dart';

class MoreLikeThisCardWidget extends StatelessWidget {
  const MoreLikeThisCardWidget({
    Key? key,
    required this.tag,
    required this.films,
    required this.index,
  }) : super(key: key);
  final String tag;
  final List<Film> films;
  final int index;
  @override
  Widget build(BuildContext context) {
    // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    // 'https://media.gettyimages.com/id/458467163/photo/the-first-avenger-movie-poster.jpg?s=612x612&w=gi&k=20&c=Fc9E7HSJmEiviWNqmLsoXGgwOdpN8fv3qZ0fem6__rM='
    // https://i.pinimg.com/564x/79/a2/ae/79a2aee7312bad1619af1fe967ee0680.jpg
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/film-detail',
          arguments: FilmDetailArguments(
            bannerTag: tag,
            film: films[index],
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: 200,
        decoration: const BoxDecoration(
          color: Colors.grey,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Hero(
              tag: tag,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(
                      films[index].thumbnail!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              color: const Color.fromARGB(61, 255, 255, 255),
            ),
          ],
        ),
      ),
    );
  }
}



// Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
//           // MaterialPageRoute(
//           //   builder: (context) => const MenuPage(),
//           // ),
//           PageRouteBuilder(
//             transitionDuration: const Duration(milliseconds: 900),
//             pageBuilder: (_, __, ___) => DetailPage(
//               tag: tag,
//             ),
//           ),
//           (route) => false,
//         );