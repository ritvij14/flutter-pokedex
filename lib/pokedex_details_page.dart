import 'package:flutter/material.dart';
import 'package:pokemon_app/pokemon_model.dart';

class PokemonDetails extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetails({this.pokemon});

  detailsCard(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height/1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              color: Color(0xFF406187),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 75.0,
                  ),
                  Text(pokemon.name, style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
                  Text("Height: ${pokemon.height}", style: TextStyle(color: Colors.white),),
                  Text("Weight: ${pokemon.weight}", style: TextStyle(color: Colors.white),),
                  Text("Types:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type
                        .map((t) => FilterChip(
                          label: Text(
                            t,
                            style: TextStyle(
                              color: Colors.white
                            )
                          ),
                          onSelected: (b){},
                          backgroundColor: Colors.amber[900],
                        )).toList(),
                  ),
                  Text("Weakness:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses
                        .map((w) => FilterChip(
                          label: Text(
                            w,
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                          backgroundColor: Colors.red,
                          onSelected: (b){}
                        )).toList(),
                  ),
                  Text("Next evolution:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.nextEvolution
                        .map((nextEvol) => FilterChip(
                          label: Text(
                            nextEvol.name,
                            style: TextStyle(
                              color: Colors.white
                            )
                          ),
                          backgroundColor: Colors.deepPurple[700],
                          onSelected: (b){},
                        )).toList(),
                  ),
              ]),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img,
              child: Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(pokemon.img),
                    fit: BoxFit.cover,
                  )
                ),
              ),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF223346),
      appBar: AppBar(
        elevation: 0,
        title: Text(pokemon.name),
        backgroundColor: Color(0xFF223346),
      ),
      body: detailsCard(context),
    );
  }
}
