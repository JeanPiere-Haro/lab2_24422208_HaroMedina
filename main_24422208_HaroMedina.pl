:- module(main_24422208_HaroMedina, []).

:- reexport(herramienta_24422208_HaroMedina, [
    herramienta/5, herramientaNombre/2, herramientaRol/2,
    herramientaCosto/2, herramientaPredicado/2
    ]).
:- reexport(tarea_24422208_HaroMedina,[
    tarea/8, tareaId/2, tareaDescripcion/2, tareaRol/2,
    tareaHerramienta/2, tareaDatos/2, tareaComplejidad/2,
    tareaPrioridad/2, tareaEstado/2, tareaAgente/2,tareaResultado/2
    ]).

:-reexport(agente_24422208_HaroMedina,[
    agente/7, agenteId/2,agenteNombre/2,agenteRol/2,agenteHerramientas/2,agenteTokensIniciales/2,
    agenteTokensActuales/2,agenteVentana/2,agenteEstado/2,agenteSupervisor/2,agenteSubordinados/2,
    agenteMemoria/2
    ]).