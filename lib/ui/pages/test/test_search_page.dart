import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prima_studio/app/blocs/blocs.dart';
import 'package:prima_studio/app/models/models.dart';
import 'package:prima_studio/config/routing/arguments/arguments.dart';
import 'package:prima_studio/ui/widgets/search_field_widget.dart';

class TestSearchPage extends StatefulWidget {
  const TestSearchPage({super.key});

  @override
  State<TestSearchPage> createState() => _TestSearchPageState();
}

class _TestSearchPageState extends State<TestSearchPage> {
  bool isCheck = false;
  List filter = [
    'All Film',
    'Drama',
    'Fantasi',
    'Romance',
  ];

  List check = [
    true,
    false,
    false,
    false,
  ];
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                snap: true,
                pinned: true,
                elevation: 2,
                floating: true,
                centerTitle: true,
                title: Text(
                  'Search Film',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                bottom: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  toolbarHeight: 70,
                  title: Container(
                    width: double.infinity,
                    height: 40,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          child: SearchFieldWidget(
                            searchController: searchController,
                          ),
                        ),
                        const SizedBox(width: 5),
                        FloatingActionButton(
                          heroTag: '<fab-banner-search>',
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: Colors.orange,
                          child: const Icon(CupertinoIcons.search),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: ListView(
            children: [
              SizedBox(
                width: double.infinity,
                height: 35,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filter.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 9),
                      child: InputChip(
                        onPressed: () {
                          setState(() {
                            check[index] = !check[index];
                          });
                        },
                        label: Text(
                          filter[index],
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.orange,
                            fontWeight: check[index]
                                ? FontWeight.w800
                                : FontWeight.w600,
                          ),
                        ),
                        disabledColor: Colors.white,
                        selected: check[index],
                        selectedColor: const Color.fromARGB(29, 255, 153, 0),
                        checkmarkColor: Colors.orange,
                        surfaceTintColor: Colors.orange,
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: Colors.orange,
                        ),
                      ),
                    );
                  },
                ),
              ),
              courseLayout(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget courseLayout(BuildContext context) {
  return BlocBuilder<FilmBloc, FilmState>(
    builder: (context, state) {
      if (state is FilmLoaded) {
        return MasonryGridView.count(
          padding:
              const EdgeInsets.only(top: 27, bottom: 100, left: 16, right: 16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 27,
          crossAxisSpacing: 23,
          itemCount: state.films.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pushNamed(
                    '/film-detail',
                    arguments: FilmDetailArguments(
                      fabTag: '<fab-banner-search>',
                      bannerTag: '<banner-search> ${state.films[index].title}',
                      film: state.films[index],
                    ),
                  );
                },
                child: Hero(
                  tag: '<banner-search> ${state.films[index].title}',
                  child: CachedNetworkImage(
                    imageUrl: state.films[index].thumbnail!,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const SizedBox(
                      height: 100,
                      child: Center(
                        child: Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      } else {
        return MasonryGridView.count(
          padding:
              const EdgeInsets.only(top: 15, bottom: 100, left: 16, right: 16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 27,
          crossAxisSpacing: 23,
          itemCount: Film.films.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(Film.films[index].thumbnail!),
            );
          },
        );
      }
    },
  );
}
