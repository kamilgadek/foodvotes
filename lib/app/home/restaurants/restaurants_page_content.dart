import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/restaurants_cubit.dart';

class RestaurantsPageContent extends StatelessWidget {
  const RestaurantsPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantsCubit()..start(),
      child: BlocBuilder<RestaurantsCubit, RestaurantsState>(
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Center(
              child: Text('Coś poszło nie tak! : ${state.errorMessage} '),
            );
          }

          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final documents = state.documents;

          return Column(
            children: [
              for (final document in documents) ...[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(document['name']),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(document['pizza']),
                        ],
                      ),
                      Text(document['rating'].toString()),
                    ],
                  ),
                ),
              ],
            ],
          );

          state.documents;
          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('restaurants')
                  .orderBy(
                    'rating',
                    descending: true,
                  )
                  .snapshots(),
              builder: (context, snapshot) {});
        },
      ),
    );
  }
}
