import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StreamDoc extends StatelessWidget {
  const StreamDoc({
    Key? key,
    required this.stream,
    required this.done,
  }) : super(key: key);

  final Stream<DocumentSnapshot> stream;
  final Widget Function(BuildContext, DocumentSnapshot) done;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: stream,
      builder: (BuildContext ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return done(ctx, snapshot.data!);
      },
    );
  }
}
