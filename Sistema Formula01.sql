create database db_sistema_formula01;
use db_sistema_formula01;

create table tbl_pais (
    codigo int not null auto_increment,
    nome varchar(50) not null,
    primary key(codigo)
);

create table tbl_equipe (
    sigla char(3),
    nome varchar(50) not null,
    cod_pais int not null,
    primary key(sigla),
   
    foreign key (cod_pais) references tbl_pais(codigo)
);

create table tbl_piloto (
    numero int,
    nome varchar(50) not null,
    cod_pais int not null,
    sigla_equipe char(3) not null,
    primary key(numero),
   
    foreign key (cod_pais) references tbl_pais(codigo),
    foreign key (sigla_equipe) references tbl_equipe(sigla)
);

create table tbl_corrida (
    sigla_gp char(3),
    nome_gp varchar(50) not null,
    cod_pais int not null,
    qtd_voltas int not null,
    primary key(sigla_gp),
    foreign key (cod_pais) references tbl_pais(codigo)
);

create table tbl_participante (
    numero int,
    sigla_gp char(3),
    posicao_largada int,
    primary key (sigla_gp, numero),
    foreign key (sigla_gp) references tbl_corrida(sigla_gp),
    foreign key (numero) references tbl_piloto(numero)
);

insert into tbl_pais (nome) values
('Brasil'),
('Itália'),
('França'),
('Reino Unido'),
('Alemanha');

insert into tbl_equipe (sigla, nome, cod_pais) values
('FER', 'Ferrari', 2),
('MER', 'Mercedes', 5),
('RBR', 'Red Bull Racing', 4),
('MCL', 'McLaren', 4),
('ALP', 'Alpine', 3);

insert into tbl_piloto (numero, nome, cod_pais, sigla_equipe) values
(11, 'Ayrton Senna', 1, 'MCL'),
(12, 'Nelson Piquet', 1, 'RBR'),
(13, 'Felipe Massa', 1, 'FER'),
(14, 'Rubens Barrichello', 1, 'MER'),
(15, 'Emerson Fittipaldi', 1, 'ALP'),

(21, 'Giuseppe Farina', 2, 'FER'),
(22, 'Alberto Ascari', 2, 'FER'),
(23, 'Riccardo Patrese', 2, 'MER'),

(31, 'Alain Prost', 3, 'MCL'),
(32, 'Pierre Gasly', 3, 'ALP');

insert into tbl_corrida (sigla_gp, nome_gp, cod_pais, qtd_voltas) values
('BRA', 'GP do Brasil', 1, 71),
('ITA', 'GP da Itália', 2, 53),
('FRA', 'GP da França', 3, 53),
('GBR', 'GP da Inglaterra', 4, 52),
('GER', 'GP da Alemanha', 5, 67);

insert into tbl_participante (sigla_gp, numero, posicao_largada) values
('BRA', 11, 1),
('BRA', 31, 2),
('ITA', 21, 1),
('ITA', 22, 2),
('FRA', 31, 1),
('FRA', 32, 2),
('GBR', 14, 3),
('GER', 23, 4);

select nome
from tbl_pais
where nome like 'B%L';

select p.nome
from tbl_piloto p
join tbl_pais pa on p.cod_pais = pa.codigo
where pa.nome in ('Brasil', 'Itália', 'França');

select nome
from tbl_piloto;

select nome_gp as grande_premio,
       qtd_voltas as quantidade_voltas
from tbl_corrida;

select p.nome as piloto,
pa.nome as pais
from tbl_piloto p
join tbl_pais pa on p.cod_pais = pa.codigo;

alter table tbl_piloto
add salario decimal(10,2);

update tbl_piloto set salario = 120000.00 where numero = 11;
update tbl_piloto set salario = 95000.00  where numero = 12;
update tbl_piloto set salario = 85000.00  where numero = 13;
update tbl_piloto set salario = 78000.00  where numero = 14;
update tbl_piloto set salario = 70000.00  where numero = 15;
update tbl_piloto set salario = 110000.00 where numero = 21;
update tbl_piloto set salario = 98000.00  where numero = 22;
update tbl_piloto set salario = 76000.00  where numero = 23;
update tbl_piloto set salario = 130000.00 where numero = 31;
update tbl_piloto set salario = 88000.00  where numero = 32;

select nome
from tbl_piloto
where salario between 70000 and 100000;

select cod_pais,
avg(salario) as media_salarial
from tbl_piloto
group by cod_pais;

select distinct salario
from tbl_piloto
order by salario asc; 

select cod_pais,  
round(AVG(salario)) AS media_salarial
from tbl_piloto
group by cod_pais;

select p.nome_pais, 
count (pi.numero_piloto) AS qtd_pilotos
from tbl_pais p, tbl_piloto pi 
where p.cod_pais = pi.cod_pais
group by p.nome_pais 
order by nome_pais;

