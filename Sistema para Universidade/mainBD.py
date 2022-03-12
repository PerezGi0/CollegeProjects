import cadastro

#----------------------------------------------------------------------------------------------------------------------------------------
#	Interface gráfica feita utilizando a biblioteca tkinter, de python.
#----------------------------------------------------------------------------------------------------------------------------------------
from tkinter import *
#------------------------------------------
#	Classe que constrói a primeira tela.  |
#------------------------------------------
class Application:
	def __init__(self, master=None):
		self.widget1 = Frame(master)
		self.widget1.pack()

		self.msg = Label(self.widget1, text="Bem-vindo!", background = "#FFFFFF", foreground = "#00269E")
		self.msg["font"] = ("Verdana", "25", "italic", "bold")
		self.msg.pack ()

		#Containers para gerenciar os layouts.
		self.w2 = Frame(master)
		self.w2.pack()

		self.w3 = Frame(master)
		self.w3.pack()

		self.w4 = Frame(master)
		self.w4.pack()

		self.w5 = Frame(master)
		self.w5.pack()

		self.w6 = Frame(master)
		self.w6.pack()

		self.w7 = Frame(master)
		self.w7.pack()

		#Botões da tela inicial, que tem como evento as telas de cadastro
		self.b1 = Button(self.w2)
		self.b1["background"] = "#083E7C"
		self.b1.configure(foreground = "#FFFFFF")
		self.b1["text"] = "Cadastrar Aluno"
		self.b1["font"] = ("Calibri", "12")
		self.b1["width"] = 20
		self.b1["height"] = 2
		self.b1["command"] = self.handler1
		self.b1.pack (side=LEFT)

		self.b2 = Button(self.w3)
		self.b2["background"] = "#083E7C"
		self.b2.configure(foreground = "#FFFFFF")
		self.b2["text"] = "Cadastrar Professor"
		self.b2["font"] = ("Calibri", "12")
		self.b2["width"] = 20
		self.b2["height"] = 2
		self.b2["command"] = self.handler2
		self.b2.pack (side=LEFT)

		self.b4 = Button(self.w4)
		self.b4["background"] = "#083E7C"
		self.b4.configure(foreground = "#FFFFFF")
		self.b4["text"] = "Cadastrar Funcionário"
		self.b4["font"] = ("Calibri", "12")
		self.b4["width"] = 20
		self.b4["height"] = 2
		self.b4["command"] = self.handler3
		self.b4.pack (side=LEFT)

		self.b5 = Button(self.w5)
		self.b5["background"] = "#083E7C"
		self.b5.configure(foreground = "#FFFFFF")
		self.b5["text"] = "Cadastrar Setor"
		self.b5["font"] = ("Calibri", "12")
		self.b5["width"] = 20
		self.b5["height"] = 2
		self.b5["command"] = self.handler4
		self.b5.pack (side=LEFT)

		self.b6 = Button(self.w5)
		self.b6["background"] = "#083E7C"
		self.b6.configure(foreground = "#FFFFFF")
		self.b6["text"] = "Cadastrar Curso"
		self.b6["font"] = ("Calibri", "12")
		self.b6["width"] = 20
		self.b6["height"] = 2
		self.b6["command"] = self.handler5
		self.b6.pack (side=LEFT)

		self.b7 = Button(self.w2)
		self.b7["background"] = "#083E7C"
		self.b7.configure(foreground = "#FFFFFF")
		self.b7["text"] = "Cadastrar Disciplina"
		self.b7["font"] = ("Calibri", "12")
		self.b7["width"] = 20
		self.b7["height"] = 2
		self.b7["command"] = self.handler6
		self.b7.pack (side=LEFT)

		self.b8 = Button(self.w3)
		self.b8["background"] = "#083E7C"
		self.b8.configure(foreground = "#FFFFFF")
		self.b8["text"] = "Gerenciar matrícula"
		self.b8["font"] = ("Calibri", "12")
		self.b8["width"] = 20
		self.b8["height"] = 2
		self.b8["command"] = self.handler7
		self.b8.pack (side=LEFT)

		self.b9 = Button(self.w4)
		self.b9["background"] = "#083E7C"
		self.b9.configure(foreground = "#FFFFFF")
		self.b9["text"] = "Lançar notas"
		self.b9["font"] = ("Calibri", "12")
		self.b9["width"] = 20
		self.b9["height"] = 2
		self.b9["command"] = self.handler8
		self.b9.pack (side=LEFT)

		self.b10 = Button(self.w6)
		self.b10["background"] = "#083E7C"
		self.b10.configure(foreground = "#FFFFFF")
		self.b10["text"] = "Próxima página --->"
		self.b10["font"] = ("Calibri", "12")
		self.b10["width"] = 20
		self.b10["height"] = 2
		self.b10["command"] = self.handler9
		self.b10.pack (side=RIGHT)


		self.aux = PhotoImage(file = "img.png")
		self.img = Label(self.w7, image = self.aux)
		self.img.pack(side = "bottom")

	#Eventos que vão ser executados quando seus respectivos botões são apertados.
	def handler1(self):
		windowAluno = Tk()
		windowAluno.title("Portal da Universidade")
		windowAluno.resizable(width=0, height=0)
		windowAluno["background"] = "#FFFFFF"
		cadastraAluno(windowAluno)
		windowAluno.mainloop()

	def handler2(self):
		windowProfessor = Tk()
		windowProfessor.title("Portal da Universidade")
		windowProfessor.resizable(width=0, height=0)
		windowProfessor["background"] = "#FFFFFF"
		cadastraProfessor(windowProfessor)
		windowProfessor.mainloop()

	def handler3(self):
		windowFunc = Tk()
		windowFunc.title("Portal da Universidade")
		windowFunc.resizable(width=0, height=0)
		windowFunc["background"] = "#FFFFFF"
		cadastraFunc(windowFunc)
		windowFunc.mainloop()

	def handler4(self):
		windowSetor = Tk()
		windowSetor.title("Portal da Universidade")
		windowSetor.resizable(width=0, height=0)
		windowSetor["background"] = "#FFFFFF"
		cadastraSetor(windowSetor)
		windowSetor.mainloop()

	def handler5(self):
		windowCurso = Tk()
		windowCurso.title("Portal da Universidade")
		windowCurso.resizable(width=0, height=0)
		windowCurso["background"] = "#FFFFFF"
		cadastraCurso(windowCurso)
		windowCurso.mainloop()

	def handler6(self):
		windowDisc = Tk()
		windowDisc.title("Portal da Universidade")
		windowDisc.resizable(width=0, height=0)
		windowDisc["background"] = "#FFFFFF"
		cadastraDisc(windowDisc)
		windowDisc.mainloop()

	def handler7(self):
		windowInsc = Tk()
		windowInsc.title("Portal da Universidade")

		windowInsc.resizable(width=0, height=0)
		windowInsc["background"] = "#FFFFFF"
		cadastraInsc(windowInsc)
		windowInsc.mainloop()

	def handler8(self):
		windowNota = Tk()
		windowNota.title("Portal da Universidade")
		windowNota.resizable(width=0, height=0)
		windowNota["background"] = "#FFFFFF"
		cadastraNota(windowNota)
		windowNota.mainloop()

	def handler9(self):
		windowApp2 = Toplevel()
		windowApp2.title("Portal da Universidade")
		windowApp2.geometry("700x300")
		windowApp2.resizable(width=0, height=0)
		windowApp2["background"] = "#FFFFFF"
		Application2(windowApp2)
		windowApp2.mainloop()

