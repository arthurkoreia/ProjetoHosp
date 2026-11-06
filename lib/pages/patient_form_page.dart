import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'patient_list_page.dart';

enum TipoAtendimento { particular, convenio, sus }

class PatientFormPage extends StatefulWidget {
  const PatientFormPage({super.key});

  @override
  State<PatientFormPage> createState() => _PatientFormPageState();
}

class _PatientFormPageState extends State<PatientFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _telefoneController = TextEditingController();

  TipoAtendimento _tipo = TipoAtendimento.sus;
  bool _possuiAlergia = false;
  bool _salvando = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _idadeController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _salvando = true);

    try {
      await FirebaseFirestore.instance.collection('pacientes').add({
        'nome': _nomeController.text.trim(),
        'idade': int.parse(_idadeController.text.trim()),
        'telefone': _telefoneController.text.trim(),
        'tipoAtendimento': _tipo.name,
        'possuiAlergia': _possuiAlergia,
        'criadoEm': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Paciente cadastrado com sucesso!')),
      );
      _formKey.currentState!.reset();
      _nomeController.clear();
      _idadeController.clear();
      _telefoneController.clear();
      setState(() {
        _tipo = TipoAtendimento.sus;
        _possuiAlergia = false;
      });
    } on FirebaseException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao salvar no Firestore: ${e.message}')),
      );
    } finally {
      if (mounted) setState(() => _salvando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de paciente'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Dados do paciente',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
              const SizedBox(height: 18),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome completo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _idadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Idade',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake),
                ),
                validator: (v) {
                  final idade = int.tryParse(v ?? '');
                  if (idade == null || idade < 0 || idade > 120) {
                    return 'Informe uma idade válida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _telefoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (v) => v == null || v.trim().length < 8
                    ? 'Informe um telefone válido'
                    : null,
              ),
              const SizedBox(height: 14),
              const Text('Tipo de atendimento',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              ...TipoAtendimento.values.map(
                (tipo) => RadioListTile<TipoAtendimento>(
                  title: Text(switch (tipo) {
                    TipoAtendimento.particular => 'Particular',
                    TipoAtendimento.convenio => 'Convênio',
                    TipoAtendimento.sus => 'SUS',
                  }),
                  value: tipo,
                  groupValue: _tipo,
                  onChanged: (v) => setState(() => _tipo = v!),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Paciente informou possuir alergia'),
                value: _possuiAlergia,
                onChanged: (v) => setState(() => _possuiAlergia = v ?? false),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _salvando ? null : _salvar,
                icon: _salvando
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.save),
                label: Text(_salvando ? 'Salvando...' : 'Salvar cadastro'),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const PatientListPage()),
                ),
                child: const Text('Ver pacientes cadastrados'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
