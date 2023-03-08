import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prima_studio/app/blocs/profile/profile_bloc.dart';
import 'package:prima_studio/config/routing/arguments/profile/account_setting_args.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../app/cubits/cubits.dart';
import '../../../../app/repositories/apperance/theme_repo.dart';
import '../../../widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore user = FirebaseFirestore.instance;
  final Uri whatsapp = Uri.parse(
    Uri.encodeFull("whatsapp://send?phone=6285697837912"),
  );

  // ignore: no_leading_underscores_for_local_identifiers
  Future<void> _launchUrl() async {
    if (!await launchUrl(whatsapp)) {
      throw 'Could not launch $whatsapp';
    }
  }

  bool apperanceValue = ThemeRepository.getThemeSettings();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Profile',
                style: GoogleFonts.plusJakartaSans(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Theme.of(context).primaryColor,
            ),
          ];
        },
        body: BlocBuilder<ProfileBloc, ProfileState>(
          buildWhen: (previous, current) => current is ProfileLoaded,
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            } else if (state is ProfileLoaded) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileSectionWidget(avatar: state.user.avatar),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.plusJakartaSans(
                              color: Theme.of(context).primaryColor,
                            ),
                            children: [
                              TextSpan(
                                text: '${state.user.name}\n',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '${state.user.description}\n',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(
                              '/profile-account',
                              arguments:
                                  AccountSettingArguments(user: state.user),
                            );
                          },
                          child: ListTile(
                            tileColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Theme.of(context).highlightColor,
                              child: const Icon(
                                CupertinoIcons.profile_circled,
                                size: 35,
                              ),
                            ),
                            title: const Text('Account'),
                            subtitle: const Text('Manage your account'),
                          ),
                        ),
                      ),
                      const Divider(thickness: 2),
                      Card(
                        elevation: 0,
                        child: InkWell(
                          onTap: _launchUrl,
                          child: ListTile(
                            tileColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Theme.of(context).highlightColor,
                              child: const Icon(
                                CupertinoIcons.ellipses_bubble,
                                size: 35,
                              ),
                            ),
                            title: const Text('Admin Chat'),
                            subtitle: const Text('Use our services'),
                          ),
                        ),
                      ),
                      // ! MASIH MASA DEVELOP
                      // const Divider(thickness: 2),
                      // Card(
                      //   elevation: 0,
                      //   child: InkWell(
                      //     onTap: () {},
                      //     child: const ListTile(
                      //       leading: CircleAvatar(
                      //         backgroundColor: Colors.white,
                      //         foregroundColor: Colors.black,
                      //         child: Icon(
                      //           CupertinoIcons.bell,
                      //           size: 35,
                      //           color: Colors.black87,
                      //         ),
                      //       ),
                      //       title: Text('Notification'),
                      //       subtitle: Text('Set your notifications'),
                      //     ),
                      //   ),
                      // ),
                      const Divider(thickness: 2),
                      Card(
                        elevation: 0,
                        child: SwitchListTile(
                          tileColor: Theme.of(context).scaffoldBackgroundColor,
                          activeColor: Theme.of(context).primaryColor,
                          secondary: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Theme.of(context).highlightColor,
                            child: Icon(
                              apperanceValue
                                  ? CupertinoIcons.brightness
                                  : Icons.mode_night_outlined,
                              size: 35,
                            ),
                          ),
                          title: apperanceValue
                              ? const Text('Light Mode')
                              : const Text('Dark Mode'),
                          subtitle: const Text('Change theme app'),
                          value: apperanceValue,
                          onChanged: (value) {
                            setState(() {
                              ThemeRepository.putThemeSettings(value);
                              apperanceValue =
                                  ThemeRepository.getThemeSettings();
                            });
                            final cubit = context.read<ThemeCubit>();
                            cubit.toggleTheme(apperanceValue);
                          },
                        ),
                      ),
                      const Divider(thickness: 2),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamedAndRemoveUntil(
                                  '/auth-login', (route) => false);
                          context.read<AuthCubit>().signOut();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          minimumSize: const Size(double.infinity, 25),
                        ),
                        child: const Text('Sign Out'),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          },
        ),
      ),
    );
  }
}
