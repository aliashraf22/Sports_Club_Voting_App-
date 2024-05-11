import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/models/candidate_model.dart';

class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({super.key});

  @override
  State<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _newCandidateFormKey = GlobalKey<FormState>();
  late Map<String, List<CandidateModel>> _candidatesByCategory;
  bool _isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _fetchCandidates();
  }

  Future<void> _fetchCandidates() async {
    _candidatesByCategory = {};
    setState(() => _isLoading = true);
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('candidates').get();
    Map<String, List<CandidateModel>> tempMap = {};
    for (var doc in snapshot.docs) {
      String category = doc['type'] ?? 'Unknown';
      if (!tempMap.containsKey(category)) {
        tempMap[category] = [];
      }
      tempMap[category]?.add(CandidateModel.fromFirestore(doc));
    }
    setState(() {
      _candidatesByCategory = tempMap;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Panel'),
          centerTitle: false,
          actions: [
            TextButton(
                onPressed: _showResetVotingDialog,
                child: const Text('Reset Voting')),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _candidatesByCategory.keys.length,
                itemBuilder: (context, index) {
                  String category = _candidatesByCategory.keys.elementAt(index);
                  List<CandidateModel> candidates =
                      _candidatesByCategory[category]!;
                  candidates.sort((a, b) =>
                      b.numberOfVotes?.compareTo(a.numberOfVotes ?? 0) ?? 0);

                  return ExpansionTile(
                    title: Text(category),
                    children: candidates
                        .map((candidate) =>
                            _buildCandidateCard(candidate, candidates.length))
                        .toList(),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddCandidateDialog,
          tooltip: 'Add Candidate',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showResetVotingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Reset Voting"),
          content: const Text(
            "Are you sure you want to reset the voting process?",
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              onPressed: () {
                _resetAllVotes();
                Navigator.of(context).pop();
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _resetAllVotes() async {
    setState(() => _isLoading = true);
    // Fetch all candidates from the Firestore collection
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('candidates').get();

    // Create a batch to update all documents
    WriteBatch batch = FirebaseFirestore.instance.batch();
    for (var doc in snapshot.docs) {
      // Set numberOfVotes to 0 for each document
      batch.update(doc.reference, {'numberOfVotes': 0});
    }

    // Commit the batch
    await batch.commit().then((_) {
      log('All votes have been reset successfully!');
      setState(() => _isLoading = false);
      _fetchCandidates();
    }).catchError((error) {
      log('Error resetting votes: $error');
      setState(() => _isLoading = false);
    });
  }

  void _showAddCandidateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: _newCandidateFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: AlertDialog(
            title: const Text("Add New Candidate"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    hint: const Text("Select Category"),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                    items: _candidatesByCategory.keys.map((String category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                  ),
                  TextFormField(
                    controller: _nameController,
                    maxLines: null,
                    decoration: const InputDecoration(labelText: "Name"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _imageUrlController,
                    maxLines: null,
                    decoration: const InputDecoration(labelText: "Image URL"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _bioController,
                    maxLines: null,
                    decoration: const InputDecoration(labelText: "Bio"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _selectedCategory = null;
                  _nameController.clear();
                  _bioController.clear();
                  _imageUrlController.clear();
                },
              ),
              TextButton(
                child: const Text('Save'),
                onPressed: () {
                  if (_newCandidateFormKey.currentState?.validate() ?? false) {
                    _addNewCandidate();
                    Navigator.of(context).pop();
                    _selectedCategory = null;
                    _nameController.clear();
                    _bioController.clear();
                    _imageUrlController.clear();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _addNewCandidate() {
    CandidateModel newCandidate = CandidateModel(
      type: _selectedCategory,
      info: Info(
        name: _nameController.text,
        bio: _bioController.text,
        imageUrl: _imageUrlController.text,
      ),
      numberOfVotes: 0,
    );

    FirebaseFirestore.instance
        .collection('candidates')
        .add(newCandidate.toJson())
        .then((docRef) {
      log('New candidate added successfully!');
      _fetchCandidates();
    }).catchError((error) {
      log('Error adding candidate: $error');
    });
  }

  Widget _buildCandidateCard(CandidateModel candidate, int candidatesLength) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              maxLines: null,
              initialValue: candidate.info?.name ?? '',
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return 'This field is required';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            Text('Votes: ${candidate.numberOfVotes}'),
            const SizedBox(height: 12),
            Image.network(
              candidate.info?.imageUrl ?? '',
              height: 400,
              width: double.maxFinite,
              fit: BoxFit.fill,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              },
              errorBuilder: (_, __, ___) => const Placeholder(),
            ),
            const SizedBox(height: 12),
            TextFormField(
              maxLines: null,
              initialValue: candidate.info?.imageUrl ?? '',
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return 'This field is required';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              maxLines: null,
              initialValue: candidate.info?.bio,
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return 'This field is required';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(labelText: 'Bio'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FittedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _updateCandidateInfo(candidate);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Theme.of(context).primaryColor, // Text color
                    ),
                    child: const Row(
                      children: [
                        Text('Save'),
                        SizedBox(width: 4),
                        Icon(Icons.save),
                      ],
                    ),
                  ),
                ),
                FittedBox(
                  child: ElevatedButton(
                    onPressed:
                        (candidate.type == 'Member' && candidatesLength >= 6) ||
                                (candidate.type == 'Youth Member' &&
                                    candidatesLength >= 3) ||
                                candidatesLength != 0
                            ? () => _showRemoveDialog(candidate.id ?? '')
                            : null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      backgroundColor: Colors.white, // Text color
                    ),
                    child: const Row(
                      children: [
                        Text('Remove'),
                        SizedBox(width: 4),
                        Icon(Icons.delete),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _updateCandidateInfo(CandidateModel candidate) async {
    setState(() => _isLoading = true);
    try {
      await FirebaseFirestore.instance
          .collection('candidates')
          .doc(candidate.id)
          .update(candidate.toJson());
      log('Candidate updated successfully!');
    } catch (error) {
      log('Error updating candidate: $error');
    } finally {
      await _fetchCandidates();
      setState(() => _isLoading = false);
    }
  }

  void _showRemoveDialog(String candidateId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("warning"),
          content: const Text(
            "Are you sure you want to remove this candidate?",
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _removeCandidate(candidateId);
              },
              child: const Text("Remove"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            )
          ],
        );
      },
    );
  }

  void _removeCandidate(String id) {
    FirebaseFirestore.instance
        .collection('candidates')
        .doc(id)
        .delete()
        .then((_) {
      log('Candidate removed successfully!');
      _fetchCandidates();
    }).catchError((error) {
      log('Error removing candidate: $error');
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }
}
