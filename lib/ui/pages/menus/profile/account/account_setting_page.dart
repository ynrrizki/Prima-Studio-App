import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prima_studio/app/blocs/blocs.dart';
import 'package:prima_studio/app/models/models.dart';
import '../../../../widgets/widgets.dart';

class AccountSettingPage extends StatefulWidget {
  final User user;
  const AccountSettingPage({super.key, required this.user});

  @override
  State<AccountSettingPage> createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

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
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Theme.of(context).primaryColor,
            ),
          ];
        },
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            } else if (state is ProfileLoaded) {
              nameController.text = state.user.name;
              descriptionController.text = state.user.description;
              return ListView(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
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
                  TextFieldWidget(
                    controller: nameController,
                    onChanged: (name) {},
                    label: const Text('Full Name'),
                    autofocus: true,
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                        return "Enter correct name";
                      } else {
                        return nameController.text;
                      }
                    },
                  ),
                  const Divider(thickness: 2),
                  TextFieldWidget(
                    controller: descriptionController,
                    onChanged: (name) {},
                    label: const Text('Description'),
                  ),
                  const Divider(thickness: 2),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProfileBloc>().add(
                            EditProfile(
                              user: User(
                                id: state.user.id,
                                avatar: state.user.avatar,
                                name: nameController.text,
                                description: descriptionController.text,
                                email: state.user.email,
                              ),
                            ),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text('Save'),
                  ),
                ],
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
