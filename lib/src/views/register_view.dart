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
  final dni = TextEditingController();
  final digit = TextEditingController();
  final name = TextEditingController();
  final price = TextEditingController();

  bool loading = false;

  final tickets = FirebaseFirestore.instance
      .collection('brands/4K8YupbFjWCA4SIqxOe8/tickets');

  void saveData() async {
    setState(() => loading = true);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final _resumeRef = FirebaseFirestore.instance
          .collection('brands')
          .doc('4K8YupbFjWCA4SIqxOe8');
      final _resumeData = await transaction.get(_resumeRef);

      final dniVal = dni.value.text;
      // use for search data: 2 primeros + 2 últimos
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

      final data = _resumeData.data()!;

      int updatedTotal = data['total'] + int.parse(price.value.text);
      transaction.update(_resumeRef, {'total': updatedTotal});
    });
    setState(() => loading = false);
    // clear
    dni.clear();
    digit.clear();
    name.clear();
    price.clear();
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
                      Expanded(
                        child: InpuField(
                          placeholder: 'DNI',
                          ctrlInput: dni,
                          maxl: 8,
                        ),
                      ),
                      Container(
                        width: 90,
                        margin: const EdgeInsets.only(left: 20),
                        child: InpuField(
                          placeholder: 'Dígito',
                          ctrlInput: digit,
                          maxl: 1,
                        ),
                      ),
                    ],
                  ),
                  InpuField(
                    placeholder: 'Nombres',
                    ctrlInput: name,
                    kbType: TextInputType.text,
                    maxl: 32,
                  ),
                  InpuField(
                    placeholder: 'Monto pagado',
                    ctrlInput: price,
                    maxl: 4,
                  ),
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
}

class InpuField extends StatelessWidget {
  const InpuField({
    Key? key,
    required this.ctrlInput,
    required this.placeholder,
    this.kbType = TextInputType.number,
    this.maxl,
  }) : super(key: key);
  final TextEditingController ctrlInput;
  final String placeholder;
  final TextInputType kbType;
  final int? maxl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(bottom: 15),
      child: CupertinoTextField(
        maxLength: maxl,
        keyboardType: kbType,
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
