import 'package:flutter/material.dart';
import 'package:greekassignment/models/move_model.dart';

class MovieItem extends StatelessWidget {
  Result result;
  MovieItem({required this.result, super.key});

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(
        int.parse(result.releasedDate.toString()));
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Row(
              children: [
                Column(
                  children: [
                    const Icon(
                      Icons.arrow_drop_up,
                      size: 40,
                    ),
                    Text(result.voting.toString()),
                    const Icon(
                      Icons.arrow_drop_down_sharp,
                      size: 40,
                    ),
                    const Text("Votes")
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.24,
                  width: MediaQuery.of(context).size.width * 0.24,
                  child: Image.network(result.poster.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          result.title,
                          style:
                              const TextStyle(fontFamily: 'LibreBaskerville'),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text("Genre : ${result.genre.toString()}",
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text("Director : ${result.director[0]}",
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Text(
                            "Starring : ${result.stars.toString().replaceAll('[', '').replaceAll(']', "")}",
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                            "Mins | ${result.language} |${date.day} ${date.month}"),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                            "${result.pageViews} views | Voted by ${result.totalVoted} People"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {}, child: const Text("Watch Trailer")),
            ),
          )
        ],
      ),
    );
  }
}
