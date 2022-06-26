import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../firebase/fire_list.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference tickets = FirebaseFirestore.instance
        .collection('brands/4K8YupbFjWCA4SIqxOe8/tickets');

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
              FireList(
                query: tickets.get(),
                done: (ctx, snapshot) {
                  return Column(
                    children: snapshot.docs
                        .map(
                          (doc) => itemList(
                            digit: doc['digit'],
                            title: doc['dni'],
                            subtitle: doc['name'],
                            isCheck: false,
                          ),
                        )
                        .toList(),
                  );
                },
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
