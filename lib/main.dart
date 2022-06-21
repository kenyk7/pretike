import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Preticke',
      home: HomePage(),
    );
  }
}

class ResumePage extends StatelessWidget {
  const ResumePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            color: Colors.blue,
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 10),
                      Text(
                        'Meta',
                      ),
                      Text.rich(
                        TextSpan(
                          text: 'S/ ',
                          children: [
                            TextSpan(
                              text: '35000',
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ],
                        ),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    '+ S/ 5000',
                    style: TextStyle(
                      fontSize: 20,
                      height: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(
                  child: Transform.scale(
                    scale: 1.2,
                    child: SizedBox(
                      width: 160,
                      child: CircleProgressBar(
                        foregroundColor: Colors.teal,
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        value: 1,
                        child: _dragonCircle(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(
                      child: cardInfo('Venta', 'S/ 40000'),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: cardInfo('Falta', 'S/ 0', color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                cardInfo('Ganancias', 'S/ 5000', color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DefaultTextStyle cardInfo(
    String name,
    String data, {
    Color color = Colors.teal,
  }) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: Colors.white,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name),
            const SizedBox(height: 10),
            Text(
              data,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dragonCircle() {
    const innerMargin = 10;
    const double strokeWidth = 4;
    final Color backgroundColor = Colors.blue.shade400;

    return Container(
      margin: const EdgeInsets.all(innerMargin + strokeWidth),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(150),
      ),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            '100%',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Ventas',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Registro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              searchField('DNI'),
              const SizedBox(height: 20),
              // Text('Sin resultados'),
              Column(
                children: [
                  itemList(
                    digit: '1',
                    title: '48302281',
                    subtitle: 'Keny Romero',
                    isCheck: false,
                  ),
                  itemList(
                    digit: '3',
                    title: '48302287',
                    subtitle: 'Elon Musk',
                    isCheck: true,
                  ),
                  itemList(
                    digit: '7',
                    title: '48302287',
                    subtitle: 'Larry Page',
                    isCheck: false,
                  ),
                  itemList(
                    digit: '4',
                    title: '48303387',
                    subtitle: 'Evely Rafael',
                    isCheck: false,
                  ),
                  itemList(
                    digit: '0',
                    title: '48307687',
                    subtitle: 'Jorge Lorem',
                    isCheck: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  searchField(String placeholder) {
    return Stack(
      children: [
        SizedBox(
          height: 48,
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
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.search_rounded),
          ),
        ),
      ],
    );
  }

  Widget itemList({
    required String digit,
    required String title,
    required String subtitle,
    bool isCheck = false,
    GestureTapCallback? onTap,
  }) {
    final icon = isCheck ? Icons.check_box : Icons.check_box_outline_blank;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.15),
          ),
        ),
      ),
      child: Slidable(
        key: Key(title),
        endActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {},
              // backgroundColor: Colors.grey,
              foregroundColor: Colors.black54,
              icon: Icons.sell_rounded,

              label: 'S/ 40',
            ),
          ],
        ),
        child: ListTile(
          onTap: onTap,
          // dense: true,
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(digit),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Opacity(
            opacity: 0.9,
            child: Text(subtitle),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          trailing: Icon(
            icon,
            color: isCheck ? Colors.blue : null,
          ),
        ),
      ),
    );
  }
}

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
                onPressed: () => Get.to(const RegisterPage()),
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

class BtnFull extends StatelessWidget {
  const BtnFull({
    Key? key,
    required this.title,
    this.color = Colors.blue,
    this.onPressed,
  }) : super(key: key);
  final String title;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 15),
      child: CupertinoButton(
        color: color,
        borderRadius: BorderRadius.circular(30),
        onPressed: onPressed,
        child: Text(
          title,
        ),
      ),
    );
  }
}
