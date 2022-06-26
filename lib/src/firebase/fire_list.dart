import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireList extends StatelessWidget {
  const FireList({
    Key? key,
    required this.query,
    required this.done,
  }) : super(key: key);

  final Future<QuerySnapshot> query;
  final Widget Function(BuildContext, QuerySnapshot) done;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: query,
      builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.hasData && !snapshot.data!.docs.isNotEmpty) {
          return const Text("Sin resultados");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return done(ctx, snapshot.data!);
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
