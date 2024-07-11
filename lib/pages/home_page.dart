

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_pokedex_app/controllers/home_name_controller.dart';
import 'package:riverpod_pokedex_app/models/page_data.dart';
import 'package:riverpod_pokedex_app/models/pokemon.dart';
import 'package:riverpod_pokedex_app/widgets/pokemon_list_tile.dart';


final HomePageControllerProvider = StateNotifierProvider<HomePageController,HomePageData>((ref){

return HomePageController(HomePageData.initial(), );
});



class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {


  final ScrollController _allpokemonesListScrollController = ScrollController();


// what is the use of late ? 
// late is used to declare a non-nullable variable without immediately initializing it with a value.

late HomePageController _homePageController;
late HomePageData _homePageData;


@override
  void initState() {
    // TODO: implement initState
    super.initState();

_allpokemonesListScrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _allpokemonesListScrollController.removeListener(_scrollListener);
    _allpokemonesListScrollController.dispose();
    super.dispose();
  }


  void _scrollListener(){

    if(_allpokemonesListScrollController.offset >= 
    _allpokemonesListScrollController.position.maxScrollExtent *1 && 
    !_allpokemonesListScrollController.position.outOfRange)
    {
      print("reached end of list",);
      _homePageController.loadData();
    }

  }


  @override
  Widget build(BuildContext context) {


    _homePageController = ref.watch(HomePageControllerProvider.notifier);

    _homePageData = ref.watch(HomePageControllerProvider,);




    return  Scaffold(

      body: _buildUI(
        context,
      ),
    );
  }

Widget _buildUI( BuildContext context, ){

  return SafeArea(child: SingleChildScrollView(
    child: Container(
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width * 0.02,

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _allpokemonesList(
            context
          )

        ],
      ),
    ),



  )
  );
}

Widget _allpokemonesList(
BuildContext context,
){
  return SizedBox(
    width: MediaQuery.sizeOf(context).width,
    child:  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

      Text("All Pokemons",
      style: TextStyle(
        fontSize: 25,

      ),
      ),

      SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: ListView.builder(
          controller: _allpokemonesListScrollController,
          itemCount: _homePageData.data?.results?.length ?? 0,
          itemBuilder: (context, index){
            PokemonListResult pokemon = _homePageData.data!.results![index];
          return PokemonListTile(PokemonURL: pokemon.url!,);

        }),
      )
  


    ],),
  );

}



}