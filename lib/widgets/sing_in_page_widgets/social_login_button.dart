import 'package:flutter/material.dart';

/// A button for social buttons
///
/// [buttonText] is required for the use SocialLoginButton
///
/// ```Create SocialLoginButton With detailed
/// SocialLoginButton(
/// buttonText : "Login",
/// buttonColor : Colors.blue,
/// textColor : Colors.black,
/// height : 30,
/// radius: 10,
/// buttonIcon : Image.asset("images/facebook-logo.png") or Icon(Icons.email),
/// onPressed : () {}
/// )
/// ```
///
/// ```Create SocialLoginButton with easy way
/// SocialLoginButton(
/// buttonText : "Login"
/// buttonIcon : Icon(Icons.email), => not required but didn't try with null icon
/// onPressed : () {}
/// )
/// ```
///
/// ```Create SocialLoginButton with custom way
/// SocialLoginButton(
/// buttonText : "Login",
/// buttonIcon : Icon(Icons.email),
/// onPressed : (){},
/// radius : 20 ,
/// buttonColor : Colors.amber,
/// )
/// ```

class SocialLoginButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double height;
  final double radius;
  final Widget buttonIcon;
  final VoidCallback onPressed;

  const SocialLoginButton(
      {Key key,
      @required this.buttonText,
      this.buttonColor,
      this.textColor: Colors.white,
      this.radius: 16,
      this.height: 40,
      this.buttonIcon,
      this.onPressed})
      : assert(buttonText != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: height,
        child: RaisedButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// If [buttonIcon] null, create container
              buttonIcon != null ? buttonIcon : Container(),
              Text(
                buttonText,
                style: TextStyle(color: textColor),
              ),
              buttonIcon != null
                  ? Opacity(opacity: 0, child: buttonIcon)
                  : Container(),
            ],
          ),
          color: buttonColor,
        ),
      ),
    );
  }
}
