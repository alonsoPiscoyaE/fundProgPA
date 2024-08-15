
Funcion valorVerificado <- IngresarEnteroValido(limInf,limSup)
	// FUNCION PARA LEER ENTEROS QUE NECESARIAMENTE DEBEN ESTAR EN UN INTERVALO
	Definir valorIngresado Como Entero
	Leer valorIngresado
	Mientras (valorIngresado<limInf o valorIngresado>limSup) Hacer
		Escribir "Ingrese un valor entero válido, del ",limInf," al ",limSup,":"
		Leer valorIngresado
	FinMientras
	valorVerificado <- valorIngresado
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
	// Pago único al inicio de ciclo
	// Si hay beca o media beca descuento 100% o 50%.
	// La condicion de becado es tambien parte de la info de cada estudiante
FinFuncion



Funcion ReportesAcademicos
	// Contiene las funciones:
	//		GenerarReporteEstudiante() : por estudiante, ingresando dni.
	//		EstadísticasMatrícula(): por curso o por carrera
FinFuncion



Algoritmo ProdAcred
	
	//     DEFINICIONES BASE
	Definir cantidadEstudiantes, cantidadCursos, cantidadCarreras Como Entero
	cantidadEstudiantes <- 9
	cantidadCursos <- 1
	cantidadCarreras <- 3
	
	
	//     "BASES DE DATOS" DE ESTUDIANTES
	// El ID interno de cada estudiante será su posición en la 1ra dimensión 
	// del arreglo, asignado de acuerdo al orden en que es agregado.
	// El ID interno será usado para las operaciones del programa.
	Definir datosEstudiantesCaracter Como Caracter
	Definir datosEstudiantesEntero Como Entero
	Definir datosEstudiantesHorario Como Logico
	Dimension datosEstudiantesCaracter[cantidadEstudiantes,2]
	// Los 2 espacios corresponden a CODIGO, NOMBRE
	Dimension datosEstudiantesEntero[cantidadEstudiantes,2]
	// Los 2 espacios corresponden a CARRERA (ID interno), CICLO
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
	
	
	//     "BASE DE DATOS" DE CARRERA
	// El ID interno de cada carrera será su posición en la 1ra dimensión
	Definir nombreCarrera Como Caracter
	Dimension nombreCarrera[cantidadCarreras]
	
	
	//     "BASE DE DATOS" DE CURSOS
	// El ID interno de cada curso será su posición en la 1ra dimensión
	// del arreglo, asignado de acuerdo al orden en que es agregado.
	// El ID interno será usado para las operaciones del programa.
	// Cada ciclo (2da dimensión) admite hasta 10 cursos (3ra dimensión).
	// Cada carrera (1ra dimensión) tiene 10 ciclos.
	Definir datosCursosCaracter Como Caracter
	Definir datosCursosEntero Como Entero
	Dimension datosCursosCaracter[cantidadCarreras,10,10,3]
	// Los 2 espacios corresponden a CODIGO (ABCD-1001), NOMBRE, CÓDIGO PREREQUISITO (ABCD-1001)
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
	
	
	//     INICIALIZACIÓN DE INFORMACIÓN PREDEFINIDA
	nombreCarrera[1] <- "Ingeniería Civil"       // ID interno: 1
	nombreCarrera[2] <- "Ingeniería de Sistemas" // ID interno: 2
	nombreCarrera[3] <- "Arquitectura"           // ID interno: 3
	
	// ESTUDIANTES (ID 1 a 9)
	datosEstudiantesCaracter[1,1] <- "231639H"  // Codigo
	datosEstudiantesCaracter[1,2] <- "PISCOYA ENCAJIMA JOSE ALONSO"
	datosEstudiantesEntero[1,1] <- 2  // Sistemas
	datosEstudiantesEntero[1,2] <- 9  // Ciclo
	datosEstudiantesCaracter[2,1] <- "231645H"  // Codigo
	datosEstudiantesCaracter[2,2] <- "VILLEGAS CUENCA JOSE MANUEL"
	datosEstudiantesEntero[2,1] <- 2  // Sistemas
	datosEstudiantesEntero[2,2] <- 8  // Ciclo
	datosEstudiantesCaracter[3,1] <- "231625G"  // Codigo
	datosEstudiantesCaracter[3,2] <- "CAUCHOS LABAN NELSON ANIBAL"
	datosEstudiantesEntero[3,1] <- 2  // Sistemas
	datosEstudiantesEntero[3,2] <- 7  // Ciclo
	datosEstudiantesCaracter[4,1] <- "231624K"  // Codigo
	datosEstudiantesCaracter[4,2] <- "CASTRO MENDOZA JHORDY FABRICIO"
	datosEstudiantesEntero[4,1] <- 1  // Civil
	datosEstudiantesEntero[4,2] <- 6  // Ciclo
	datosEstudiantesCaracter[5,1] <- "231620E"  // Codigo
	datosEstudiantesCaracter[5,2] <- "BARRERA ALVARADO HENRY CRISTIAN"
	datosEstudiantesEntero[5,1] <- 1  // Civil
	datosEstudiantesEntero[5,2] <- 4  // Ciclo
	datosEstudiantesCaracter[6,1] <- "231640F"  // Codigo
	datosEstudiantesCaracter[6,2] <- "QUISPE CABEZAS JUAN DE DIOS"
	datosEstudiantesEntero[6,1] <- 1  // Civil
	datosEstudiantesEntero[6,2] <- 2  // Ciclo
	datosEstudiantesCaracter[7,1] <- "231638A"  // Codigo
	datosEstudiantesCaracter[7,2] <- "PAREDES AGUINAGA JOSUE SAMUEL"
	datosEstudiantesEntero[7,1] <- 3  // Arquitectura
	datosEstudiantesEntero[7,2] <- 5  // Ciclo
	datosEstudiantesCaracter[8,1] <- "231631G"  // Codigo
	datosEstudiantesCaracter[8,2] <- "LOZANO PAZ ABIMA GALILEY"
	datosEstudiantesEntero[8,1] <- 3  // Arquitectura
	datosEstudiantesEntero[8,2] <- 3  // Ciclo
	datosEstudiantesCaracter[9,1] <- "231636I"  // Codigo
	datosEstudiantesCaracter[9,2] <- "NUÑEZ RUBIO MAICOL JHORDY"
	datosEstudiantesEntero[9,1] <- 3  // Arquitectura
	datosEstudiantesEntero[9,2] <- 1  // Ciclo
	
	// CARRERAS ING. CIVIL
	// Ciclo 1
	datosCursosCaracter[1,1,1,1] <- "MATG1001" // Código de curso 1
	datosCursosCaracter[1,1,1,2] <- "Fundamentos matemáticos"
	datosCursosCaracter[1,1,1,3] <- "0"    // Sin prerrequisito
	datosCursosEntero[1,1,1,1] <- 4    // Créditos
	datosCursosEntero[1,1,1,2] <- 0    // Cupos actuales
	datosCursosEntero[1,1,1,3] <- 35    // Cupos máximos
	datosCursosCaracter[1,1,2,1] <- "MATG1002" // Código de curso 2
	datosCursosCaracter[1,1,2,2] <- "Geometría descriptiva"
	datosCursosCaracter[1,1,2,3] <- "0"    // Sin prerrequisito
	datosCursosEntero[1,1,2,1] <- 3    // Créditos
	datosCursosEntero[1,1,2,2] <- 0    // Cupos actuales
	datosCursosEntero[1,1,2,3] <- 40    // Cupos máximos
	// Ciclo 2
	datosCursosCaracter[1,2,1,1] <- "CALC1011" // Código de curso 1
	datosCursosCaracter[1,2,1,2] <- "Cálculo diferencial"
	datosCursosCaracter[1,2,1,3] <- "MATG1001" // Prerrequisito
	datosCursosEntero[1,2,1,1] <- 5    // Créditos
	datosCursosEntero[1,2,1,2] <- 0    // Cupos actuales
	datosCursosEntero[1,2,1,3] <- 30    // Cupos máximos
	datosCursosCaracter[1,2,2,1] <- "ALIN1101" // Código de curso 2
	datosCursosCaracter[1,2,2,2] <- "Álgebra Lineal 1"
	datosCursosCaracter[1,2,2,3] <- "MATG1002" // Prerrequisito
	datosCursosEntero[1,2,2,1] <- 4    // Créditos
	datosCursosEntero[1,2,2,2] <- 0    // Cupos actuales
	datosCursosEntero[1,2,2,3] <- 30    // Cupos máximos
	
	
	//     VARIABLES AUXILIARES
	// GESTION ESTUDIANTES
	Definir codigoEstudianteBuscar Como Caracter
	Definir IdEstudianteBuscar Como Entero
	// SALIR DEL PROGRAMA
	Definir verifSalirPrograma Como Real
	verifSalirPrograma <- 1
	
	
	// MENU PRINCIPAL, recursivo hasta que verifSalirPrograma lo detenga
	Definir accionMenu Como Real
	Repetir
		Escribir "================================================"
		Escribir " BIENVENIDO AL SISTEMA DE GESTIÓN DE MATRÍCULA. "
		Escribir "================================================"
		Escribir "1. Gestión de Estudiantes."
		Escribir "2. Gestión de Cursos."
		Escribir "3. Proceso de matrícula."
		Escribir "4. Gestión de Pagos."
		Escribir "5. Reportes Académicos."
		Escribir "6. Salir del programa."
		Leer accionMenu
		Segun accionMenu Hacer
			1:
				// GESTION DE ESTUDIANTES
				Escribir "=== GESTIÓN DE ESTUDIANTES ==="
				Escribir "1. Mostrar lista de estudiantes."
				Escribir "2. Registrar un nuevo estudiante."
				Escribir "3. Buscar estudiante y/o actualizar información."
				Escribir "(otro número). Regresar al menú principal."
				Leer accionMenu
				Segun accionMenu Hacer
					1:
						// MOSTRAR LISTA DE ESTUDIANTES
						Escribir "== LISTA DE ESTUDIANTES =="
						Para i<-1 Hasta cantidadEstudiantes Hacer
							Escribir i,". ", datosEstudiantesCaracter[i,2]
							Escribir "    Código ",datosEstudiantesCaracter[i,1],", " Sin Saltar
							Escribir nombreCarrera[datosEstudiantesEntero[i,1]],", ciclo ",datosEstudiantesEntero[i,2]
							Escribir ""
						FinPara
					2:
						// REGISTRAR NUEVO ESTUDIANTE
						cantidadEstudiantes <- cantidadEstudiantes +1
						// Redimensionar todos los arreglos que dependan de la cantidad de estudiantes
						Redimension datosEstudiantesCaracter[cantidadEstudiantes,2]
						Redimension datosEstudiantesEntero[cantidadEstudiantes,2]
						Redimension datosEstudiantesHorario[cantidadEstudiantes,6,18]
						Redimension datosEstudiantesCursos[cantidadEstudiantes,10,10]
						// Leer información del nuevo estudiante
						Escribir "Ingrese el código del estudiante nuevo:"
						Leer datosEstudiantesCaracter[cantidadEstudiantes,1]
						Escribir "Ingrese los apellidos y nombres (en ese orden, en mayúsculas) del estudiante nuevo:"
						Leer datosEstudiantesCaracter[cantidadEstudiantes,2]
						Escribir "Elija la carrera del estudiante nuevo:"
						Para i<-1 Hasta cantidadCarreras Hacer
							Escribir i,". ",nombreCarrera[i]
						FinPara
						datosEstudiantesEntero[cantidadEstudiantes,1] <- IngresarEnteroValido(1,3)
						Escribir "Ingrese el ciclo en que se encuentra, del 1 al 10."
						datosEstudiantesEntero[cantidadEstudiantes,2] <- IngresarEnteroValido(1,10)
						
						// Confirmar registro de estudiante
						Escribir "Estudiante registrado correctamente."
					3:
						// BUSCAR Y/O ACTUALIZAR INFORMACIÓN DE ESTUDIANTE
						Escribir "Ingrese el código exacto (de la forma 256789A) del estudiante a buscar:"
						IdEstudianteBuscar <- 0
						Leer codigoEstudianteBuscar
						Para i<-1 Hasta cantidadEstudiantes Hacer
							Si datosEstudiantesCaracter[i,1] = codigoEstudianteBuscar Entonces
								IdEstudianteBuscar <- i
							FinSi
						FinPara
						Si IdEstudianteBuscar = 0 Entonces
							Escribir "No se encontró un estudiante con ese código exacto."
						SiNo
							Escribir "Se encontró al estudiante:"
							Escribir IdEstudianteBuscar,". ", datosEstudiantesCaracter[IdEstudianteBuscar,2]
							Escribir "    Código ",datosEstudiantesCaracter[IdEstudianteBuscar,1],", " Sin Saltar
							Escribir nombreCarrera[datosEstudiantesEntero[IdEstudianteBuscar,1]],", ciclo ",datosEstudiantesEntero[IdEstudianteBuscar,2]
							// Proceder a la actualización de un valor
							Escribir "Elija la opción a actualizar:"
							Escribir "1. Código"
							Escribir "2. Apellidos y nombres"
							Escribir "3. Carrera"
							Escribir "4. Ciclo"
							Escribir "(otro número). No actualizar nada."
							Leer accionMenu
							Segun accionMenu Hacer
								1:
									// Actualizar código
									Escribir "Ingrese el código actualizado del estudiante:"
									Leer datosEstudiantesCaracter[IdEstudianteBuscar,1]
								2:
									// Actualizar nombre
									Escribir "Ingrese los apellidos y nombres (en ese orden, en mayúsculas) actualizados del estudiante:"
									Leer datosEstudiantesCaracter[IdEstudianteBuscar,2]
								3:
									// Actualizar carrera
									Escribir "Elija la carrera actualizada del estudiante:"
									Para j<-1 Hasta cantidadCarreras Hacer
										Escribir j,". ",nombreCarrera[j]
									FinPara
									datosEstudiantesEntero[IdEstudianteBuscar,1] <- IngresarEnteroValido(1,3)
								4:
									// Actualizar ciclo
									Escribir "Ingrese el ciclo actualizado, del 1 al 10."
									datosEstudiantesEntero[IdEstudianteBuscar,2] <- IngresarEnteroValido(1,10)
								De Otro Modo:
									// Volver al menú principal
							FinSegun
						FinSi
					De Otro Modo:
						// Volver al menú principal
				FinSegun
				
				
			2:
				// GESTIÓN DE CURSOS
				Escribir "=== GESTIÓN DE CURSOS ==="
				GestionCursos
				
			3:
				// Procesos de matrícula
				Escribir "=== MATRÍCULA ==="
				ProcesoMatricula
				
			4:
				// Gestión de Pagos
				Escribir "=== PAGOS ==="
				GestionPagos
				
			5:
				// Reportes Académicos
				Escribir "=== REPORTES ACADÉMICOS ==="
				ReportesAcademicos
				
			6:
				// Diálogo para salir del programa
				Escribir "=== SALIR DEL PROGRAMA ==="
				Escribir "Desea salir del programa?"
				Escribir "0. Sí"
				Escribir "(otro número). No"
				Leer verifSalirPrograma
				
			De Otro Modo:
				Escribir "No se ingresó una opción correcta."
		Fin Segun
	Hasta Que verifSalirPrograma=0
	
	
	// Mensaje de despedida al salir
	Escribir "======================"
	Escribir "Que tenga un buen día."
FinAlgoritmo
