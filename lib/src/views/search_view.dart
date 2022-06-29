import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../firebase/fire_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  CollectionReference tickets = FirebaseFirestore.instance
      .collection('brands/4K8YupbFjWCA4SIqxOe8/tickets');
  TextEditingController tkey = TextEditingController();
  late Future<QuerySnapshot> fquery;

  void searchSubmit() async {
    if (tkey.value.text.isNotEmpty) {
      setState(() {
        fquery =
            tickets.where('tkey', isEqualTo: tkey.value.text).limit(20).get();
      });
    } else {
      setState(() {
        fquery = tickets.limit(20).get();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fquery = tickets.limit(20).get();
    });
  }

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
              FireList(
                query: fquery,
                done: (ctx, snapshot) {
                  return Column(
                    children: snapshot.docs
                        .map(
                          (doc) => itemList(
                            digit: doc['digit'],
                            title: doc['dni'],
                            subtitle: doc['name'],
                            price: doc['price'],
                            isCheck: doc['checkin'],
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
            controller: tkey,
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
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            onPressed: () => searchSubmit(),
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
    required int price,
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
              foregroundColor: Colors.black54,
              icon: Icons.sell_rounded,
              label: 'S/ $price',
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
