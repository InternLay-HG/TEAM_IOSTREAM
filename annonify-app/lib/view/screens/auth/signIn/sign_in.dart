import 'package:annonify/view/screens/auth/signIn/widgets/sign_in_form.dart';
import 'package:annonify/view/widgets/sample.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SampleImage(height: MediaQuery.of(context).size.height * 0.45),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "WELCOME BACK!",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "SIGN IN TO YOUR ACCOUNT",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 20),
                    const SignInForm(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(child: Text("Don't have an account?")),
                        TextButton(
                          onPressed: () {
                            Get.offNamed('/chooseAvatar');
                          },
                          child: const Text("CREATE  ONE"),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
