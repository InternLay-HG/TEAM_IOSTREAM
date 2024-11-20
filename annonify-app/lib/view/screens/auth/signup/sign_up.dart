import 'package:annonify/view/screens/auth/signup/widgets/sign_up_form.dart';
import 'package:annonify/view/widgets/sample.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SampleImage(height: MediaQuery.of(context).size.height * 0.4),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "WELCOME TO ANNONIFY",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "CREATE NEW ACCOUNT",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 20),
                    const SignUpForm(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(child: Text("Already have an account?")),
                        TextButton(
                          onPressed: () {
                            Get.offAllNamed('/signin');
                          },
                          child: const Text("NEXT"),
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
