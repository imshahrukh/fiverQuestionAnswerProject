import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v24/constants.dart';

void main() {
  runApp(MaterialApp(
    title: 'Q&A LogIn',
    theme: ThemeData(
      primaryColor: kPrimaryColor,
      //textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
    ),
    home: LoginPage(),
  ));
}

class LoginPage extends StatefulWidget {
  //const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{

  bool isLogin = true;
  late Animation<double> containerSize;
  Duration animationDuration = const Duration(milliseconds: 270);
  late AnimationController animationController;
  @override
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);

    animationController = AnimationController(vsync: this,duration: animationDuration);
  }

  @override
  void dispose(){
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double viewInsets = MediaQuery.of(context).viewInsets.bottom;
    double defaultLoginSize = size.height - (size.height * 0.2);
    double defaultRegisterSize = size.height - (size.height * 0.1);
    containerSize = Tween<double>(begin: size.height *0.1, end: defaultRegisterSize).animate(CurvedAnimation(parent: animationController,curve: Curves.linear));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 100,
            right: -50,

            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: kPrimaryColor,
              ),
            ),
          ),
          Positioned(
            top: -50,
            left: -50,

            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: kPrimaryColor,
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: isLogin ? 0.0 : 1.0,
            duration: animationDuration,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: size.width,
                height: size.height * 0.1,
                alignment: Alignment.bottomCenter,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: isLogin ? null : (){
                    animationController.reverse();
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  color: Colors.purple,
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: isLogin ? 1.0 : 0.0,
            duration: animationDuration * 4,
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Container(
                  width: size.width,
                  height: defaultLoginSize,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const Image(image: AssetImage('assets/Log.png'),),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 7),
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 1),
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: kPrimaryColor.withAlpha(50),
                        ),
                        child: const TextField(
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email,color: kPrimaryColor,),
                            hintText: 'Username',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 7),
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 1),
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: kPrimaryColor.withAlpha(50),
                        ),
                        child: const TextField(
                          cursorColor: kPrimaryColor,
                          obscureText: true,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock,color: kPrimaryColor,),
                            hintText: 'Password',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      InkWell(
                        onTap: (){},
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kPrimaryColor,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          child: const Text('Log In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (context,child){
              if(viewInsets == 0 && isLogin){
                return buildRegisterContainer();
              }else if(!isLogin){
                return buildRegisterContainer();
              }
              return Container();
            },
          ),
          AnimatedOpacity(
            opacity: isLogin ? 0.0 : 1.0,
            duration: animationDuration * 5,
            child: Visibility(
              visible: !isLogin,
              child: Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Container(
                    //color: Colors.white,
                    width: size.width,
                    height: defaultLoginSize,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Welcome',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const Image(image: AssetImage('assets/Log.png'),),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 7),
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 1),
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kPrimaryColor.withAlpha(50),
                          ),
                          child: const TextField(
                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              icon: Icon(Icons.email,color: kPrimaryColor,),
                              hintText: 'Username',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 7),
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 1),
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kPrimaryColor.withAlpha(50),
                          ),
                          child: const TextField(
                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              icon: Icon(Icons.face_rounded,color: kPrimaryColor,),
                              hintText: 'Name',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 7),
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 1),
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kPrimaryColor.withAlpha(50),
                          ),
                          child: const TextField(
                            cursorColor: kPrimaryColor,
                            obscureText: true,
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock,color: kPrimaryColor,),
                              hintText: 'Password',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        //const SizedBox(height: 10,),
                        InkWell(
                          onTap: (){},
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: kPrimaryColor,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            alignment: Alignment.center,
                            child: const Text('Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildRegisterContainer(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: containerSize.value,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100),
            topRight: Radius.circular(100),
          ),
          color: kBackgroundColor,
        ),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: !isLogin ? null : (){
            animationController.forward();
            setState(() {
              isLogin = !isLogin;
            });
          },
          child: isLogin ? const Text(
            "Don't have an Account? SignUp",
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 14,
            ),
          ): null,
        ),
      ),
    );

  }
}
