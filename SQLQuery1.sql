create table personas(
id_persona int NOT NULL PRIMARY KEY IDENTITY(1,1),
nombre varchar(50),
cedula varchar(10),
edad int null,
pais varchar(50),
SysStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL,
SysEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL,
PERIOD FOR SYSTEM_TIME (SysStartTime,SysEndTime)
)
WITH (SYSTEM_VERSIONING = ON)
GO


insert into personas (nombre,cedula,edad,pais) values ('Juana','1105671252',14,'Brasil');
insert into personas (nombre,cedula,edad,pais) values ('Doris','1105434562',24,'Brasil');
insert into personas (nombre,cedula,edad,pais) values ('Dorotea','1108712352',44,'Brasil');

select * from personas;

select nombre from personas where pais = 'Ecuador';
select nombre,cedula,pais from personas where edad = 54;
select nombre,pais from personas where edad between 30 and 50;

delete from personas where nombre = 'Juana';

create table departamento (
id_departamento int NOT NULL PRIMARY KEY IDENTITY(1,1),
nombre varchar(50),
puestos int,
salario float,
SysStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL,
SysEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL,
PERIOD FOR SYSTEM_TIME (SysStartTime,SysEndTime)
)
WITH (SYSTEM_VERSIONING = ON)
GO

insert into departamento(nombre,puestos,salario) values ('Sistemas',5, 800.30);
insert into departamento(nombre,puestos,salario) values ('Contabilidad',11,459.90);
insert into departamento(nombre,puestos,salario) values ('Administracion',11,1423.00);
insert into departamento(nombre,puestos,salario) values ('Finanzas',2, 870.64);
insert into departamento(nombre,puestos,salario) values ('Marketing',17,469.20);
insert into departamento(nombre,puestos,salario) values ('Orientacion',19,423.00);


select * from departamento;

select p.nombre as 'empleado', d.nombre as 'departamento' from personas p join departamento d on id_departamento = id_persona;
select p.nombre as 'empleado', d.nombre as 'departamento' from personas p left join departamento d on id_departamento = id_persona;
select p.nombre as 'empleado', d.nombre as 'departamento' from personas p right join departamento d on id_departamento = id_persona;
select p.nombre as 'empleado', d.nombre as 'departamento' from personas p inner join departamento d on id_departamento = id_persona;

sp_help personas;
sp_columns personas;


create procedure Info_Personas
@nombre varchar(50)
 as
 Begin
  select p.nombre, p.cedula, p.edad, p.pais 'empleado', d.nombre as 'departamento' from personas p join departamento d on id_departamento = id_persona 
  where p.nombre = @nombre;
   END
 GO


execute Info_Personas 'Alexandra';
execute Info_Personas 'Diego';
execute Info_Personas 'Raul';

drop procedure Info_Personas;
