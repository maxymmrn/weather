import 'package:flutter/material.dart';

import '../http_requests.dart';
import '../model/city.dart';

class CitySearchDelegate extends SearchDelegate<City> {

  City _city;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        this.close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Tap to confirm',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold
              ),
            ),
            GestureDetector(
              onTap: () {
                this.close(context, _city);
              },
              child: Text(this.query),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    return _WordSuggestionList(
      query: this.query,
      onSelected: (City city) {
        this.query = city.name;
        this._city = city;
        showResults(context);
      },
    );
  }

}


class _WordSuggestionList extends StatelessWidget {
  const _WordSuggestionList({this.query, this.onSelected});

  final String query;
  final ValueChanged<City> onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subhead;
    return FutureBuilder<List<City>>(
        future: getCities(query),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.hasData ? snapshot.data.length : 0,
            itemBuilder: (BuildContext context, int i) {
              final City chosenCity = snapshot.data[i];
              return ListTile(
                leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
                title: RichText(
                  text: TextSpan(
                    text: chosenCity.name.substring(0, query.length),
                    style: textTheme.copyWith(fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: chosenCity.name.substring(query.length),
                        style: textTheme,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  onSelected(chosenCity);
                },
              );
            },
          );
        }
    );
  }
}