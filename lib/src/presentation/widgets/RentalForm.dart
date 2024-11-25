import 'package:corvi_app/src/presentation/pages/firma/bloc/FirmaBloc.dart';
import 'package:corvi_app/src/presentation/pages/firma/bloc/FirmaEvent.dart';
import 'package:corvi_app/src/presentation/pages/firma/bloc/FirmaService.dart';
import 'package:corvi_app/src/presentation/pages/firma/bloc/FirmaState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:corvi_app/src/presentation/pages/ruc/bloc/RucBloc.dart';
import 'package:corvi_app/src/presentation/pages/ruc/bloc/RucEvent.dart';
import 'package:corvi_app/src/presentation/pages/ruc/bloc/RucState.dart';
import 'package:corvi_app/src/presentation/pages/calendar/bloc/DisponibilidadBloc.dart';
import 'package:corvi_app/src/presentation/pages/calendar/bloc/DisponibilidadEvent.dart';
import 'package:corvi_app/src/domain/models/Disponibilidad.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/RucData.dart';

class RentalForm extends StatefulWidget {
  final String precioTipo;
  final double precio;
  

  const RentalForm({super.key, required this.precioTipo, required this.precio});

  @override
  _RentalFormState createState() => _RentalFormState();
}

class _RentalFormState extends State<RentalForm> {
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _rucController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _codigoController = TextEditingController();

  double _total = 0.0;
  int? _usuarioId;

  DateTime? _fechaInicio;
  DateTime? _fechaFin;

  bool _showValidationField = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? fechaInicio = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (fechaInicio != null) {
      final DateTime? fechaFin = await showDatePicker(
        context: context,
        initialDate: fechaInicio.add(Duration(days: 1)),
        firstDate: fechaInicio,
        lastDate: DateTime(2030),
      );

      if (fechaFin != null) {
        setState(() {
          _fechaInicio = fechaInicio;
          _fechaFin = fechaFin;
          _dateController.text =
              '${fechaInicio.day}/${fechaInicio.month}/${fechaInicio.year} - ${fechaFin.day}/${fechaFin.month}/${fechaFin.year}';
          _calcularTotal();
        }); 

        final disponibilidad = Disponibilidad(
          idMaquinaria: 1, // Cambia a la ID de maquinaria correcta
          fechaInicio: fechaInicio,
          fechaFin: fechaFin,
        );

        context
            .read<DisponibilidadBloc>()
            .add(GuardarDisponibilidadEvent(disponibilidad));
      }
    }
  }

  void _calcularTotal() {
    if (widget.precioTipo == 'por día' && _fechaInicio != null && _fechaFin != null) {
      final dias = _fechaFin!.difference(_fechaInicio!).inDays + 1;
      _total = widget.precio * dias;
    } else if (widget.precioTipo == 'por hora' && _hoursController.text.isNotEmpty) {
      final horas = int.tryParse(_hoursController.text) ?? 0;
      _total = widget.precio * horas;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _hoursController.dispose();
    _rucController.dispose();
    _dateController.dispose();
    _codigoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadUsuarioId();
  }

  Future<void> _loadUsuarioId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _usuarioId = prefs.getInt('idUsuario');
    });
    if (_usuarioId == null) {
      // Mostrar un mensaje de error en un diálogo
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Inicie session para poder reservar las maquinarias.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cerrar el diálogo
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
      future: _getUsuarioId(), // Recupera dinámicamente el ID del usuario
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data != null) {
          final usuarioId = snapshot.data!;
          return BlocProvider(
            create: (_) => FirmaBloc(FirmaService(), usuarioId!),
            child: _buildForm(context),
          );
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }

  /// Método para obtener el ID del usuario autenticado
  Future<int?> _getUsuarioId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('idUsuario'); // Asegúrate de que este campo esté almacenado
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          _buildTextField('Horas', _hoursController, enabled: widget.precioTipo != 'por día', onChanged: _calcularTotal),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField('RUC', _rucController),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  final ruc = _rucController.text;
                  if (ruc.isNotEmpty) {
                    BlocProvider.of<RucBloc>(context).add(FetchRucEvent(ruc));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBCBCBC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                child: const Text(
                  'Validar',
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Mostrar detalles del RUC
          _buildRucDetailsSection(), // Incluye aquí
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: _buildTextField('Elegir fecha de alquiler', _dateController),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'Total a Pagar: S/. ${_total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontFamily: 'Oswald',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildFirmaSection(context),
        ],
      ),
    );
  }


  Widget _buildRucDetailsSection() {
    return BlocConsumer<RucBloc, RucState>(
      listener: (context, state) {
        if (state is RucError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is RucLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RucSuccess) {
          return _buildRucDetails(state.data);
        } else if (state is RucError) {
          return const Center(child: Text('No se pudo validar el RUC.'));
        }
        return const Center(child: Text('Ingrese un RUC para validar.'));
      },
    );
  }
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildRucDetails(RucData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Número de Documento:', data.numeroDocumento),
        _buildDetailRow('Razón Social:', data.razonSocial),
        _buildDetailRow('Estado:', data.estado),
        _buildDetailRow('Condición:', data.condicion),
        _buildDetailRow('Departamento:', data.departamento),
        _buildDetailRow('Provincia:', data.provincia),
        _buildDetailRow('Distrito:', data.distrito),
        _buildDetailRow('Dirección:', data.direccion),
        _buildDetailRow('Actividad Económica:', data.actividadEconomica), // Nueva propiedad
        _buildDetailRow('Tipo de Empresa:', data.tipoEmpresa), // Nueva propiedad
      ],
    );
  }


  Widget _buildFirmaSection(BuildContext context) {
    return BlocConsumer<FirmaBloc, FirmaState>(
      listener: (context, state) {
        if (state is FirmaCodigoEnviado) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Código enviado a su correo.')),
          );
          setState(() {
            _showValidationField = true; // Mostrar el campo de validación
          });
        } else if (state is FirmaCodigoValidado) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Contrato firmado exitosamente.')),
          );
          setState(() {
            _showValidationField = false; // Ocultar el campo de validación
          });
        } else if (state is FirmaError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            if (_showValidationField)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _codigoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Ingrese el código de validación',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            if (_showValidationField)
              ElevatedButton(
                onPressed: () {
                  final codigoIngresado = _codigoController.text;
                  if (codigoIngresado.isNotEmpty) {
                    context.read<FirmaBloc>().add(ValidarCodigo(codigoIngresado));
                  }
                },
                child: Text('Validar código'),
              ),
            ElevatedButton(
              onPressed: () {
                context.read<FirmaBloc>().add(EnviarCodigo());
              },
              child: Text('Firmar contrato'),
            ),
          ],
        );
      },
    );
  }


  Widget _buildTextField(String label, TextEditingController controller, {bool enabled = true, void Function()? onChanged}) {
    return TextField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontFamily: 'Oswald',
          fontSize: 16,
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
      keyboardType: label == 'Horas' || label == 'RUC'
          ? TextInputType.number
          : TextInputType.text,
      style: const TextStyle(
        fontSize: 14,
        fontFamily: 'Oswald',
      ),
      onChanged: (_) => onChanged?.call(),
    );
  }
}
