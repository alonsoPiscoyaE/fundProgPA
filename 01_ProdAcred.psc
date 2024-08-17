// FUNCIONES Y SUBPROCESOS DEFINIDOS MANUALMENTE
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



// ALGORITMO PRINCIPAL
Algoritmo ProdAcred
	
	//     DEFINICIONES BASE
	Definir cantidadEstudiantes, cantidadCursos, cantidadCarreras Como Entero
	cantidadEstudiantes <- 9
	cantidadCursos <- 4
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
	datosCursosCaracter[1,2,1,2] <- "Cálculo Diferencial"
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
	// Ciclo 3
	datosCursosCaracter[1,3,1,1] <- "CALC1012" // Código de curso 1
	datosCursosCaracter[1,3,1,2] <- "Cálculo Integral"
	datosCursosCaracter[1,3,1,3] <- "CALC1011"    // Prerrequisito
	datosCursosEntero[1,3,1,1] <- 4    // Créditos
	datosCursosEntero[1,3,1,2] <- 0    // Cupos actuales
	datosCursosEntero[1,3,1,3] <- 30    // Cupos máximos
	datosCursosCaracter[1,3,2,1] <- "ALIN1102" // Código de curso 2
	datosCursosCaracter[1,3,2,2] <- "Álgebra Lineal 2"
	datosCursosCaracter[1,3,2,3] <- "ALIN1101"    // Prerrequisito
	datosCursosEntero[1,3,2,1] <- 3    // Créditos
	datosCursosEntero[1,3,2,2] <- 0    // Cupos actuales
	datosCursosEntero[1,3,2,3] <- 25    // Cupos máximos
	// Ciclo 4
	datosCursosCaracter[1,4,1,1] <- "MATE4011" // Código de curso 1
	datosCursosCaracter[1,4,1,2] <- "Análisis Real Avanzado"
	datosCursosCaracter[1,4,1,3] <- "CALC1012" // Prerrequisito
	datosCursosEntero[1,4,1,1] <- 5    // Créditos
	datosCursosEntero[1,4,1,2] <- 0    // Cupos actuales
	datosCursosEntero[1,4,1,3] <- 28    // Cupos máximos
	datosCursosCaracter[1,4,2,1] <- "CIVI4001" // Código de curso 2
	datosCursosCaracter[1,4,2,2] <- "Introducción a la planificación de construcciones"
	datosCursosCaracter[1,4,2,3] <- "ALIN1102" // Prerrequisito
	datosCursosEntero[1,4,2,1] <- 4    // Créditos
	datosCursosEntero[1,4,2,2] <- 0    // Cupos actuales
	datosCursosEntero[1,4,2,3] <- 20    // Cupos máximos
	
	
	//     VARIABLES AUXILIARES
	// GESTION ESTUDIANTES
	Definir codigoEstudianteBuscar Como Caracter
	Definir idEstudianteBuscar Como Entero
	// GESTION CURSOS
	Definir cursoCodigoBuscar Como Caracter
	Definir cursoCarreraSeleccionado, cursoCicloSeleccionado, idCursoNuevo, cursoCantidadBusq Como Entero
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
						datosEstudiantesEntero[cantidadEstudiantes,1] <- IngresarEnteroValido(1,cantidadCarreras)
						Escribir "Ingrese el ciclo en que se encuentra, del 1 al 10."
						datosEstudiantesEntero[cantidadEstudiantes,2] <- IngresarEnteroValido(1,10)
						
						// Confirmar registro de estudiante
						Escribir "Estudiante registrado correctamente."
					3:
						// BUSCAR Y/O ACTUALIZAR INFORMACIÓN DE ESTUDIANTE
						Escribir "Ingrese el código exacto (de la forma 256789A) del estudiante a buscar:"
						idEstudianteBuscar <- 0
						Leer codigoEstudianteBuscar
						Para i<-1 Hasta cantidadEstudiantes Hacer
							Si datosEstudiantesCaracter[i,1] = codigoEstudianteBuscar Entonces
								idEstudianteBuscar <- i
							FinSi
						FinPara
						Si idEstudianteBuscar = 0 Entonces
							Escribir "No se encontró un estudiante con ese código exacto."
						SiNo
							Escribir "Se encontró al estudiante:"
							Escribir idEstudianteBuscar,". ", datosEstudiantesCaracter[idEstudianteBuscar,2]
							Escribir "    Código ",datosEstudiantesCaracter[idEstudianteBuscar,1],", " Sin Saltar
							Escribir nombreCarrera[datosEstudiantesEntero[idEstudianteBuscar,1]],", ciclo ",datosEstudiantesEntero[idEstudianteBuscar,2]
							// Proceder a la actualización de un valor
							Escribir "¿Desea actualizar la información de este estudiante?"
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
									Leer datosEstudiantesCaracter[idEstudianteBuscar,1]
								2:
									// Actualizar nombre
									Escribir "Ingrese los apellidos y nombres (en ese orden, en mayúsculas) actualizados del estudiante:"
									Leer datosEstudiantesCaracter[idEstudianteBuscar,2]
								3:
									// Actualizar carrera
									Escribir "Elija la carrera actualizada del estudiante:"
									Para j<-1 Hasta cantidadCarreras Hacer
										Escribir j,". ",nombreCarrera[j]
									FinPara
									datosEstudiantesEntero[idEstudianteBuscar,1] <- IngresarEnteroValido(1,3)
								4:
									// Actualizar ciclo
									Escribir "Ingrese el ciclo actualizado, del 1 al 10."
									datosEstudiantesEntero[idEstudianteBuscar,2] <- IngresarEnteroValido(1,10)
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
				Escribir "1. Mostrar lista de cursos por carrera o ciclo."
				Escribir "2. Registrar un nuevo curso."
				Escribir "3. Buscar curso y/o actualizar información."
				Escribir "(otro número). Regresar al menú principal."
				Leer accionMenu
				Segun accionMenu Hacer
					1:
						// LISTA DE CURSOS POR CARRERA Y CICLO
						Escribir "Elija la carrera de los cursos a mostrar:"
						Para i<-1 Hasta cantidadCarreras Hacer
							Escribir i,". ",nombreCarrera[i]
						FinPara
						cursoCarreraSeleccionado <- IngresarEnteroValido(1,cantidadCarreras)
						Escribir "Ingrese el ciclo, del 1 al 10, de los cursos a mostrar:"
						cursoCicloSeleccionado <- IngresarEnteroValido(1,10)
						Para i<-1 Hasta 10 Hacer
							Si datosCursosCaracter[cursoCarreraSeleccionado,cursoCicloSeleccionado,i,1] <> "" Entonces
								// Imprimir curso
								Escribir "Curso ",i,": ",datosCursosCaracter[cursoCarreraSeleccionado,cursoCicloSeleccionado,i,2]
								Escribir "    Código ",datosCursosCaracter[cursoCarreraSeleccionado,cursoCicloSeleccionado,i,1]
								Si datosCursosCaracter[cursoCarreraSeleccionado,cursoCicloSeleccionado,i,3] = "0" Entonces
									Escribir "    No tiene prerequisitos."
								SiNo
									Escribir "    Prerequisito: ", datosCursosCaracter[cursoCarreraSeleccionado,cursoCicloSeleccionado,i,3] 
								FinSi
								Escribir "    Créditos: ",datosCursosEntero[cursoCarreraSeleccionado,cursoCicloSeleccionado,i,1]
								Escribir "    Cupos: ",datosCursosEntero[cursoCarreraSeleccionado,cursoCicloSeleccionado,i,2]," de ",datosCursosEntero[cursoCarreraSeleccionado,cursoCicloSeleccionado,i,3]
							FinSi
						FinPara
					2:
						// REGISTRAR UN NUEVO CURSO
						Escribir "Elija la carrera a la que se va a agregar el curso:"
						Para i<-1 Hasta cantidadCarreras Hacer
							Escribir i,". ",nombreCarrera[i]
						FinPara
						cursoCarreraSeleccionado <- IngresarEnteroValido(1,cantidadCarreras)
						Escribir "Ingrese el ciclo, del 1 al 10, al que se va a agregar el curso:"
						cursoCicloSeleccionado <- IngresarEnteroValido(1,10)
						// Asignar ID interno del nuevo curso
						idNuevoCurso <- 0
						Repetir
							idNuevoCurso <- idNuevoCurso +1
						Hasta Que (datosCursosCaracter[cursoCarreraSeleccionado,cursoCicloSeleccionado,idNuevoCurso,1] = "" o idNuevoCurso > 9)
						Si (idNuevoCurso = 10 y datosCursosCaracter[cursoCarreraSeleccionado,cursoCicloSeleccionado,idNuevoCurso,1] <> "") Entonces
							Escribir "Ya se alcanzó el máximo de 10 cursos en este ciclo."
						SiNo
							// Registrar información del nuevo curso:
							Escribir "Ingrese el código exacto del nuevo curso (de la forma ABCD1001):"
							Leer datosCursosCaracter[cursoCarreraSeleccionado,cursoCicloSeleccionado,idNuevoCurso,1]
							Escribir "Ingrese el nombre del nuevo curso:"
							Leer datosCursosCaracter[cursoCarreraSeleccionado,cursoCicloSeleccionado,idNuevoCurso,2]
							Escribir "Ingrese el código del curso prerequisito, o 0 si no tiene ninguno:"
							Leer datosCursosCaracter[cursoCarreraSeleccionado,cursoCicloSeleccionado,idNuevoCurso,3]
							Escribir "Ingrese el número de créditos, de 1 a 9:"
							datosCursosEntero[cursoCarreraSeleccionado,cursoCicloSeleccionado,idNuevoCurso,1] <- IngresarEnteroValido(1,9)
							// Asignar cupos actuales a 0
							datosCursosEntero[cursoCarreraSeleccionado,cursoCicloSeleccionado,idNuevoCurso,2] <- 0
							Escribir "Ingrese el número de cupos máximos, de 10 a 60:"
							datosCursosEntero[cursoCarreraSeleccionado,cursoCicloSeleccionado,idNuevoCurso,3] <- IngresarEnteroValido(10,60)
							Escribir "Curso registrado correctamente."
						FinSi
					3:
						// BUSCAR CURSO Y/O ACTUALIZAR INFORMACIÓN
						Escribir "Ingrese el código exacto del curso a buscar (de la forma ABCD1001):"
						Leer cursoCodigoBuscar
						// Restablecer contador de búsqueda
						cursoCantidadBusq <- 0
						Escribir "Resultados de búsqueda:"
						Para i<-1 Hasta cantidadCarreras Hacer // Busca cada carrera
							Para j<-1 Hasta 10 Hacer           // Busca cada ciclo
								Para k<-1 Hasta 10 Hacer       // Busca cada espacio de los 10 max. de cursos.
									Si datosCursosCaracter[i,j,k,1] = cursoCodigoBuscar Entonces
										// Imprimir curso
										Escribir datosCursosCaracter[i,j,k,1],": ",datosCursosCaracter[i,j,k,2]
										Escribir "    ",nombreCarrera[i],", ciclo ",j,"."
										Si datosCursosCaracter[i,j,k,3] = "0" Entonces
											Escribir "    No tiene prerequisitos."
										SiNo
											Escribir "    Prerequisito: ", datosCursosCaracter[i,j,k,3] 
										FinSi
										Escribir "    Créditos: ",datosCursosEntero[i,j,k,1]
										Escribir "    Cupos: ",datosCursosEntero[i,j,k,2]," de ",datosCursosEntero[i,j,k,3]
										cursoCantidadBusq <- cursoCantidadBusq+1
										// Proceder a la actualización del curso
										Escribir "¿Desea actualizar algún dato de este curso?"
										Escribir "1. Código"
										Escribir "2. Nombre"
										Escribir "3. Código del prerrequisito"
										Escribir "4. Créditos"
										Escribir "5. Cupos máximos"
										Escribir "(otro número). No actualizar nada"
										Leer accionMenu
										Segun accionMenu Hacer
											1:
												// Actualizar código
												Escribir "Ingrese el código exacto actualizado del curso (de la forma ABCD1001):"
												Leer datosCursosCaracter[i,j,k,1]
											2:
												// Actualizar nombre
												Escribir "Ingrese el nombre actualizado del curso:"
												Leer datosCursosCaracter[i,j,k,2]
											3:
												// Actualizar código prerrequisito
												Escribir "Ingrese el código del curso prerequisito, o 0 si no tiene ninguno:"
												Leer datosCursosCaracter[i,j,k,3]
											4:
												// Actualizar créditos
												Escribir "Ingrese el número de créditos, de 1 a 9:"
												datosCursosEntero[i,j,k,1] <- IngresarEnteroValido(1,9)
											5:
												// Actualizar cupos máximos
												Escribir "Ingrese el número de cupos máximos, de 10 a 60:"
												datosCursosEntero[i,j,k,3] <- IngresarEnteroValido(10,60)
											De Otro Modo:
												// Continuar búsqueda o volver al menú principal.
										FinSegun
									FinSi
								FinPara
							FinPara
						FinPara
						Si cursoCantidadBusq <- 0 Entonces
							Escribir "No se encontró ningún curso con el código proporcionado"
						FinSi
					De Otro Modo:
						// Volver al menú principal
				FinSegun
				
				
				
				
				
			3:
				// Procesos de matrícula
				// Contiene las funciones:
				// 		MatricularEstudianteEnCurso() : Agregar estudiante a ciertos cursos acorde a su ciclo y carrera
				// 		VerificarMatricula() : Verificar prerequisitos y conflictos horarios 
				// 		GenerarBoletaMatricula() : con costo total
				Escribir "=== MATRÍCULA ==="
				Escribir "Aún no implementado."
				
				
				
				
				
			4:
				// Gestión de Pagos
				// Contiene las funciones:
				// 		RegistrarPagos() : de matrícula
				// 		CalcularDscto() : por pronto pago o becas.
				// Pago único al inicio de ciclo
				// Si hay beca o media beca descuento 100% o 50%.
				// La condicion de becado es tambien parte de la info de cada estudiante
				Escribir "=== PAGOS ==="
				Escribir "Aún no implementado."
				
				
				
				
				
			5:
				// Reportes Académicos
				// Contiene las funciones:
				//		GenerarReporteEstudiante() : por estudiante, ingresando dni.
				//		EstadísticasMatrícula(): por curso o por carrera
				Escribir "=== REPORTES ACADÉMICOS ==="
				Escribir "Aún no implementado."
				
				
				
				
				
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
