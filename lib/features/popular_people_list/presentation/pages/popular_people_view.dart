import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../dependencies/service_locator.dart';
import '../../../../utils/constants.dart';
import '../../domain/entities/popular_person.dart';
import '../bloc/popular_people_list_bloc.dart';


class PopularPeopleView extends StatefulWidget {
  static const String routeName = '/popularPersons';
  const PopularPeopleView({Key? key}) : super(key: key);

  @override
  State<PopularPeopleView> createState() => _PopularPeopleViewState();
}

class _PopularPeopleViewState extends State<PopularPeopleView> {
  final List<PopularPerson> _personsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Popular People",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocProvider<PopularPeopleListBloc>(
        create: (_) => serviceLocator()
          ..add(const FetchPopularPersonsListEvent(isLoadMore: false)),
        child: BlocConsumer<PopularPeopleListBloc, PopularPeopleListState>(
            listener: (context, state) {
          if (state is FetchPopularPersonsFailedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.failureMessage)));
          } else if (state is FetchPopularPersonsSuccessState) {
            setState(() {
              _personsList.addAll(state.personsList);
            });
          }
        }, builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                _personsList.isNotEmpty
                    ? LazyLoadScrollView(
                        child: ListView.builder(
                            itemCount: _personsList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: ListTile(
                                  onTap: () {},
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(imageBaseURL +
                                        _personsList[index].imageURL),
                                  ),
                                  title: Text(_personsList[index].name),
                                ),
                              );
                            }),
                        onEndOfPage: () {
                          BlocProvider.of<PopularPeopleListBloc>(context).add(
                              const FetchPopularPersonsListEvent(
                                  isLoadMore: true));
                        })
                    : const SizedBox(),
                state is FetchPopularPersonsLoadingState
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: MaterialStateColor.resolveWith(
                                  (states) => Colors.black),
                              borderRadius: BorderRadius.circular(32)),
                          child: const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ))
                    : const SizedBox()
              ],
            ),
          );
        }),
      ),
    );
  }
}
