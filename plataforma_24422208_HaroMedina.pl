:- module(plataforma_24422208_HaroMedina, [
    plataforma/5
    ]).

:- use_module(tarea_24422208_HaroMedina).
:- use_module(agente_24422208_HaroMedina).

% RF05 TDA Plataforma
% Descripción: Relaciona agentes,tareas,máximo de ciclos y semillas con la plataforma. Las tareas quedan en la cola, y la plataforma guarda el ciclo actual y el historial.
% Dom: Agentes(lista de agentes) X Tareas(lista de tareas) X MaxCiclos(int mayor que 0) X Seed(int mayor que 0) 
% Rec: Plataforma(plataforma)
% Estrategia: No aplica

plataforma(Agentes,Tareas,MaxCiclos,Seed,[Agentes,TareasOrdenadas,MaxCiclos,Seed,0,[]]):-
    paresPrioridad(Tareas,Pares),
    keysort(Pares,ParesOrdenados),
    extraerTareas(ParesOrdenados,TareasOrdenadas).


%SELECTORES

% Descripción: relaciona una plataforma con su lista de agentes.
% Dom: Plataforma(plataforma)
% Rec: Agentes(lista)
% Estrategia: No aplica
plataformaAgentes([Agentes | _],Agentes).


% Descripción: relaciona una plataforma con su cola de tareas.
% Dom: Plataforma(plataforma)
% Rec: Tareas(lista)
% Estrategia: No aplica
plataformaTareas([_, Tareas | _ ],Tareas).


% Descripción: relaciona una plataforma con su cantidad máxima de ciclos.
% Dom: Plataforma(plataforma)
% Rec: MaxCiclos(int)
% Estrategia: No aplica
plataformaMaxCiclos([_,_,MaxCiclos | _ ],MaxCiclos).

% Descripción: relaciona una plataforma con su seed.
% Dom: Plataforma(plataforma)
% Rec: Seed(int)
% Estrategia: No aplica
plataformaSeed([_,_,_,Seed | _ ],Seed).

% Descripción: relaciona una plataforma con su ciclo actual.
% Dom: Plataforma(plataforma)
% Rec: CicloActual(int)
% Estrategia: No aplica
plataformaCicloActual([_,_,_,_,CicloActual | _ ],CicloActual).

% Descripción: relaciona una plataforma con su historial.
% Dom: Plataforma(plataforma)
% Rec: Historial(lista de strings)
% Estrategia: No aplica
plataformaHistorial([_,_,_,_,_,Historial],Historial).






%Funciones auxiliares

% Para RF05
% Descripción: Crea una lista de pares en formato tarea-prioridad
% Dom: Tareas(Lista)
% Rec: Pares(Lista)
% Estrategia: Recursión natural

%Caso base
paresPrioridad([],[]).

%Caso recursivo
paresPrioridad([Tarea | T], [P-Tarea | Resto]):-
    tareaPrioridad(Tarea,P),
    paresPrioridad(T,Resto).


% Descripción: Extrae una lista de tareas de una lista de pares de formato Prioridad-Tarea
% Dom: Pares(Lista)
% Rec: Tareas(Lista)
% Estrategia: Recursión natural

%Caso base
extraerTareas([],[]).

%Caso recursivo
extraerTareas([_-T | Resto], [T| Resto2 ]):-
    extraerTareas(Resto,Resto2).

% Para RF06
% Descripción: Extrae una lista de tareas de una lista de pares de formato Prioridad-Tarea.
% Dom: Pares(Lista)
% Rec: Tareas(Lista)
% Estrategia: Recursión natural

buscarAgente(Id, [Agente | _],Agente):-
    agenteId(Agente,Id).

buscarAgente(Id, [_ | Resto],Agente):-
    buscarAgente(Id,Resto,Agente).


%Nota para informe: Se decidió crear la siguiente funcion auxiliar para agilizar el proceso de modificar un agente en especifico(RF06), y por si hiciese falta en otros requisitos mas adelante.

% Descripción: Reemplaza un elemento de una lista por un nuevo elemento
% Dom: Viejo(término) X Nuevo(término) X ListaVieja(lista)
% Rec: ListaNueva(lista)
% Estrategia: Recursión natural

