import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class GetDataFromFireStore extends StatefulWidget {
  const GetDataFromFireStore({Key? key}) : super(key: key);

  @override
  State<GetDataFromFireStore> createState() => _GetDataFromFireStoreState();
}

class _GetDataFromFireStoreState extends State<GetDataFromFireStore> {
// text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  final CollectionReference _users =
      FirebaseFirestore.instance.collection('User');

  logCrash() async {
    FirebaseCrashlytics.instance.setCustomKey('custom_key', 'value');
    await FirebaseCrashlytics.instance.recordError(Error(), null,
        reason: 'Custom error',
        // Pass in 'fatal' argument
        fatal: true);
    FirebaseCrashlytics.instance.crash();
  }

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String city = _cityController.text;
                    if (city != null) {
                      await _users.add({"name": name, "City": city});

                      _nameController.text = '';
                      _cityController.text = '';
                      FirebaseAnalytics.instance.logEvent(name: 'Add user', parameters: <String, String>{"name":  name});
                      Navigator.of(context).pop();
                    }
                  },
                ),
                TextButton(onPressed: logCrash, child: Text("Crash log"))
              ],
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _cityController.text = documentSnapshot['City'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String city = _cityController.text;
                    if (city != null) {
                      await _users
                          .doc(documentSnapshot!.id)
                          .update({"name": name, "City": city});
                      _nameController.text = '';
                      _cityController.text = '';
                      FirebaseAnalytics.instance.logEvent(name: 'Update user');
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _users.doc(productId).delete();

    FirebaseAnalytics.instance.logEvent(name: 'Delete user');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Firebase Firestore')),
        ),
        body: Container(
          child: Column(
            children: [
              TextButton(onPressed: _create,child: Text("Add User"), style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.indigo,
                    width: 1,
                    style: BorderStyle.solid
                  )
                )
              ),)),
              StreamBuilder(
              stream: _users.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(documentSnapshot['name']),
                          subtitle: Text(documentSnapshot['City'].toString()),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => _update(documentSnapshot)),
                                IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => _delete(documentSnapshot.id)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),],
          ),
        ),
// Add new product
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, '/app_localization');
          },
          child: const Icon(Icons.navigate_next),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
