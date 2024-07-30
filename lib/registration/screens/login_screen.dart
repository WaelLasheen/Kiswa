import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:kiswa/consts/colors.dart';
import 'package:kiswa/registration/widgets/text_feild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscureText = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تسجيل الدخول" ,style: TextStyle(fontSize: 28 ,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'البريد الالكتروني',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            textFeild(
                hint: 'أدخل البريد الالكتروني ',
                icon: Icons.email_outlined,
                controller: _email,
                obscureText: false,
                obscureIcon: const SizedBox()),
            const Text(
              'كلمة المرور',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            textFeild(
              hint: 'أدخل كلمة المرور',
              icon: Icons.lock,
              controller: _password,
              obscureText: _obscureText,
              obscureIcon: IconButton(
                onPressed: () => setState(() => _obscureText = !_obscureText),
                icon: _obscureText
                    ? const Icon(
                        Icons.visibility_off,
                        color: Colors.grey,
                      )
                    : const Icon(Icons.visibility, color: green),
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    // add it latter for forgot password
                  },
                  child: const Text(
                    'نسيت كلمة المرور؟',
                    style: TextStyle(
                        color: green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                const Text(
                  'تذكرني',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) =>
                      setState(() => _rememberMe = !_rememberMe),
                  shape: const CircleBorder(),
                  activeColor: green,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20 ,horizontal: 18),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  // modify it latter for login  <<<<<<<<<<<<<<<<<<<<<<<<<<<<
                  print(_email.text);
                  print(_password.text);
                },

                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(green),
                ),
                child: const Text(
                  'تابع',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // modify it latter for login
                  },
                  child: const Text(
                    'انشاء حساب',
                    style: TextStyle(
                        color: green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Text(
                  'ليس لديك حساب؟',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