% Caso Base
reemplazarElemento(Viejo,Nuevo,[Viejo | Resto],[Nuevo | Resto]) :- !.

% Caso recursivo
reemplazarElemento(Viejo,Nuevo,[Elemento | Resto],[Elemento | Resto2]):-
    reemplazarElemento(Viejo,Nuevo,Resto,Resto2).


% Para RF07
% Descripción: Inserta una tarea en la cola de tareas siguiendo el criterio de prioridad. La tarea queda después de las que tienen un número de prioridad menor o igual al suyo y antes de la primera con un número mayor.
% Dom: TareaNueva(tarea) X Cola(lista)
% Rec: ColaNueva(lista)
% Estrategia: Recursión natural 

% Caso Base
insertarPorPrioridad(TareaNueva,[],[TareaNueva]).

% Casos recursivos
insertarPorPrioridad(TareaNueva,[Tarea | Resto],[TareaNueva | Resto2]):-
    tareaPrioridad(TareaNueva,PrioridadNueva),
    tareaPrioridad(Tarea,Prioridad),
    PrioridadNueva >= Prioridad,
    insertarPorPrioridad(TareaNueva,Resto,Resto2).

insertarPorPrioridad(TareaNueva,[Tarea | Resto],[TareaNueva,Tarea | Resto]):-
    tareaPrioridad(TareaNueva,PrioridadNueva),
    tareaPrioridad(Tarea,Prioridad),
    PrioridadNueva < Prioridad.

%  Para RF08
% Descripción: Verifica que un agente tenga un rol específico y esté disponible.
% Dom: Rol(átomo de roles) X Agente(agente)
% Rec: Booleano
% Estrategia: No aplica
% Nota para el informe, predicado auxiliar pedido por el enunciado
delRol(Rol,Agente):-
    agenteRol(Agente,Rol),
    agenteEstado(Agente,disponible).

% Para RF09

% Descripción: Busca una tarea en una cola de tareas y la devuelve.
% Dom: Id(int) X Cola(lista)
% Rec: TareaBuscada(tarea)
% Estrategia: Recursión natural.

% Nota para informe en la seccion de diseño, originalmente se habia decidido diseñar un predicado para buscar y eliminar una tarea, es decir, en  un solo predicado, pero para mayor practicidad para los siguientes RF se decidió separarlos en 2.

buscarTarea(Id,[Tarea | _ ],Tarea):-
    tareaId(Tarea,Id), !.

buscarTarea(Id,[Tarea | Resto],TareaBuscada):-
    tareaId(Tarea,IdTarea),
    Id \= IdTarea,
    buscarTarea(Id,Resto,TareaBuscada).

% Descripción: Busca y elimina una tarea en la cola de tareas según su id.
% Dom: Id(int) X Cola(lista)
% Rec: ColaNueva(lista)
% Estrategia: Recursión natural.

eliminarTarea(Id,[Tarea | Resto],Resto):-
    tareaId(Tarea,Id), !.

eliminarTarea(Id,[Tarea | Resto],[Tarea | Resto2]):-
    tareaId(Tarea,IdTarea),
    Id \= IdTarea,
    eliminarTarea(Id,Resto,Resto2).

% Descripción: Crea una lista de subtareas a partir de una tarea original, asignando el resto de la complejidad a las primeras.
% Dom: Tarea(tarea) X Partes(int) X Cociente(int) X Resto(int) X Indice(int)
% Rec: ListaSubTareas(lista de tareas)
% Estrategia: Recursión natural.

% Caso base
crearSubTareas(_,Partes,_,_,Indice,[]):-
    Indice > Partes, !.

% Caso recursivo
crearSubTareas(Tarea,Partes,Cociente,Resto,Indice,[TareaNueva | Resto2]):-
    Tarea = [Id,Descripcion,Rol,Herramienta,Datos,_,Prioridad | _],
    IdNuevo is Id * 10 + Indice,
    format(string(DescripcionNueva),"~w (parte ~w de ~w)",[Descripcion,Indice,Partes]),
    
    % Se calcula la complejidad nueva
    calcularComplejidad(Indice,Resto,Cociente,ComplejidadNueva),

    % Se crea la tarea nueva
    TareaNueva = [IdNuevo,DescripcionNueva,Rol,Herramienta,Datos,ComplejidadNueva,Prioridad,pendiente,[],""],

    IndiceNuevo is Indice + 1,
    crearSubTareas(Tarea,Partes,Cociente,Resto,IndiceNuevo,Resto2).



