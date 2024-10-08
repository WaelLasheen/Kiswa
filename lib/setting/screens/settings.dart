import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kiswa/authentication/screens/login_screen.dart';
import 'package:kiswa/consts/images.dart';
import 'package:kiswa/firebase/authentication/auth_services.dart';
import 'package:kiswa/setting/screens/personal_details.dart';
import 'package:kiswa/setting/widgets/setting_buttom.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * .55,
          child: Stack(children: [
            Center(child: Image.asset(Ellipse)),
            Center(child: Image.asset(Personal_Image)),
          ]),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'اسراء جمال', // will come from backend in future
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SettingButton(
              text: 'المعلومات الشخصية',
              icon: Icons.info,
              function: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PersonalDetails(),
                  ),
                );
              },
            ),
            SettingButton(
              text: 'الاشعارات',
              icon: Icons.notifications,
              function: () {},
            ),
            SettingButton(
              text: ' اللغة',
              icon: Icons.language,
              function: () {},
            ),
            SettingButton(
              text: 'مركز المساعدة',
              icon: Icons.help,
              function: () {},
            ),
            SettingButton(
              text: 'الخصوصية و الامان',
              icon: Icons.lock,
              function: () {},
            ),
            SettingButton(
              text: 'تسجيل الخروج',
              icon: Icons.power_settings_new_outlined,
              function: () async{
                await AuthServices().signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
            ),
          ],
        ),
      ],
    );
  }
}
