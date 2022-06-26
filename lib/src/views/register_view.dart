import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/btn_full.dart';
import 'search_view.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Column(
                children: [
                  inputField('DNI'),
                  inputField('Nombres'),
                  inputField('Monto pagado'),
                ],
              ),
              const SizedBox(height: 20),
              BtnFull(
                title: 'Registrar',
                onPressed: () => {},
              ),
              BtnFull(
                title: 'Buscar en lista',
                color: Colors.teal,
                onPressed: () => Get.to(const SearchPage()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  inputField(String placeholder) {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(bottom: 15),
      child: CupertinoTextField(
        placeholder: placeholder,
        placeholderStyle: const TextStyle(
          color: Colors.grey,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        // style: GoogleFonts.poppins(),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(0.2),
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