% Descripcion: Calcula la complejidad de una subtarea asignando el resto a las primeras
% Dom: Indice(int) X Resto(int) X Cociente(int)
% Rec: ComplejidadNueva(int)
% Estrategia: No aplica.

calcularComplejidad(Indice,Resto,Cociente,ComplejidadNueva):-
    Indice =< Resto,
    ComplejidadNueva is Cociente + 1.

calcularComplejidad(Indice,Resto,Cociente,ComplejidadNueva):-
    Indice > Resto,
    ComplejidadNueva is Cociente.

% Descripción: Encola la lista de subtareas en la plataforma utilizando el RF07: Encolar tarea.
% Dom: Plataforma(plataforma) X ListaSubTareas(lista)
% Rec: PlataformaSalida(plataforma)
% Recursión natural.

% Caso base
encolarSubTareas(Plataforma,[],Plataforma).

% Caso recursivo
encolarSubTareas(Plataforma,[Subtarea | Resto],PlataformaSalida):-
    encolarTarea(Plataforma,Subtarea,Plataforma2),
    encolarSubTareas(Plataforma2,Resto,PlataformaSalida).

%Nota para informe, este es uno de los RF que más me costó y en los que más me sirvió dividir algunos procesos en funciones auxiliares

% Para RF10
% Descripcion: Verifica si una tarea es dependiente de otra, y comprueba si su dependencia está completada.
% Dom: Datos(término) X Cola(lista)
% Rec: Booleano
% Estrategia: No aplica

% Caso 1: hay dependencia
verificarDependencia(resultado(IdDependencia),Cola):-
    buscarTarea(IdDependencia,Cola,TareaDependencia),
    tareaEstado(TareaDependencia, completada).

% Caso 2: No hay dependencia
verificarDependencia(Datos, _):-
    Datos \= resultado(_).


% Descripción: Verifica que una tarea esté pendiente y cumpla sus dependencias.
% Dom: Tarea(tarea) X Cola(lista)
% Rec: Booleano
% Estrategia: No aplica.
% Nota para informe, se optó por una funcion auxiliar para verificar las condiciones de la tarea para evitar alargar el codigo principal del RF
esTareaValida(Tarea,Cola):-
    tareaEstado(Tarea,pendiente),
    tareaDatos(Tarea,Datos),
    verificarDependencia(Datos,Cola).

% Descripción: Verifica que un agente tenga herramientas utilizables, es decir que la herramienta buscada esté entre su lista de herramientas.
% Dom: HerramientaBuscada(herramienta) X Agente(agente)
% Rec: Booleano
% Estrategia: No aplica.

tieneHerramientas(HerramientaBuscada,Agente):-
    agenteHerramientas(Agente,HerramientasAgente),
    member(HerramientaBuscada,HerramientasAgente).


% Descripcion: Compara dos agentes según el criterio de mayor cantidad de tokens, y menor Id.
% Dom: Agente1(agente) X Agente2(agente)
% Rec: Resultado(símbolo)
% Estrategia: No aplica.

% Nota para el informe para la sección de dificultades, se me complicó entender la sintaxis del predicado de orden superior predsort/3 debido al como deben ir los argumentos, lo que significa cada uno y sobretodo como funciona el comparador

% Casos donde los tokens actuales entre los agentes son diferentes
% Caso 1: Tokens de agente 1 > Tokens de agente 2
elegirCandidato(Resultado,Agente1,Agente2):-
    agenteTokensActuales(Agente1,Tokens1),
    agenteTokensActuales(Agente2,Tokens2),
    Tokens1 > Tokens2,
    Resultado = < .

% Caso 2: Tokens de agente 2 > Tokens de agente 1
elegirCandidato(Resultado,Agente1,Agente2):-
    agenteTokensActuales(Agente1,Tokens1),
    agenteTokensActuales(Agente2,Tokens2),
    Tokens1 < Tokens2,
    Resultado = > .

