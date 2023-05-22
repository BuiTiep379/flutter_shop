import 'package:flutter/material.dart';
import '../../../utils/text_custom.dart';

class CardUser extends StatelessWidget {
  final String name;
  final String username;
  final String id;

  const CardUser({
    Key? key,
    required this.name,
    required this.username,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: 100,
          child: Card(
            margin: const EdgeInsets.only(top: 10.0, left: 2.0, right: 2.0),
            color: Colors.white,
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Stack(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: Image.asset(
                        'assets/images/avatar.png',
                        height: 70,
                        width: 70,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 10.0),
                            child: Text(
                              name.toString().toUpperCase(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 5.0),
                            child: Text(
                              username.toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
