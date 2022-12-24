import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prima_studio/app/blocs/blocs.dart';
import 'package:prima_studio/config/routing/arguments/arguments.dart';
import 'package:prima_studio/ui/widgets/search_field_widget.dart';
import 'dart:math';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(
          const SearchFilm(title: ''),
        );
  }

  final searchController = TextEditingController();
  bool isCheck = false;
  List filter = ['All Film', 'Drama', 'Fantasi', 'Romance', 'Horor'];

  List check = [true, false, false, false, false];
  @override
  Widget build(BuildContext context) {
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
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                foregroundColor: Theme.of(context).primaryColor,
                bottom: AppBar(
                  elevation: 0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  toolbarHeight: 70,
                  title: Container(
                    width: double.infinity,
                    height: 40,
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          child: SearchFieldWidget(
                            searchController: searchController,
                            onSubmitted: (value) {
                              context.read<SearchBloc>().add(
                                    SearchFilm(title: searchController.text),
                                  );
                            },
                            onChanged: (value) {
                              if (value == '') {
                                context.read<SearchBloc>().add(
                                      SearchFilm(title: value),
                                    );
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 5),
                        FloatingActionButton(
                          heroTag: '<fab-banner-search>',
                          onPressed: () {
                            context.read<SearchBloc>().add(
                                  SearchFilm(title: searchController.text),
                                );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
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
                        showCheckmark: false,
                        onPressed: () {
                          setState(() {
                            // check[index] = !check[index];
                            check[index] = true;
                            check.setRange(
                              0,
                              check.length,
                              [false],
                              index,
                            );
                          });
                        },
                        label: Text(
                          filter[index],
                          style: GoogleFonts.plusJakartaSans(
                            color: Theme.of(context).primaryColor,
                            fontWeight: check[index]
                                ? FontWeight.w800
                                : FontWeight.w600,
                          ),
                        ),
                        selected: check[index],
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
  return BlocBuilder<SearchBloc, SearchState>(
    buildWhen: (previous, current) => current is SearchLoaded,
    builder: (context, state) {
      if (state is SearchLoading) {
        return const Padding(
          padding: EdgeInsets.only(top: 100),
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          ),
        );
      } else if (state is SearchLoaded) {
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
                borderRadius: BorderRadius.circular(12),
                child: Hero(
                  tag: '<banner-search> ${state.films[index].title}',
                  child: CachedNetworkImage(
                    imageUrl: state.films[index].thumbnail!,
                    height: Random().nextInt(270 - 200) + 200,
                    fit: BoxFit.cover,
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
        return Container();
      }
    },
  );
}