% Casos donde los tokens son iguales
elegirCandidato(Resultado,Agente1,Agente2):-
    agenteTokensActuales(Agente1,Tokens1),
    agenteTokensActuales(Agente2,Tokens2),
    Tokens1 = Tokens2,
    agenteId(Agente1,Id1),
    agenteId(Agente2,Id2),
    Id1 < Id2,
    Resultado = < .

elegirCandidato(Resultado,Agente1,Agente2):-
    agenteTokensActuales(Agente1,Tokens1),
    agenteTokensActuales(Agente2,Tokens2),
    Tokens1 = Tokens2,
    agenteId(Agente1,Id1),
    agenteId(Agente2,Id2),
    Id2 < Id1,
    Resultado = > .


% Requisitos Funcionales (RF06-RF17)

% RF06 Vinculación de agentes
% Descripción: Relaciona la plataforma con otra en que el agente IdSupervisor supervisa al agente IdSubordinado. El vinculo existe en PlataformaSalida y en las plataformas que se obtienen de ella.
% Dom: Plataforma(plataforma) X IdSupervisor(int) X IdSubordinado(int)
% Rec: PlataformaSalida(plataforma)
% Estrategia: Recursión natural
vincularAgentes(Plataforma,IdSupervisor,IdSubordinado,PlataformaSalida):-
    plataformaAgentes(Plataforma,Agentes),

    %Verificacion de condiciones
    buscarAgente(IdSupervisor,Agentes,Supervisor),
    buscarAgente(IdSubordinado,Agentes,Subordinado),

    agenteRol(Supervisor,RolSupervisor),
    RolSupervisor = orquestador,

    agenteRol(Subordinado,RolSubordinado),
    RolSubordinado \= orquestador,

    agenteSupervisor(Subordinado, SupervisorAsignado),
    SupervisorAsignado = [],

    %Modificacion de subordinado y supervisor
    Subordinado = [IdSub,NombreSub,RolSub,HerramientasSub,TokensInicialesSub,TokensActualesSub,VentanaSub,EstadoSub,[],SubordinadosSub,MemoriaSub],
    NuevoSubordinado = [IdSub,NombreSub,RolSub,HerramientasSub,TokensInicialesSub,TokensActualesSub,VentanaSub,EstadoSub,IdSupervisor,SubordinadosSub,MemoriaSub],

    Supervisor = [IdSup,NombreSup,RolSup,HerramientasSup,TokensInicialesSup,TokensActualesSup,VentanaSup,EstadoSup,SupervisorSup,SubordinadosSup,MemoriaSup],
    append(SubordinadosSup,[IdSubordinado],NuevoSubordinadosSup),
    NuevoSupervisor = [IdSup,NombreSup,RolSup,HerramientasSup,TokensInicialesSup,TokensActualesSup,VentanaSup,EstadoSup,SupervisorSup,NuevoSubordinadosSup,MemoriaSup],

    %Modificacion de lista de agentes
    reemplazarElemento(Subordinado,NuevoSubordinado,Agentes,AgentesNuevos),
    reemplazarElemento(Supervisor,NuevoSupervisor,AgentesNuevos,AgentesFinales),

    %Modificacion del historial
    plataformaCicloActual(Plataforma,CicloActual),
    format(string(EventoNuevo),"ciclo ~w: ~w supervisa a ~w",[CicloActual,NombreSup,NombreSub]),

    %ModificarPlataforma
    Plataforma = [_,TareasPlat,MaxCiclosPlat,SeedPlat,CicloActualPlat,HistorialPlat],
    append(HistorialPlat,[EventoNuevo],NuevoHistorialPlat),
    PlataformaSalida = [AgentesFinales,TareasPlat,MaxCiclosPlat,SeedPlat,CicloActualPlat,NuevoHistorialPlat].


% RF07 Encolado de una tarea
% Descripción: Relaciona la plataforma con otra cuya cola tiene además la tarea. La tarea queda después de las que tienen un número de prioridad menor o igual al suyo y antes de la primera con un número mayor.
% Dom: Plataforma(plataforma) X Tarea(tarea)
% Rec: PlataformaSalida(plataforma)
% Estrategia: No aplica.


