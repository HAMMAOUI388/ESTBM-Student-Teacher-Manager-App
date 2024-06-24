import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class PageCalendrier extends StatefulWidget {
  const PageCalendrier({super.key,});

  @override
  // ignore: library_private_types_in_public_api
  _PageCalendrierState createState() => _PageCalendrierState();
}

class _PageCalendrierState extends State<PageCalendrier> {
  late CalendarFormat _formatCalendrier;
  late DateTime _jourCible;
  late Map<String, List<String>> _evenements;
  DateTime? _jourSelectionne;

  @override
  void initState() {
    super.initState();
    _formatCalendrier = CalendarFormat.month;
    _jourCible = DateTime.now();
    _evenements = {};
    _chargerEvenements();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          const Text(
            'Calendrier',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(width: 40),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 152, 0),
    ),
    body: Stack(
        children: [
          Image.asset(
            'lib/images/patt.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
  Align(
          alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2021, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _jourCible,
              calendarFormat: _formatCalendrier,
              eventLoader: _chargeurEvenements,
              onFormatChanged: (format) {
                setState(() {
                  _formatCalendrier = format;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _jourSelectionne = selectedDay;
                  _jourCible = focusedDay;
                });
              },
              selectedDayPredicate: (day) {
                return isSameDay(_jourSelectionne, day);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_jourSelectionne != null) {
                      if (_jourSelectionne!.isBefore(DateTime.now())) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Vous ne pouvez pas ajouter un événement à un jour déjà passé.'),
                          ),
                        );
                      } else {
                        _afficherConfirmationAjoutEvenement(context);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Veuillez sélectionner un jour pour ajouter un événement.'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    minimumSize: const Size(150, 0),
                    backgroundColor: const Color.fromARGB(255, 255, 152, 0),
                  ),
                  child: const Text(
                    'Ajouter un événement',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: _jourSelectionne != null && _evenements.containsKey(_obtenirCleFormatee(_jourSelectionne!))
                  ? Column(
                      children: _evenements[_obtenirCleFormatee(_jourSelectionne!)]!.map((evenement) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Événement : ',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 255, 152, 0),
                                    ),
                                  ),
                                  Text(
                                    evenement,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _afficherConfirmationSuppression(context, evenement);
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    )
                  : const Text(
                      'Aucun événement',
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          ],
        ),
      ),
    ),
       ],
    ),
  );
}


  List<String> _chargeurEvenements(DateTime day) {
    return _evenements[_obtenirCleFormatee(day)] ?? [];
  }

  String _obtenirCleFormatee(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  Future<void> _afficherConfirmationAjoutEvenement(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Ajouter un événement',
            style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 255, 152, 0)),
          ),
          content: Text('Voulez-vous ajouter un événement le $_jourSelectionne ?'),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Annuler',
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Oui',
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _afficherDialogueAjoutEvenement(context);
              },
            ),
          ],
        );
      },
    );
  }

 Future<void> _afficherDialogueAjoutEvenement(BuildContext context) async {
  String nomEvenement = '';
  TimeOfDay? heureSelectionnee;

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text(
              'Ajouter un événement',
              style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 152, 0)),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    ' ${DateFormat('EEEE, MMMM d, yyyy').format(_jourSelectionne!)}', // Affiche le jour sélectionné
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Nom de l\'événement',
                    ),
                    onChanged: (value) {
                      nomEvenement = value;
                    },
                  ),
                  const SizedBox(height: 10),
                 ElevatedButton(
  onPressed: () async {
    // Afficher le sélecteur d'heure et mettre à jour l'heure sélectionnée
    final heureChoisie = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (heureChoisie != null) {
      setState(() {
        heureSelectionnee = heureChoisie;
      });
    }
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 255, 152, 0), // Couleur de fond
  ),
  child: const Text(
    'Sélectionner l\'heure',
    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold), // Couleur du texte
  ),
),

                  if (heureSelectionnee != null) // Afficher l'heure sélectionnée si disponible
                    Text('Heure sélectionnée : ${heureSelectionnee!.format(context)}'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Enregistrer',
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (nomEvenement.isNotEmpty) {
                    setState(() {
                      final cleFormatee = _obtenirCleFormatee(_jourSelectionne!);
                      _evenements.update(
                        cleFormatee,
                        (value) => value..add('$nomEvenement     à :  ${heureSelectionnee!.format(context)}'), // Inclure l'heure dans le nom de l'événement
                        ifAbsent: () => ['$nomEvenement      à :  ${heureSelectionnee!.format(context)}'],
                      );
                      _enregistrerEvenements(); // Enregistrer les événements lors de l'ajout
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Votre événement a été ajouté avec succès'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Veuillez saisir le nom de l\'événement.'),
                      ),
                    );
                  }
                },
              ),
              TextButton(
                child: const Text('Annuler'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
  );
}

  Future<void> _afficherConfirmationSuppression(BuildContext context, String evenement) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Supprimer l\'événement'),
          content: Text('Voulez-vous supprimer l\'événement "$evenement" ?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Non'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Oui'),
              onPressed: () {
                setState(() {
                  final cleFormatee = _obtenirCleFormatee(_jourSelectionne!);
                  _evenements[cleFormatee]!.remove(evenement);
                  _enregistrerEvenements(); // Enregistrer les événements lors de la suppression
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Événement supprimé avec succès'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _chargerEvenements() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    _evenements = Map<String, List<String>>.from(
      (prefs.getString('evenements') ?? '{}').split(',').asMap().map(
            (key, value) => MapEntry<String, List<String>>(
              key.toString(), // Changer la clé en type chaîne de caractères
              value.split(';'),
            ),
          ),
    );
  });
}


  Future<void> _enregistrerEvenements() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('evenements', '${_evenements.keys.join(',')};${_evenements.values.join(';')}');
  }
}
