import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prima_studio/app/cubits/auth/auth_cubit.dart';
import 'package:prima_studio/ui/widgets/text_field_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: '');
    TextEditingController emailController = TextEditingController(text: '');
    TextEditingController passwordController = TextEditingController(text: '');
    final formKey = GlobalKey<FormState>();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
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
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    controller: emailController,
                    onChanged: (email) {},
                    label: const Text('Email'),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                              .hasMatch(value)) {
                        return "Enter correct email";
                      } else {
                        return emailController.text;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    controller: passwordController,
                    onChanged: (password) {},
                    label: const Text('Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "must enter your password";
                      } else {
                        return passwordController.text;
                      }
                    },
                  ),
                  const SizedBox(height: 50),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/menu',
                          (route) => false,
                        );
                      } else if (state is AuthFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red[200],
                            content: Text(state.error),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            const snackBar =
                                SnackBar(content: Text('Submitting form'));
                            scaffoldKey.currentState!
                                .showBottomSheet((context) => snackBar);
                          } else {
                            context.read<AuthCubit>().signUp(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text('Register'),
                        )),
                      );
                    },
                  ),
                  const SizedBox(height: 35),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/menu',
                          (route) => false,
                        );
                      } else if (state is AuthFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red[200],
                            content: Text(state.error),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthGoogleLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          context.read<AuthCubit>().signInWithGoogle();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.orange,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Text('Sign In with Google'),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
