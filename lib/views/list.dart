import 'package:flutter/material.dart';
import 'package:pertemuan7/detail/anime_detail.dart';
import 'package:pertemuan7/models/anime_model.dart';
import 'package:pertemuan7/presenters/anime_presenter.dart';

class AnimeListScreen extends StatefulWidget {
  const AnimeListScreen({super.key});

  @override
  State<AnimeListScreen> createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen>
    implements AnimeView{
      late AnimePresenter _presenter;
      bool _isLoading = false;
      List<Anime> _animeList = [];
      String? _errorMessage;
      String _currentEndpoint = 'akatsuki';

      @override
    void initState(){
      super.initState();
      _presenter = AnimePresenter(this);
      _presenter.loadAnimeData(_currentEndpoint);
    }

    void _fetchData(String endpoint){
      setState((){
        _currentEndpoint = endpoint;
        _presenter.loadAnimeData(endpoint);
      });
    }

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showAnimeList(List<Anime> animeList) {
    _animeList = animeList;
  }

  @override
  void showError(String message) {
    _errorMessage = message;
  }

  @override
  void showLoading() {
    _isLoading = true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anime List"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => _fetchData('akatsuki'),
                  child: Text("Akatsuki")),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () => _fetchData('kara'), child: Text("Kara")),
                  SizedBox(
                width: 10,
              ),
                  ElevatedButton(
                  onPressed: () => _fetchData('characters'), child: Text("Character"))
            ],
          ),
          Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                      ? Center(child: Text("Error : ${_errorMessage}"))
                      : ListView.builder(
                          itemCount: _animeList.length,
                          itemBuilder: (context, index) {
                            final anime = _animeList[index];
                            return ListTile(
                              leading: anime.imageUrl.isNotEmpty
                                  ? Image.network(anime.imageUrl)
                                  : Image.network(
                                      'https://placehold.co/600x400'),
                              title: Text(anime.name),
                              subtitle: Text('Family ${anime.familyCreator}'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                            id: anime.id,
                                            endpoint: _currentEndpoint)));
                              },
                            );
                          }))
        ],
      ),
    );
  }
}