import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pod_player/pod_player.dart';
import '../../../../../app/blocs/film/film_bloc.dart';
import '../../../../../app/models/film.dart';
import '../../../../widgets/widgets.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({
    super.key,
    required this.heroTag,
    required this.film,
  });
  final Object heroTag;
  final Film film;
  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(
        widget.film.video ?? 'https://www.youtube.com/watch?v=p29JUpsOSTE',
      ),
      // playVideoFrom: PlayVideoFrom.network(
      //   'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
      // ),
    )..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.film.title!),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Hero(
            tag: widget.heroTag,
            child: PodVideoPlayer(controller: controller),
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.film.description!,
                      style: GoogleFonts.plusJakartaSans(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'More Like This',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 300,
                child: BlocBuilder<FilmBloc, FilmState>(
                  bloc: context.read<FilmBloc>()
                    ..add(
                      LoadFilm(field: "title", isNotEqualTo: widget.film.title),
                    ),
                  builder: (context, state) {
                    if (state is FilmLoaded) {
                      return ListView.builder(
                        shrinkWrap: true,
                        primary: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.films
                            .where((film) => film.isRecomended)
                            .length,
                        itemBuilder: (context, index) {
                          return MoreLikeThisCardWidget(
                            tag: '<banner-video-1> ${state.films[index].title}',
                            films: state.films
                                .where((film) => film.isRecomended)
                                .toList(),
                            index: index,
                          );
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }
}


// 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Quod alias veniam magni dicta minus aut, fugit nam labore pariatur ut iusto possimus voluptatem placeat sit sapiente! Quas.'
