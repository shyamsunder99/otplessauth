import 'package:flutter/material.dart';
import 'package:otpless_flutter/otpless_flutter.dart';

//Add this to your screen widget view code

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _waId = 'Unknown';
  final _otplessFlutterPlugin = Otpless();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

// ** Function that is called when page is loaded
// ** We can check the auth state in this function
  Future<void> initPlatformState() async {
    _otplessFlutterPlugin.authStream.listen((token) {
      setState(() {
        _waId = token ?? "Unknown";
// Send the waId to your server and pass the waId in getUserDetail API to retrieve the user detail.
// Handle the signup/signin process here
      });
    });
  }

// Continue With WhatsApp function
  void initiateWhatsappLogin(String intentUrl) async {
    var result =
        await _otplessFlutterPlugin.loginUsingWhatsapp(intentUrl: intentUrl);
    switch (result['code']) {
      case "581":
        print(result['message']);
//TODO: handle whatsapp not found
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Login Page',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 23, vertical: 0),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black12),
              ),
              child: Row(
                children: [
                  Image.asset('assets/2.png'),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    'WhatsApp',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    'Sign in',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    width: 140,
                  ),
                  Icon(Icons.close),
                ],
              ),
            ),
            Container(
              height: 150,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Use your WhatsApp Account to sign in to harshitatiwari...',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              height: 1.5),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'No more OTPs.',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Signing in is fast,simple and secure ',
                          style: TextStyle(
                              fontSize: 16, color: Colors.black54, height: 1.5),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  Expanded(flex: 2, child: Image.asset('assets/1.jpeg')),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    initiateWhatsappLogin(
                        "https://gniindia.authlink.me?redirectUri=gniindiaotpless://otpless");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: Text('Continue'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
