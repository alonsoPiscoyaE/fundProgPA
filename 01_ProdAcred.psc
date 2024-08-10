
Funcion GestionEstudiantes
	// Contiene las funciones:
	// 		RegistrarEstudiantes() : agregar informacion de alumnos (dni, nombre, carrera, ciclo)
	//		ActualizarEstudiantes() : editar informacion ya registrada
	// 		BuscarEstudiantes() : por ID o nombre, para mostrar información relevante
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



Funcion retornoSalirPrograma <- SalirPrograma
	// Retorna un valor usado para detener el bucle de ejecución de MenuPrincipal
	Escribir "Desea salir del programa?"
	Escribir "0 = Sí"
	Escribir "(cualquier otro número) = No"
	Leer retornoSalirPrograma
FinFuncion



Algoritmo ProdAcred	
	
	Definir arr Como Caracter
	Dimension arr[5,7,8,9]
	// Variable para salir del programa
	Definir verifSalirPrograma Como Real
	verifSalirPrograma <- 1
	
	// MENU PRINCIPAL, recursivo hasta que verifSalirPrograma lo detenga
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
