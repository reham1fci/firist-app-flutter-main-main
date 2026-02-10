
import 'dart:async';

import 'package:betakety_app/view/screens/auth/new_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpDialog extends StatefulWidget {
   String otpCode  ;

   OtpDialog( this.otpCode);

  @override
  _OtpDialogState createState() => _OtpDialogState();
}

class _OtpDialogState extends State<OtpDialog> {
  List<TextEditingController> controllers =
  List.generate(4, (_) => TextEditingController());
  int _secondsRemaining = 45;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _secondsRemaining = 45;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
        setState(() {});
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("input_valid_otp".tr),
      content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            return SizedBox(
              width: 50,
              child: TextField(
                controller: controllers[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                decoration: const InputDecoration(
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

        const SizedBox(height: 12),

        Text(
          _secondsRemaining > 0
              ? "00:${_secondsRemaining.toString().padLeft(2, '0')}"
              : "otp_expired".tr,
          style: TextStyle(
            color: _secondsRemaining > 0 ? Colors.grey : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),


    actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed:  _secondsRemaining == 0
    ? null:() {
            String otp =
            controllers.map((c) => c.text).join();
            print("OTP: $otp");
             if(otp==widget.otpCode){
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NewPassScreen()));

             }
             else{
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("otp_incorrect".tr)));
             }
            // هنا تنادي API
          },
          child: Text("Verify"),
        ),
      ],
    );
  }
}
