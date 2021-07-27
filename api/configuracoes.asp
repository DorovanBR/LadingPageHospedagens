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
	'|-API: Configurações do Landinpage 			        	                    |'
	'+------------------------------------------------------------------------------+'
	'|-Metodos da API:								        	                    |'
	'|- (1) - Cadastro de Configuração				        	                    |'
	'|- (2) - Alteração de Configuração				        	                    |'
	'|- (3) - Exclusão de Configuração				        	                    |'
	'|- (4) - Consulta de Configuração				        	                    |'
	'+------------------------------------------------------------------------------+'
	'|-Funções da API:								        	                    |'
	'+------------------------------------------------------------------------------+'

	'Declaração das Variaveis'

		Funcao = cInt(Request("Funcao"))

	'Metodos da API'

		Select Case cInt(Funcao)

            Case 1

                'Declara as Variaveis

                    TituloSite = EncodeUTF8(Request("TituloSite"))
                    MetaAutores = EncodeUTF8(Request("MetaAutores"))
                    MetaDescricao = EncodeUTF8(Request("MetaDescricao"))
                    MetaPalavrasChaves = EncodeUTF8(Request("MetaPalavrasChaves"))
                    MetaCharset = EncodeUTF8(Request("MetaCharset"))
                    MetaNome = EncodeUTF8(Request("MetaNome"))
                    MetaIdioma = EncodeUTF8(Request("MetaIdioma"))
                    MetaCriador = EncodeUTF8(Request("MetaCriador"))
                    MetaLayout = EncodeUTF8(Request("MetaLayout"))
                    xPicpayToken = Request("xPicpayToken")
                    xSellerToken = Request("xSellerToken")
                    linkURIPicpay = Request("linkURIPicpay")
                    
                    colunas_sql = ""
                    campos_sql = ""

                'Estrutura as colunas e valores do SQL

                    if trim(TituloSite) <> "" then
                        colunas_sql = colunas_sql & "titulo_site, "
                        campos_sql = campos_sql & "'" & TituloSite & "', "
                    end if

                    if trim(MetaAutores) <> "" then
                        colunas_sql = colunas_sql & "meta_autores, "
                        campos_sql = campos_sql & "'" & MetaAutores & "', "
                    end if

                    if trim(MetaDescricao) <> "" then
                        colunas_sql = colunas_sql & "meta_descricao, "
                        campos_sql = campos_sql & "'" & MetaDescricao & "', "
                    end if

                    if trim(MetaPalavrasChaves) <> "" then
                        colunas_sql = colunas_sql & "meta_palavraschaves, "
                        campos_sql = campos_sql & "'" & MetaPalavrasChaves & "', "
                    end if

                    if trim(MetaCharset) <> "" then
                        colunas_sql = colunas_sql & "meta_charset, "
                        campos_sql = campos_sql & "'" & MetaCharset & "', "
                    end if

                    if trim(MetaNome) <> "" then
                        colunas_sql = colunas_sql & "meta_nome, "
                        campos_sql = campos_sql & "'" & MetaNome & "', "
                    end if

                    if trim(MetaIdioma) <> "" then
                        colunas_sql = colunas_sql & "meta_idioma, "
                        campos_sql = campos_sql & "'" & MetaIdioma & "', "
                    end if

                    if trim(MetaCriador) <> "" then
                        colunas_sql = colunas_sql & "meta_criador, "
                        campos_sql = campos_sql & "'" & MetaCriador & "', "
                    end if

                    if trim(MetaLayout) <> "" then
                        colunas_sql = colunas_sql & "meta_layout, "
                        campos_sql = campos_sql & "'" & MetaLayout & "', "
                    end if

                    if trim(xPicpayToken) <> "" then
                        colunas_sql = colunas_sql & "x_picpay_token, "
                        campos_sql = campos_sql & "'" & xPicpayToken & "', "
                    end if

                    if trim(xSellerToken) <> "" then
                        colunas_sql = colunas_sql & "x_seller_token, "
                        campos_sql = campos_sql & "'" & xSellerToken & "', "
                    end if

                    if trim(linkURIPicpay) <> "" then
                        colunas_sql = colunas_sql & "link_uri_picpay, "
                        campos_sql = campos_sql & "'" & linkURIPicpay & "', "
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

                    string_sql = "insert into configuracoes ("&colunas_sql&") VALUES ("&campos_sql&")"

                    ' call debuga(string_sql, true)

                'Realiza a Inserção

                    set insereConfiguracao = ConexaoBD.Execute(string_sql)

                'Estrutura o JSON de retorno

                    MensagemTitulo = "Sucesso"
                    MensagemTexto = "Configuração Cadastrada com sucesso."
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
                    TituloSite = EncodeUTF8(Request("TituloSite"))
                    MetaAutores = EncodeUTF8(Request("MetaAutores"))
                    MetaDescricao = EncodeUTF8(Request("MetaDescricao"))
                    MetaPalavrasChaves = EncodeUTF8(Request("MetaPalavrasChaves"))
                    MetaCharset = EncodeUTF8(Request("MetaCharset"))
                    MetaNome = EncodeUTF8(Request("MetaNome"))
                    MetaIdioma = EncodeUTF8(Request("MetaIdioma"))
                    MetaCriador = EncodeUTF8(Request("MetaCriador"))
                    MetaLayout = EncodeUTF8(Request("MetaLayout"))
                    xPicpayToken = Request("xPicpayToken")
                    xSellerToken = Request("xSellerToken")
                    linkURIPicpay = Request("linkURIPicpay")
                    
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

                    if trim(TituloSite) <> "" then
                        campos_sql = campos_sql & "titulo_site = '" & TituloSite & "', "
                    end if

                    if trim(MetaAutores) <> "" then
                        campos_sql = campos_sql & "meta_autores = '" & MetaAutores & "', "
                    end if

                    if trim(MetaDescricao) <> "" then
                        campos_sql = campos_sql & "meta_descricao = '" & MetaDescricao & "', "
                    end if

                    if trim(MetaPalavrasChaves) <> "" then
                        colunas_sql = colunas_sql & ", "
                        campos_sql = campos_sql & "meta_palavraschaves = '" & MetaPalavrasChaves & "', "
                    end if

                    if trim(MetaCharset) <> "" then
                        campos_sql = campos_sql & "meta_charset = '" & MetaCharset & "', "
                    end if

                    if trim(MetaNome) <> "" then
                        campos_sql = campos_sql & "meta_nome = '" & MetaNome & "', "
                    end if

                    if trim(MetaIdioma) <> "" then
                        campos_sql = campos_sql & "meta_idioma = '" & MetaIdioma & "', "
                    end if

                    if trim(MetaCriador) <> "" then
                        campos_sql = campos_sql & "meta_criador = '" & MetaCriador & "', "
                    end if

                    if trim(MetaLayout) <> "" then
                        campos_sql = campos_sql & "meta_layout = '" & MetaLayout & "', "
                    end if

                    if trim(xPicpayToken) <> "" then
                        campos_sql = campos_sql & "x_picpay_token = '" & xPicpayToken & "', "
                    end if

                    if trim(xSellerToken) <> "" then
                        campos_sql = campos_sql & "x_seller_token = '" & xSellerToken & "', "
                    end if

                    if trim(linkURIPicpay) <> "" then
                        campos_sql = campos_sql & "link_uri_picpay = '" & linkURIPicpay & "', "
                    end if

                'Insere os Campos de Controle

                    DataAtualizacao = Year(Now()) & "-" & Month(Now()) & "-" & Day(Now())
                    campos_sql = campos_sql & "data_atualizacao = '" & DataAtualizacao & "', "

                    HorarioAtualizacao = Hour(Now()) & ":" & Minute(Now()) & ":" & Second(Now())
                    campos_sql = campos_sql & "horario_atualizacao = '" & HorarioAtualizacao & "'"

                    ' call debuga(colunas_sql, false)
                    ' call debuga(campos_sql, true)

                'Estrutura a String SQL

                    string_sql = "update configuracoes set " & campos_sql & " where codigo = " & Codigo

                    ' call debuga(string_sql, true)

                'Realiza a Alteração

                    set alteraConfiguracao = ConexaoBD.Execute(string_sql)

                'Estrutura o JSON de retorno

                    MensagemTitulo = "Sucesso"
                    MensagemTexto = "Configuração Alterada com sucesso."
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

                    string_sql = "select count(codigo) as Total from configuracoes where cod_situacao = 2 and codigo = " & Codigo

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

                            string_sql = "update configuracoes set " & campos_sql & " where codigo = " & Codigo

                            ' call debuga(string_sql, true)

                        'Realiza a Exclusão

                            set excluiConfiguracao = ConexaoBD.Execute(string_sql)

                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Sucesso"
                            MensagemTexto = "Configuração Excluída com sucesso."
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
                        string_sql = "select * from configuracoes where cod_situacao = 1"
                    else
                        string_sql = "select * from configuracoes where cod_situacao = 1 and codigo = " & Codigo
                    end if

                'Verifica se o Registro já foi excluido

                    set consultaConfiguracao = ConexaoBD.Execute(string_sql)

                'Cria a Estrutura dos Registros

                    EstruturaConfiguracoes = ""

                'Faz um laço de repetição para listar os dados na tela

                    while not consultaConfiguracao.eof

                        TituloSite = consultaConfiguracao("titulo_site")
                        MetaAutores = consultaConfiguracao("meta_autores")
                        MetaDescricao = consultaConfiguracao("meta_descricao")
                        MetaPalavrasChaves = consultaConfiguracao("meta_palavraschaves")
                        MetaCharset = consultaConfiguracao("meta_charset")
                        MetaNome = consultaConfiguracao("meta_nome")
                        MetaIdioma = consultaConfiguracao("meta_idioma")
                        MetaCriador = consultaConfiguracao("meta_criador")
                        MetaLayout = consultaConfiguracao("meta_layout")
                        xPicpayToken = consultaConfiguracao("x_picpay_token")
                        xSellerToken = consultaConfiguracao("x_seller_token")
                        linkURIPicpay = consultaConfiguracao("link_uri_picpay")
                        DataCadastro = consultaConfiguracao("data_cadastro")
                        HorarioCadastro = consultaConfiguracao("horario_cadastro")
                        DataAtualizacao = consultaConfiguracao("data_atualizacao")
                        HorarioAtualizacao = consultaConfiguracao("horario_atualizacao")

                        EstruturaConfiguracoes = EstruturaConfiguracoes & "{"
                        EstruturaConfiguracoes = EstruturaConfiguracoes & """TituloSite"": """ & DecodeUTF8(TituloSite) & ""","
                        EstruturaConfiguracoes = EstruturaConfiguracoes & """MetaAutores"": """ & DecodeUTF8(MetaAutores) & ""","
                        EstruturaConfiguracoes = EstruturaConfiguracoes & """MetaDescricao"": """ & DecodeUTF8(MetaDescricao) & ""","
                        EstruturaConfiguracoes = EstruturaConfiguracoes & """MetaPalavrasChaves"": """ & DecodeUTF8(MetaPalavrasChaves) & ""","
                        EstruturaConfiguracoes = EstruturaConfiguracoes & """MetaCharset"": """ & DecodeUTF8(MetaCharset) & ""","
                        EstruturaConfiguracoes = EstruturaConfiguracoes & """MetaNome"": """ & DecodeUTF8(MetaNome) & ""","
                        EstruturaConfiguracoes = EstruturaConfiguracoes & """MetaIdioma"": """ & DecodeUTF8(MetaIdioma) & ""","
                        EstruturaConfiguracoes = EstruturaConfiguracoes & """MetaCriador"": """ & DecodeUTF8(MetaCriador) & ""","
                        EstruturaConfiguracoes = EstruturaConfiguracoes & """MetaLayout"": """ & DecodeUTF8(MetaLayout) & ""","
                        EstruturaConfiguracoes = EstruturaConfiguracoes & """xPicpayToken"": """ & xPicpayToken & ""","
                        EstruturaConfiguracoes = EstruturaConfiguracoes & """xSellerToken"": """ & xSellerToken & ""","
                        EstruturaConfiguracoes = EstruturaConfiguracoes & """linkURIPicpay"": """ & linkURIPicpay & ""","
                        EstruturaConfiguracoes = EstruturaConfiguracoes & """DataCadastro"": """ & DataCadastro & ""","
                        EstruturaConfiguracoes = EstruturaConfiguracoes & """HorarioCadastro"": """ & HorarioCadastro & ""","
                        EstruturaConfiguracoes = EstruturaConfiguracoes & """DataAtualizacao"": """ & DataAtualizacao & ""","
                        EstruturaConfiguracoes = EstruturaConfiguracoes & """HorarioAtualizacao"": """ & HorarioAtualizacao & """"
                        EstruturaConfiguracoes = EstruturaConfiguracoes & "}"

                        consultaConfiguracao.movenext
                    wend

                'Ajusta a Estrutura dos Registros JSON

                    EstruturaConfiguracoes = replace(EstruturaConfiguracoes, "}{", "},{")

                'Estrutura o JSON de retorno

                    MensagemTitulo = "Sucesso"
                    MensagemTexto = "Configurações carregadas com sucesso."
                    MensagemTipo = "success"
                    StatusRequisicao = 200

                    retornoJSON = "{"
                    retornoJSON = retornoJSON & """Mensagem"": {"
                    retornoJSON = retornoJSON & """Titulo"": """ & MensagemTitulo & ""","
                    retornoJSON = retornoJSON & """Texto"": """ & MensagemTexto & ""","
                    retornoJSON = retornoJSON & """Tipo"": """ & MensagemTipo & ""","
                    retornoJSON = retornoJSON & "},"
                    retornoJSON = retornoJSON & """Requisicao"": {"
                    retornoJSON = retornoJSON & """Retorno"": [" & EstruturaConfiguracoes & "],"
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