import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:kiswa/cache/cache_helper.dart';
import 'package:kiswa/consts/colors.dart';
import 'package:kiswa/consts/images.dart';
import 'package:kiswa/firebase/authentication/auth_services.dart';
import 'package:kiswa/app/main_app.dart';
import 'package:kiswa/authentication/screens/login_screen.dart';
import 'package:kiswa/authentication/widgets/login_with.dart';
import 'package:kiswa/authentication/widgets/text_feild.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SighupScreen extends StatefulWidget {
  const SighupScreen({super.key});

  @override
  State<SighupScreen> createState() => _SighupScreenState();
}

class _SighupScreenState extends State<SighupScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscureText = true;
  bool _rememberMe = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    CacheData.setData(key: "firstTime", value: false);
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "إنشاء حساب",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
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
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _loading = true;
                    });
                    var user = await AuthServices()
                        .registerWithEmailAndPassword(
                            _email.text, _password.text);
                    if (user != null) {
                      // Sign-in successful
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sign-up Successful')));
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const MainApp(),
                        ),
                      );

                      setState(() {
                        _loading = false;
                      });
                    } else {
                      // Sign-in failed
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sign-up Failed')));
                      setState(() {
                        _loading = false;
                      });
                    }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // handel function later
                  LoginWith(
                      image: Google,
                      onTap: () async {
                        _loading = true;
                        UserCredential? user = await AuthServices().signInWithGoogle();
                        if (user != null) {
                          _loading = false;
                          // Sign-in successful
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Sign-in Successful')));
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const MainApp(),
                            ),
                          );
                        } else {
                          _loading = false;
                          // Sign-in failed
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Sign-in Failed')));
                        }
                      }),
                  LoginWith(image: Facebook, onTap: () {}),
                  LoginWith(image: LinkedIn, onTap: () {}),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                    },
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                          color: green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                    'لديك حساب بالفعل؟',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
