import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_pokedex_app/models/pokemon.dart';
import 'package:riverpod_pokedex_app/providers/pokemon_data_providers.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonListTile extends ConsumerWidget {


final String PokemonURL;

PokemonListTile({ required this.PokemonURL});


  @override
  Widget build(BuildContext context, WidgetRef ref,) {

    final Pokemon = ref.watch(PokemonDataProvider(PokemonURL, ));
   
   return Pokemon.when(data: (data){
    
    return _tile(context, false, data);
   }, error: (error, StackTrace){
    return Text("Error: $error");
   }, loading: (){
    return   _tile(context,true, null);
   });


  }

  Widget _tile (BuildContext context,
  bool isLoading,
  Pokemon? pokemon, 
   ){

    return Skeletonizer(
      enabled: isLoading,
      child: ListTile(
        leading: pokemon != null ? CircleAvatar(backgroundImage:  NetworkImage(pokemon.sprites!.frontDefault!,),) : CircleAvatar(),
        title: Text(
          pokemon != null ? pokemon.name!.toUpperCase() : "Currently loading name for pokemon.",
        ),

        subtitle: Text("Has ${pokemon?.moves?.length.toString() ?? 0} moves"),

        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
      ),
    );

  }
}