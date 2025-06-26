import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/auth_Controller.dart';
import 'package:review_app/app/routes/app_routes.dart';


class LoginScreen extends StatelessWidget {
  final auth = Get.find<AuthController>();

   LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 225, 227, 242),
      // appBar: AppBar(title: Text("Login")),
      body: Obx(() {
        return auth.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(10),
            
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "SignIn",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                ),
                const SizedBox(height: 24),

                // email box
                TextField(
                  controller: auth.emailController,
                  onChanged: auth.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                // email error
                Obx(() => auth.emailError.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text(
                          auth.emailError.value,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                    : const SizedBox()),
                const SizedBox(height: 30),

                // password box
                Obx(
                  () =>  TextField(
                    controller: auth.passController,
                    onChanged: auth.validatePassword,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: auth.hiddenPass.value ? true : false,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(onPressed: () => auth.hiddenPass.value = !auth.hiddenPass.value, icon: auth.hiddenPass.value ? Icon(CupertinoIcons.eye) : Icon(CupertinoIcons.eye_slash))
                    ),
                  ),
                ),
                // password error
                Obx(() => auth.passError.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text(
                          auth.passError.value,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                    : const SizedBox()),
                const SizedBox(height: 35),

                // login button
                Obx(() => ElevatedButton(
                      onPressed: 
                          auth.isLoading.value ? null : () => auth.signIn(auth.emailController.text.trim(), auth.passController.text.trim()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 77, 103, 251),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26)),
                      ),
                      child: auth.isLoading.value
                          ? const CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2)
                          : const Text(
                              "Login",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                    )),

                    const SizedBox(height: 40),
                    // not registered
                    TextButton(onPressed: () => Get.toNamed(TRouteNames.signup), child: Text('Not registered yet? then Sign up', style: TextStyle(decoration: TextDecoration.underline),))
              ],
            ),
          ),
        ),
      )
    ;
      }),
    );
  }
}


// wasimaesty@gmail.com
// pass: abcd1234#D
// device : 30 API