import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSectionWidget extends StatelessWidget {
  const ProfileSectionWidget({
    Key? key,
    this.avatar,
  }) : super(key: key);

  final String? avatar;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 165,
        child: Stack(
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Scaffold(
                      extendBody: true,
                      extendBodyBehindAppBar: true,
                      backgroundColor: Colors.black,
                      appBar: AppBar(
                        iconTheme: const IconThemeData(color: Colors.white),
                        backgroundColor: Colors.transparent,
                        title: Text(
                          'Photo profile',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                          ),
                        ),
                        actions: [
                          IconButton(
                            onPressed: () {
                              _showModalBottomSheet(context);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.share),
                          ),
                        ],
                      ),
                      body: Hero(
                        tag: avatar!,
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
                                avatar!,
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
                },
                child: Hero(
                  tag: avatar!,
                  child: Container(
                    height: 121,
                    width: 121,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: NetworkImage(avatar!),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // right: -75,
              // left: 0,
              // bottom: 16,
              right: 110,
              bottom: 16,
              child: FloatingActionButton.small(
                onPressed: () {
                  _showModalBottomSheet(context);
                },
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                foregroundColor: Theme.of(context).primaryColor,
                clipBehavior: Clip.hardEdge,
                child: const Icon(Icons.linked_camera_outlined),
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
        maxHeight: 195,
      ),
      useRootNavigator: true,
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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Photo profile',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Column(
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          foregroundColor: Theme.of(context).primaryColor,
                          child: const Icon(CupertinoIcons.camera),
                        ),
                        const SizedBox(height: 10),
                        const Text('Camera'),
                      ],
                    ),
                    const SizedBox(width: 50),
                    Column(
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          foregroundColor: Theme.of(context).primaryColor,
                          child: const Icon(Icons.add_photo_alternate_outlined),
                        ),
                        const SizedBox(height: 10),
                        const Text('Gallery'),
                      ],
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
