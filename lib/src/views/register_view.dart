import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/btn_full.dart';
import 'search_view.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController dni = TextEditingController();
  TextEditingController digit = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();

  bool loading = false;

  CollectionReference tickets = FirebaseFirestore.instance
      .collection('brands/4K8YupbFjWCA4SIqxOe8/tickets');

  void saveData() async {
    setState(() => loading = true);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final DocumentReference _resumeRef = FirebaseFirestore.instance
          .collection('brands')
          .doc('4K8YupbFjWCA4SIqxOe8');
      DocumentSnapshot _resumeData = await transaction.get(_resumeRef);

      final dniVal = dni.value.text;
      final tkey = '${dniVal.substring(0, 2)}${dniVal.substring(6, 8)}';

      await tickets.add({
        'dni': dniVal,
        'digit': digit.value.text,
        'name': name.value.text,
        'price': int.parse(price.value.text),
        'checkin': false,
        'tkey': tkey,
      });

      if (!_resumeData.exists) {
        throw Exception('Document does not exist!');
      }

      Map<String, dynamic> data = _resumeData.data() as Map<String, dynamic>;

      int updatedTotal = data['total'] + int.parse(price.value.text);
      transaction.update(_resumeRef, {'total': updatedTotal});
    });
    setState(() => loading = false);
    // reset
    dni.value = dni.value.copyWith(text: '');
    digit.value = digit.value.copyWith(text: '');
    name.value = name.value.copyWith(text: '');
    price.value = price.value.copyWith(text: '');
  }

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
            children: [
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: inputField('DNI', dni)),
                      Container(
                        width: 90,
                        margin: const EdgeInsets.only(left: 20),
                        child: inputField('Dígito', digit),
                      ),
                    ],
                  ),
                  inputField('Nombres', name),
                  inputField('Monto pagado', price),
                ],
              ),
              const SizedBox(height: 20),
              loading ? const CircularProgressIndicator() : const SizedBox(),
              BtnFull(
                title: 'Registrar',
                onPressed: loading ? null : () => saveData(),
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

  inputField(String placeholder, TextEditingController ctrlInput) {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(bottom: 15),
      child: CupertinoTextField(
        controller: ctrlInput,
        placeholder: placeholder,
        placeholderStyle: const TextStyle(
          color: Colors.grey,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