% Nota para informe, como se comentó para la forma de encolar las tareas en el constructor de la plataforma se tenian las posibilidades de hacerlo con el uso del rf07 o con pares ordenados, en este caso se decidió hacerlo mediante pares ordenados, dado que se diseñó primero el constructor de la plataforma, aunque igualmente se diseñó el RF07, que será usado en los proximos RF.

encolarTarea(Plataforma,Tarea,PlataformaSalida):-
    Plataforma = [Agentes,ColaActual,MaxCiclos,Seed,CicloActual,Historial],
    tareaId(Tarea,Id),
    % Verificacion de que no exista una tarea con el mismo id en la cola de tareas
    \+ member([Id | _ ],ColaActual),
    
    % Se inserta la tarea en la cola de tareas y se modifica la plataforma
    insertarPorPrioridad(Tarea,ColaActual,ColaNueva),
    PlataformaSalida = [Agentes,ColaNueva,MaxCiclos,Seed,CicloActual,Historial].


% RF08 Agentes por el rol
% Descripción: Relaciona la plataforma y un rol con sus candidatos: primero los agentes disponibles del rol y después los genéricos disponibles, cada grupo en el orden la plataforma. Para el rol generico, solo los genéricos, una vez cada uno.
% Dom: Plataforma(plataforma) X Rol(átomo de roles)
% Rec: Agentes(lista de agentes)
% Estrategia: No aplica.

% Caso rol generico
agentesPorRol(Plataforma,generico,Agentes):-
    plataformaAgentes(Plataforma,AgentesActuales),
    include(delRol(generico),AgentesActuales,Agentes).

% Caso rol especifico
agentesPorRol(Plataforma,Rol,Agentes):-
    plataformaAgentes(Plataforma,AgentesActuales),
    Rol \= generico,
    % Se filtran los agentes segun el rol especifico y los genericos
    include(delRol(Rol),AgentesActuales,AgentesRol),
    include(delRol(generico),AgentesActuales,AgentesGenericos),

    % Se unen ambas listas de agentes filtrados
    append(AgentesRol,AgentesGenericos,Agentes).


% RF09 Planificación de una tarea
% Descripción: Relaciona la plataforma con otra en que la tarea idTarea ya no está y la cola tiene Partes subtareas. 
% Dom: Plataforma(plataforma) X idTarea(int) X Partes(int)
% Rec: PlataformaSalida(plataforma)
% Estrategia: No aplica.
planificarTarea(Plataforma,IdTarea,Partes,PlataformaSalida):-
    Plataforma = [Agentes,ColaActual,MaxCiclos,Seed,CicloActual,Historial],
    
    % Verificación de condiciones
    buscarTarea(IdTarea,ColaActual,Tarea),
    tareaEstado(Tarea,pendiente),
    Partes >= 2,
    tareaComplejidad(Tarea,Complejidad),
    Complejidad >= Partes,

    % Se elimina la tarea original de la cola
    eliminarTarea(IdTarea,ColaActual,ColaSinTarea),

    % Calculo de cociente y resto 
    Cociente is Complejidad // Partes,
    Resto is Complejidad mod Partes,

    % Creación de subtareas
    crearSubTareas(Tarea,Partes,Cociente,Resto,1,ListaSubTareas),

    % Se encolan las nuevas subtareas
    Plataforma2 = [Agentes,ColaSinTarea,MaxCiclos,Seed,CicloActual,Historial],
    encolarSubTareas(Plataforma2,ListaSubTareas,Plataforma3),

    Plataforma3 = [AgentesFinales,ColaFinal,MaxCiclosFinal,SeedFinal,CicloActualFinal,Historial2],
    tareaDescripcion(Tarea,Descripcion),
    format(string(EventoNuevo), "ciclo ~w: tarea ~w planificada en ~w subtareas",[CicloActualFinal,Descripcion,Partes]),
    append(Historial2,[EventoNuevo],HistorialFinal),

    PlataformaSalida = [AgentesFinales,ColaFinal,MaxCiclosFinal,SeedFinal,CicloActualFinal,HistorialFinal].



