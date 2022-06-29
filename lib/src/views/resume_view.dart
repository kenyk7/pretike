import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase/stream_doc.dart';

class ResumePage extends StatefulWidget {
  const ResumePage({Key? key}) : super(key: key);

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  final Stream<DocumentSnapshot> _resumeStream = FirebaseFirestore.instance
      .collection('brands')
      .doc('4K8YupbFjWCA4SIqxOe8')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen'),
      ),
      body: StreamDoc(
        stream: _resumeStream,
        done: (context, snapshot) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          final int meta = data['meta'];
          final int total = data['total'];
          final int need = total <= meta ? meta - total : 0;
          final int benefit = total > meta ? total - meta : 0;
          final double percentage = total >= meta ? 1 : total / meta;
          return Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
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
                        children: [
                          const SizedBox(height: 10),
                          const Text('Meta'),
                          Text.rich(
                            TextSpan(
                              text: 'S/ ',
                              children: [
                                TextSpan(
                                  text: meta.toString(),
                                  style: const TextStyle(
                                    fontSize: 40,
                                  ),
                                ),
                              ],
                            ),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '+ S/ ${benefit.toString()}',
                        style: const TextStyle(
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
                            value: percentage,
                            child: _dragonCircle(percentage * 100),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        Expanded(
                          child: cardInfo('Venta', 'S/ ${total.toString()}'),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: cardInfo('Falta', 'S/ ${need.toString()}',
                              color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    cardInfo('Ganancias', 'S/ ${benefit.toString()}',
                        color: benefit > 0 ? Colors.blue : Colors.orange),
                  ],
                ),
              ),
            ],
          );
        },
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

  Widget _dragonCircle(double percentage) {
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
        children: [
          Text(
            '${percentage.toString()}%',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(
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
