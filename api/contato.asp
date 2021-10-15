<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/conexao.asp"-->
<!--#include file="helpers/helper_Charset.asp"-->
<!--#include file="helpers/helper_Base64.asp"-->
<!--#include file="helpers/helper_JSON.asp"-->
<!--#include file="helpers/helper_Debugger.asp"-->
<!--#include file="helpers/helper_ByteToString.asp"-->
<!--#include file="helpers/helper_FuncoesURL.asp"-->
<!--#include file="helpers/helper_FuncoesAPI.asp"-->
<%

	'+------------------------------------------------------------------------------+'
	'|-Projeto: SOS Hospedagens     				        	                    |'
	'|-Versão: 1.0									        	                    |'
	'+------------------------------------------------------------------------------+'
	'|-API: Contato da Landinpage       			        	                    |'
	'+------------------------------------------------------------------------------+'
	'|-Metodos da API:  							        	                    |'
	'|- (1) - Cadastro de Contato     				        	                    |'
	'|- (2) - Alteração de Contato   				        	                    |'
	'|- (3) - Exclusão de Contato     				        	                    |'
	'|- (4) - Consulta de Contato     				        	                    |'
	'+------------------------------------------------------------------------------+'
	'|-Funções da API:								        	                    |'
	'+------------------------------------------------------------------------------+'

	'Declaração das Variaveis'

		Funcao = cInt(Request("Funcao"))

	'Metodos da API'

		Select Case cInt(Funcao)

            Case 1

                'Declara as Variaveis

                    CodLeading = Request("CodLeading")
                    Nome = EncodeUTF8(Request("Nome"))
                    Email = Request("Email")
                    Telefone = Request("Telefone")
                    Assunto = EncodeUTF8(Request("Assunto"))
                    Mensagem = EncodeUTF8(Request("Mensagem"))
                    
                    colunas_sql = ""
                    campos_sql = ""

                'Estrutura as colunas e valores do SQL e caso as Validaçõe estejam incorretas retorna o erro

                    if trim(CodLeading) <> "" then
                        colunas_sql = colunas_sql & "cod_leading, "
                        campos_sql = campos_sql & "" & CodLeading & ", "
                    else
                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O Codigo do Leading do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    end if

                    if trim(Nome) <> "" then
                        colunas_sql = colunas_sql & "nome, "
                        campos_sql = campos_sql & "'" & Nome & "', "
                    else
                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O Nome do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    end if

                    if trim(Email) <> "" then
                        colunas_sql = colunas_sql & "email, "
                        campos_sql = campos_sql & "'" & Email & "', "
                    else
                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O Email do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    end if

                    if trim(Telefone) <> "" then
                        colunas_sql = colunas_sql & "telefone, "
                        campos_sql = campos_sql & "'" & Telefone & "', "
                    else
                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O Telefone do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    end if

                    if trim(Assunto) <> "" then
                        colunas_sql = colunas_sql & "assunto, "
                        campos_sql = campos_sql & "'" & Assunto & "', "
                    else
                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O Assunto do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    end if

                    if trim(Mensagem) <> "" then
                        colunas_sql = colunas_sql & "mensagem, "
                        campos_sql = campos_sql & "'" & Mensagem & "', "
                    else
                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O Mensagem do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    end if

                'Insere os Campos de Controle

                    DataCadastro = Year(Now()) & "-" & Month(Now()) & "-" & Day(Now())
                    colunas_sql = colunas_sql & "data_cadastro, "
                    campos_sql = campos_sql & "'" & DataCadastro & "', "

                    HorarioCadastro = Hour(Now()) & ":" & Minute(Now()) & ":" & Second(Now())
                    colunas_sql = colunas_sql & "horario_cadastro, "
                    campos_sql = campos_sql & "'" & HorarioCadastro & "', "

                    CodSituacao = 1
                    colunas_sql = colunas_sql & "cod_situacao"
                    campos_sql = campos_sql & "" & CodSituacao & ""

                    ' call debuga(colunas_sql, false)
                    ' call debuga(campos_sql, true)

                'Estrutura a String SQL

                    string_sql = "insert into contato ("&colunas_sql&") VALUES ("&campos_sql&")"

                    ' call debuga(string_sql, true)

                'Realiza a Inserção

                    set insereContato = ConexaoBD.Execute(string_sql)

                'Realiza a Estruturação do Envio de Email

                    Set myMail = CreateObject("CDO.Message")
                    Set objCDOSYSCon = Server.CreateObject ("CDO.Configuration")
                        objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "" 'Servidor SMTP
                        objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465  'Porta SMTP
                        objCDOSYSCon.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True 'Usa SSL SMTP
                        objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Tipo de Envio
                        objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'Tipo de Autenticação
                        objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/sendusername") = "" 'Username [Email] 
                        objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "" 'Senha
                        objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60 'Timeout
                        objCDOSYSCon.Fields.Update
                    myMail.Configuration = objCDOSYSCon
                    myMail.AutoGenerateTextBody = False
                    myMail.From = "SOS Hospedagens" & "<>" '<Username [Email]>
                    myMail.To = Nome & " <" & Email & ">"
                    myMail.Subject = DecodeUTF8(Assunto)
                    myMail.HTMLBody = Mensagem & " - Contato: " & Telefone & " - Nome: " & Nome
                    myMail.Send
                    set myMail = nothing

                'Estrutura o JSON de retorno

                    MensagemTitulo = "Sucesso"
                    MensagemTexto = "Contato Cadastrado com sucesso."
                    MensagemTipo = "success"
                    StatusRequisicao = 200
                    
                'Define o tipo de retorno e traz os dados em tela

                    call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

            Case 2, 3

                'Estrutura o JSON de retorno

                    MensagemTitulo = "Ops"
                    MensagemTexto = "Este Metodo não existe ou não esta liberado para acesso"
                    MensagemTipo = "error"
                    StatusRequisicao = 401
                    
                'Define o tipo de retorno e traz os dados em tela

                    call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

            Case 4

                'Declara as Variaveis

                    Codigo = Request("Codigo")

                'Verifica se o Codigo foi inserido                    

                    if cInt(Codigo) = 0 or Codigo = "" then
                        string_sql = "select * from contato where cod_situacao = 1"
                    else
                        string_sql = "select * from contato where cod_situacao = 1 and codigo = " & Codigo
                    end if

                'Verifica se o Registro já foi excluido

                    set consultaContato = ConexaoBD.Execute(string_sql)

                'Cria a Estrutura dos Registros

                    EstruturaContato = ""

                'Faz um laço de repetição para listar os dados na tela

                    while not consultaContato.eof

                        CodLeading = consultaContato("cod_leading")
                        Nome = consultaContato("nome")
                        Email = consultaContato("email")
                        Telefone = consultaContato("telefone")
                        Assunto = consultaContato("assunto")
                        Mensagem = consultaContato("mensagem")
                        DataCadastro = consultaContato("data_cadastro")
                        HorarioCadastro = consultaContato("horario_cadastro")
                        DataAtualizacao = consultaContato("data_atualizacao")
                        HorarioAtualizacao = consultaContato("horario_atualizacao")

                        EstruturaContato = EstruturaContato & "{"
                        EstruturaContato = EstruturaContato & """CodLeading"": """ & CodLeading & ""","
                        EstruturaContato = EstruturaContato & """Nome"": """ & DecodeUTF8(Nome) & ""","
                        EstruturaContato = EstruturaContato & """Email"": """ & Email & ""","
                        EstruturaContato = EstruturaContato & """Telefone"": """ & Telefone & ""","
                        EstruturaContato = EstruturaContato & """Assunto"": """ & DecodeUTF8(Assunto) & ""","
                        EstruturaContato = EstruturaContato & """Mensagem"": """ & DecodeUTF8(Mensagem) & ""","
                        EstruturaContato = EstruturaContato & """DataCadastro"": """ & DataCadastro & ""","
                        EstruturaContato = EstruturaContato & """HorarioCadastro"": """ & HorarioCadastro & ""","
                        EstruturaContato = EstruturaContato & """DataAtualizacao"": """ & DataAtualizacao & ""","
                        EstruturaContato = EstruturaContato & """HorarioAtualizacao"": """ & HorarioAtualizacao & """"
                        EstruturaContato = EstruturaContato & "}"

                        consultaContato.movenext
                    wend

                'Ajusta a Estrutura dos Registros JSON

                    EstruturaContato = replace(EstruturaContato, "}{", "},{")

                'Estrutura o JSON de retorno

                    MensagemTitulo = "Sucesso"
                    MensagemTexto = "Contatos carregados com sucesso."
                    MensagemTipo = "success"
                    StatusRequisicao = 200

                    DadosRetorno = "{"
                    DadosRetorno = DadosRetorno & """Contatos"": [" & EstruturaContato & "]"
                    DadosRetorno = DadosRetorno & "}"
                    
                'Define o tipo de retorno e traz os dados em tela

                    call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, True, DadosRetorno)

        End Select

%>