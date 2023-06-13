import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  Widget _buildLogo(){
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Image.asset(
          'assets/logo.png',
        ),
      );
    }

Widget _buildInputContainer({required String hintText, bool isPassword = false}){
      return Container(
        height: 46,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Color(0xFF84A361),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: TextFormField(
            obscureText: isPassword,
            style: GoogleFonts.inter(
              color: Colors.black
            ),
            decoration: InputDecoration.collapsed(
              hintText: hintText,
              hintStyle: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500
              )
            ),
          ),
        ),
      );
    }

    Widget _buildButtonLogin(){
      return Container(
        height: 46,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, 'home');
          },
          style: TextButton.styleFrom(
            backgroundColor: Color(0xFF84A361),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
          ),
          child: Text(
            'DAFTAR',
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 19,
              fontWeight: FontWeight.bold
            ),
          ),
        ),

      );
    }

    _buildFooter(){
      return Container(
        margin: EdgeInsets.only(bottom: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sudah punya akun ? ',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text(
                'MASUK',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600
                ),
              ),
            )
          ],
        ),
      );
    }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F7E5),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
                SizedBox(height: 60),
                _buildInputContainer(hintText: 'Nama Lengkap'),
                SizedBox(height: 20),
                _buildInputContainer(hintText: 'Username'),
                SizedBox(height: 20),
                _buildInputContainer(hintText: 'No. HP'),
                SizedBox(height: 20),
                _buildInputContainer(hintText: 'Email'),
                SizedBox(height: 20),
                _buildInputContainer(hintText: 'Password', isPassword: true),
                SizedBox(height: 20),
                _buildInputContainer(hintText: 'Password Check', isPassword: true),
                SizedBox(height: 30),
                _buildButtonLogin(),
                SizedBox(height: 5),
                _buildFooter()
                
              ],
            ),
          ),
        ),
      ),
    );
      
  }
}