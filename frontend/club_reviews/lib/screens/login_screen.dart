// ignore_for_file: use_build_context_synchronously

import 'package:club_reviews/constants/routes.dart';
import 'package:club_reviews/services/auth/auth_exceptions.dart';
import 'package:club_reviews/services/auth/auth_service.dart';
import 'package:club_reviews/utilities/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void login() async {
    final email = _email.text;
    final password = _password.text;

    try {
      await AuthService.firebase().login(
        email: email,
        password: password,
      );

      final user = AuthService.firebase().currentUser;
      if (user?.isVerified ?? false) {
        // _cloudStorage = FirebaseCloudStorage();
        // _cloudStorage.sessionsPath = 'clubs/${user!.id}';
        // _cloudStorage.initialize(user: user);
        Navigator.of(context).pushNamedAndRemoveUntil(
          sessionsRoute,
          (_) => false,
        );
      } else {
        Navigator.of(context).pushNamed(verifyRoute);
      }
    } on UserNotFoundException catch (_) {
      await showErrorDialog(
        context: context,
        error: 'User Not Found',
      );
    } on WrongPasswordException catch (_) {
      await showErrorDialog(
        context: context,
        error: 'Wrong Password',
      );
    } on GenericAuthException catch (_) {
      await showErrorDialog(
        context: context,
        error: 'Authentication Error',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        color: const Color(0xFF28292B),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 500,
                child: Center(
                  child: Text('Reviews',
                      style: Theme.of(context).textTheme.displaySmall),
                ),
              ),
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  labelText: 'email',
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Color(0xFF545454),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _password,
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  labelText: 'password',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Color(0xFF545454),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton.icon(
                icon: const Icon(
                  Icons.email_outlined,
                  color: Color(0xFFDDDDDD),
                ),
                label: Text(
                  'Login with email address',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onPressed: () => login(),
              ),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                    (_) => false,
                  );
                },
                child: Text(
                  'Don’t have an account? Register here!',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
