import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../base_page.dart';
import '../../service/user_service.dart';
import './components/search_util.dart';
import './components/user_card.dart';
class UserListScreen extends BasePage {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends BasePageState<UserListScreen> {
  final Stream<QuerySnapshot> collectionReference =
      UserService.readUsers();


  @override
  void initState() {
    super.initState();
    pageTitle = "Users";
  }

  @override
Widget pageUI() {

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SearchInput(),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: Padding(
              padding: const EdgeInsets.all(0),
              child: StreamBuilder(
                stream: collectionReference,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((e) {
                            return CardUser(
                                name: e['name'], username: e['username'],id: e.id);
                          }).toList(),
                        ));
                  }
                  return Container();
                },
              ),
            ), 
            ),
            
          ],
        ),
      ),
    );
  }
}
