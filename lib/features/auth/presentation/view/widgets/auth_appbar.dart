import 'package:flutter/material.dart';
import 'package:recipe_app/features/auth/presentation/view/create_account_view.dart';

import '../../../../../core/resources/colors_manager.dart';
import '../login_view.dart';
import '../register_view.dart';

class AuthAppBar extends StatelessWidget  implements PreferredSizeWidget {
  final switchText;
  const AuthAppBar({
    super.key,
    this.switchText,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(

      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CreateAccountView()));
          },
          child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorsManager.primaryColor
              ),
              child: Icon(Icons.arrow_back_ios_new, color: Colors.white,size: 14,)),
        ),
      ),
      actions: [Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: TextButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => switchText=='Register'? RegisterView(): LoginView(),));
        }, child: Text(switchText, style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold),)),
      )],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);}
