import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:hive_flutter/adapters.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 

  

  @override
  Widget build(BuildContext context) {
    final words = nouns.take(50).toList();
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: const Text('Lista favoritos'),
      ),
      body: ValueListenableBuilder( 
        valueListenable: Hive.box('favorites').listenable(),
        builder: (context, box, child){
          return ListView.builder(
        
            itemCount: words.length,
            itemBuilder:  (context, index){
              final word = words[index];
              final isFavorite = box.get(index) != null;
              return ListTile(
                title: Text(word),
                trailing: IconButton(onPressed: () async{
                  ScaffoldMessenger.of(context).clearSnackBars();
                  if (isFavorite) {
                    await box.delete(index);
                    const snackBar = SnackBar(
                      content: Text('Removed Successfully'),
                      backgroundColor: Colors.red,
                    );
                    
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else{
                    await box.put(index, word);
                    const snackBar = SnackBar(
                      content: Text('Added Successfully'),
                      backgroundColor: Colors.blue,
                    );
                    
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  }
                  
                 
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border, 
                  color: Colors.red,
                  )
                ),
              );
            },
          );
        },
      ),
      
    );
  }
}
