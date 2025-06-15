import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/controller/auth_Controller.dart';


class LoginScreen extends StatelessWidget {
  final auth = Get.find<AuthController>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Obx(() {
        return auth.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
                    TextField(controller: passController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => auth.signIn(emailController.text, passController.text),
                      child: Text("Sign In"),
                    ),
                    TextButton(
                      onPressed: () => auth.signUp(emailController.text, passController.text),
                      child: Text("Sign Up"),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
