/* debug */
drop table if exists usuario;
drop table if exists cartao;
drop table if exists hitorico;
drop table if exists horario;
drop table if exists tipo_horario;
drop table if exists linha;
drop table if exists bairro;
drop table if exists cidade;
drop table if exists logradouro;


/* criacao de estruturas */
create table if not exists usuario (
	usuario_id serial,
	usuario_cpf char(11),
	usuario_nome varchar(150),
	usuario_nascimento date,
	usuario_email varchar(100),
	usuario_senha varchar(64),
	usuario_cep char(8),
	usuario_saldo money,
	PRIMARY KEY (usuario_id)
);

create table if not exists cartao(
	cartao_numero char(16),
	cartao_titular varchar(150),
	cartao_validade char(7),
	usuario_id serial,
	PRIMARY KEY(cartao_numero)
);

create table if not exists historico(
	historico_id serial,
	historico_linha varchar(4),
	historico_data date,
	historico_horario time,
	historico_valor money,
	usuario_id serial,
	PRIMARY KEY(historico_id)
);

create table if not exists horario(
	horario_id serial,
	horario_saida time,
	horario_tipo_orientacao char(1),
	horario_data_inicio date,
	horario_tipo_orientacao char(1);
	horario_terminal_seq int,
	horario_numero_linha smallserial,
	horario_desc_terminal varchar(150),
	linha_numero,
	PRIMARY KEY(horario_id)
);

create table if not exists tipo_horario(
	tipoh_id smallserial,
	tipoh_desc_horario varchar(30),
	PRIMARY KEY(tipo_horario_id));

create table if not exists linha(
	linha_numero smallserial,
	linha_desc varchar(150),
	PRIMARY KEY (numero_linha)
);

create table if not exists bairro(
	bairro_id serial,
	bairro_desc varchar(150),
	cidade_id serial,
	PRIMARY KEY(bairro_id)
);

create table if not exists logradouro (
	log_id serial,
	log_cep char(8),
	log_desc_tipo varchar(20),
	log_desc_logradouro varchar(150),
	bairro_id serial,
	PRIMARY KEY(log_id)
);


create table if not exists cidade(
	cidade_id serial,
	cidade_desc varchar(150),
	PRIMARY KEY(id_cidade)
);

/* adicionar chaves estrangeiras */
alter table cartao add constraint FK_CARTAO_ID FOREIGN KEY(usuario_id) references usuario(usuario_id) MATCH FULL on delete cascade on update cascade;
alter table historico add constraint FK_HISTORICO_ID FOREIGN KEY(usuario_id) references usuario(usuario_id) MATCH FULL on delete cascade on update cascade;
alter table horario add constraint FK_HORARIO_TIPOH FOREIGN KEY(horario_tipo_orientacao) references tipo_horario(tipoh_id);
alter table horario add constraint FK_HORARIO_LINHA FOREIGN KEY(horario_numero_linha) references linha(linha_numero) MATCH FULL on delete cascade on update cascade;
alter table usuario add constraint FK_USUARIO_LOGRADOURO FOREIGN KEY(usuario_cep) references logradouro(log_cep);
alter table logradouro add constraint FK_LOG_BAIRRO FOREIGN KEY(bairro_id) references bairro(bairro_id);
alter table bairro add constraint FK_BAIRRO_CIDADE FOREIGN KEY(cidade_id) references cidade(cidade_id);