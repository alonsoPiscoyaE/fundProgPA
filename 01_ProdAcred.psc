
Funcion GestionEstudiantes
	// Contiene las funciones:
	// 		RegistrarEstudiantes() : agregar informacion de alumnos (dni, nombre, carrera, ciclo)
	//		ActualizarEstudiantes() : editar informacion ya registrada
	// 		BuscarEstudiantes() : por DNI o nombre, para mostrar información relevante
FinFuncion



Funcion GestionCursos
	// Contiene las funciones:
	// 		RegistrarCursos() : agregar cursos (código, nombre, créditos, cupos máximos)
	// 		ActualizarCursos() : editar información ya registrada
	// 		MostrarCursos() : mostrar lista de cursos disponibles por carrera o por ciclo
FinFuncion



Funcion ProcesoMatricula
	// Contiene las funciones:
	// 		MatricularEstudianteEnCurso() : Agregar estudiante a ciertos cursos acorde a su ciclo y carrera
	// 		VerificarMatricula() : Verificar prerequisitos y conflictos horarios 
	// 		GenerarBoletaMatricula() : con costo total
FinFuncion



Funcion GestionPagos
	// Contiene las funciones:
	// 		RegistrarPagos() : de matrícula
	// 		CalcularDscto() : por pronto pago o becas.
FinFuncion



Funcion ReportesAcademicos
	// Contiene las funciones:
	//		GenerarReporteEstudiante() : por estudiante, ingresando dni.
	//		EstadísticasMatrícula(): por curso o por carrera
FinFuncion



Algoritmo ProdAcred
	
	//     DEFINICIONES BASE
	Definir cantidadEstudiantes, cantidadCursos Como Entero
	cantidadEstudiantes <- 1
	cantidadCarreras <- 1
	
	
	//     BASES DE DATOS DE ESTUDIANTES
	// El ID interno de cada estudiante será su posición en la 1ra dimensión 
	// del arreglo, asignado de acuerdo al orden en que es agregado.
	// El ID interno será usado para las operaciones del programa.
	Definir datosEstudiantesCaracter Como Caracter
	Definir datosEstudiantesHorario Como Logico
	Dimension datosEstudiantesCaracter[cantidadEstudiantes,4]
	// Los 4 espacios corresponden a DNI, NOMBRE, CARRERA, CICLO
	Dimension datosEstudiantesHorario[cantidadEstudiantes,6,18]
	// Arreglo de booleanos lógicos (0 o 1) donde:
	// 0 = Espacio vacío sin clases
	// 1 = Espacio lleno con clases
	// La 2da dimensión es el Día de la semana (1-6)
	// La 3ra dimensión es el Bloque horario (1-18)
	//   °ID interno    Lun  Mar  Mie  Jue  Vie  Sab
	//   7:30 - 8:20     1    2    3    4    5    6
	//   8:20 - 9:10     2
	//   9:10 - 10:00    3
	//  10:00 - 10:50    4
	//  10:50 - 11:40    5
	//  11:40 - 12:30    6
	//  12:30 - 13:20    7
	//  13:20 - 14:10    8
	//  14:10 - 15:00    9
	//  15:00 - 15:50   10
	//  15:50 - 16:40   11
	//  16:40 - 17:30   12
	//  17:30 - 18:20   13
	//  18:20 - 19:10   14
	//  19:10 - 20:00   15
	//  20:00 - 20:50   16
	//  20:50 - 21:40   17
	//  21:40 - 22:30   18
	
	
	//     BASE DE DATOS DE CARRERA
	// El ID interno de cada carrera será su posición en la 1ra dimensión
	Definir nombreCarrera Como Caracter
	Dimension nombreCarrera[cantidadCarreras]
	// El espacio corresponde a NOMBRE.
	
	
	//     BASE DE DATOS DE CURSOS
	// El ID interno de cada curso será su posición en la 1ra dimensión
	// del arreglo, asignado de acuerdo al orden en que es agregado.
	// El ID interno será usado para las operaciones del programa.
	// Cada ciclo (2da dimensión) admite hasta 10 cursos (3ra dimensión).
	// Cada carrera (1ra dimensión) tiene 10 ciclos.
	Definir datosCursosCaracter Como Caracter
	Definir datosCursosEntero Como Entero
	Dimension datosCursosCaracter[cantidadCarreras,10,10,3]
	// Los 2 espacios corresponden a CODIGO (ABCD-1001), NOMBRE, CÓDIGO PREREQUISITO
	Dimension datosCursosEntero[cantidadCarreras,10,10,3]
	// Los 3 espacios corresponden a CRÉDITOS, CUPOS ACTUALES, CUPOS MÁXIMOS
	
	
	//     REGISTRO DE CURSOS POR ESTUDIANTE	
	Definir datosEstudiantesCursos Como Logico
	Dimension datosEstudiantesCursos[cantidadEstudiantes,10,10]
	// Arreglo de booleanos lógicos (0 o 1) donde:
	// 0 = No lleva el curso
	// 1 = Sí lleva el curso
	// La 1ra dimensión es el ID interno del estudiante
	// La 2da dimensión es el ID interno del curso
	
	
	// Variable para salir del programa
	Definir verifSalirPrograma Como Real
	verifSalirPrograma <- 1
	
	
	//     Definición de datos iniciales
	
	
	// MENU PRINCIPAL, recursivo hasta que verifSalirPrograma lo detenga
	Definir accionMenuPrincipal Como Real
	Repetir
		Escribir "Bienvenido a blablabla."
		Escribir "1. Gestión de Estudiantes."
		Escribir "2. Gestión de Cursos."
		Escribir "3. Proceso de matrícula."
		Escribir "4. Gestión de Pagos."
		Escribir "5. Reportes Académicos."
		Escribir "6. Salir del programa."
		Leer accionMenuPrincipal
		Segun accionMenuPrincipal Hacer
			1:
				// Gestión de Estudiantes
				GestionEstudiantes
				
			2:
				// Gestión de Cursos
				GestionCursos
				
			3:
				// Procesos de matrícula
				ProcesoMatricula
				
			4:
				// Gestión de Pagos
				GestionPagos
				
			5:
				// Reportes Académicos
				ReportesAcademicos
				
			6:
				// Diálogo para salir del programa
				Escribir "Desea salir del programa?"
				Escribir "0 = Sí"
				Escribir "(cualquier otro número) = No"
				Leer verifSalirPrograma
				
			De Otro Modo:
				Escribir "No se ingresó una opción correcta."
		Fin Segun
	Hasta Que verifSalirPrograma=0
	
	
	// Mensaje de despedida al salir
	Escribir "Que tenga un buen día."
FinAlgoritmo