#-----------------------------------------------------
#	Classe que constrói a tela de cadastro do aluno  |
#-----------------------------------------------------
class cadastraAluno:
	def __init__(self, master=None):
		self.w = Frame(master)
		#self.w["pady"] = 10
		self.w.pack()

		self.nomeLabel = Label(self.w, text="Cadastrar novo aluno.", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel["font"] = ("Verdana", "15", "italic", "bold")
		self.nomeLabel.pack()

		self.widget1 = Frame(master)
		self.widget1["background"] = "#FFFFFF"
		#self.widget1["pady"] = 10
		self.widget1.pack()

		self.nomeLabel = Label(self.widget1,text="Nome completo: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.nome = Entry(self.widget1)
		self.nome["width"] = 30
		self.nome.pack(side=LEFT)

		self.widget2 = Frame(master)
		self.widget2["background"] = "#FFFFFF"
		#self.widget2["pady"] = 10
		self.widget2.pack()

		self.nomeLabel = Label(self.widget2,text="CPF [formato 000.000.000-00]: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.cpf = Entry(self.widget2)
		self.cpf["width"] = 30
		self.cpf.pack(side=LEFT)

		self.widget3 = Frame(master)
		self.widget3["background"] = "#FFFFFF"
		#self.widget3["pady"] = 10
		self.widget3.pack()

		self.nomeLabel = Label(self.widget3,text="Telefone [formato 00 00000-0000]: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.tel = Entry(self.widget3)
		self.tel["width"] = 30
		self.tel.pack(side=LEFT)

		self.widget4 = Frame(master)
		self.widget4["background"] = "#FFFFFF"
		#self.widget4["pady"] = 10
		self.widget4.pack()

		self.nomeLabel = Label(self.widget4,text="Endereço: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.end = Entry(self.widget4)
		self.end["width"] = 30
		self.end.pack(side=LEFT)

		self.widget5 = Frame(master)
		self.widget5["background"] = "#FFFFFF"
		#self.widget5["pady"] = 10
		self.widget5.pack()

		self.nomeLabel = Label(self.widget5,text="Ativo[S/n]: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.sit = Entry(self.widget5)
		self.sit["width"] = 30
		self.sit.pack(side=LEFT)

		self.widget6 = Frame(master)
		#self.widget6["pady"] = 10
		self.widget6.pack()

		self.b3 = Button(self.widget6)
		self.b3["background"] = "#083E7C"
		self.b3.configure(foreground = "#FFFFFF")
		self.b3["text"] = "Cadastrar"
		self.b3["font"] = ("Calibri", "12")
		self.b3["width"] = 10
		self.b3["height"] = 1
		self.b3["command"] = self.func
		self.b3.pack ()

	def func(self):
		self.out1 = self.nome.get()
		self.out2 = self.cpf.get()
		self.out3 = self.tel.get()
		self.out4 = self.end.get()
		self.out5 = self.sit.get()
		cadastro.insereAluno(self.out2, self.out1, self.out3, self.out4, self.out5)
		#self.nomeLabel = Label(self.widget1,text="Setor cadastrado!")
		#self.nomeLabel.pack(side=LEFT)

#---------------------------------------------------------
#	Classe que constrói a tela de cadastro do professor  |
#---------------------------------------------------------
class cadastraProfessor:
	def __init__(self, master=None):
		self.w = Frame(master)
		#self.w["pady"] = 10
		self.w.pack()

		self.nomeLabel = Label(self.w,text="Cadastrar novo professor.",  background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel["font"] = ("Verdana", "15", "italic", "bold")
		self.nomeLabel.pack()

		self.widget1 = Frame(master)
		self.widget1["background"] = "#FFFFFF"
		#self.widget1["pady"] = 10
		self.widget1.pack()

		self.nomeLabel = Label(self.widget1,text="Nome completo: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.nome = Entry(self.widget1)
		self.nome["width"] = 30
		self.nome.pack(side=LEFT)

		self.widget2 = Frame(master)
		self.widget2["background"] = "#FFFFFF"
		#self.widget2["pady"] = 10
		self.widget2.pack()

		self.nomeLabel = Label(self.widget2,text="CPF [formato 000.000.000-00]: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.cpf = Entry(self.widget2)
		self.cpf["width"] = 30
		self.cpf.pack(side=LEFT)

		self.widget3 = Frame(master)
		self.widget3["background"] = "#FFFFFF"
		#self.widget3["pady"] = 10
		self.widget3.pack()

		self.nomeLabel = Label(self.widget3,text="Telefone [formato 00 00000-0000]: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.tel = Entry(self.widget3)
		self.tel["width"] = 30
		self.tel.pack(side=LEFT)

		self.widget4 = Frame(master)
		self.widget4["background"] = "#FFFFFF"
		#self.widget4["pady"] = 10
		self.widget4.pack()

		self.nomeLabel = Label(self.widget4,text="Endereço: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.end = Entry(self.widget4)
		self.end["width"] = 30
		self.end.pack(side=LEFT)

		self.widget5 = Frame(master)
		self.widget5["background"] = "#FFFFFF"
		#self.widget5["pady"] = 10
		self.widget5.pack()

		self.nomeLabel = Label(self.widget5,text="Ativo[s/n]: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.at = Entry(self.widget5)
		self.at["width"] = 30
		self.at.pack(side=LEFT)

		self.widget6 = Frame(master)
		self.widget6["background"] = "#FFFFFF"
		#self.widget6["pady"] = 10
		self.widget6.pack()

		self.nomeLabel = Label(self.widget6,text="Código do curso de atuação: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.curso = Entry(self.widget6)
		self.curso["width"] = 30
		self.curso.pack(side=LEFT)

		self.widget7 = Frame(master)
		self.widget7["background"] = "#FFFFFF"
		#self.widget7["pady"] = 10
		self.widget7.pack()

		self.nomeLabel = Label(self.widget7,text="Data da contratação [Formato YYYY-MM-DD]: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.data = Entry(self.widget7)
		self.data["width"] = 30
		self.data.pack(side=LEFT)

		self.widget8 = Frame(master)
		self.widget8["background"] = "#FFFFFF"
		#self.widget8["pady"] = 10
		self.widget8.pack()

		self.nomeLabel = Label(self.widget8,text="Salário[Formato 00000.00]: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.sal = Entry(self.widget8)
		self.sal["width"] = 30
		self.sal.pack(side=LEFT)

		self.widget9 = Frame(master)
		#self.widget9["pady"] = 10
		self.widget9.pack()

		self.b3 = Button(self.widget9)
		self.b3["background"] = "#083E7C"
		self.b3.configure(foreground = "#FFFFFF")
		self.b3["text"] = "Cadastrar"
		self.b3["font"] = ("Calibri", "12")
		self.b3["width"] = 10
		self.b3["height"] = 1
		self.b3["command"] = self.func
		self.b3.pack ()

	def func(self):
		self.out1 = self.nome.get()
		self.out2 = self.cpf.get()
		self.out3 = self.tel.get()
		self.out4 = self.end.get()
		self.out5 = self.data.get()
		self.out6 = self.sal.get()
		self.out7 = self.at.get()
		self.out8 = self.curso.get()
		cadastro.insereProf(self.out2, self.out1, self.out3, self.out4, self.out5, self.out6, self.out7, self.out8)
		#self.nomeLabel = Label(self.widget1,text="Setor cadastrado!")
		#self.nomeLabel.pack(side=LEFT)

#--------------------------------------------------------------------------
#	Classe que constrói a tela de cadastro do funcionário administrativo  |
#--------------------------------------------------------------------------
class cadastraFunc:
	def __init__(self, master=None):
		self.w = Frame(master)
		#self.w["pady"] = 10
		self.w.pack()

		self.nomeLabel = Label(self.w,text="Cadastrar novo funcionário.", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel["font"] = ("Verdana", "15", "italic", "bold")
		self.nomeLabel.pack()

		self.widget1 = Frame(master)
		self.widget1["background"] = "#FFFFFF"
		#self.widget1["pady"] = 10
		self.widget1.pack()

		self.nomeLabel = Label(self.widget1,text="Nome completo: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.nome = Entry(self.widget1)
		self.nome["width"] = 30
		self.nome.pack(side=LEFT)

		self.widget2 = Frame(master)
		self.widget2["background"] = "#FFFFFF"
		#self.widget2["pady"] = 10
		self.widget2.pack()

		self.nomeLabel = Label(self.widget2,text="CPF [formato 000.000.000-00]: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.cpf = Entry(self.widget2)
		self.cpf["width"] = 30
		self.cpf.pack(side=LEFT)

		self.widget3 = Frame(master)
		self.widget3["background"] = "#FFFFFF"
		#self.widget3["pady"] = 10
		self.widget3.pack()

		self.nomeLabel = Label(self.widget3,text="Endereço: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.end = Entry(self.widget3)
		self.end["width"] = 30
		self.end.pack(side=LEFT)

		self.widget4 = Frame(master)
		self.widget4["background"] = "#FFFFFF"
		#self.widget4["pady"] = 10
		self.widget4.pack()

		self.nomeLabel = Label(self.widget4,text="Salário: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.sal = Entry(self.widget4)
		self.sal["width"] = 30
		self.sal.pack(side=LEFT)

		self.widget5 = Frame(master)
		self.widget5["background"] = "#FFFFFF"
		#self.widget5["pady"] = 10
		self.widget5.pack()

		self.nomeLabel = Label(self.widget5,text="Setor: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.setor = Entry(self.widget5)
		self.setor["width"] = 30
		self.setor.pack(side=LEFT)

		self.widget6 = Frame(master)
		#self.widget6["pady"] = 10
		self.widget6.pack()

		self.b3 = Button(self.widget6)
		self.b3["background"] = "#083E7C"
		self.b3.configure(foreground = "#FFFFFF")
		self.b3["text"] = "Cadastrar"
		self.b3["font"] = ("Calibri", "12")
		self.b3["width"] = 10
		self.b3["height"] = 1
		self.b3["command"] = self.func
		self.b3.pack ()

	def func(self):
		self.out1 = self.nome.get()
		self.out2 = self.cpf.get()
		self.out3 = self.end.get()
		self.out4 = self.sal.get()
		self.out5 = self.setor.get()
		cadastro.insereAdm(self.out2, self.out1, self.out3, self.out4, self.out5)
		#self.nomeLabel = Label(self.widget1,text="Setor cadastrado!")
		#self.nomeLabel.pack(side=LEFT)

#-----------------------------------------------------
#	Classe que constrói a tela de cadastro do setor  |
#-----------------------------------------------------
class cadastraSetor:
	def __init__(self, master=None):
		self.w = Frame(master)
		#self.w["pady"] = 10
		self.w.pack()

		self.nomeLabel = Label(self.w,text="Cadastrar novo setor.", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel["font"] = ("Verdana", "15", "italic", "bold")
		self.nomeLabel.pack()

		self.widget1 = Frame(master)
		self.widget1["background"] = "#FFFFFF"
		#self.widget1["pady"] = 10
		self.widget1.pack()

		self.nomeLabel = Label(self.widget1,text="Nome do novo setor: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.nome = Entry(self.widget1)
		#self.out = str(self.nome.get())
		self.nome["width"] = 30
		self.nome.pack(side=LEFT)

		self.widget2 = Frame(master)
		#self.widget2["pady"] = 10
		self.widget2.pack()

		self.b3 = Button(self.widget2)
		self.b3["background"] = "#083E7C"
		self.b3.configure(foreground = "#FFFFFF")
		self.b3["text"] = "Cadastrar"
		self.b3["font"] = ("Calibri", "12")
		self.b3["width"] = 10
		self.b3["height"] = 1
		self.b3["command"] = self.func
		self.b3.pack()

	def func(self):
		self.out = self.nome.get()
		cadastro.insereSetor(self.out)

#-----------------------------------------------------
#	Classe que constrói a tela de cadastro do curso  |
#-----------------------------------------------------
class cadastraCurso:
	def __init__(self, master=None):
		self.w = Frame(master)
		#self.w["pady"] = 10
		self.w.pack()

		self.nomeLabel = Label(self.w,text="Cadastrar novo curso.", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel["font"] = ("Verdana", "15", "italic", "bold")
		self.nomeLabel.pack()

		self.widget1 = Frame(master)
		self.widget1["background"] = "#FFFFFF"
		#self.widget1["pady"] = 10
		self.widget1.pack()

		self.nomeLabel = Label(self.widget1,text="Nome do novo curso: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.nome = Entry(self.widget1)
		self.nome["width"] = 30
		self.nome.pack(side=LEFT)

		self.widget2 = Frame(master)
		self.widget1["background"] = "#FFFFFF"
		#self.widget2["pady"] = 10
		self.widget2.pack()

		self.nomeLabel = Label(self.widget2,text="Ano de início: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.ano = Entry(self.widget2)
		self.ano["width"] = 30
		self.ano.pack(side=LEFT)

		self.widget6 = Frame(master)
		#self.widget6["pady"] = 10
		self.widget6.pack()

		self.b3 = Button(self.widget6)
		self.b3["background"] = "#083E7C"
		self.b3.configure(foreground = "#FFFFFF")
		self.b3["text"] = "Cadastrar"
		self.b3["font"] = ("Calibri", "12")
		self.b3["width"] = 10
		self.b3["height"] = 1
		self.b3["command"] = self.func
		self.b3.pack ()

	def func(self):
		self.out1 = self.nome.get()
		self.out2 = self.ano.get()
		cadastro.insereCurso(self.out1, self.out2)
		#self.nomeLabel = Label(self.widget1,text="Setor cadastrado!")
		#self.nomeLabel.pack(side=LEFT)

#----------------------------------------------------------
#	Classe que constrói a tela de cadastro da disciplina  |
#----------------------------------------------------------
class cadastraDisc:
	def __init__(self, master=None):
		self.w = Frame(master)
		#self.w["pady"] = 10
		self.w.pack()

		self.nomeLabel = Label(self.w,text="Cadastrar nova disciplina.", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel["font"] = ("Verdana", "15", "italic", "bold")
		self.nomeLabel.pack()

		self.widget1 = Frame(master)
		self.widget1["background"] = "#FFFFFF"
		#self.widget1["pady"] = 10
		self.widget1.pack()

		self.nomeLabel = Label(self.widget1,text="Nome da nova disciplina: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.nome = Entry(self.widget1)
		self.nome["width"] = 30
		self.nome.pack(side=LEFT)

		self.widget2 = Frame(master)
		self.widget2["background"] = "#FFFFFF"
		#self.widget2["pady"] = 10
		self.widget2.pack()

		self.nomeLabel = Label(self.widget2,text="CPF do professor que irá ministrar: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.cpf = Entry(self.widget2)
		self.cpf["width"] = 30
		self.cpf.pack(side=LEFT)

		self.widget3 = Frame(master)
		self.widget3["background"] = "#FFFFFF"
		#self.widget3["pady"] = 10
		self.widget3.pack()

		self.nomeLabel = Label(self.widget3,text="Código do curso que possui essa disciplina: ", background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.curso = Entry(self.widget3)
		self.curso["width"] = 30
		self.curso.pack(side=LEFT)

		self.widget4 = Frame(master)
		#self.widget4["pady"] = 10
		self.widget4.pack()

		self.b3 = Button(self.widget4)
		self.b3["background"] = "#083E7C"
		self.b3.configure(foreground = "#FFFFFF")
		self.b3["text"] = "Cadastrar"
		self.b3["font"] = ("Calibri", "12")
		self.b3["width"] = 10
		self.b3["height"] = 1
		self.b3["command"] = self.func
		self.b3.pack ()

	def func(self):
		self.out1 = self.nome.get()
		self.out2 = self.cpf.get()
		self.out3 = self.curso.get()
		cadastro.insereDisc(self.out1, self.out2, self.out3)
		#self.nomeLabel = Label(self.widget1,text="Setor cadastrado!")
		#self.nomeLabel.pack(side=LEFT)

#-------------------------------------------------------
#	Classe que constrói a tela de lançamento de notas  |
#-------------------------------------------------------
class cadastraNota:
	def __init__(self, master=None):
		self.w = Frame(master)
		#self.w["pady"] = 10
		self.w.pack()

		self.nomeLabel = Label(self.w,text="Lançamento de notas.",  background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel["font"] = ("Verdana", "15", "italic", "bold")
		self.nomeLabel.pack()

		self.widget1 = Frame(master)
		self.widget1["background"] = "#FFFFFF"
		#self.widget1["pady"] = 10
		self.widget1.pack()

		self.nomeLabel = Label(self.widget1,text="CPF do aluno: ",  background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.cpf = Entry(self.widget1)
		self.cpf["width"] = 30
		self.cpf.pack(side=LEFT)

		self.widget2 = Frame(master)
		self.widget2["background"] = "#FFFFFF"
		#self.widget2["pady"] = 10
		self.widget2.pack()

		self.nomeLabel = Label(self.widget2,text="Código da disciplina: ",  background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.disc = Entry(self.widget2)
		self.disc["width"] = 30
		self.disc.pack(side=LEFT)

		self.widget3 = Frame(master)
		self.widget3["background"] = "#FFFFFF"
		#self.widget3["pady"] = 10
		self.widget3.pack()

		self.nomeLabel = Label(self.widget3,text="Nota: ",  background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.nota = Entry(self.widget3)
		self.nota["width"] = 30
		self.nota.pack(side=LEFT)

		self.widget4 = Frame(master)
		self.widget4["background"] = "#FFFFFF"
		#self.widget4["pady"] = 10
		self.widget4.pack()

		self.nomeLabel = Label(self.widget4,text="Situação[A/R]: ",  background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.sit = Entry(self.widget4)
		self.sit["width"] = 30
		self.sit.pack(side=LEFT)

		self.widget5 = Frame(master)
		#self.widget5["pady"] = 10
		self.widget5.pack()

		self.b3 = Button(self.widget5)
		self.b3["background"] = "#083E7C"
		self.b3.configure(foreground = "#FFFFFF")
		self.b3["text"] = "Cadastrar"
		self.b3["font"] = ("Calibri", "12")
		self.b3["width"] = 10
		self.b3["height"] = 1
		self.b3["command"] = self.func
		self.b3.pack ()

	def func(self):
		self.out1 = self.cpf.get()
		self.out2 = self.disc.get()
		self.out3 = self.nota.get()
		self.out4 = self.sit.get()
		cadastro.insereNota(self.out1, self.out2, self.out3, self.out4)
		#self.nomeLabel = Label(self.widget1,text="Setor cadastrado!")
		#self.nomeLabel.pack(side=LEFT)

#--------------------------------------------------------------------
#	Classe que constrói a tela de cadastro de inscrições/matrícula  |
#--------------------------------------------------------------------
class cadastraInsc:
	def __init__(self, master=None):
		self.w = Frame(master)
		#self.w["pady"] = 10
		self.w.pack()

		self.nomeLabel = Label(self.w,text="Gerenciamento de matrícula ",  background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel["font"] = ("Verdana", "15", "italic", "bold")
		self.nomeLabel.pack()

		self.widget1 = Frame(master)
		self.widget1["background"] = "#FFFFFF"
		#self.widget1["pady"] = 10
		self.widget1.pack()

		self.nomeLabel = Label(self.widget1,text="Insira seu CPF: ",  background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.cpf = Entry(self.widget1)
		self.cpf["width"] = 30
		self.cpf.pack(side=LEFT)

		self.widget2 = Frame(master)
		self.widget2["background"] = "#FFFFFF"
		#self.widget2["pady"] = 10
		self.widget2.pack()

		self.nomeLabel = Label(self.widget2,text="Código da disciplina: ",  background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.disc = Entry(self.widget2)
		self.disc["width"] = 30
		self.disc.pack(side=LEFT)

		self.widget3 = Frame(master)
		self.widget3["background"] = "#FFFFFF"
		#self.widget3["pady"] = 10
		self.widget3.pack()

		self.nomeLabel = Label(self.widget3,text="Código do curso dessa disciplina: ",  background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.nota = Entry(self.widget3)
		self.nota["width"] = 30
		self.nota.pack(side=LEFT)

		self.widget4 = Frame(master)
		self.widget4["background"] = "#FFFFFF"
		#self.widget4["pady"] = 10
		self.widget4.pack()

		self.nomeLabel = Label(self.widget4,text="Código da turma que deseja se matricular: ",  background = "#FFFFFF", foreground = "#00269E")
		self.nomeLabel.pack(side=LEFT)

		self.sit = Entry(self.widget4)
		self.sit["width"] = 30
		self.sit.pack(side=LEFT)

		self.widget5 = Frame(master)
		#self.widget5["pady"] = 10
		self.widget5.pack()

		self.b3 = Button(self.widget5)
		self.b3["background"] = "#083E7C"
		self.b3.configure(foreground = "#FFFFFF")
		self.b3["text"] = "Matrícular-se"
		self.b3["font"] = ("Calibri", "10")
		self.b3["width"] = 15
		self.b3["height"] = 1
		self.b3["command"] = self.func1
		self.b3.pack(side=LEFT)

		self.b4 = Button(self.widget5)
		self.b4["background"] = "#083E7C"
		self.b4.configure(foreground = "#FFFFFF")
		self.b4["text"] = "Cancelar a matrícula"
		self.b4["font"] = ("Calibri", "10")
		self.b4["width"] = 15
		self.b4["height"] = 1
		self.b4["command"] = self.func2
		self.b4.pack(side=LEFT)

	def func1(self):
		self.out1 = self.cpf.get()
		self.out2 = self.disc.get()
		self.out3 = self.nota.get()
		self.out4 = self.sit.get()
		cadastro.insereInsc(self.out1, self.out2, self.out3, self.out4)
		#self.nomeLabel = Label(self.widget1,text="Setor cadastrado!")
		#self.nomeLabel.pack(side=LEFT)

	def func2(self):
		self.out1 = self.cpf.get()
		self.out2 = self.disc.get()
		cadastro.deletaInsc(self.out1, self.out2)

#----------------------------------------------------------------------
#	Classe que constrói a segunda tela (funcionalidades do item 1.8)  |
#----------------------------------------------------------------------
class Application2:
	def __init__(self, master=None):
		self.widget1 = Frame(master)
		self.widget1.pack()

		self.msg = Label(self.widget1, text="Bem-vindo!", background = "#FFFFFF", foreground = "#00269E")
		self.msg["font"] = ("Verdana", "25", "italic", "bold")
		self.msg.pack()

		self.w2 = Frame(master)
		self.w2.pack()

		self.w3 = Frame(master)
		self.w3.pack()

		self.w4 = Frame(master)
		self.w4.pack()

		self.w5 = Frame(master)
		self.w5.pack()

		self.b1 = Button(self.w2)
		self.b1["background"] = "#083E7C"
		self.b1.configure(foreground = "#FFFFFF")
		self.b1["text"] = "Turmas com mais alunos do campus"
		self.b1["font"] = ("Calibri", "12")
		self.b1["width"] = 30
		self.b1["height"] = 2
		#self.b1["command"] = self.handler1
		self.b1.pack (side=LEFT)

		self.b2 = Button(self.w3)
		self.b2["background"] = "#083E7C"
		self.b2.configure(foreground = "#FFFFFF")
		self.b2["text"] = "Professores ativos por curso"
		self.b2["font"] = ("Calibri", "12")
		self.b2["width"] = 30
		self.b2["height"] = 2
		#self.b2["command"] = self.handler2
		self.b2.pack (side=LEFT)

		self.b4 = Button(self.w4)
		self.b4["background"] = "#083E7C"
		self.b4.configure(foreground = "#FFFFFF")
		self.b4["text"] = "Média salarial dos professores"
		self.b4["font"] = ("Calibri", "12")
		self.b4["width"] = 30
		self.b4["height"] = 2
		#self.b4["command"] = self.handler3
		self.b4.pack (side=LEFT)

		self.b5 = Button(self.w5)
		self.b5["background"] = "#083E7C"
		self.b5.configure(foreground = "#FFFFFF")
		self.b5["text"] = "Quantos cursos cada professor trabalha"
		self.b5["font"] = ("Calibri", "12")
		self.b5["width"] = 30
		self.b5["height"] = 2
		#self.b5["command"] = self.handler4
		self.b5.pack (side=LEFT)

		self.b6 = Button(self.w2)
		self.b6["background"] = "#083E7C"
		self.b6.configure(foreground = "#FFFFFF")
		self.b6["text"] = "Professor mais antigo"
		self.b6["font"] = ("Calibri", "12")
		self.b6["width"] = 30
		self.b6["height"] = 2
		#self.b6["command"] = self.handler5
		self.b6.pack ()

		self.b7 = Button(self.w3)
		self.b7["background"] = "#083E7C"
		self.b7.configure(foreground = "#FFFFFF")
		self.b7["text"] = "Número de alunos por curso"
		self.b7["font"] = ("Calibri", "12")
		self.b7["width"] = 30
		self.b7["height"] = 2
		#self.b7["command"] = self.handler6
		self.b7.pack ()
		
		self.b8 = Button(self.w4)
		self.b8["background"] = "#083E7C"
		self.b8.configure(foreground = "#FFFFFF")
		self.b8["text"] = "Médias da turma"
		self.b8["font"] = ("Calibri", "12")
		self.b8["width"] = 30
		self.b8["height"] = 2
		#self.b8["command"] = self.handler7
		self.b8.pack (side=LEFT)

		self.b9 = Button(self.w5)
		self.b9["background"] = "#083E7C"
		self.b9.configure(foreground = "#FFFFFF")
		self.b9["text"] = "SAIR"
		self.b9["font"] = ("Calibri", "12")
		self.b9["width"] = 30
		self.b9["height"] = 2
		#self.b9["command"] = self.quit
		self.b9.pack (side=LEFT)

	def handler1(self):
		'''
		window1 = Tk()
		window1.title("Portal da Universidade")
		window1.resizable(width=0, height=0)
		window1["background"] = "#FFFFFF"
		self.out = alunoTurma(windowAluno)
		for i in self.out:
			print("")
			print("Código da turma: ", i[0])
			print("Quantidade de alunos: ", i[1])
		windowAluno.mainloop()
		'''

widgets = Tk()
widgets.title("Portal da Universidade")
widgets.geometry("500x500")
widgets.resizable(width=0, height=0)
widgets["background"] = "#FFFFFF"
Application(widgets)
widgets.mainloop()


while True:
	print("")
	print("------OUTRAS FUNCIONALIDADES------")
	print("1)Turmas com mais alunos do campus.")
	print("2)Quantos professores ativos existem por curso.")
	print("3)Média salarial dos professores de cada curso.")
	print("4)Folha de pagamento dos departamentos.")
	print("5)Média da turma por disciplina de um professor.")
	print("6)Cursos em que cada professor trabalha.")
	print("7)Professor mais antigo da instituição.")
	print("8)Número de alunos por curso.")
	print("0)Sair.")
	print("")
	r = int(input())

	if r == 0:
		print("")
		print("Obrigado por utilizar! :)")
		break

	elif r == 7:
		print("")
		prof = cadastro.profAntigo()
		print("O(A) professor(a) mais antigo(a) na instituição é: ", prof[0][0])

	elif r == 2:
		aux1 = cadastro.profAtivo()
		for i in aux1:
			print("")
			print("Código do curso: ", i[0])
			print("Professores ativos: ", i[1])
	elif r == 3:
		aux2 = cadastro.mediaProf()
		for i in aux2:
			print("")
			print("Código do curso: ", i[0])
			print("Média salarial: ", i[1])

	elif r == 8:
		aux3 = cadastro.alunoCurso()
		for i in aux3:
			print("")
			print("Código do curso: ", i[0])
			print("Quantidade de alunos: ", i[1])

	elif r == 1:
		aux4 = cadastro.alunoTurma()
		for i in aux4:
			print("")
			print("Código da turma: ", i[0])
			print("Quantidade de alunos: ", i[1])

	elif r == 6:
		aux5 = cadastro.cursoProf()
		for i in aux5:
			print("")
			print("Nome do professor: ", i[0])
			print("Quantidade de cursos: ", i[1])

	elif r == 5:
		aux5 = cadastro.mediaNotas()
		for i in aux5:
			print("")
			print("CPF do professor: ", i[1])
			print("Código da disciplina: ", i[2])
			print("Média da turma: ", i[0])

	elif r == 4:
		aux6 = cadastro.folhaDep()
		for i in aux6:
			print("")
			print("Código do departamento: ", i[0])
			print("Folha de pagamento: ", i[1])
	
