import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/btn_full.dart';
import 'register_view.dart';
import 'resume_view.dart';
import 'search_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: const [
                  CircleAvatar(
                    radius: 72,
                    backgroundImage: NetworkImage('https://picsum.photos/200'),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Pretike - v1.0',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              BtnFull(
                title: 'Registrar',
                onPressed: () => Get.to(const RegisterPage()),
              ),
              BtnFull(
                title: 'Buscar',
                color: Colors.teal,
                onPressed: () => Get.to(const SearchPage()),
              ),
              const SizedBox(height: 30),
              BtnFull(
                title: 'Resumen',
                color: Colors.amber.shade300,
                onPressed: () => Get.to(const ResumePage()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
