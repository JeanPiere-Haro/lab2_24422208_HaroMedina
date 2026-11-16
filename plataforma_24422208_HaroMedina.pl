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

buscarTarea(Id,[Tarea | Resto],Tarea):-
    tareaId(Tarea,Id), !.

buscarTarea(Id,[Tarea | Resto],TareaBuscada):-
    tareaId(Tarea,Id),
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
    member(ColaActual,Plataforma).






