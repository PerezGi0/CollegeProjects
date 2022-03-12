import pymysql

#Integração com o MySql para começar a escrever o código
banco = pymysql.connect(
	user="root",
	passwd="",
	database="universidade"
)
cursor = banco.cursor()

#--------------------------------------------------------------------------------------------------------------------------------------------------
#	Função para cadastrar um professor
#	Recebe os parâmetros para executar o INSERT, ou seja, os atributos da tabela 'professor', vindos da interface gráfica.
#	Executa um INSERT na tabela 'professor'
#--------------------------------------------------------------------------------------------------------------------------------------------------
def insereProf(cpf, nome, telefone, address, data_contratacao, salario, ativo, cod_curso):
	sql= "insert into professor(cpf, nome, telefone, address, data_contratacao, salario, ativo, cod_curso) values (%s, %s, %s, %s, %s, %s, %s, %s)"
	val= (cpf, nome, telefone, address, data_contratacao, salario, ativo, cod_curso)
	cursor.execute(sql, val) #executa o comando "sql" com os parâmetros contidos em "val"
	banco.commit()


#--------------------------------------------------------------------------------------------------------------------------------------------------
#	Função para cadastrar um funcionário administrativo
#	Recebe os parâmetros necessários para executar o INSERT, ou seja, os atributos da tabela 'funcionario', vindos da interface gráfica.
#	Executa um INSERT na tabela 'funcionario'
#--------------------------------------------------------------------------------------------------------------------------------------------------
def insereAdm(cpf, nome, address, salario, cod_setor):
	sql= "insert into funcionario(cpf, nome, address, salario, cod_setor) values (%s, %s, %s, %s, %s)"
	val= (cpf, nome, address, salario, cod_setor)
	cursor.execute(sql, val)
	banco.commit()

#--------------------------------------------------------------------------------------------------------------------------------------------------
#	Função para cadastrar uma disciplina
#	Recebe os parâmetros necessários para executar o INSERT, ou seja, os atributos da tabela 'disciplina', vindos da interface gráfica.
#	Executa um INSERT na tabela 'disciplina' e executa um INSERT na tabela 'turma'
#--------------------------------------------------------------------------------------------------------------------------------------------------
def insereDisc(nome1, cpf_prof1, cod_curso):
	sql= "insert into disciplina(nome, cpf_prof, cod_curso) values (%s, %s, %s)"
	val= (nome1, cpf_prof1, cod_curso)
	cursor.execute(sql, val)
	aux = "select cod_disc from disciplina where nome=%s and cpf_prof=%s"
	aux2 = (nome1, cpf_prof1)
	cursor.execute(aux, aux2)
	out= cursor.fetchone()
	sql= "insert into turma(cod_disc) values (%s)"
	cursor.execute(sql, out)
	banco.commit()

#--------------------------------------------------------------------------------------------------------------------------------------------------
#	Função para cadastrar um curso
#	Recebe os parâmetros necessários para executar o INSERT, ou seja, os atributos da tabela 'curso', vindos da interface gráfica.
#	Executa um INSERT na tabela 'curso'
#--------------------------------------------------------------------------------------------------------------------------------------------------
def insereCurso(nome, ano_inicio):
	sql= "insert into curso(nome, ano_inicio) values (%s, %s)"
	val= (nome, ano_inicio)
	cursor.execute(sql, val)
	banco.commit()

#--------------------------------------------------------------------------------------------------------------------------------------------------
#	Função para cadastrar setor
#	Recebe os parâmetros necessários para executar o INSERT, ou seja, os atributos da tabela 'setor', vindos da interface gráfica.
#	Executa um INSERT na tabela 'setor'
#--------------------------------------------------------------------------------------------------------------------------------------------------
def insereSetor(nome):
	sql= "insert into setor(nome) values (%s)"
	val= (nome)
	cursor.execute(sql, val)
	banco.commit()

#--------------------------------------------------------------------------------------------------------------------------------------------------
#	Função para cadastrar um aluno
#	Recebe os parâmetros necessários para executar o INSERT, ou seja, os atributos da tabela 'aluno', vindos da interface gráfica.
#	Executa um INSERT na tabela 'aluno'
#--------------------------------------------------------------------------------------------------------------------------------------------------
def insereAluno(cpf, nome, telefone, address, ativo):
	sql= "insert into aluno(cpf, nome, telefone, address, ativo) values (%s, %s, %s, %s, %s)"
	val= (cpf, nome, telefone, address, ativo)
	cursor.execute(sql, val)
	banco.commit()

