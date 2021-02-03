import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_app/pokedex_details_page.dart';
import 'dart:convert';

import 'package:pokemon_app/pokemon_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    fetchdata();
  }

  static const API_URL =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokemonModel pokemonModel = PokemonModel();

  fetchdata() async {
    var res = await http.get(API_URL);
    var responseData = json.decode(res.body);
    // print(responseData);
    pokemonModel = PokemonModel.fromJson(responseData);
    // print(pokemonModel.toJson());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF223346),
      body: pokemonModel.pokemon == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokemonModel.pokemon
                  .map((item) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PokemonDetails(pokemon: item),
                                ));
                          },
                          child: Hero(
                            tag: item.img,
                            child: Card(
                              color: Color(0xFF406187),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: 100.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(item.img)),
                                    ),
                                  ),
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
    );
  }
}
