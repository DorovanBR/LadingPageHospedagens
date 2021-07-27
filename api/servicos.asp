<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/conexao.asp"-->
<!--#include file="helpers/helper_Charset.asp"-->
<!--#include file="helpers/helper_Base64.asp"-->
<!--#include file="helpers/helper_JSON.asp"-->
<!--#include file="helpers/helper_Debugger.asp"-->
<!--#include file="helpers/helper_ByteToString.asp"-->
<%

	'+------------------------------------------------------------------------------+'
	'|-Projeto: SOS Hospedagens     				        	                    |'
	'|-Versão: 1.0									        	                    |'
	'+------------------------------------------------------------------------------+'
	'|-API: Serviços da Landinpage       			        	                    |'
	'+------------------------------------------------------------------------------+'
	'|-Metodos da API:  							        	                    |'
	'|- (1) - Cadastro de Serviços  				        	                    |'
	'|- (2) - Alteração de Serviços 				        	                    |'
	'|- (3) - Exclusão de Serviços  				        	                    |'
	'|- (4) - Consulta de Serviços  				        	                    |'
	'+------------------------------------------------------------------------------+'
	'|-Funções da API:								        	                    |'
	'+------------------------------------------------------------------------------+'

	'Declaração das Variaveis'

		Funcao = cInt(Request("Funcao"))

	'Metodos da API'

		Select Case cInt(Funcao)

            Case 1

                'Declara as Variaveis

                    Nome = EncodeUTF8(Request("Nome"))
                    Descricao = EncodeUTF8(Request("Descricao"))
                    Valor = Request("Valor")
                    
                    colunas_sql = ""
                    campos_sql = ""

                'Estrutura as colunas e valores do SQL

                    if trim(Nome) <> "" then
                        colunas_sql = colunas_sql & "nome, "
                        campos_sql = campos_sql & "'" & Nome & "', "
                    else
                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O Nome do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406

                            retornoJSON = "{"
                            retornoJSON = retornoJSON & """Mensagem"": {"
                            retornoJSON = retornoJSON & """Titulo"": """ & MensagemTitulo & ""","
                            retornoJSON = retornoJSON & """Texto"": """ & MensagemTexto & ""","
                            retornoJSON = retornoJSON & """Tipo"": """ & MensagemTipo & ""","
                            retornoJSON = retornoJSON & "},"
                            retornoJSON = retornoJSON & """Requisicao"": {"
                            retornoJSON = retornoJSON & """Status"": " & StatusRequisicao & ","
                            retornoJSON = retornoJSON & """Link_Referencia"": """ & CVG_URL & """"
                            retornoJSON = retornoJSON & "}"
                            retornoJSON = retornoJSON & "}"
                            
                        'Define o tipo de retorno e traz os dados em tela

                            Response.ContentType = "application/json"
                            Response.Status = StatusRequisicao
                            Response.Write retornoJSON
                            Response.End
                    end if

                    if trim(Descricao) <> "" then
                        colunas_sql = colunas_sql & "descricao, "
                        campos_sql = campos_sql & "'" & Descricao & "', "
                    else
                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "A Descrição do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406

                            retornoJSON = "{"
                            retornoJSON = retornoJSON & """Mensagem"": {"
                            retornoJSON = retornoJSON & """Titulo"": """ & MensagemTitulo & ""","
                            retornoJSON = retornoJSON & """Texto"": """ & MensagemTexto & ""","
                            retornoJSON = retornoJSON & """Tipo"": """ & MensagemTipo & ""","
                            retornoJSON = retornoJSON & "},"
                            retornoJSON = retornoJSON & """Requisicao"": {"
                            retornoJSON = retornoJSON & """Status"": " & StatusRequisicao & ","
                            retornoJSON = retornoJSON & """Link_Referencia"": """ & CVG_URL & """"
                            retornoJSON = retornoJSON & "}"
                            retornoJSON = retornoJSON & "}"
                            
                        'Define o tipo de retorno e traz os dados em tela

                            Response.ContentType = "application/json"
                            Response.Status = StatusRequisicao
                            Response.Write retornoJSON
                            Response.End
                    end if

                    if trim(Valor) <> "" then
                        colunas_sql = colunas_sql & "valor, "
                        campos_sql = campos_sql & "" & Valor & ", "
                    else
                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O Valor do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406

                            retornoJSON = "{"
                            retornoJSON = retornoJSON & """Mensagem"": {"
                            retornoJSON = retornoJSON & """Titulo"": """ & MensagemTitulo & ""","
                            retornoJSON = retornoJSON & """Texto"": """ & MensagemTexto & ""","
                            retornoJSON = retornoJSON & """Tipo"": """ & MensagemTipo & ""","
                            retornoJSON = retornoJSON & "},"
                            retornoJSON = retornoJSON & """Requisicao"": {"
                            retornoJSON = retornoJSON & """Status"": " & StatusRequisicao & ","
                            retornoJSON = retornoJSON & """Link_Referencia"": """ & CVG_URL & """"
                            retornoJSON = retornoJSON & "}"
                            retornoJSON = retornoJSON & "}"
                            
                        'Define o tipo de retorno e traz os dados em tela

                            Response.ContentType = "application/json"
                            Response.Status = StatusRequisicao
                            Response.Write retornoJSON
                            Response.End
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

                    string_sql = "insert into servicos ("&colunas_sql&") VALUES ("&campos_sql&")"

                    ' call debuga(string_sql, true)

                'Realiza a Inserção

                    set insereServico = ConexaoBD.Execute(string_sql)

                'Estrutura o JSON de retorno

                    MensagemTitulo = "Sucesso"
                    MensagemTexto = "Serviço Cadastrado com sucesso."
                    MensagemTipo = "success"
                    StatusRequisicao = 200

                    retornoJSON = "{"
                    retornoJSON = retornoJSON & """Mensagem"": {"
                    retornoJSON = retornoJSON & """Titulo"": """ & MensagemTitulo & ""","
                    retornoJSON = retornoJSON & """Texto"": """ & MensagemTexto & ""","
                    retornoJSON = retornoJSON & """Tipo"": """ & MensagemTipo & ""","
                    retornoJSON = retornoJSON & "},"
                    retornoJSON = retornoJSON & """Requisicao"": {"
                    retornoJSON = retornoJSON & """Status"": " & StatusRequisicao & ","
                    retornoJSON = retornoJSON & """Link_Referencia"": """ & CVG_URL & """"
                    retornoJSON = retornoJSON & "}"
                    retornoJSON = retornoJSON & "}"
                    
                'Define o tipo de retorno e traz os dados em tela

                    Response.ContentType = "application/json"
                    Response.Status = StatusRequisicao
                    Response.Write retornoJSON
                    Response.End

            Case 2

                'Declara as Variaveis

                    Codigo = Request("Codigo")
                    Nome = EncodeUTF8(Request("Nome"))
                    Descricao = EncodeUTF8(Request("Descricao"))
                    Valor = Request("Valor")

                    campos_sql = ""

                'Verifica se o Codigo foi inserido                    

                    if cInt(Codigo) = 0 or Codigo = "" then
                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O Codigo do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406

                            retornoJSON = "{"
                            retornoJSON = retornoJSON & """Mensagem"": {"
                            retornoJSON = retornoJSON & """Titulo"": """ & MensagemTitulo & ""","
                            retornoJSON = retornoJSON & """Texto"": """ & MensagemTexto & ""","
                            retornoJSON = retornoJSON & """Tipo"": """ & MensagemTipo & ""","
                            retornoJSON = retornoJSON & "},"
                            retornoJSON = retornoJSON & """Requisicao"": {"
                            retornoJSON = retornoJSON & """Status"": " & StatusRequisicao & ","
                            retornoJSON = retornoJSON & """Link_Referencia"": """ & CVG_URL & """"
                            retornoJSON = retornoJSON & "}"
                            retornoJSON = retornoJSON & "}"
                            
                        'Define o tipo de retorno e traz os dados em tela

                            Response.ContentType = "application/json"
                            Response.Status = StatusRequisicao
                            Response.Write retornoJSON
                            Response.End
                    end if

                'Estrutura as colunas e valores do SQL

                    if trim(Nome) <> "" then
                        campos_sql = campos_sql & "nome = '" & Nome & "', "
                    end if

                    if trim(Descricao) <> "" then
                        campos_sql = campos_sql & "descricao = '" & Descricao & "', "
                    end if

                    if trim(Valor) <> "" then
                        campos_sql = campos_sql & "valor = " & Valor & ", "
                    end if

                'Insere os Campos de Controle

                    DataAtualizacao = Year(Now()) & "-" & Month(Now()) & "-" & Day(Now())
                    campos_sql = campos_sql & "data_atualizacao = '" & DataAtualizacao & "', "

                    HorarioAtualizacao = Hour(Now()) & ":" & Minute(Now()) & ":" & Second(Now())
                    campos_sql = campos_sql & "horario_atualizacao = '" & HorarioAtualizacao & "'"

                    ' call debuga(colunas_sql, false)
                    ' call debuga(campos_sql, true)

                'Estrutura a String SQL

                    string_sql = "update servicos set " & campos_sql & " where codigo = " & Codigo

                    ' call debuga(string_sql, true)

                'Realiza a Alteração

                    set alteraServico = ConexaoBD.Execute(string_sql)

                'Estrutura o JSON de retorno

                    MensagemTitulo = "Sucesso"
                    MensagemTexto = "Serviço Atualizado com sucesso."
                    MensagemTipo = "success"
                    StatusRequisicao = 200

                    retornoJSON = "{"
                    retornoJSON = retornoJSON & """Mensagem"": {"
                    retornoJSON = retornoJSON & """Titulo"": """ & MensagemTitulo & ""","
                    retornoJSON = retornoJSON & """Texto"": """ & MensagemTexto & ""","
                    retornoJSON = retornoJSON & """Tipo"": """ & MensagemTipo & ""","
                    retornoJSON = retornoJSON & "},"
                    retornoJSON = retornoJSON & """Requisicao"": {"
                    retornoJSON = retornoJSON & """Status"": " & StatusRequisicao & ","
                    retornoJSON = retornoJSON & """Link_Referencia"": """ & CVG_URL & """"
                    retornoJSON = retornoJSON & "}"
                    retornoJSON = retornoJSON & "}"
                    
                'Define o tipo de retorno e traz os dados em tela

                    Response.ContentType = "application/json"
                    Response.Status = StatusRequisicao
                    Response.Write retornoJSON
                    Response.End

            Case 3

                'Declara as Variaveis

                    Codigo = Request("Codigo")

                    campos_sql = ""

                'Verifica se o Codigo foi inserido                    

                    if cInt(Codigo) = 0 or Codigo = "" then
                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O Codigo do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406

                            retornoJSON = "{"
                            retornoJSON = retornoJSON & """Mensagem"": {"
                            retornoJSON = retornoJSON & """Titulo"": """ & MensagemTitulo & ""","
                            retornoJSON = retornoJSON & """Texto"": """ & MensagemTexto & ""","
                            retornoJSON = retornoJSON & """Tipo"": """ & MensagemTipo & ""","
                            retornoJSON = retornoJSON & "},"
                            retornoJSON = retornoJSON & """Requisicao"": {"
                            retornoJSON = retornoJSON & """Status"": " & StatusRequisicao & ","
                            retornoJSON = retornoJSON & """Link_Referencia"": """ & CVG_URL & """"
                            retornoJSON = retornoJSON & "}"
                            retornoJSON = retornoJSON & "}"
                            
                        'Define o tipo de retorno e traz os dados em tela

                            Response.ContentType = "application/json"
                            Response.Status = StatusRequisicao
                            Response.Write retornoJSON
                            Response.End
                    end if

                'Verifica se o Registro já foi excluido

                    string_sql = "select count(codigo) as Total from servicos where cod_situacao = 2 and codigo = " & Codigo

                    set checaRegistro = ConexaoBD.Execute(string_sql)

                    if cInt(checaRegistro("Total")) >= 1 then

                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Eita"
                            MensagemTexto = "Esse registro já foi excluido, verifique e tente novamente"
                            MensagemTipo = "warning"
                            StatusRequisicao = 400

                            retornoJSON = "{"
                            retornoJSON = retornoJSON & """Mensagem"": {"
                            retornoJSON = retornoJSON & """Titulo"": """ & MensagemTitulo & ""","
                            retornoJSON = retornoJSON & """Texto"": """ & MensagemTexto & ""","
                            retornoJSON = retornoJSON & """Tipo"": """ & MensagemTipo & ""","
                            retornoJSON = retornoJSON & "},"
                            retornoJSON = retornoJSON & """Requisicao"": {"
                            retornoJSON = retornoJSON & """Status"": " & StatusRequisicao & ","
                            retornoJSON = retornoJSON & """Link_Referencia"": """ & CVG_URL & """"
                            retornoJSON = retornoJSON & "}"
                            retornoJSON = retornoJSON & "}"
                            
                        'Define o tipo de retorno e traz os dados em tela

                            Response.ContentType = "application/json"
                            Response.Status = StatusRequisicao
                            Response.Write retornoJSON
                            Response.End

                    else

                        'Insere os Campos de Controle

                            DataAtualizacao = Year(Now()) & "-" & Month(Now()) & "-" & Day(Now())
                            campos_sql = campos_sql & "data_atualizacao = '" & DataAtualizacao & "', "

                            HorarioAtualizacao = Hour(Now()) & ":" & Minute(Now()) & ":" & Second(Now())
                            campos_sql = campos_sql & "horario_atualizacao = '" & HorarioAtualizacao & "', "

                            CodSituacao = 2
                            campos_sql = campos_sql & "cod_situacao = " & CodSituacao & ""

                        'Estrutura a String SQL

                            string_sql = "update servicos set " & campos_sql & " where codigo = " & Codigo

                            ' call debuga(string_sql, true)

                        'Realiza a Exclusão

                            set excluiLeading = ConexaoBD.Execute(string_sql)

                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Sucesso"
                            MensagemTexto = "Serviço Excluído com sucesso."
                            MensagemTipo = "success"
                            StatusRequisicao = 200

                            retornoJSON = "{"
                            retornoJSON = retornoJSON & """Mensagem"": {"
                            retornoJSON = retornoJSON & """Titulo"": """ & MensagemTitulo & ""","
                            retornoJSON = retornoJSON & """Texto"": """ & MensagemTexto & ""","
                            retornoJSON = retornoJSON & """Tipo"": """ & MensagemTipo & ""","
                            retornoJSON = retornoJSON & "},"
                            retornoJSON = retornoJSON & """Requisicao"": {"
                            retornoJSON = retornoJSON & """Status"": " & StatusRequisicao & ","
                            retornoJSON = retornoJSON & """Link_Referencia"": """ & CVG_URL & """"
                            retornoJSON = retornoJSON & "}"
                            retornoJSON = retornoJSON & "}"
                            
                        'Define o tipo de retorno e traz os dados em tela

                            Response.ContentType = "application/json"
                            Response.Status = StatusRequisicao
                            Response.Write retornoJSON
                            Response.End

                    end if

            Case 4

                'Declara as Variaveis

                    Codigo = Request("Codigo")

                'Verifica se o Codigo foi inserido                    

                    if cInt(Codigo) = 0 or Codigo = "" then
                        string_sql = "select * from servicos where cod_situacao = 1"
                    else
                        string_sql = "select * from servicos where cod_situacao = 1 and codigo = " & Codigo
                    end if

                'Verifica se o Registro já foi excluido

                    set consultaServicos = ConexaoBD.Execute(string_sql)

                'Cria a Estrutura dos Registros

                    EstruturaServicos = ""

                'Faz um laço de repetição para listar os dados na tela

                    while not consultaServicos.eof

                        Nome = consultaServicos("nome")
                        Descricao = consultaServicos("descricao")
                        Valor = consultaServicos("valor")
                        DataCadastro = consultaServicos("data_cadastro")
                        HorarioCadastro = consultaServicos("horario_cadastro")
                        DataAtualizacao = consultaServicos("data_atualizacao")
                        HorarioAtualizacao = consultaServicos("horario_atualizacao")

                        EstruturaServicos = EstruturaServicos & "{"
                        EstruturaServicos = EstruturaServicos & """Nome"": """ & DecodeUTF8(Nome) & ""","
                        EstruturaServicos = EstruturaServicos & """Descricao"": """ & DecodeUTF8(Descricao) & ""","
                        EstruturaServicos = EstruturaServicos & """Valor"": """ & Valor & ""","
                        EstruturaServicos = EstruturaServicos & """DataCadastro"": """ & DataCadastro & ""","
                        EstruturaServicos = EstruturaServicos & """HorarioCadastro"": """ & HorarioCadastro & ""","
                        EstruturaServicos = EstruturaServicos & """DataAtualizacao"": """ & DataAtualizacao & ""","
                        EstruturaServicos = EstruturaServicos & """HorarioAtualizacao"": """ & HorarioAtualizacao & """"
                        EstruturaServicos = EstruturaServicos & "}"

                        consultaServicos.movenext
                    wend

                'Ajusta a Estrutura dos Registros JSON

                    EstruturaServicos = replace(EstruturaServicos, "}{", "},{")

                'Estrutura o JSON de retorno

                    MensagemTitulo = "Sucesso"
                    MensagemTexto = "Leadings carregados com sucesso."
                    MensagemTipo = "success"
                    StatusRequisicao = 200

                    retornoJSON = "{"
                    retornoJSON = retornoJSON & """Mensagem"": {"
                    retornoJSON = retornoJSON & """Titulo"": """ & MensagemTitulo & ""","
                    retornoJSON = retornoJSON & """Texto"": """ & MensagemTexto & ""","
                    retornoJSON = retornoJSON & """Tipo"": """ & MensagemTipo & ""","
                    retornoJSON = retornoJSON & "},"
                    retornoJSON = retornoJSON & """Requisicao"": {"
                    retornoJSON = retornoJSON & """Retorno"": [" & EstruturaServicos & "],"
                    retornoJSON = retornoJSON & """Status"": " & StatusRequisicao & ","
                    retornoJSON = retornoJSON & """Link_Referencia"": """ & CVG_URL & """"
                    retornoJSON = retornoJSON & "}"
                    retornoJSON = retornoJSON & "}"
                    
                'Define o tipo de retorno e traz os dados em tela

                    Response.ContentType = "application/json"
                    Response.Status = StatusRequisicao
                    Response.Write retornoJSON
                    Response.End

        End Select

%>