% RF10 Asignación de una tarea
% Descripción: Relaciona la plataforma con otra en que la tarea idTarea está asignada al agente que la plataforma elige con una regla fija. 
% Dom: Plataforma(plataforma) X idTarea(int)
% Rec: PlataformaSalida(plataforma)
% Estrategia: No aplica.
asignarTarea(Plataforma,IdTarea,PlataformaSalida):-
    Plataforma = [Agentes,ColaActual,MaxCiclos,Seed,CicloActual,Historial],
    
    % Verificación de condiciones
    buscarTarea(IdTarea,ColaActual,Tarea),
    esTareaValida(Tarea,ColaActual),
    
    tareaHerramienta(Tarea,HerramientaRequerida),
    tareaRol(Tarea,RolRequerido),

    % Candidatos 
    agentesPorRol(Plataforma,RolRequerido,Candidatos),

    % Se filtran los candidatos 
    include(tieneHerramientas(HerramientaRequerida),Candidatos,CandidatosFiltrados),

    % Se verifica que hayan candidatos aptos
    CandidatosFiltrados \= [],

    % Se elige al candidato final en base al criterio de mayor cantidad de tokens actuales y menor Id
    predsort(elegirCandidato,CandidatosFiltrados,CandidatosFinales),
    CandidatosFinales = [AgenteElegido | _ ],

    % Se actualiza el agente y la tarea
    Tarea = [Id,DescripcionTarea,RolRequerido,HerramientaRequerida,DatosTarea,ComplejidadTarea,PrioridadTarea,_,_,ResultadoTarea],
    agenteId(AgenteElegido,IdAgenteElegido),
    TareaNueva = [Id,DescripcionTarea,RolRequerido,HerramientaRequerida,DatosTarea,ComplejidadTarea,PrioridadTarea,asignada,IdAgenteElegido,ResultadoTarea],
    reemplazarElemento(Tarea,TareaNueva,ColaActual,ColaNueva),

    AgenteElegido = [IdAgente,NombreAgente,RolAgente,HerramientaAgente,TokensInicialesAgente,TokensActualesAgente,VentanaAgente,_],
    AgenteNuevo = [IdAgente,NombreAgente,RolAgente,HerramientaAgente,TokensInicialesAgente,TokensActualesAgente,VentanaAgente,ocupado],
    reemplazarElemento(AgenteElegido,AgenteNuevo,Agentes,AgentesNuevos),

    % Se actualiza el historial
    format(string(NuevoEvento), "ciclo ~w: tarea ~w asignada a ~w",[CicloActual,DescripcionTarea,NombreAgente]),
    append(Historial,[NuevoEvento],HistorialNuevo),

    PlataformaSalida = [AgentesNuevos,ColaNueva,MaxCiclos,Seed,CicloActual,HistorialNuevo].
    





% RF17 Representación como string
% Descripción: Relaciona la plataforma con un string de varias líneas que la muestra.
% Dom: Plataforma(plataforma)
% Rec. String(string)

imprimirPlataforma(Plataforma,String):-
    Plataforma = [Agentes,ColaActual,MaxCiclos,Seed,CicloActual,Historial],
    

    % Se calcula el total de tokens gastados
    foldl(calcularTokensGastados,Agentes,0,TotalTokensGastados).



% Descripción: Calcula los tokens gastados por un agente y los suma a un acumulador
% Dom: Agente(agente) X Acumulador(int) X AcumuladorNuevo(int)
% Rec: No aplica
% Estrategia: No aplica.
calcularTokensGastados(Agente,Acumulador,AcumuladorNuevo):-
    agenteTokensActuales(Agente,TokensActuales),
    agenteTokensIniciales(Agente,TokensIniciales),

    TokensGastadods is TokensIniciales - TokensActuales,
    AcumuladorNuevo is Acumulador + TokensGastados.

% Descripción: Convierte la lista de eventos del historial a un string
% Dom: Historial(lista) X Acumulador(string)
% Rec: StringFinal(string)
% Caso Base
historialString([],StringFinal,StringFinal).

% Caso recursivo
historialString([Evento | Resto],Acumulador,StringFinal):-
    format(string(EventoString),"~w\n",[Evento]),
    string_concat(Acumulador,EventoString,AcumuladorNuevo),
    historialString(Resto,AcumuladorNuevo,StringFinal).