import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var pokeApi = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  List pokedex = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      fetchPokemonData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.4,
          ), 
            itemCount: pokedex.length, 
            itemBuilder: (context, index) { 
              var type = pokedex[index]['type'][0];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 12),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: -10,
                        right: -10,
                        child: Image.asset('assets/images/pokeball.png',
                         height: 100, fit: BoxFit.fitHeight,)),
                      Positioned(
                        top: 20,
                        left: 10,
                        child: Text(
                          pokedex[index]['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 45,
                        left: 20,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.black26,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 4, bottom: 4, right: 8),
                            child: Text(
                              type.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: CachedNetworkImage(
                          imageUrl: pokedex[index]['img'],
                          height: 100,
                          fit: BoxFit.fitHeight,
                        )
                      ),
                    ]
                  ),
                ),
              );
            },
            )
          )
        ],        
      )
    );
  }

  void fetchPokemonData(){
    var url = Uri.http("raw.githubusercontent.com", "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    http.get(url).then((value) {
      if(value.statusCode == 200){
        var decodedJsonData = jsonDecode(value.body);
        pokedex = decodedJsonData['pokemon'];
        setState(() {});
      }
    });
  }

}