#--------------------------------------------------------------------------------------------------------------------------------------------------
#	As duas funções a seguir são para o gerenciamento de uma inscrição
#	A primeira, 'insereInsc' recebe os parâmetros para executar um INSERT na tabela 'inscricao', vindos da interface gráfica
#	A segunda, 'deletaInsc' recebe os parâmetros para executar um DELETE na tabela 'inscricao', vindos da interface gráfica
#--------------------------------------------------------------------------------------------------------------------------------------------------
def insereInsc(cpf_aluno, cod_disc, cod_curso, cod_turma):
	sql= "insert into inscricao(cpf_aluno, cod_disc, cod_curso, cod_turma) values (%s, %s, %s, %s)"
	val= (cpf_aluno, cod_disc, cod_curso, cod_turma)
	cursor.execute(sql, val)
	banco.commit()

def deletaInsc(cpf_aluno, cod_disc):
	sql= "delete from inscricao where cpf_aluno=%s and cod_disc=%s"
	val= (cpf_aluno, cod_disc)
	cursor.execute(sql, val)
	banco.commit()

#--------------------------------------------------------------------------------------------------------------------------------------------------
#	Função para lançar notas
#	Recebe os parâmetros necessários para executar o INSERT, ou seja, os atributos da tabela 'notas', vindos da interface gráfica.
#	Executa um INSERT na tabela 'notas'
#--------------------------------------------------------------------------------------------------------------------------------------------------
def insereNota(cpf_aluno, cod_disc, nota, situacao):
	sql= "insert into notas(cpf_aluno, cod_disc, nota, situacao) values (%s, %s, %s, %s)"
	val= (cpf_aluno, cod_disc, nota, situacao)
	cursor.execute(sql, val)
	banco.commit()

#--------------------------------------------------------------------------------------------------------------------------------------------------
#	A partir daqui as funções são relacionadas as querys do item 1.8 do enunciado do trabalho
#	Nenhuma função recebe parâmetro mas retorna a(s) tupla(s) de acordo com o seu respectivo objetivo
#--------------------------------------------------------------------------------------------------------------------------------------------------

#Função referente ao item 1.8.1
def alunoTurma():
	sql= "select cod_turma, count(cpf_aluno) as contagem from inscricao group by cod_turma order by contagem desc"
	cursor.execute(sql)
	out= cursor.fetchall()
	banco.commit()
	return out

#Função referente ao item 1.8.2
def profAtivo():
	sql= "select cod_curso, count(*) as contagem from professor where ativo='s' group by cod_curso order by contagem desc"
	cursor.execute(sql)
	out= cursor.fetchall()
	banco.commit()
	return out

#Função referente ao item 1.8.3
def mediaProf():
	sql= "select cod_curso, avg(salario) from professor group by cod_curso"
	cursor.execute(sql)
	out= cursor.fetchall()
	banco.commit()
	return out

#Função referente ao item 1.8.5
def folhaDep():
	sql = "select cod_setor, sum(salario)  as somaSal from funcionario group by cod_setor order by somaSal desc"
	cursor.execute(sql)
	out= cursor.fetchall()
	banco.commit()
	return out

#Função referente ao item 1.8.6
def mediaNotas():
	sql= "select avg(nota), cpf_prof, cod_disc from (select * from disciplina natural join notas) as aux group by cpf_prof, cod_disc"
	cursor.execute(sql)
	out= cursor.fetchall()
	banco.commit()
	return out

#Função referente ao item 1.8.7
def cursoProf():
	sql= "select nome, contagem from professor as prof inner join (select cpf_prof, count(*) as contagem from (select cpf_prof, cod_curso from disciplina group by cpf_prof, cod_curso) as aux group by cpf_prof) as aux2 where prof.cpf=aux2.cpf_prof order by contagem desc, nome desc"
	cursor.execute(sql)
	out= cursor.fetchall()
	banco.commit()
	return out

#Função referente ao item 1.8.8
def profAntigo():
	sql= "select nome from professor where data_contratacao in (select min(data_contratacao) as data_contratacao from professor)"
	cursor.execute(sql)
	out= cursor.fetchall()
	banco.commit()
	return out

#Função referente ao item 1.8.9
def alunoCurso():
	sql= "select cod_curso, count(cpf_aluno) from inscricao group by cod_curso"
	cursor.execute(sql)
	out= cursor.fetchall()
	banco.commit()
	return out

'''
DELIMITER $$

create trigger desativa after insert 
on notas for each row

begin
	set @conta = select count(situacao) from notas where(situacao = 'R' and cpf_aluno = new.cpf_aluno);

	if @conta >= 3 then
		update aluno set ativo = 'n' where cpf = new.cpf_aluno;
	
	end if;
end$$
DELIMITER ;
'''