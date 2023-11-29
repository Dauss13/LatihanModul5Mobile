import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mikan/controller/auth_controller.dart';
import 'package:mikan/view/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _StateLoginPage();
}

class _StateLoginPage extends State<LoginPage> {
  final AuthController _loginController = Get.put(AuthController());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(
              height: 16,
            ),
            Obx(() {
              return ElevatedButton(
                  onPressed: _loginController.isLoading.value
                      ? null
                      : () {
                          _loginController.loginUser(
                              _emailController.text, _passwordController.text);
                        },
                  child: _loginController.isLoading.value
                      ? CircularProgressIndicator()
                      : Text('Login'));
            }),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => RegisterPage());
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
      //bottomNavigationBar: BottomNavBar(),
    );
  }
}
