import 'package:betakety_app/view/screens/auth/new_password_screen.dart';
import 'package:flutter/material.dart';

class OtpDialog extends StatefulWidget {
   String otpCode  ;

   OtpDialog( this.otpCode);

  @override
  _OtpDialogState createState() => _OtpDialogState();
}

class _OtpDialogState extends State<OtpDialog> {
  List<TextEditingController> controllers =
  List.generate(4, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Enter OTP"),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) {
          return SizedBox(
            width: 50,
            child: TextField(
              controller: controllers[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              decoration: InputDecoration(
                counterText: "",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (value.isNotEmpty && index < 3) {
                  FocusScope.of(context).nextFocus();
                }
              },
            ),
          );
        }),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            String otp =
            controllers.map((c) => c.text).join();
            print("OTP: $otp");
             if(otp==widget.otpCode){
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NewPassScreen()));

             }
            // هنا تنادي API
          },
          child: Text("Verify"),
        ),
      ],
    );
  }
}
